Given /^that I am a logged\-in user$/ do
  go_to_sign_up_page
  sign_up
end

When /^I create an itinerary$/ do
  visit root_path
  click_link "Create an itinerary"

  @attr = FactoryGirl.attributes_for(:itinerary)
  fill_in "Title", with: @attr[:title]
  fill_in "Description", with: @attr[:description]
  click_button "Save"
end

Then /^it is listed in my itineraries$/ do
  page.current_path.should == itineraries_path
  page.should have_content "Enjoy your trip!"
  page.should have_content @attr[:title]
end

When /^I select an itinerary$/ do
  @itinerary = Itinerary.last
  click_link @itinerary.title
end

Then /^I can view that itinerary$/ do
  page.current_path.should == itinerary_path(@itinerary)
  page.should have_content @itinerary.title
  page.should have_content @itinerary.description
end
