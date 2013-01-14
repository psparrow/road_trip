Given /^that I have an itinerary$/ do
  visit root_path
  click_link "Create an itinerary"

  @attr = FactoryGirl.attributes_for(:itinerary)
  fill_in "Title", with: @attr[:title]
  fill_in "Description", with: @attr[:description]
  click_button "Save"
end

When /^I add a stop to the itinerary$/ do
  click_link @attr[:title]
  click_link "Add a Stop"

  @stop_count = Stop.count
  @stop_attr = FactoryGirl.attributes_for(:stop)
  fill_in "Title",       with: @stop_attr[:title]
  fill_in "Description", with: @stop_attr[:description]
  fill_in "Url",         with: @stop_attr[:url]
  fill_in "City",        with: @stop_attr[:city]
  fill_in "State",       with: @stop_attr[:state]
  click_button "Save"
end

Then /^it is listed in the stops$/ do

  Stop.count.should == @stop_count + 1

  page.should have_content(@attr[:title])
  page.should have_content(@stop_attr[:title])
  page.should have_content(@stop_attr[:description])
  page.should have_content(@stop_attr[:city])
  page.should have_content(@stop_attr[:state])

  click_link "More info"
  page.current_url.should have_content(@stop_attr[:url])
end
