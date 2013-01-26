class ContributorManager

  attr_reader :new_user, :user, :itinerary

  def initialize(itinerary)
    @itinerary = itinerary
  end

  def add_by_email(email)
    load_or_invite_user_by_email(email)

    if itinerary.add_invitee(user)
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
    InvitationMailer.send(message, user, itinerary).deliver
  end

end
