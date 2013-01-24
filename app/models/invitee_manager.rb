class InviteeManager

  def self.invite_to(itinerary, args = {})
    email = args[:email]

    if user = User.where(:email => email).first
      new_user = false
    else
      user = User.invite!(email: email, username: "User#{User.count}") do |u|
        u.skip_invitation =  true
      end
      new_user = true
    end

    invitee = itinerary.invitees.build(user_id: user.id)
    result = invitee.save

    yield(user, new_user) if block_given? && result

    result
  end

end
