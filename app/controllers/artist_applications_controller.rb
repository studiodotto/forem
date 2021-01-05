class ArtistApplicationsController < ApplicationController
  def new
    @artist_application = ArtistApplication.new
    set_data
  end

  def create
    artist_application = ArtistApplication.new(artist_application_params)
    # services = params[:services].reject! { |s| s.empty? }
    # services = params[:services]
    services = ['treat', 'wedding', 'family', 'party', 'anniversary', 'ceremony', 'birthday', 'religion']
    if services.length > 0
      services.each do |service|
        artist_application.services.new({name: service, price: 0, currency: 'USD'})
      end
    end
    if artist_application.save
      resource = User.new
      resource.email = artist_application.email
      resource.password = params[:password]
      resource.password_confirmation = params[:password]
      resource.name = artist_application.first_name + artist_application.last_name
      resource.first_name = artist_application.first_name
      resource.last_name = artist_application.last_name
      resource.telephone = artist_application.telephone
      resource.location_id = artist_application.location_id
      resource.composer_id = artist_application.composer_id
      resource.industry_id = artist_application.industry_id
      resource.song_language_id = artist_application.song_language_id
      resource.genre_id = artist_application.genre_id
      resource.commission_accepted = artist_application.commission_accepted
      resource.sell_tracks = artist_application.sell_tracks
      resource.sell_campaigns = artist_application.sell_campaigns
      resource.spotify_url = artist_application.spotify_url
      resource.soundcloud_url = artist_application.soundcloud_url
      resource.itunes_url = artist_application.itunes_url
      resource.twitter_url = artist_application.twitter_url
      resource.email = artist_application.email
      resource.saw_onboarding = true
      resource.checked_code_of_conduct = true
      resource.checked_terms_and_conditions = true
      resource.registered = true
      resource.registered_at = Time.current
      resource.editor_version = "v2"
      resource.username = artist_application.first_name + SecureRandom.rand(999).to_s
      # resource.skip_confirmation!
      resource.is_verified = false
      if resource.save
        resource.add_role(:applicant)
        artist_application.services.each do |service|
          service.user_id = resource.id
          service.save
        end
        artist_application.status = true
        artist_application.save
        if VerificationMailer.with(user_id: resource.id).user_documents_email.deliver_now
          flash[:notice] = "Application received successfully"
          sign_in_and_redirect(resource, event: :authentication)
        else
          flash[:alert] = "Failed to send verification mail"
          @artist_application = ArtistApplication.new
          set_data
          return redirect_to new_artist_application_path
        end
      else
        @artist_application = ArtistApplication.new
        set_data
        flash[:alert] = resource.errors.full_messages.to_sentence
        return redirect_to new_artist_application_path
      end
    else
      @artist_application = ArtistApplication.new
      set_data
      flash[:alert] = artist_application.errors.full_messages.to_sentence
      return redirect_to new_artist_application_path
    end
  end

  private

  def artist_application_params
    params.require(:artist_application).permit(:first_name, :last_name, :date_of_birth, :email, :telephone,
                                               :location_id, :composer_id, :industry_id, :song_language_id, :genre_id,
                                               :commission_accepted, :sell_tracks, :sell_campaigns, :spotify_url,
                                               :soundcloud_url, :itunes_url, :facebook_url, :twitter_url, :website_url,
                                               :accept_terms, :password)
  end

  def set_data
    artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
    @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
    @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
    @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
    @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
    @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
  end
end
