class ExclusiveContentController < ApplicationController
  INDEX_ATTRIBUTES_FOR_SERIALIZATION = %i[
        id video path title video_thumbnail_url main_image user_id video_duration_in_seconds video_source_url
      ].freeze
  private_constant :INDEX_ATTRIBUTES_FOR_SERIALIZATION
  def index
    sellers = current_user.buyer_orders.pluck(:seller_id).uniq
    orgs = []
    if sellers.present?
      sellers.each do |seller_id|
        seller = User.find_by_id(seller_id)
        if seller.present? && seller.artist_organizations && seller.artist_organizations.exclusive.first.present?
          orgs << seller.artist_organizations.exclusive.first.id
        end
      end
    end
    @orgs = orgs
    @exclusive_articles = Article.published
                              .includes([:user])
                              .select(INDEX_ATTRIBUTES_FOR_SERIALIZATION)
                              .where(organization_id: orgs)
                              .order(published_at: :desc)
                              .page(params[:page].to_i).per(24)
    set_surrogate_key_header "exclusive_contents", Article.table_key, @exclusive_articles.map(&:record_key)
  end
end
