class InviteesController < ApplicationController

  def new
    @itinerary = Itinerary.where(
      id:       params[:itinerary_id],
      user_id:  current_user.id
    ).first

    @invitee = @itinerary.invitees.new
  end

  def create
    user = User.find_or_invite_by_email!(
      email:      params[:invitee][:email],
      invited_by: current_user
    )

    @itinerary = Itinerary.where(
      id:       params[:itinerary_id],
      user_id:  current_user.id
    ).first

    @invitee = @itinerary.invitees.build({
      user_id: user.id,
    })

    if @invitee.save
      flash[:notice] = "An invitation has been sent to #{user.email}"
      redirect_to @itinerary
    else
      render :new
    end
  end

end
