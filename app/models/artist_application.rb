class ArtistApplication < ApplicationRecord
  has_many :services, dependent: :destroy
  belongs_to :user, optional: true
  validates :email, uniqueness: true
end
