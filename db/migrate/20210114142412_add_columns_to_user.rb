class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    safety_assured{
      remove_column :users, :location_id
      remove_column :users, :composer_id
      remove_column :users, :industry_id
      remove_column :users, :song_language_id
      remove_column :users, :genre_id
      remove_column :users, :spotify_url
      remove_column :users, :soundcloud_url
      remove_column :users, :itunes_url
      remove_column :users, :twitter_url
    }
  end
end
