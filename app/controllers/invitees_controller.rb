class InviteesController < ApplicationController

  before_filter :load_itinerary

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
  end

  def new
    @invitee = Invitee.new
  end

  def create
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
        ExistingUserInvitation.notify(user, @itinerary).deliver
      end
      flash[:notice] = "An invitation has been sent to #{user.email}"
      redirect_to @itinerary
    else
      render :new
    end
  end

end
