When /^I invite a non\-user to the itinerary$/ do
  visit root_path
  click_link "My Itineraries"

  @attr = FactoryGirl.attributes_for(:itinerary)
  click_link @attr[:title]
  click_link "Send Invitation"

  fill_in "Email", with: "pat@test.com"
  click_button "Send"
end
