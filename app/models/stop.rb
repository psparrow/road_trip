class Stop < ActiveRecord::Base
  attr_accessible :title, :description, :url,
                  :city, :state, :zip_code,
                  :itinerary_id, :user_id

  belongs_to :itinerary, :user
  validates_presence_of :title, :itinerary_id, :user_id
end
