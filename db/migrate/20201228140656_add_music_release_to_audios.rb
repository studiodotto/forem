class AddMusicReleaseToAudios < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
    add_column :audios, :music_release_id, :integer
    add_index :audios, :music_release_id, algorithm: :concurrently
  end
end
