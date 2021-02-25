class Audio < ApplicationRecord
  belongs_to :user
  belongs_to :music_release, optional: true
  belongs_to :organization, optional: true
  has_and_belongs_to_many :playlists
  validates :slug, presence: true, uniqueness: true
  scope :published, -> { where(status: true) }
end
