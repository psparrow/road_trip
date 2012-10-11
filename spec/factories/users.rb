FactoryGirl.define do

  sequence :email do |n|
    "dannytanner#{n}@fullhouse.com"
  end

  sequence :username do |n|
    "bobsaget#{n}"
  end

  factory :user do
    email
    username
    password "fullhouse"
    password_confirmation "fullhouse"
  end

end
