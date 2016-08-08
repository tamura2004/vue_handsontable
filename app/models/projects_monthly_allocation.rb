class ProjectsMonthlyAllocation < ApplicationRecord
  belongs_to :project
  validates :cost, presence: true, numericality: {greater_than: 0}
end
