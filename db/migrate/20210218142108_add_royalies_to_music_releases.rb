class AddRoyaliesToMusicReleases < ActiveRecord::Migration[6.0]
  def change
    add_column :music_releases, :royalty, :float, default: 0
  end
end
