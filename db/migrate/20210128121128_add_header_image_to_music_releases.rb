class AddHeaderImageToMusicReleases < ActiveRecord::Migration[6.0]
  def change
    add_column :music_releases, :header_image_url, :text
  end
end
