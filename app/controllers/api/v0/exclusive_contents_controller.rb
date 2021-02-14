module Api
  module V0
    class ExclusiveContentsController < ApiController
      before_action :set_cache_control_headers, only: %i[index]

      INDEX_ATTRIBUTES_FOR_SERIALIZATION = %i[
        id video path title video_thumbnail_url main_image user_id video_duration_in_seconds video_source_url
      ].freeze
      private_constant :INDEX_ATTRIBUTES_FOR_SERIALIZATION

      def index
        page = params[:page]
        per_page = (6).to_i
        num = [per_page, 1000].min
        orgs = params[:orgs].split(',')
        @exclusive_articles = Article.published
                              .includes([:user])
                              .select(INDEX_ATTRIBUTES_FOR_SERIALIZATION)
                              .where(organization_id: orgs)
                              .order(published_at: :desc)
                              .page(page).per(num)
        set_surrogate_key_header "exclusive_contents", Article.table_key, @exclusive_articles.map(&:record_key)
      end
    end
  end
end
