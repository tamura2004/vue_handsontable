# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  department_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  sequence :group_name do |n|
    "第#{n}グループ"
  end

  factory :group do
    name {generate :group_name}
    association :department
  end
end
