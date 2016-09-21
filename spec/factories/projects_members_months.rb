FactoryGirl.define do
  factory :projects_members_month do
    association :projects_member
    month "MyString"
    cost 1.5
  end
end
