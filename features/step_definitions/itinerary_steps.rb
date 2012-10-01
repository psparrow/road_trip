Given /^that I am a logged\-in user$/ do
  step "that I have a user account"
  step "I submit the login form"
  step "I am logged into the application"
end

When /^I create an itinerary$/ do
  visit new_itinerary_path

  @itinerary = FactoryGirl.build(:itinerary)
  fill_in "Title", with: @itinerary.title
  click_button "Save"
end

Then /^it is listed in my itineraries$/ do
  page.current_path.should == itineraries_path
  page.should have_content "Enjoy your trip!"
  page.should have_content @itinerary.title
end
