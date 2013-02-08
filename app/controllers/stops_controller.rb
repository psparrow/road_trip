class StopsController < ApplicationController

  before_filter :load_itinerary, only: [:new, :create]

  def load_itinerary
    if security.can_add_stops?(params[:itinerary_id])
      @itinerary = Itinerary.find(params[:itinerary_id])
    else
      flash[:notice] = "You do not have permissions to add stops to this itinerary!"
      redirect_to itineraries_path
    end
  end

  def new
  end

  def create
    @stop = @itinerary.stops.build(
      params[:stop].merge(user_id: current_user.id)
    )

    if @stop.save
      flash[:notice] = "Sounds like fun!"
      redirect_to @itinerary
    else
      render :new
    end

  end
end
