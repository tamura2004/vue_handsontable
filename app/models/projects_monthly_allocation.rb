class ProjectsMonthlyAllocation < ApplicationRecord
  belongs_to :project
  has_one :group, through: :project

  validates :cost, presence: true, numericality: {greater_than: 0}

  scope :pivot, -> {
    all.group_by(&:project_id).map do |project_id,rows|
      rows.inject(project_id: project_id) do |memo,row|
        memo.merge row.month => row.cost
      end
    end
  }

  scope :view, -> {
    find_by_sql <<-SQL
      select
        groups.id as group_id,
        groups.name as group_name,
        projects.id as project_id,
        projects.name as project_name,
        projects.number as project_number,
        alloc.month as month,
        alloc.cost as cost
      from projects_monthly_allocations as alloc
      inner join projects on projects.id = alloc.project_id
      inner join groups on groups.id = projects.group_id
    SQL
  }

end
