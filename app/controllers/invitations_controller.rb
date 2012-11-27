class InvitationsController < ApplicationController

  def new
    @user      = User.new
    @itinerary = Itinerary.where(
      id:       params[:itinerary_id],
      user_id:  current_user.id
    )
  end

  def create
    @user = User.where(email: params[:user][:email]).first ||
      User.invite!({
        :email => params[:user][:email],
        :username  => "User#{User.count}"
      },
        current_user
      )


  end

end
