class AudiosController < ApplicationController
  before_action :set_no_cache_header
  before_action :authenticate_user!

  def new
    @user = current_user
    @audios = current_user.audios
  end

  def audio_upload
    begin
      raise CarrierWave::IntegrityError if params[:audio].blank?

      uploaders = upload_audios(params[:audio])
      links = uploaders.map(&:url)

      if links.length.zero? || !links[0].include?('studioappbucket')
        render json: { error: 'bucket is not responding' }, status: :unprocessable_entity
      end
      uploaded_audio = current_user.audios.create(link: links[0])

      if uploaded_audio
        render json: { link: links[0] }, status: :ok
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
