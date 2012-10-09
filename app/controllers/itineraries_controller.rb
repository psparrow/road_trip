class ItinerariesController < ApplicationController

  def index
    @itineraries = current_user.itineraries
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(
      params[:itinerary].merge(user_id: current_user.id)
    )

    if @itinerary.save
      flash[:notice] = "Enjoy your trip!"
      redirect_to itineraries_path
    else
      render action: :new
    end
  end

  def show
    @itinerary = current_user.itineraries.find(params[:id])
  end

end
