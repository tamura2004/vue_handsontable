# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  name         :string
#  group_id     :integer
#  job_title_id :integer
#  number       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  sequence :member_number do |n|
    "%06d" % n
  end

  factory :member do
    number {generate :member_number}
    name {Faker::Name.name}
    association :group
    association :job_title
  end
end
