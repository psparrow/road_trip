def get_role_factory_key(role)
  role.downcase.gsub(/ /, '_') + '_role'
end

def get_role_symbol(role)
  role.downcase.gsub(/ /, '_').to_sym
end

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
  user.email.should    == @user.email
  user.username.should == @user.username
end

def create_itinerary
  visit root_path
  click_link "Create an itinerary"

  @attr = FactoryGirl.attributes_for(:itinerary)
  fill_in "Title", with: @attr[:title]
  fill_in "Description", with: @attr[:description]
  click_button "Save"
end
