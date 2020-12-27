module MusicTracks
  class BustCacheWorker < BustCacheBaseWorker
    def perform(music_track_id, path, music_release_slug)
      music_track = MusicTrack.find_by(id: music_track_id)
      return if music_track.nil?

      CacheBuster.bust_music_track(music_track, path, music_release_slug)
    end
  end
end
