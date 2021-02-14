class ListeningsController < ApplicationController
  before_action :set_cache_control_headers, only: %i[index]

  def index
    @audios = Audio.published.where("link is not null").order(created_at: :desc)
                  .page(params[:page].to_i).per(24)
    # set_surrogate_key_header "listenings", Article.table_key, @exclusive_articles.map(&:record_key)
  end
end
