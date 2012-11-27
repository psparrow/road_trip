class Itinerary < ActiveRecord::Base
  belongs_to :user
  has_many :stops
  has_many :invitees
  attr_accessible :title, :description, :user_id
  validates_presence_of :title, :user_id
end
