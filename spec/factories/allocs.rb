# == Schema Information
#
# Table name: projects_members_months
#
#  id                 :integer          not null, primary key
#  projects_member_id :integer
#  month              :string
#  cost               :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :alloc do
    association :assign
    month
    cost
  end
end
