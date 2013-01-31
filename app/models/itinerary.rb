class Itinerary < ActiveRecord::Base
  belongs_to :user
  has_many   :stops
  has_many   :contributors

  attr_accessible :title, :description, :user_id

  validates_presence_of :title, :user_id

  def self.find_for_user(id, user)
    if contributor = Contributor.where(itinerary_id: id, user_id: user.id).first
     contributor.itinerary
    else
      user.itineraries.find(id)
    end
  end

  def add_contributor(user)
    contributors.build(user_id: user.id).save
  end

end
