# == Schema Information
#
# Table name: job_titles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  sequence :job_title_name do |n|
    "#{n}班"
  end

  factory :job_title do
    name {generate :job_title_name}
  end
end
