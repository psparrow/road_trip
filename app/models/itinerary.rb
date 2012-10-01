class Itinerary < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :user_id
  validates_presence_of :title, :user_id
end
