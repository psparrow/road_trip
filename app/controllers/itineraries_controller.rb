class ItinerariesController < ApplicationController

  before_filter :load_itinerary, only: [:edit, :update]

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:id])
  end

  def index
    @itineraries = itineraries_for_current_user
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = current_user.itineraries.build(params[:itinerary])

    if @itinerary.save
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
    @itinerary = itinerary_for_current_user(params[:id])
  end

end
