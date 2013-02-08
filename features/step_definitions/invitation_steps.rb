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

Then /^they can view the itinerary$/ do
  click_link "My Itineraries"
  click_link @itinerary.title

  page.should have_content @itinerary.description
end

And /^they cannot add stops to the itinerary$/ do
  page.should_not have_content "Add a Stop"
end

And /^they can add stops to the itinerary$/ do
  click_link "Add a Stop"
  @stop_count = Stop.count
  attr = FactoryGirl.attributes_for(:another_stop)

  fill_in "Title",       with: attr[:title]
  fill_in "Description", with: attr[:description]
  fill_in "Url",         with: attr[:url]
  fill_in "City",        with: attr[:city]
  fill_in "State",       with: attr[:state]
  click_button "Save"

  Stop.count.should == @stop_count + 1

  page.should have_content(attr[:title])
  page.should have_content(attr[:description])
  page.should have_content(attr[:city])
  page.should have_content(attr[:state])
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

When /^they login$/ do
  step "I logout"

  visit root_path
  click_link "Login"

  attr = FactoryGirl.attributes_for(:user)

  fill_in "Login", with: @contributor.email
  fill_in "Password", with: attr[:password]

  click_button "Sign in"
end
