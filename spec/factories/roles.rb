# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_role, class: Role  do
    id 1
    title "Administrator"
  end

  factory :contributor_role, class: Role do
    id 2
    title "Contributor"
  end

  factory :read_only_role, class: Role do
    id 3
    title "Read Only"
  end
end
