# == Schema Information
#
# Table name: systems
#
#  id         :integer          not null, primary key
#  number     :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :system do
    number { "MyString" }
    name { "MyString" }
  end
end
