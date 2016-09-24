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

require 'test_helper'

class ProjectsMonthlyAllocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
