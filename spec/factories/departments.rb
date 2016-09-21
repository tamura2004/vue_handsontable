FactoryGirl.define do
  sequence :department_name do |n|
    "第#{n}開発部"
  end

  factory :department do
    name {generate :department_name}
  end
end
