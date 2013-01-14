class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

    def itineraries_for_current_user
    itineraries = current_user.itineraries.all

    current_user.invitees.each do |invitee|
      itineraries << invitee.itinerary
    end

    itineraries
  end

  def itinerary_for_current_user(itinerary_id)
    Itinerary.find_for_user(itinerary_id, current_user)
  end

end
