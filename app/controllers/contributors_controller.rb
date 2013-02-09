class ContributorsController < ApplicationController

  before_filter :load_itinerary

  def new
    @contributor = Contributor.new
  end

  def create
    email = params[:contributor][:email]

    if user = User.find_by_email(email)
      msg  = :existing_user
    else
      user = User.invite_by_email(email)
      msg  = :new_user
    end

    @contributor = Contributor.new(
      params[:contributor].merge(user: user, itinerary: @itinerary)
    )

    if @contributor.save
      InvitationMailer.send(msg, user, @itinerary).deliver
      flash[:notice] = "An invitation has been sent!"
      redirect_to @itinerary
    else
      render :new
    end
  end

  private

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
  end

end
