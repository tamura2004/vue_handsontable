# == Schema Information
#
# Table name: projects_monthly_allocations
#
#  id         :integer          not null, primary key
#  project_id :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :projects_monthly_allocation do
    association :project
    month
    cost
  end
end
