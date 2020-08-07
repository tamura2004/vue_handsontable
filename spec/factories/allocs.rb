# == Schema Information
#
# Table name: allocs
#
#  id         :integer          not null, primary key
#  assign_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :alloc do
    association :assign
    month
    cost
  end
end
