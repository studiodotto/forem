class ProjectEvent < ApplicationRecord
  belongs_to :organization
  enum event_type: {"ninty_second"=>"ninty_second", "casual"=>"casual", "sport"=>"sport"}
end
