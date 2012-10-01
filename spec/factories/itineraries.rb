FactoryGirl.define do
  factory :itinerary do
    title "My Trip to Mars"
    association :user, factory: :user
  end
end
