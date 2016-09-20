FactoryGirl.define do
  factory :group do
    name "MyString"
    association :department
  end
end
