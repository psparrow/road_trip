class ItinerariesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @itineraries = Itinerary.where("user_id = ?", current_user)
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(
      params[:itinerary].merge(user_id: current_user)
    )

    if @itinerary.save
      flash[:notice] = "Enjoy your trip!"
      redirect_to itineraries_path
    else
      render action: :new
    end
  end

end
