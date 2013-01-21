class UserInviter

  def self.find_or_invite_by_email(email, inviter)

    user = User.where(:email => email).first

    if user
      exists = true
    else
      user = User.invite!(
        {email: email, username: "User#{User.count}" },
        inviter
      )
      exists = false
    end

    user.define_singleton_method("exists?") do
      exists
    end

    user
  end

end
