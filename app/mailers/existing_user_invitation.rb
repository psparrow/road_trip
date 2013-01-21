class ExistingUserInvitation < ActionMailer::Base
  default from: "from@example.com"

  def notify(user, itinerary)
    @itinerary = itinerary
    mail to: user.email
  end

end
