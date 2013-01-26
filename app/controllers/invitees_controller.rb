class InviteesController < ApplicationController

  before_filter :load_itinerary

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
  end

  def new
    @invitee = Invitee.new
  end

  def create
    manager = ContributorManager.new(@itinerary)

    if manager.add_by_email(params[:invitee][:email])
      flash[:notice] = "An invitation has been sent!"
      redirect_to @itinerary
    else
      render :new
    end
  end

end
