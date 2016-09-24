# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  sequence :department_name do |n|
    "第#{n}開発部"
  end

  factory :department do
    name {generate :department_name}
  end
end
