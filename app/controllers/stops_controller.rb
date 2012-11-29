class StopsController < ApplicationController

  def new
    @itinerary = Itinerary.find_for_user(params[:itinerary_id], current_user)
  end

  def create
    @itinerary = Itinerary.find_for_user(params[:itinerary_id], current_user)

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
