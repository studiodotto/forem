module Api
  module V0
    class ListeningsController < ApiController
      before_action :set_cache_control_headers, only: %i[index]

      def index
        @audios = Audio.published.where("link is not null").order(created_at: :desc)
                      .page(params[:page].to_i).per(24)
      end
    end
  end
end
