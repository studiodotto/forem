class Order < ApplicationRecord
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
  belongs_to :music_release, optional: true, foreign_key: 'release_id'
  belongs_to :organization
end
