class OrganizationsController < ApplicationController
  after_action :verify_authorized, except: [:organization_feeds, :create_organization, :create_organizations_music_release, :create_organizations_event, :project_show, :project_edit, :generate_new_artist_secret]
  before_action :initialize_stripe, only: :organization_feeds
  def create
    rate_limit!(:organization_creation)

    @tab = "organization"
    @user = current_user

    unless valid_image?
      render template: "users/edit"
      return
    end

    @organization = Organization.new(organization_params)
    authorize @organization
    if @organization.save
      rate_limiter.track_limit_by_action(:organization_creation)
      @organization_membership = OrganizationMembership.create!(organization_id: @organization.id,
                                                                user_id: current_user.id, type_of_user: "admin")
      flash[:settings_notice] = "Your organization was successfully created and you are an admin."
      redirect_to "/settings/organization/#{@organization.id}"
    else
      render template: "users/edit"
    end
  end

  def create_organization
    begin
      params.permit!
      params["organization"]["release_date"] = (params["organization"]["release_date"]).to_date
      collaborators =  params[:organization_memberships]
      # total_royalty = 20
      # collaborators.each do |collaborator|
      #   total_royalty = total_royalty + (collaborator[:royalty].to_i)
      # end
      # unless total_royalty == 100
      #   flash[:error] = "Royalty distribution is not equal to 100%"
      # else
      if organization_params[:id].present?
        flash[:settings_notice] = "Project updated successfully"
      else
        flash[:settings_notice] = "Project created successfully"
      end
      slug = SecureRandom.hex(5) + (Organization.last.id + 1).to_s
      @organization = Organization.find_or_initialize_by(id: organization_params[:id])
      @organization.assign_attributes(organization_params.merge(slug: slug))
      raise StandardError.new @organization.errors.any? ? @organization.errors.full_messages.to_sentence : "Invalid image" unless valid_image?
      @organization.save
      raise StandardError.new @organization.errors.full_messages.join(',') if @organization.errors.any?
      if organization_params[:organization_type] == 'single_track'
        @organization_music_release = MusicRelease.find_or_initialize_by(id: organization_music_release_params[:id])
        @organization_music_release.assign_attributes(organization_music_release_params.merge({organization_id: @organization.id}))
        @organization_music_release.save(validate: false)
        if @organization_music_release.errors.any?
          raise StandardError.new @organization_music_release.errors.full_messages.join(',') if @organization_music_release.errors.any?
        end
        if @organization_music_release.present? && params[:audio].present?
          uploaders = upload_audios(params[:audio])
          links = uploaders.map(&:url)
          if links.length.zero? || !links[0].include?('studioappbucket')
            raise StandardError.new 'Bucket is not responding'
          end
          if @organization_music_release.audios.present?
            @organization_music_release.audios.first.update(link: links[0])
          else
            @organization_music_release.audios.create(name: @organization_music_release.title, link: links[0], slug: @organization_music_release.slug + "#{Audio.last.id.to_i + 1}", music_release_id: @organization_music_release.try(:id), user_id: current_user.id)
          end
        end
        collaborators.each do |collaborator|
          collaborator.merge!({organization_id: @organization.id, type_of_user: 'collaborator'})
        end
        @organization.organization_memberships.destroy_all
        OrganizationMembership.create(collaborators)
      end
      # end
    rescue => exc
      flash[:settings_notice] = exc.message
    rescue CarrierWave::IntegrityError => e # client error
      flash[:settings_notice] = e.message
    rescue CarrierWave::ProcessingError # server error
      flash[:settings_notice] = 'Audio processing error occurred'
    ensure
      redirect_to artist_settings_path(tab: 'my-projects')
    end
  end

  def create_organizations_music_release
    begin
      raise StandardError.new "Invalid Image" unless valid_image?
      @organization_music_release = MusicRelease.find_or_initialize_by(id: organization_music_release_params[:id])
      raise StandardError.new "Create Project First" if organization_music_release_params[:organization_id].blank?
      @organization_music_release.assign_attributes(organization_music_release_params)
      @organization_music_release.save(validate: false)
      raise StandardError.new @organization_music_release.errors.full_messages.join(',') if @organization_music_release.errors.any?
    rescue => exc
      flash[:settings_notice] = exc.message
    ensure
      redirect_to artist_settings_path(tab: tabs(params[:organization_type]))
    end
  end

  def create_organizations_event
    begin
      params[:project_events].each do|key, event|
        project_event = ProjectEvent.find_or_initialize_by(id: organization_project_event_params(event)[:id])
        project_event.assign_attributes(organization_project_event_params(event))
        if project_event.active? || project_event.active == "true"
        raise StandardError.new "Create Project First" if project_event.organization_id.blank?
        project_event.save!
        raise StandardError.new project_event.errors.full_messages.join(',') if project_event.errors.any?
        end
      end
    rescue => exc
      flash[:settings_notice] = exc.message
    ensure
      redirect_to artist_settings_path(tab: tabs(params[:organization_type]))
    end
  end

  def organization_feeds
    @organizations = Organization.approved.includes(:music_releases => [:audios]).order(created_at: :desc)
    artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
    @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
    @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
    @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
    @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
    @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
    @listings = []
    @source = nil
    if current_user.present? && current_user.stripe_id_code.present?
      find_customer
      @customer.sources.each do |source|
        if source.id == @customer.default_source
          @source = source
        end
      end
    end
  end

  def project_edit
    @organization = Organization.find_by(id: params[:id])
    if @organization.present?
      prepare_org_data
      set_user
    end
    @artists = User.with_role(:artist).map{|a| {'id': a.id,'name': a.username}}.to_json
  end

  def project_show
    @organization = Organization.find_by(id: params[:id])
    return redirect_to organization_feeds_path unless @organization.present?
    @music_release = @organization.music_releases.first
    unless @music_release.present?
      flash[:alert] = 'No product exists against this project'
      return redirect_to organization_feeds_path
    end
    artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
    @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
    @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
    @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
    @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
    @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
  end

  def update
    @user = current_user
    @tab = "organization"
    set_organization

    unless valid_image?
      render template: "users/edit"
      return
    end

    if @organization.update(organization_params.merge(profile_updated_at: Time.current))
      flash[:settings_notice] = "Your organization was successfully updated."
      redirect_to "/settings/organization"
    else
      @org_organization_memberships = @organization.organization_memberships.includes(:user)
      @organization_membership = OrganizationMembership.find_by(user_id: current_user.id,
                                                                organization_id: @organization.id)

      render template: "users/edit"
    end
  end

  def destroy
    organization = Organization.find_by(id: params[:id])
    authorize organization
    if organization.destroy
      current_user.touch(:organization_info_updated_at)
      CacheBuster.bust_user(current_user)
      flash[:settings_notice] = "Your organization: \"#{organization.name}\" was successfully deleted."
      redirect_to user_settings_path(:organization)
    else
      flash[:settings_notice] = "#{organization.errors.full_messages.to_sentence}.
        Please email #{SiteConfig.email_addresses['default']} for assistance."
      redirect_to user_settings_path(:organization, id: organization.id)
    end
  rescue Pundit::NotAuthorizedError
    flash[:error] = "Your organization was not deleted; you must be an admin, the only member in the organization,
      and have no articles connected to the organization."
    redirect_to user_settings_path(:organization, id: organization.id)
  end

  def generate_new_secret
    set_organization
    @organization.secret = @organization.generated_random_secret
    @organization.save
    flash[:settings_notice] = "Your org secret was updated"
    redirect_to "/settings/organization"
  end

  def generate_new_artist_secret
    @organization = Organization.find_by(id: organization_params[:id])
    @organization.secret = @organization.generated_random_secret
    @organization.save
    flash[:global_notice] = "Your project secret was updated"
    redirect_to "/organizations/project_edit/#{@organization.id}"
  end

  private

  def find_customer
    @customer = Payments::Customer.get(current_user.stripe_id_code)
  end

  def permitted_params
    %i[
      id
      name
      summary
      tag_line
      slug
      url
      proof
      profile_image
      nav_image
      dark_nav_image
      location
      company_size
      tech_stack
      email
      story
      bg_color_hex
      text_color_hex
      twitter_username
      github_username
      cta_button_text
      cta_button_url
      cta_body_markdown
      artist_id
      composer_id
      song_language_id
      genre_id
      industry_id
      location_id
      insta_url
      spotify_url
      soundcloud_url
      itunes_url
      organization_type
      release_date
      org_type
    ]
  end

  def organization_params
    params[:organization][:genre_id] = params[:organization][:genre_id].map {|str| "#{str}"}.join(',') if params[:organization][:genre_id].is_a?(Array)
    params.require(:organization).permit(permitted_params)
      .transform_values do |value|
        if value.instance_of?(String)
          ActionController::Base.helpers.strip_tags(value)
        else
          value
        end
      end
  end

  def organization_music_release_params
    params.require(:music_release).permit(:id, :music_release_type, :user_id, :organization_id, :title, :description, :slug, :image, :price, :copies, :length, :header_image_url, :royalty)
  end

  def organization_project_event_params(event)
    event.permit(:id, :organization_id, :title, :icon, :event_type, :active)
  end

  def set_organization
    @organization = Organization.find_by(id: organization_params[:id])
    not_found unless @organization
    authorize @organization
  end

  def valid_image?
    image = params.dig("organization", "profile_image") || params.dig("music_release", "pimage")

    return true unless image

    if action_name == "create" && !@organization.present?
      @organization = Organization.new(organization_params.except(:profile_image))
      authorize @organization
    end

    return true if valid_image_file?(image) && valid_filename?(image)

    false
  end

  def valid_image_file?(image)
    return true if file?(image)

    @organization.errors.add(:profile_image, IS_NOT_FILE_MESSAGE)

    false
  end

  def valid_filename?(image)
    return true unless long_filename?(image)

    @organization.errors.add(:profile_image, FILENAME_TOO_LONG_MESSAGE)

    false
  end

  def tabs(tab)
    case tab
    when "unreleased"
      return "unreleased-music-project"
    when "deejaying"
      return "deejaying-services"
    when "online_music_service"
      return "online-music-services-page"
    when "single_track"
      return "single-track-music-page"
    end
  end

  def prepare_org_data
    @single = @organization.music_releases.single.first || MusicRelease.new(music_release_type: "single")
    @album = @organization.music_releases.album.first || MusicRelease.new(music_release_type: "album")
    @music_set = @organization.music_releases.music_set.first || MusicRelease.new(music_release_type: "music_set")
    @ninty_second = @organization.music_releases.ninty_second.first || MusicRelease.new(music_release_type: "ninty_second")
    @organization_events = @organization.project_events
    artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
    @ninty_second_events = artists_data['ninty_second_events'].map{|ninty_second_event| [ninty_second_event[:label], ninty_second_event[:url]]}
    @events = artists_data['events'].map{|event| [event[:label], event[:url]]}
    @sport_events = artists_data['sports_events'].map{|sport_event| [sport_event[:label], sport_event[:url]]}
    @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
    @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
    @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
    @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
    @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
  end

  def set_user
    @user = current_user
  end

  private

  def upload_audios(audios)
    Array.wrap(audios).map do |audio|
      BaseAudioUploader.new.tap do |uploader|
        uploader.store!(audio)
      end
    end
  end
end
