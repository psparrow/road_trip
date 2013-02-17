class ItinerariesController < ApplicationController

  before_filter :load_itinerary, only: [:edit, :update]
  before_filter :new_itinerary,  only: [:new,  :create]

  def index
    @itineraries = current_user.shared_itineraries
  end

  def new
  end

  def create
    if @itinerary.save
      @itinerary.contributors.create!(
        role_id: ROLES[:administrator],
        user:    current_user
      )
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
    if user.can_view?(params[:id])
      @itinerary     = Itinerary.find(params[:id])
      @can_add_stops = user.can_add_stops?(params[:id])
      @can_edit      = user.can_edit?(params[:id])
      @can_reorder_stops = user.can_reorder_stops?(params[:id])
    else
      flash[:notice] = "You can't view this!"
      redirect_to itineraries_path
    end
  end

  private

  def new_itinerary
    @itinerary = current_user.itineraries.build(params[:itinerary])
  end

  def load_itinerary
    if user.can_edit?(params[:id])
      @itinerary = current_user.shared_itineraries.find(params[:id])
    else
      flash[:notice] = "You cannot edit this itinerary!"
      redirect_to itineraries_path
    end
  end
end
