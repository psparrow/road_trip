When /^I invite a non\-user to the itinerary$/ do
  visit root_path
  click_link "My Itineraries"

  @itinerary = Itinerary.last
  @invitee_email = "pat@test.net"
  click_link @itinerary.title
  click_link "Send Invitation"

  fill_in "Email", with: @invitee_email
  click_button "Send"
end

Then /^they are invited to join the site$/ do
  page.should have_content("An invitation has been sent to #{@invitee_email}")
end

When /^they accept the invitation$/ do
  open_email(@invitee_email)
  current_email.click_link "Accept"

  fill_in "Password", with: "foobar"
  fill_in "Password confirmation", with: "foobar"
  click_button "Set my password"
end

Then /^they can view the itinerary$/ do
  click_link "My Itineraries"
  click_link @itinerary.title
  page.should have_content @itinerary.description
end

And /^they can add stops to the itinerary$/ do
  fail
end

