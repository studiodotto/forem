class MusicRelease < ApplicationRecord
  resourcify

  belongs_to :user
  has_many :music_tracks, dependent: :destroy
  has_many :audios, dependent: :destroy

  mount_uploader :image, ProfileImageUploader
  mount_uploader :pattern_image, ProfileImageUploader

  validates :main_color_hex, :title, :description, :image, presence: true
  validates :main_color_hex, format: /\A([a-fA-F]|[0-9]){6}\Z/
  validates :slug,
            presence: true,
            uniqueness: true,
            format: { with: /\A[a-zA-Z0-9\-_]+\Z/ },
            exclusion: { in: ReservedWords.all, message: "slug is reserved" }
  validate :unique_slug_including_users_and_orgs, if: :slug_changed?

  # after_save :bust_cache

  scope :published, -> { where(published: true) }
  scope :eager_load_serialized_data, -> { includes(:user, :podcast) }

  alias_attribute :path, :slug
  alias_attribute :profile_image_url, :image_url
  alias_attribute :name, :title

  def existing_track(item)
    track = MusicTrack.where(media_url: item.url)
                .or(MusicTrack.where(title: item.title))
                .or(MusicTrack.where(guid: item.guid.to_s)).presence

    track.to_a.first
  end

  def image_90
    Images::Profile.call(profile_image_url, length: 90)
  end

  private

  def unique_slug_including_users_and_orgs
    slug_exists = User.exists?(username: slug) || Organization.exists?(slug: slug) || Page.exists?(slug: slug)
    errors.add(:slug, "is taken.") if slug_exists
  end

  # def bust_cache
  #   return unless path
  #
  #   Podcasts::BustCacheWorker.perform_async(path)
  # end
end
