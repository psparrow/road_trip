FactoryGirl.define do
  factory :user do
    email    "bob@saget.com"
    username "bobsaget"
    password "fullhouse"
    password_confirmation "fullhouse"
  end
end
