Given /^that I am registering for an account$/ do
  go_to_sign_up_page
end

When /^I fill out the registration form$/ do
  sign_up
end

Then /^I am registered as a user$/ do
  verify_registration
end
