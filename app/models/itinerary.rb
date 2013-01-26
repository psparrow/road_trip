class Itinerary < ActiveRecord::Base
  belongs_to :user
  has_many :stops
  has_many :invitees
  attr_accessible :title, :description, :user_id
  validates_presence_of :title, :user_id

  def self.find_for_user(id, user)
    if invitee = Invitee.where(itinerary_id: id, user_id: user.id).first
     invitee.itinerary
    else
      user.itineraries.find(id)
    end
  end

  def add_invitee(user)
    invitees.create(user_id: user.id)
  end

end
