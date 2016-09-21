FactoryGirl.define do
  factory :projects_member do
    association :project
    association :member
  end
end
