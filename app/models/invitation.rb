class Invitation < ActiveRecord::Base
  belongs_to :user
  attr_accessible :accepted, :email, :guid, :itinerary_id
end
