class Invitee < ActiveRecord::Base
  belongs_to      :user
  belongs_to      :itinerary
  attr_accessible :itinerary_id, :user_id
  attr_accessor   :email
end
