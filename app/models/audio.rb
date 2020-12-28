class Audio < ApplicationRecord
  belongs_to :user
  belongs_to :music_release
  validates :slug, presence: true, uniqueness: true
end
