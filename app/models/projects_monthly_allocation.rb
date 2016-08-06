class ProjectsMonthlyAllocation < ApplicationRecord
  belongs_to :project
  validates :cost, presence: true
end
