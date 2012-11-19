class Contributor < ActiveRecord::Base
  attr_accessible :itinerary_id, :user_id
  belongs_to :user
  belongs_to :itinerary
end
