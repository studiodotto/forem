import { h } from 'preact';
import PropTypes from 'prop-types';

export const MusicReleaseFeed = ({ musicReleaseItems }) => {
  const musicReleaseItemDivs = musicReleaseItems.map((ep) => (
    <a
      className="individual-podcast-link"
      href={`/${ep.music_release.slug}/${ep.slug}`}
    >
      <img src={ep.music_release.image_90} alt={ep.music_release.title} />
      <div className="individual-podcast-link-details">
        <strong>{ep.title}</strong>
        {ep.music_release.title}
      </div>
    </a>
  ));
  return (
    <div className="single-article single-article-podcast-div">
      <h3>
        <a href="/music_releases">Today&apos;s Music releases</a>
      </h3>
      {musicReleaseItemDivs}
    </div>
  );
};

MusicReleaseFeed.propTypes = {
  musicReleaseItems: PropTypes.arrayOf(PropTypes.object).isRequired,
};
