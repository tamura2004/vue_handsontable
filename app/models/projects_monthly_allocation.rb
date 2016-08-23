class ProjectsMonthlyAllocation < ApplicationRecord
  include Pivot

  belongs_to :project
  has_one :group, through: :project

  validates :cost, presence: true, numericality: {greater_than: 0}

  scope :group_view, -> {
    select(<<-"SQL")
      groups.id as groups_id,
      groups.name as groups_name,
      projects_monthly_allocations.month as month,
      sum(projects_monthly_allocations.cost) as cost
    SQL
    .joins(:group)
    .group(:groups_id, :month)
  }

end




