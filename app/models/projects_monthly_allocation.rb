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




