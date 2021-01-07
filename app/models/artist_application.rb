class ArtistApplication < ApplicationRecord
  has_many :services
  belongs_to :user, optional: true
end
