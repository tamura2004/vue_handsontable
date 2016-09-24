# == Schema Information
#
# Table name: projects_members
#
#  id         :integer          not null, primary key
#  project_id :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :projects_member do
    association :project
    association :member

    # 別名定義
    factory :assignment
    factory :assign
  end
end
