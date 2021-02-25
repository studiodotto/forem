class Playlist < ApplicationRecord
  belongs_to :artist, foreign_key: :user_id
  has_and_belongs_to_many :audios

  def new

  end
end
