class Stop < ActiveRecord::Base
  attr_accessible :title, :description, :url,
                  :city, :state, :zip_code, :position,
                  :itinerary_id, :user_id

  belongs_to :itinerary
  acts_as_list :scope =>:itinerary

  belongs_to :user

  validates_presence_of :title, :itinerary_id, :user_id
end
