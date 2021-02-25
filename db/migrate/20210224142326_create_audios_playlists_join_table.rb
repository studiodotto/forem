class CreateAudiosPlaylistsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :audios, :playlists do |t|
      t.index [:audio_id, :playlist_id]
      t.index [:playlist_id, :audio_id]
    end
  end
end
