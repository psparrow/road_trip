class InviteesController < ApplicationController

  def new
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
    @invitee = @itinerary.invitees.new
  end

  def create
    @itinerary = current_user.itineraries.find(params[:itinerary_id])

    user = User.where(email: params[:invitee][:email]).first

    if !user
      user = User.invite!(
        { email: params[:invitee][:email], username: "User#{User.count}" },
        current_user
      )
      user_exists = false
    else
      user_exists = true
    end

    @invitee = @itinerary.invitees.build({ user_id: user.id })

    if @invitee.save
      if user_exists
        # Newly invited users already receive an email.  Another email should
        # be sent to existing users alerting them about the shared itinerary
      end
      flash[:notice] = "An invitation has been sent to #{user.email}"
      redirect_to @itinerary
    else
      render :new
    end
  end

end
