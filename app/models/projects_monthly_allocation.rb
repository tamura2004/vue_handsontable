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

class ProjectsMonthlyAllocation < ApplicationRecord
  include Pivot

  belongs_to :project
  has_one :group, through: :project

  validates :cost, presence: true, numericality: {greater_than: 0}

end




