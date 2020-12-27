class CreateMusicTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :music_tracks do |t|
      t.string :title
      t.string :summary
      t.text :body
      t.string :slug
      t.string :guid
      t.string :image
      t.string :media_url
      t.datetime :published_at
      t.references :music_release, null: false, foreign_key: true

      t.timestamps
    end
  end
end
