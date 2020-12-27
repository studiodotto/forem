json.array! @music_tracks do |music_track|
  json.type_of      "music_tracks"
  json.class_name   "MusicTrack"

  json.extract!(music_track, :id, :path, :title)

  json.image_url music_track.image_url || music_track.music_release.image_url

  json.music_release do
    json.extract!(music_track.music_release, :title, :slug, :image_url)
  end
end
