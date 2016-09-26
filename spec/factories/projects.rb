# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  number     :string
#  name       :string
#  cost       :float
#  rd         :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  sequence :project_number do |n|
    sprintf("2%05d%04d-%02d-a",n*13,n*7,n%5)
  end

  sequence :project_name do |n|
    actions = %w(更改 構築 改善 制度対応 機能追加)
    Faker::Company.name + "システムの" + actions[n % actions.size]
  end

  factory :project do
    name {generate :project_name}
    association :group
    number {generate :project_number}
    cost 1.5
    rd 1.5
  end
end
