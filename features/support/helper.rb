def go_to_sign_up_page
  visit root_path
  click_link "Sign up"
end

def sign_up
  @user_count = User.count

  @user = FactoryGirl.build(:user)
  fill_in "Username", with: @user.username
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  fill_in "Password confirmation", with: @user.password

  click_button "Sign up"
end

def verify_registration
  page.current_path.should == root_path

  User.count.should == @user_count + 1

  user = User.last
  user.email.should == @user.email
  user.username.should == @user.username
end
