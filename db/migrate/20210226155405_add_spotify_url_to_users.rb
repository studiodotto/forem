class AddSpotifyUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :spotify_url, :string
  end
end
