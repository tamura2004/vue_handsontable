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

require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
