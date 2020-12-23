class AudiosController < ApplicationController
  before_action :set_no_cache_header
  before_action :authenticate_user!

  def new
    @user = current_user
    @audios = current_user.audios.where(status: true)
    @podcasts = Podcast.where(creator_id: current_user.id, published: true)
  end

  def audio_upload
    begin
      raise CarrierWave::IntegrityError if params[:audio].blank?

      uploaders = upload_audios(params[:audio])
      links = uploaders.map(&:url)

      if links.length.zero? || !links[0].include?('studioappbucket')
        render json: { error: 'bucket is not responding' }, status: :unprocessable_entity and return
      end
      uploaded_audio = current_user.audios.create(link: links[0])

      if uploaded_audio
        podcast = Podcast.find_by(id: params[:podcast])
        if podcast.present?
          slug = links[0].split('/').last.split('.')[0]
          title = slug.gsub('-',' ').gsub('_',' ').capitalize
          podcast_episode = PodcastEpisode.new
          podcast_episode.title = title
          podcast_episode.slug = slug
          podcast_episode.media_url = links[0]
          podcast_episode.podcast_id = podcast.id
          podcast_episode.guid = "<guid>"+SecureRandom.uuid+"</guid>"
          podcast_episode.published_at = Time.now.utc
          if podcast_episode.save
            render json: { link: links[0] }, status: :ok and return
          else
            render json: { error: podcast_episode.errors.full_messages.to_sentence }, status: :unprocessable_entity and return
          end
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
