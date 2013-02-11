When /^I invite a new user to the itinerary as a (.*)$/ do |role|
  visit root_path
  click_link "My Itineraries"

  @itinerary = Itinerary.last
  @contributor_email = FactoryGirl.build(:user).email

  click_link @itinerary.title
  click_link "Send Invitation"

  fill_in "Email", with: @contributor_email
  select role, from: "Role"

  click_button "Send"
end

Then /^they are invited to join the site$/ do
  page.should have_content("An invitation has been sent")
end

When /^they accept the invitation$/ do
  step "I logout"

  open_email(@contributor_email)

  current_email.click_link "Accept"

  fill_in "Password",              with: "foobar"
  fill_in "Password confirmation", with: "foobar"

  click_button "Set my password"
end

When /^I invite an existing user to the itinerary as a (.*)$/ do |role|
  visit root_path
  click_link "My Itineraries"

  @itinerary   = Itinerary.last
  @contributor = FactoryGirl.create(:user)

  click_link @itinerary.title
  click_link "Send Invitation"

  fill_in "Email", with: @contributor.email
  select role, from: "Role"

  click_button "Send"
end

Then /^they are notified about the invitation$/ do
  open_email(@contributor.email)
  current_email.should have_content "You have been invited on a trip."
  current_email.should have_content @itinerary.title
end

Then /^they have the (.*) role on the itinerary$/ do |role|
  contributor = User.last.contributors.first
  contributor.itinerary.should == @itinerary
  contributor.role.title.should == role
end
