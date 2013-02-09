class ItinerariesController < ApplicationController

  before_filter :load_itinerary, only: [:edit, :update]

  def index
    @itineraries = current_user.itineraries
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(params[:itinerary])

    if CreateNewItinerary.new(@itinerary, current_user).perform
      flash[:notice] = "Enjoy your trip!"
      redirect_to itineraries_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @itinerary.update_attributes(params[:itinerary])
      flash[:notice] = "The itinerary has been updated!"
      redirect_to itinerary_path(@itinerary)
    else
      render action: :edit
    end
  end

  def show
    if security.can_view?(params[:id])
      @itinerary     = Itinerary.find(params[:id])
      @can_add_stops = security.can_add_stops?(params[:id])
    else
      flash[:notice] = "You can't view this!"
      redirect_to itineraries_path
    end
  end

  private

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:id])
  end
end
