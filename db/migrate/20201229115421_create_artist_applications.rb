class CreateArtistApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :artist_applications do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :email
      t.string :telephone
      t.integer :location_id
      t.integer :composer_id
      t.integer :industry_id
      t.integer :song_language_id
      t.integer :genre_id
      t.boolean :commission_accepted
      t.boolean :sell_tracks
      t.boolean :sell_campaigns
      t.string :spotify_url
      t.string :soundcloud_url
      t.string :itunes_url
      t.string :facebook_url
      t.string :twitter_url
      t.string :website_url
      t.boolean :accept_terms

      t.timestamps
    end
  end
end
