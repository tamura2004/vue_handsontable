FactoryGirl.define do
  factory :projects_member do
    association :project
    association :member
    factory :assignment
    factory :assign
  end
end
