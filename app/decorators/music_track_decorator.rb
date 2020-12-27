class MusicTrackDecorator < ApplicationDecorator

  def readable_publish_date
    return "" unless published_at

    if published_at.year == Time.current.year
      published_at.strftime("%b %e")
    else
      published_at.strftime("%b %e '%y")
    end
  end

  def published_timestamp
    return "" unless published_at

    published_at.utc.iso8601
  end

  def mobile_player_metadata
    {
        musicReleaseName: music_release.title,
        musicTrackName: title,
        musicReleaseImageUrl: Images::Optimizer.call(music_release.image_url, width: 600, quality: 80)
    }
  end

  def published_at_int
    published_at.to_i
  end
end
