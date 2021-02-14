json.array! @audios do |audio|
  json.type_of "listenings"

  json.extract!(
      audio,
      :id,
      :name,
      :link,
      :status,
      :slug,
      :music_release_id,
      :organization_id,
      )

  json.music_release do
    json.title audio.music_release ? audio.music_release.title : ''
    json.description audio.music_release ? audio.music_release.description : ''
  end
end
