class InviteesController < ApplicationController

  def new
    @itinerary = Itinerary.where(
      id:       params[:itinerary_id],
      user_id:  current_user.id
    ).first
  end

  def create
    @user = User.where(email: params[:invitee][:email]).first ||
      User.invite!({
        :email => params[:invitee][:email],
        :username  => "User#{User.count}"
      },
        current_user
      )
  end

end
