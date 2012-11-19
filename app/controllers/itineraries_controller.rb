class ItinerariesController < ApplicationController

  def index
    invitations = Invitation.where(email: current_user.email)
    invitations.each do |i|
      Contributor.create!(
        user_id:       current_user.id,
        itinerary_id:  i.itinerary_id
      )
    end
    @itineraries = current_user.all_itineraries
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
    @itinerary = current_user.itineraries.find(params[:id])
  end

end
