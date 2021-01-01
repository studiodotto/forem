class Service < ApplicationRecord
   belongs_to :artist_application
   belongs_to :user
end
