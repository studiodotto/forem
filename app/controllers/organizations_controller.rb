class OrganizationsController < ApplicationController
  after_action :verify_authorized, except: [:organization_feeds, :create_organization, :create_organizations_music_release, :create_organizations_event, :project_show]

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
      @organization = Organization.find_or_initialize_by(id: organization_params[:id])
      @organization.assign_attributes(organization_params)
      raise StandardError.new @organization.errors.any? ? @organization.errors.full_messages.to_sentence : "Invalid image" unless valid_image?
      @organization.save(validate: false)
      raise StandardError.new @organization.errors.full_messages.join(',') if @organization.errors.any?
    rescue => exc
      flash[:settings_notice] = exc.message
    ensure
      redirect_to artist_settings_path(tab: tabs(organization_params[:organization_type]))
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
    @organizations = Organization.all
    artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
    @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
    @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
    @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
    @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
    @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
    @listings = []
  end

  def project_show
    @organization = Organization.find_by(id: params[:id])
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

  private

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
    params.require(:music_release).permit(:id, :music_release_type, :user_id, :organization_id, :title, :description, :slug, :image, :price, :copies, :length)
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
    end
  end
end
