class ArtistApplicationsController < ApplicationController
  def new
    @artist_application = ArtistApplication.new
    set_data
  end

  def create
    artist_application = ArtistApplication.new(artist_application_params)
    services = params[:services].reject! { |s| s.empty? }
    if services.length > 0
      services.each do |service|
        artist_application.services.new({name: service, price: 0, currency: 'USD'})
      end
    end
    if artist_application.save
      @artist_application = ArtistApplication.new
      set_data
      flash[:notice] = 'Application received successfully'
      return redirect_to new_artist_application_path
    else
      @artist_application = ArtistApplication.new
      set_data
      flash[:alert] = artist_application.errors.full_messages.to_sentence
      return redirect_to new_artist_application_path
    end
  end

  private

  def artist_application_params
    params.require(:artist_application).permit(:first_name, :last_name, :date_of_birth, :email, :telephone,
                                               :location_id, :composer_id, :industry_id, :song_language_id, :genre_id,
                                               :commission_accepted, :sell_tracks, :sell_campaigns, :spotify_url,
                                               :soundcloud_url, :itunes_url, :facebook_url, :twitter_url, :website_url,
                                               :accept_terms)
  end

  def set_data
    artists_data = YAML.load_file("#{Rails.root}/lib/data/artists_data.yml")
    @locations = artists_data['locations'].map{|location| [location[:label], location[:id]]}
    @composers = artists_data['composers'].map{|composer| [composer[:label], composer[:id]]}
    @industries = artists_data['industries'].map{|industry| [industry[:label], industry[:id]]}
    @languages = artists_data['languages'].map{|language| [language[:label], language[:id]]}
    @genres = artists_data['genres'].each_with_index.map{|genre, key| [genre, key + 1]}
  end
end
