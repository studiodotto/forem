class AddArtistFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :telephone, :string
    add_column :users, :location_id, :integer
    add_column :users, :composer_id, :integer
    add_column :users, :industry_id, :integer
    add_column :users, :song_language_id, :integer
    add_column :users, :genre_id, :string
    add_column :users, :commission_accepted, :boolean, default: false
    add_column :users, :sell_tracks, :boolean, default: false
    add_column :users, :sell_campaigns, :boolean, default: false
    add_column :users, :spotify_url, :string
    add_column :users, :soundcloud_url, :string
    add_column :users, :itunes_url, :string
    add_column :users, :twitter_url, :string
  end
end
