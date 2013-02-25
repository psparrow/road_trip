class StopsController < ApplicationController

  before_filter :load_itinerary, only: [:new, :create]
  before_filter :load_stop,      only: [:edit, :update]

  def edit
  end

  def update
    if @stop.update_attributes(params[:stop])
      flash[:notice] = "The stop has been updated!"
      redirect_to itinerary_path(@stop.itinerary)
    else
      render :edit
    end
  end

  def new
    set_form_path
  end

  def create
    stop = @itinerary.stops.build(
      params[:stop].merge(user_id: current_user.id)
    )

    if stop.save
      flash[:notice] = "Sounds like fun!"
      redirect_to itinerary_path(@itinerary)
    else
      set_form_path(stop)
      render :new
    end
  end

  private

  def set_form_path(stop = nil)
    stop ||=  @itinerary.stops.build

    @path = [@itinerary, stop]
  end

  def load_itinerary
    if user.can_add_stops?(params[:itinerary_id])
      @itinerary = Itinerary.find(params[:itinerary_id])
    else
      flash[:notice] = "You do not have permissions to add stops to this itinerary!"
      redirect_to itineraries_path
    end
  end

  def load_stop
    @stop = @path = current_user.stops.find(params[:id])
  end

end
