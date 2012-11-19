class InvitationMailer < ActionMailer::Base
  default from: "info@roadtrip.com"

  def invite_existing_user(invitation)
    mail(
      to: invitation.email,
      subject: "You've been invited on a trip!"
    )
  end

  def invite_new_user(invitation)
    @invitation = invitation

    # TODO: :only_path should be true, but setting the
    # default host options breaks other tests.
    @url = url_for(
      :action     => 'join_via_guid',
      :controller => 'invitations',
      :guid       => invitation.guid,
      :only_path  => true
    )

    mail(
      to: invitation.email,
      subject: "You've been invited on a trip!"
    )
  end
end
