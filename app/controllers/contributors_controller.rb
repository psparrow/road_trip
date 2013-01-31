class ContributorsController < ApplicationController

  before_filter :load_itinerary

  def load_itinerary
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
  end

  def new
    @contributor = Contributor.new
  end

  def create
    @contributor = Contributor.new(params[:contributor])

    command = AddContributorToItinerary.new(
      @contributor,
      @itinerary
    )

    if command.perform
      flash[:notice] = "An invitation has been sent!"
      redirect_to @itinerary
    else
      render :new
    end
  end

end
