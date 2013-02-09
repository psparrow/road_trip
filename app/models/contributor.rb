class Contributor < ActiveRecord::Base
  attr_accessible :email, :itinerary_id, :user_id, :role_id, :user, :itinerary

  attr_accessor   :email

  belongs_to      :user
  belongs_to      :itinerary
  belongs_to      :role

  validates_presence_of :role_id, :user_id, :itinerary_id
end
