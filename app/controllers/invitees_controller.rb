class InviteesController < ApplicationController

  before_filter :load_itinerary

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
  end

  def new
    @invitee = Invitee.new
  end

  def create
    user = UserInviter.find_or_invite_by_email(
      params[:invitee][:email],
      current_user
    )

    @invitee = @itinerary.invitees.build(user_id: user.id)

    if @invitee.save
      if user.exists?
        ExistingUserInvitation.notify(user, @itinerary).deliver
      end

      flash[:notice] = "An invitation has been sent to " <<
                       "#{user.email}"

      redirect_to @itinerary
    else
      render :new
    end
  end

end
