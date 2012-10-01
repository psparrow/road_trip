Given /^that I have a user account$/ do
  attr = FactoryGirl.attributes_for(:user)
  @user = User.new(attr)
  @user.save.should == true
end

When /^I submit the login form$/ do
  visit new_user_session_path

  user = FactoryGirl.build(:user)
  fill_in "Login",    with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
end

Then /^I am logged into the application$/ do
  page.current_path.should == root_path
  page.should have_content "Signed in successfully."
end

When /^I logout$/ do
  visit destroy_user_session_path
end

Then /^I am no longer logged into the application$/ do
  page.current_path.should == root_path
  page.should have_content "Signed out successfully."
end
