class UsersController < ApplicationController
  before_action :set_no_cache_header, except: :artist_edit
  before_action :raise_suspended, only: %i[update]
  before_action :set_user, only: %i[
    update update_language_settings confirm_destroy request_destroy full_delete remove_identity artist_edit
  ]
  after_action :verify_authorized, except: %i[index signout_confirm add_org_admin remove_org_admin remove_from_org artist_update made_for_you]
  before_action :authenticate_user!, only: %i[onboarding_update onboarding_checkbox_update]
  before_action :set_suggested_users, only: %i[index]
  before_action :initialize_stripe, only: %i[edit]

  INDEX_ATTRIBUTES_FOR_SERIALIZATION = %i[id name username summary profile_image].freeze
  private_constant :INDEX_ATTRIBUTES_FOR_SERIALIZATION

  def index
    @users =
      case params[:state]
      when "follow_suggestions"
        determine_follow_suggestions(current_user)
      when "sidebar_suggestions"
        Suggester::Users::Sidebar.new(current_user, params[:tag]).suggest.sample(3)
      else
        User.none
      end
  end

  # GET /settings/@tab
  def edit
    unless current_user
      skip_authorization
      return redirect_to sign_up_path
    end
    set_user
    set_current_tab(params["tab"] || "profile")
    handle_settings_tab
  end

  # GET /artist_settings/@tab
  def artist_edit
    unless current_user
      skip_authorization
      return redirect_to sign_up_path
    end
    return redirect_to sign_up_path if !current_user.any_admin?
    set_user
    set_current_tab(params["tab"] || "incoming-notifications")
    handle_artist_settings_tab
  end

  # PATCH/PUT /users/:id.:format
  def update
    set_current_tab(params["user"]["tab"])

    if @user.update(permitted_attributes(@user))
      RssReaderFetchUserWorker.perform_async(@user.id) if @user.feed_url.present?
      notice = "Your profile was successfully updated."
      if config_changed?
        notice = "Your config has been updated. Refresh to see all changes."
      end
      if @user.export_requested?
        notice += " The export will be emailed to you shortly."
        ExportContentWorker.perform_async(@user.id, @user.email)
      end
      cookies.permanent[:user_experience_level] = @user.experience_level.to_s if @user.experience_level.present?
      flash[:settings_notice] = notice
      @user.touch(:profile_updated_at)
      redirect_to "/settings/#{@tab}"
    else
      Honeycomb.add_field("error", @user.errors.messages.reject { |_, v| v.empty? })
      Honeycomb.add_field("errored", true)

      if @tab
        render :edit, status: :bad_request
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        redirect_to "/settings"
      end
    end
  end

  def artist_update
    @artist = User.find(params[:id])
    if @artist.update(artist_update_params)
      params[:service].each do |service_param|
        service = Service.find(service_param[:id])
        service.name = service_param[:name]
        service.price = service_param[:price]
        service.save
      end
      flash[:global_notice] = 'Successfully updated information'
      return redirect_to '/artist_settings/profile-and-services'
    else
      error = "Cannot update information"
      error = @artist.errors.full_messages.to_sentence if @artist.errors.any?
      flash[:error] = error
      return redirect_to '/artist_settings/profile-and-services'
    end
  end

  def update_language_settings
    set_current_tab("misc")
    @user.language_settings["preferred_languages"] = Languages::LIST.keys & params[:user][:preferred_languages].to_a
    if @user.save
      flash[:settings_notice] = "Your language settings were successfully updated."
      @user.touch(:profile_updated_at)
      redirect_to "/settings/#{@tab}"
    else
      render :edit
    end
  end

  def request_destroy
    set_current_tab("account")

    if destroy_request_in_progress?
      notice = "You have already requested account deletion. Please, check your email for further instructions."
      flash[:settings_notice] = notice
      redirect_to user_settings_path(@tab)
    elsif @user.email?
      Users::RequestDestroy.call(@user)
      notice = "You have requested account deletion. Please, check your email for further instructions."
      flash[:settings_notice] = notice
      redirect_to user_settings_path(@tab)
    else
      flash[:settings_notice] = "Please, provide an email to delete your account."
      redirect_to user_settings_path("account")
    end
  end

  def confirm_destroy
    destroy_token = Rails.cache.read("user-destroy-token-#{@user.id}")
    raise ActionController::RoutingError, "Not Found" unless destroy_token.present? && destroy_token == params[:token]

    set_current_tab("account")
  end

  def full_delete
    set_current_tab("account")
    if @user.email?
      Users::DeleteWorker.perform_async(@user.id)
      sign_out @user
      flash[:global_notice] = "Your account deletion is scheduled. You'll be notified when it's deleted."
      redirect_to root_path
    else
      flash[:settings_notice] = "Please, provide an email to delete your account"
      redirect_to user_settings_path("account")
    end
  end

  def remove_identity
    set_current_tab("account")

    error_message = "An error occurred. Please try again or send an email to: #{SiteConfig.email_addresses[:default]}"
    unless Authentication::Providers.enabled?(params[:provider])
      flash[:error] = error_message
      redirect_to user_settings_path(@tab)
      return
    end

    provider = Authentication::Providers.get!(params[:provider])

    identity = @user.identities.find_by(provider: provider.provider_name)

    if identity && @user.identities.size > 1
      identity.destroy

      @user.update(
        provider.user_username_field => nil,
        :profile_updated_at => Time.current,
      )

      flash[:settings_notice] = "Your #{provider.official_name} account was successfully removed."
    else
      flash[:error] = error_message
    end

    redirect_to user_settings_path(@tab)
  end

  def onboarding_update
    if params[:user]
      sanitize_user_params
      permitted_params = %i[summary location employment_title employer_name last_onboarding_page]
      current_user.assign_attributes(params[:user].permit(permitted_params))
      current_user.profile_updated_at = Time.current
    end
    current_user.saw_onboarding = true
    authorize User
    render_update_response
  end

  def onboarding_checkbox_update
    if params[:user]
      permitted_params = %i[
        checked_code_of_conduct checked_terms_and_conditions email_newsletter email_digest_periodic
      ]
      current_user.assign_attributes(params[:user].permit(permitted_params))
    end

    current_user.saw_onboarding = true
    authorize User
    render_update_response
  end

  def join_org
    authorize User
    if (@organization = Organization.find_by(secret: params[:org_secret].strip))
      OrganizationMembership.create(user_id: current_user.id, organization_id: @organization.id, type_of_user: "member")
      flash[:settings_notice] = "You have joined the #{@organization.name} organization."
      redirect_to "/settings/organization/#{@organization.id}"
    else
      flash[:error] = "The given organization secret was invalid."
      redirect_to "/settings/organization/new"
    end
  end

  def leave_org
    org = Organization.find_by(id: params[:organization_id])
    authorize org
    OrganizationMembership.find_by(organization_id: org.id, user_id: current_user.id)&.delete
    flash[:settings_notice] = "You have left your organization."
    redirect_to "/settings/organization/new"
  end

  def add_org_admin
    adminable = User.find(params[:user_id])
    org = Organization.find_by(id: params[:organization_id])

    not_authorized unless current_user.org_admin?(org) && OrganizationMembership.exists?(user: adminable,
                                                                                         organization: org)

    OrganizationMembership.find_by(user_id: adminable.id, organization_id: org.id).update(type_of_user: "admin")
    flash[:settings_notice] = "#{adminable.name} is now an admin."
    redirect_to "/settings/organization/#{org.id}"
  end

  def remove_org_admin
    unadminable = User.find(params[:user_id])
    org = Organization.find_by(id: params[:organization_id])

    not_authorized unless current_user.org_admin?(org) && unadminable.org_admin?(org)

    OrganizationMembership.find_by(user_id: unadminable.id, organization_id: org.id).update(type_of_user: "member")
    flash[:settings_notice] = "#{unadminable.name} is no longer an admin."
    redirect_to "/settings/organization/#{org.id}"
  end

  def remove_from_org
    removable = User.find(params[:user_id])
    org = Organization.find_by(id: params[:organization_id])
    removable_org_membership = OrganizationMembership.find_by(user_id: removable.id, organization_id: org.id)

    not_authorized unless current_user.org_admin?(org) && removable_org_membership

    removable_org_membership.delete
    flash[:settings_notice] = "#{removable.name} is no longer part of your organization."
    redirect_to "/settings/organization/#{org.id}"
  end

  def signout_confirm; end

  def handle_settings_tab
    return @tab = "profile" if @tab.blank?

    case @tab
    when "organization"
      handle_organization_tab
    when "integrations"
      handle_integrations_tab
    when "billing"
      handle_billing_tab
    when "response-templates"
      handle_response_templates_tab
    else
      not_found unless @tab.in?(Constants::Settings::TAB_LIST.map { |t| t.downcase.tr(" ", "-") })
    end
  end

  def made_for_you
    @orders = current_user.buyer_orders.includes(:music_release)
  end

  def handle_artist_settings_tab
    return @tab = "incoming-notifications" if @tab.blank?

    case @tab
    when "commission-monitor"
      # handle_organization_tab
    when "audio-uploads"
      handle_audio_uploads_tab
    when "new-music-releases"
      handle_music_release_tab
    when "account-and-banking"
      handle_account_and_banking
    when "analytics"
      # handle_response_templates_tab
    when "profile-and-services"
      artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
      @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
      @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
      @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
      @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
      @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
      # handle_response_templates_tab
    when "unreleased-music-project"
      @organization = current_user.artist_organizations.unreleased.new
      organizations_assoiations
    when "online-music-services-page"
      @organization = current_user.artist_organizations.online_music_service.new
      organizations_assoiations
    when "deejaying-services"
      @organization = current_user.artist_organizations.deejaying.new
      organizations_assoiations
    when "single-track-music-page"
      @organization = current_user.artist_organizations.single_track.new
      organizations_assoiations
    when "my-projects"
      @organizations = current_user.artist_organizations
      artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
      @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
      @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
      @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
      @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
      @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
      @listings = []
    when "posts"
      # handle_response_templates_tab
    when "share-exclusive-content"
      @exclusive = current_user.artist_organizations.exclusive.first
    else
      not_found unless @tab.in?(Constants::Settings::ARTIST_TAB_LIST.map { |t| t.downcase.tr(" ", "-") })
    end
  end

  # def handle_artist_settings_tab
  #   return @tab = "incoming-notifications" if @tab.blank?
  #
  #   case @tab
  #   when "commission-monitor"
  #     # handle_organization_tab
  #   when "audio-uploads"
  #     handle_audio_uploads_tab
  #   when "new-music-releases"
  #     handle_music_release_tab
  #   when "account-and-banking"
  #     handle_account_and_banking
  #   when "analytics"
  #     # handle_response_templates_tab
  #   when "profile-and-services"
  #     artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
  #     @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
  #     @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
  #     @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
  #     @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
  #     @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
  #     # handle_response_templates_tab
  #   when "unreleased-music-project"
  #     @organization = current_user.artist_organizations.unreleased.first_or_initialize
  #     organizations_assoiations
  #   when "online-music-services-page"
  #     @organization = current_user.artist_organizations.online_music_service.first_or_initialize
  #     organizations_assoiations
  #   when "deejaying-services"
  #     @organization = current_user.artist_organizations.deejaying.first_or_initialize
  #     organizations_assoiations
  #   when "single-track-music-page"
  #     @organization = current_user.artist_organizations.single_track.first_or_initialize
  #     organizations_assoiations
  #   when "posts"
  #     # handle_response_templates_tab
  #   else
  #     not_found unless @tab.in?(Constants::Settings::ARTIST_TAB_LIST.map { |t| t.downcase.tr(" ", "-") })
  #   end
  # end

  private

  # def organizations_assoiations
  #   @single = @organization.music_releases.single.first || MusicRelease.new(music_release_type: "single")
  #   @album = @organization.music_releases.album.first || MusicRelease.new(music_release_type: "album")
  #   @music_set = @organization.music_releases.music_set.first || MusicRelease.new(music_release_type: "music_set")
  #   @ninty_second = @organization.music_releases.ninty_second.first || MusicRelease.new(music_release_type: "ninty_second")
  #   @organization_events = @organization.project_events
  #   artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
  #   @ninty_second_events = artists_data['ninty_second_events'].map{|ninty_second_event| [ninty_second_event[:label], ninty_second_event[:url]]}
  #   @events = artists_data['events'].map{|event| [event[:label], event[:url]]}
  #   @sport_events = artists_data['sports_events'].map{|sport_event| [sport_event[:label], sport_event[:url]]}
  #   @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
  #   @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
  #   @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
  #   @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
  #   @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
  # end

  def organizations_assoiations
    @single = MusicRelease.new(music_release_type: "single")
    @album = MusicRelease.new(music_release_type: "album")
    @music_set = MusicRelease.new(music_release_type: "music_set")
    @ninty_second = MusicRelease.new(music_release_type: "ninty_second")
    @organization_events = []
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

  def sanitize_user_params
    params[:user].delete_if { |_k, v| v.blank? }
  end

  def set_suggested_users
    @suggested_users = SiteConfig.suggested_users
  end

  def default_suggested_users
    @default_suggested_users ||= User.where(username: @suggested_users)
  end

  def determine_follow_suggestions(current_user)
    return default_suggested_users if SiteConfig.prefer_manual_suggested_users? && default_suggested_users

    recent_suggestions = Suggester::Users::Recent.new(
      current_user,
      attributes_to_select: INDEX_ATTRIBUTES_FOR_SERIALIZATION,
    ).suggest

    recent_suggestions.presence || default_suggested_users
  end

  def artist_update_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :email, :telephone, :location_id, :composer_id, :industry_id,
                                 :song_language_id, :genre_id, :industry_id, :commission_accepted, :sell_tracks, :sell_campaigns, :spotify_url,
                                 :soundcloud_url, :itunes_url, :twitter_url, :facebook_url, :website_url)
  end

  def render_update_response
    outcome = current_user.save ? "updated successfully" : "update failed"

    respond_to do |format|
      format.json { render json: { outcome: outcome } }
    end
  end

  def handle_audio_uploads_tab
    @audios = @user.audios.where(status: true).order(id: :desc)
    @pending_audios = @user.audios.where(status: false).order(id: :desc)
    @music_releases = MusicRelease.where(user_id: @user.id, published: true)
  end

  def handle_music_release_tab
    @music_release = MusicRelease.new
    @music_releases = MusicRelease.published.order(title: :asc)
    @music_release_index = true
  end

  def handle_account_and_banking
    @payment_provider = @user.payment_provider
  end

  def handle_organization_tab
    @organizations = @current_user.organizations.order(name: :asc)
    if params[:org_id] == "new" || params[:org_id].blank? && @organizations.size.zero?
      @organization = Organization.new
    elsif params[:org_id].blank? || params[:org_id].match?(/\d/)
      @organization = Organization.find_by(id: params[:org_id]) || @organizations.first
      authorize @organization, :part_of_org?

      @org_organization_memberships = @organization.organization_memberships.includes(:user)
      @organization_membership = OrganizationMembership.find_by(user_id: current_user.id,
                                                                organization_id: @organization.id)
    end
  end

  def handle_integrations_tab
    @github_repositories_show = current_user.authenticated_through?(:github)
  end

  def handle_billing_tab
    stripe_code = current_user.stripe_id_code
    return if stripe_code == "special"

    @customer = Payments::Customer.get(stripe_code) if stripe_code.present?
  end

  def handle_response_templates_tab
    @response_templates = current_user.response_templates
    @response_template = ResponseTemplate.find_or_initialize_by(id: params[:id], user: current_user)
  end

  def set_user
    @user = current_user
    not_found unless @user
    authorize @user
  end

  def set_current_tab(current_tab = "profile")
    @tab = current_tab
  end

  def config_changed?
    params[:user].include?(:config_theme)
  end

  def destroy_request_in_progress?
    Rails.cache.exist?("user-destroy-token-#{@user.id}")
  end
end
