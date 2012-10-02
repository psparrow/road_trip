Given /^that I am registering for an account$/ do
  visit root_path
  click_link "Sign up"
  visit new_user_registration_path
  page.should have_content "Sign up"
end

When /^I fill out the registration form$/ do
  @user_count = User.count
  @user = FactoryGirl.build(:user)
  fill_in "Username", with: @user.username
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  fill_in "Password confirmation", with: @user.password
  click_button "Sign up"
end

Then /^I am registered as a user$/ do
  page.current_path.should == root_path
  User.count.should == @user_count + 1
  user = User.last
  user.email.should == @user.email
  user.username.should == @user.username
end
