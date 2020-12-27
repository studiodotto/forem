class CreateMusicReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :music_releases do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.string :image
      t.string :pattern_image
      t.string :main_color_hex
      t.boolean :published
      t.text :status_notice
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
