class ArtistApplication < ApplicationRecord
  has_many :services
  belongs_to :user, optional: true
  
  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
