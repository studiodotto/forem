import { h } from 'preact';
import { articlePropTypes } from '../common-prop-types';

export const MusicTrack = ({ track }) => {
  return (
    <div data-testid="podcast-episode" className="crayons-podcast-episode">
      <a
        href={`/${track.music_release.slug}/${track.slug}`}
        className="crayons-podcast-episode__cover"
      >
        <img src={track.music_release.image_90} alt={track.title} />
      </a>

      <div>
        <p className="crayons-podcast-episode__author">
          {track.music_release.title}
        </p>
        <h2 className="crayons-podcast-episode__title crayons-story__title mb-0">
          <a href={`/${track.music_release.slug}/${track.slug}`}>
            {track.title}
          </a>
        </h2>
      </div>
    </div>
  );
};

MusicTrack.propTypes = {
  track: articlePropTypes.isRequired,
};

MusicTrack.displayName = 'MusicTrack';
