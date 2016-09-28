# == Schema Information
#
# Table name: results
#
#  id             :integer          not null, primary key
#  month          :string
#  group_number   :string
#  group_name     :string
#  outsource_code :string
#  company_name   :string
#  member_number  :string
#  member_name    :string
#  project_number :string
#  project_name   :string
#  proc_number    :string
#  proc_name      :string
#  cont_number    :string
#  cont_name      :string
#  system_number  :string
#  cost           :float
#  cost_minute    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :result do
    month "MyString"
    group_number "MyString"
    group_name "MyString"
    outsource_code "MyString"
    company_name "MyString"
    member_number "MyString"
    member_name "MyString"
    project_number "MyString"
    project_name "MyString"
    proc_number "MyString"
    proc_name "MyString"
    cont_number "MyString"
    cont_name "MyString"
    system_number "MyString"
    cost 1.5
    cost_minute "MyString"
  end
end