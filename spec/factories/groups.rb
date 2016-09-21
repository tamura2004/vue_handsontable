FactoryGirl.define do
  sequence :group_name do |n|
    "第#{n}グループ"
  end

  factory :group do
    name {generate :group_name}
    association :department
  end
end
