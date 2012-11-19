When /^I give an existing user access to the itinerary$/ do
  @invitee   = FactoryGirl.build(:user)
  @invitee.save
  @itinerary = Itinerary.last

  send_invitation(
    email:     @invitee.email,
    itinerary: @itinerary
  )

end

Then /^they are alerted about the itinerary$/ do
  open_email(@invitee.email)
  current_email.should_not be_nil
end

When /^they follow the login link$/ do
  visit destroy_user_session_path
  current_email.click_link "Click here"
  fill_in "Login", with: @invitee.username
  fill_in "Password", with: @invitee.password
  click_button "Sign in"
end

When /^I give a non\-user access to the itinerary$/ do
  @invitee_attrs = FactoryGirl.attributes_for(:user)
  @itinerary     = Itinerary.last
  send_invitation(
    email:     @invitee_attrs[:email],
    itinerary: @itinerary
  )
end

Then /^they are sent an invitation to join the site$/ do
  open_email(@invitee_attrs[:email])
  current_email.should_not be_nil
end

When /^they join via the join link$/ do
  visit destroy_user_session_path
  current_email.click_link "Click here"
  fill_in "Username", with: @invitee_attrs[:username]
  fill_in "Email",    with: @invitee_attrs[:email]
  fill_in "Password", with: @invitee_attrs[:password]
  fill_in "Password confirmation", with: @invitee_attrs[:password]

  click_button "Sign up"
end

Then /^the itinerary is listed in their itineraries$/ do
  click_link "My Itineraries"
  page.should have_content(@itinerary.title)
end


