class Itinerary < ActiveRecord::Base
  belongs_to :user
  has_many :stops, :invitations, :contributors
  attr_accessible :title, :description, :user_id
  validates_presence_of :title, :user_id
end
