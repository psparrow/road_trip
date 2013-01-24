class InviteesController < ApplicationController

  before_filter :load_itinerary

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
  end

  def new
    @invitee = Invitee.new
  end

  def create
    email = params[:invitee][:email]

    result = InviteeManager.
      invite_to(@itinerary, email: email) do |user, new_user|
        message = new_user ? :new_user : :existing_user
        InvitationMailer.send(message, user, @itinerary).deliver
      end

    if result
      flash[:notice] = "An invitation has been sent to #{email}"
      redirect_to @itinerary
    else
      render :new
    end
  end

end
