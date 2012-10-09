def create_itinerary
  visit root_path
  click_link "Create an itinerary"

  @attr = FactoryGirl.attributes_for(:itinerary)
  fill_in "Title", with: @attr[:title]
  fill_in "Description", with: @attr[:description]
  click_button "Save"
end

Given /^that I am a logged\-in user$/ do
  # The following functions are defined in user/registration_steps.rb
  go_to_sign_up_page
  sign_up
  verify_registration
end

When /^I create an itinerary$/ do
  create_itinerary
end

Then /^it is listed in my itineraries$/ do
  page.current_path.should == itineraries_path
  page.should have_content "Enjoy your trip!"
  page.should have_content @attr[:title]
end

And /^I have an itinerary$/ do
  create_itinerary
  @itinerary = Itinerary.last
end

When /^I view my itinerary listing$/ do
  visit root_path
  click_link "My Itineraries"
end

Then /^I can access each itinerary$/ do
  click_link @itinerary.title
  page.current_path.should == itinerary_path(@itinerary)
  page.should have_content @itinerary.title
  page.should have_content @itinerary.description
end
