class InvitationsController < ApplicationController

  skip_before_filter :authenticate_user!, only: :join_via_guid

  def new
    @itinerary = current_user.itineraries.find(
      params[:itinerary_id]
    )
  end

  def create
    @itinerary = current_user.itineraries.find(
      params[:itinerary_id]
    )

    @invitation = @itinerary.invitations.build(
      params[:invitation].merge(guid: SecureRandom.urlsafe_base64)
    )

    if @invitation.valid?
      if user = User.where(email: @invitation.email).first
        Contributor.create!(
          user_id: user.id,
          itinerary_id: @itinerary.id
        )

        InvitationMailer.invite_existing_user(@invitation).deliver
      else
        @invitation.save
        InvitationMailer.invite_new_user(@invitation).deliver
      end

      flash[:notice] = "The invitation has been sent."
      redirect_to @itinerary
    else
      render :new
    end
  end

end
