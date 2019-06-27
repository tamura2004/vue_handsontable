# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :work do
    association :member
    month { "MyString" }
    cost { 1.5 }
  end
end
