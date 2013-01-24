class InviteeManager

  def self.invite_to(itinerary, args = {})
    if user = User.where(:email => args[:email]).first
      new_user = false
    else
      user = User.invite_by_email(args[:email])
      new_user = true
    end

    if itinerary.invitees.create(user_id: user.id)
      yield(user, new_user) if block_given?
      true
    else
     false
    end
  end

end
