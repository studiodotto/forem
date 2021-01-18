class AddColumnsToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :artist_id, :integer
    add_column :organizations, :composer_id, :integer
    add_column :organizations, :song_language_id, :integer
    add_column :organizations, :genre_id, :integer
    add_column :organizations, :industry_id, :integer
    add_column :organizations, :location_id, :integer
    add_column :organizations, :insta_url, :string
    add_column :organizations, :spotify_url, :string
    add_column :organizations, :soundcloud_url, :string
    add_column :organizations, :itunes_url, :string
    add_column :organizations, :twitter_handle, :string
    add_column :organizations, :organization_type, :string

    safety_assured{ remove_column :organizations, :location }
  end
end
