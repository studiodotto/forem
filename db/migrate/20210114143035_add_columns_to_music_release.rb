class AddColumnsToMusicRelease < ActiveRecord::Migration[6.0]
  def change
    add_column :music_releases, :price, :float
    add_column :music_releases, :copies, :integer
    add_column :music_releases, :length, :float
    add_column :music_releases, :music_release_type, :string
    add_column :music_releases, :organization_id, :integer
    add_column :music_releases, :url, :string
    add_column :music_tracks, :audio_id, :integer
    # remove_column :music_releases, :
  end
end
