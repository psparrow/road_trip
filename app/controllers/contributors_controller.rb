class ContributorsController < ApplicationController

  before_filter :load_itinerary

  def new
    @contributor = Contributor.new
  end

  def create
    find_or_invite_user(params[:contributor][:email])

    @contributor = Contributor.new(
      params[:contributor].merge(user: @user, itinerary: @itinerary)
    )

    if @contributor.save
      InvitationMailer.send(@msg, @user, @itinerary).deliver
      flash[:notice] = "An invitation has been sent!"
      redirect_to @itinerary
    else
      render :new
    end
  end

  private

  def find_or_invite_user(email)
    if @user = User.find_by_email(email)
      @msg  = :existing_user
    else
      @user = User.invite_by_email(email)
      @msg  = :new_user
    end
  end

  def load_itinerary
    if user.can_invite_to?(params[:itinerary_id])
      @itinerary = current_user.shared_itineraries.find(params[:itinerary_id])
    else
      flash[:notice] = "You do not have permission to access this feature!"
      redirect_to itineraries_path
    end
  end

end
