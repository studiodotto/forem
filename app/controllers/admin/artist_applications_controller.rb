module Admin
  class ArtistApplicationsController < Admin::ApplicationController
    layout "admin"

    def index
      @applications = ArtistApplication.all
      # @audios = @audio.result.page(params[:page] || 1).per(15)
    end

    def update
      audio = Audio.find(params[:id])
      if params[:status].present?
        status = params[:status] == 'reject' ? false : true
        update = audio.update(status: status)
        if update
          flash[:notice] = 'record updated successfully'
          redirect_to admin_audios_path
        else
          flash[:alert] = 'cannot update record'
          redirect_to admin_audios_path
        end
      else
        music_track = MusicTrack.find_by(slug: audio.slug)
        if music_track.present?
          music_track.update(title: params[:audio][:name], slug: params[:audio][:slug])
        end
        if audio.update(name: params[:audio][:name], slug: params[:audio][:slug])
          flash[:notice] = 'record updated successfully'
          redirect_to admin_audios_path
        else
          flash[:alert] = 'cannot update record'
          redirect_to admin_audios_path
        end
      end
    end

    def approve
      artist_application = ArtistApplication.find(params[:id])
      password = Devise.friendly_token(20)
      resource = User.new
      resource.email = artist_application.email
      resource.password = password
      resource.password_confirmation = password
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
      resource.registered = true
      resource.registered_at = Time.current
      resource.editor_version = "v2"
      resource.username = artist_application.first_name + SecureRandom.rand(999).to_s
      resource.skip_confirmation!
      if resource.save
        artist_application.services.each do |service|
          service.user_id = resource.id
          service.save
        end
        artist_application.status = true
        artist_application.save
        if VerificationMailer.with(user_id: resource.id).user_documents_email.deliver_now
          flash[:success] = "Approved successfully! User Documents mail has been sent"
          redirect_to admin_artist_applications_path
        else
          flash[:danger] = "Failed to approve application"
          redirect_to admin_artist_applications_path
        end
      else
        error = "Failed to approve application"
        error = resource.errors.full_messages.to_sentence if resource.errors.any?
        flash[:danger] = error
        redirect_to admin_artist_applications_path
      end
    end

    def edit
      @audio = Audio.find(params[:id])
    end
  end
end
