class MusicTrack < ApplicationRecord
  belongs_to :music_release

  include Searchable
  SEARCH_SERIALIZER = Search::MusicTrackSerializer
  SEARCH_CLASS = Search::FeedContent

  delegate :slug, to: :music_release, prefix: true
  delegate :image_url, to: :music_release, prefix: true
  delegate :title, to: :music_release, prefix: true
  delegate :published, to: :music_release

  mount_uploader :image, ProfileImageUploader

  validates :guid, presence: true, uniqueness: true
  validates :media_url, presence: true
  validates :slug, presence: true
  validates :title, presence: true

  after_commit :index_to_elasticsearch, on: %i[update create]
  after_commit :remove_from_elasticsearch, on: [:destroy]

  scope :published, -> { joins(:music_release).where(music_releases: { published: true }) }
  scope :for_user, lambda { |user|
    joins(:music_release).where(music_releases: { user_id: user.id })
  }
  scope :eager_load_serialized_data, -> {}

  def search_id
    "music_track_#{id}"
  end

  after_update :purge
  after_destroy :purge, :purge_all
  after_save :bust_cache

  def path
    return unless music_release&.slug

    "/#{music_release.slug}/#{slug}"
  end

  def class_name
    self.class.name
  end

  def zero_method
    0
  end

  alias search_score zero_method

  private

  def bust_cache
    MusicTracks::BustCacheWorker.perform_async(id, path, music_release_slug)
  end
end
