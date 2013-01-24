class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_user(user, itinerary)
    @itinerary = itinerary
    @user = user
    mail to: user.email
  end

  def existing_user(user, itinerary)
    @itinerary = itinerary
    mail to: user.email
  end

end
