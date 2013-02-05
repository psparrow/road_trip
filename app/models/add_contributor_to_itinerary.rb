class AddContributorToItinerary

  attr_reader :new_user, :user, :itinerary, :contributor, :mailer

  def initialize(contributor, itinerary)
    @itinerary   = itinerary
    @contributor = contributor
    @mailer      = InvitationMailer
  end

  def perform
    load_or_invite_user_by_email(contributor.email)

    contributor.user      = user
    contributor.itinerary = itinerary

    if contributor.save
      send_invitation
      true
    else
      false
    end
  end

  private

  def load_or_invite_user_by_email(email)
    if @user = User.find_by_email(email)
      @new_user = false
    else
      @user = User.invite_by_email(email)
      @new_user = true
    end
  end

  def send_invitation
    message = new_user ? :new_user : :existing_user
    mailer.send(message, user, itinerary).deliver
  end

end
