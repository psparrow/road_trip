# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stop do
    title "The White House"
    description "It's where the President lives."
    city "Washington"
    state "DC"
    url "http://www.whitehouse.gov"
    user
    itinerary
  end
end
