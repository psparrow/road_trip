Given /^that I am a logged\-in user$/ do
  go_to_sign_up_page
  sign_up
end

When /^I create an itinerary$/ do
  create_itinerary
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

Given /^I have an itinerary$/ do
  create_itinerary
end
