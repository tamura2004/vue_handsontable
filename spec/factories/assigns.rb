# == Schema Information
#
# Table name: assigns
#
#  id         :integer          not null, primary key
#  project_id :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :assign do
    association :project
    association :member
  end
end
