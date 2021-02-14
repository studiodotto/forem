class Audio < ApplicationRecord
  belongs_to :user
  belongs_to :music_release, optional: true
  belongs_to :organization, optional: true
  validates :slug, presence: true, uniqueness: true

  scope :published, -> { where(status: true) }
end
