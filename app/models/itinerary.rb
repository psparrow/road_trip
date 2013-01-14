class Itinerary < ActiveRecord::Base
  belongs_to :user
  has_many :stops
  has_many :invitees
  attr_accessible :title, :description, :user_id
  validates_presence_of :title, :user_id

  def self.find_for_user(id, user)
    invitee = Invitee.where(itinerary_id: id, user_id: user.id).first

    if invitee
      itinerary = invitee.itinerary
    end

    itinerary = user.itineraries.find(id) if !itinerary
    itinerary
  end

end
