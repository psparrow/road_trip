class Itinerary < ActiveRecord::Base
  belongs_to :user
  has_many :itineraries
  attr_accessible :title, :description, :user_id
  validates_presence_of :title, :user_id
end
