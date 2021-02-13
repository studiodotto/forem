class AudiosController < ApplicationController
  before_action :set_no_cache_header
  before_action :authenticate_user!

  def new
    @user = current_user
    @audios = current_user.audios.where(status: true).order(id: :desc)
    @pending_audios = current_user.audios.where(status: false).order(id: :desc)
    @music_releases = MusicRelease.where(user_id: current_user.id, published: true)
  end

  def audio_upload
    begin
      raise CarrierWave::IntegrityError if params[:audio].blank?

      uploaders = upload_audios(params[:audio])
      links = uploaders.map(&:url)
      if links.length.zero? || !links[0].include?('studioappbucket')
        render json: { error: 'bucket is not responding' }, status: :unprocessable_entity and return
      end
      music_release = MusicRelease.find_by(id: params[:music_release])
      organization = Organization.find_by(id: params[:exclusive_id])
      uploaded_audio = current_user.audios.create(name: params[:title], link: links[0], slug: params[:slug], music_release_id: music_release.try(:id), organization_id: organization.try(:id))
      if uploaded_audio
        if music_release.present?
          music_track = MusicTrack.new
          music_track.title = params[:title]
          music_track.slug = params[:slug]
          music_track.media_url = links[0]
          music_track.music_release_id = music_release.id
          music_track.guid = "<guid>"+SecureRandom.uuid+"</guid>"
          music_track.published_at = Time.now.utc
          if music_track.save
            render json: { link: links[0] }, status: :ok and return
          else
            render json: { error: music_track.errors.full_messages.to_sentence }, status: :unprocessable_entity and return
          end
        elsif organization.present?
          render json: { link: links[0] }, status: :ok and return
        end
      else
        render json: { error: 'cannot upload audio to database' }, status: :unprocessable_entity
      end
    rescue CarrierWave::IntegrityError => e # client error
      render json: { error: e.message }, status: :unprocessable_entity
    rescue CarrierWave::ProcessingError # server error
      render json: { error: "A server error has occurred!" }, status: :unprocessable_entity
    end
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
