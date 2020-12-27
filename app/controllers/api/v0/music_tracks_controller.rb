module Api
  module V0
    class MusicTracksController < ApiController
      before_action :set_cache_control_headers, only: %i[index]

      def index
        page = params[:page]
        per_page = (params[:per_page] || 30).to_i
        num = [per_page, 1000].min

        if params[:username]
          music_release = MusicRelease.published.find_by!(slug: params[:username])
          relation = music_release.music_tracks
        else
          relation = MusicTrack.includes(:music_release).published
        end

        @music_tracks = relation
                                .select(:id, :slug, :title, :music_release_id)
                                .order(published_at: :desc)
                                .page(page).per(num)

        set_surrogate_key_header MusicRelease.table_key, @music_tracks.map(&:record_key)
      end
    end
  end
end
