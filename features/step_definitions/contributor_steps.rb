Given /^I have the (.*) role on an itinerary$/ do |role_title|
  @user        = User.last

  @itinerary   = FactoryGirl.create(:itinerary)

  @contributor = FactoryGirl.create(
    :contributor,
    itinerary_id: @itinerary.id,
    user_id:      @user.id,
    role_id:      ROLES[get_role_symbol(role_title)]
  )
end

Then /^I can view the itinerary$/ do
  click_link "My Itineraries"
  click_link @itinerary.title

  page.should have_content @itinerary.description
end

Then /^I can edit the itinerary$/ do
  visit itinerary_path(@itinerary)

  title = "Updated Itinerary"
  description = "TESTING!!!"

  click_link "Edit Itinerary"

  fill_in "Title", with: title
  fill_in "Description", with: description
  click_button "Save"

  page.current_path.should == itinerary_path(@itinerary)
  page.should have_content title
  page.should have_content description
end

Then /^I cannot edit the itinerary$/ do
  visit itinerary_path(@itinerary)

  page.should_not have_content "Edit Itinerary"
end

And /^I cannot add stops to the itinerary$/ do
  visit itinerary_path(@itinerary)

  page.should_not have_content "Add a Stop"
end

And /^I can add stops to the itinerary$/ do
  visit itinerary_path(@itinerary)

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

Then /^I can invite contributors to the itinerary$/ do
  visit itinerary_path(@itinerary)

  click_link "Send Invitation"

  @contributor_email = FactoryGirl.build(:user).email

  fill_in "Email",     with: @contributor_email
  select  "Read Only", from: "Role"

  click_button "Send"

  contributor = Contributor.last
  user        = User.last

  contributor.itinerary_id.should == @itinerary.id
  contributor.user_id.should      == user.id
  user.email.should               == @contributor_email
end

Then /^I cannot invite contributors to the itinerary$/ do
  visit itinerary_path(@itinerary)

  page.should_not have_content "Send Invitation"
end
