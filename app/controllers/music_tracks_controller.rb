class MusicTracksController < ApplicationController
  # No authorization required for entirely public controller
  before_action :set_cache_control_headers, only: [:index]

  def index
    @music_release_index = true

    @music_releases = MusicRelease.published.order(title: :asc)
    @music_tracks = MusicTrackDecorator.decorate_collection(MusicTrack
                                                                .published
                                                                .includes(:music_release).order(published_at: :desc).first(20))

    if params[:q].blank?
      surrogate_keys = ["music_releases_all"] + @music_tracks.map(&:record_key)
      set_surrogate_key_header(surrogate_keys)
    end

    @featured_story = Article.new
    @article_index = true
    @list_of = "music_release-tracks"

    render template: "music_tracks/index"
  end

  private

  def music_track_params
    params.require(:music_track).permit(:title,
                                            :summary,
                                            :image)
  end
end
