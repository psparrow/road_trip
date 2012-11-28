class ItinerariesController < ApplicationController

  def index
    @itineraries = current_user.itineraries.all

    current_user.invitees.each do |invitee|
       @itineraries << invitee.itinerary
    end

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

  def edit
    @itinerary = current_user.itineraries.find(params[:id])
  end

  def update
    @itinerary = current_user.itineraries.find(params[:id])
    if @itinerary.update_attributes(params[:itinerary])
      flash[:notice] = "The itinerary has been updated!"
      redirect_to itinerary_path(@itinerary)
    else
      render action: :edit
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])

    if @itinerary.user_id != current_user.id &&
      Invitee.where(user_id: current_user.id, itinerary_id: params[:id]) == []
      flash[:notice] = "You can't do that!"
      redirect_to root_path
    end
  end

end
