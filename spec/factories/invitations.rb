# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    itinerary_id 1
    email "MyString"
    guid "MyString"
    accepted false
  end
end
