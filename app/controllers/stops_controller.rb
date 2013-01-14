class StopsController < ApplicationController

  def new
    @itinerary = itinerary_for_current_user(params[:itinerary_id])
  end

  def create
    @itinerary = itinerary_for_current_user(params[:itinerary_id])

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
