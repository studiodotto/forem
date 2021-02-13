class ExclusiveContentController < ApplicationController
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
    @exclusive_articles = Article.all.includes([:user]).page(params[:page].to_i).per(6)
    set_surrogate_key_header "exclusive_contents", Article.table_key, @exclusive_articles.map(&:record_key)
  end
end
