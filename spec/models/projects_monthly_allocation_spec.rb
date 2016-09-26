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

require 'rails_helper'

RSpec.describe ProjectsMonthlyAllocation, type: :model do
  subject{build :projects_monthly_allocation}
  it {should be_valid}
end
