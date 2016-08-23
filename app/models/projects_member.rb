class ProjectsMember < ApplicationRecord
  include Pivot

  belongs_to :project
  belongs_to :member

  has_many :projects_members_months
  has_many :allocations, class_name: "ProjectsMembersMonth"

  validates :member_id, presence: true
  validates :project_id, presence: true

  validates :member_id, uniqueness: {
    scope: [:project_id]
  }

  scope :member_view, -> {
    select(<<-SQL)
      members.id as id,
      groups.name as group,
      job_titles.name as job,
      members.number as number,
      members.name as name,
      projects_members_months.month as month,
      sum(projects_members_months.cost) as cost
    SQL
    .joins(:project)
    .joins(:member => :job_title)
    .joins(:member => :group)
    .joins("left join projects_members_months on projects_members_months.projects_member_id = projects_members.id")
    .group(<<-SQL)
      members.id,
      groups.name,
      job_titles.name,
      members.number,
      members.name,
      projects_members_months.month
    SQL
  }

  scope :project_view, -> {
    select(<<-SQL)
      projects.id as id,
      projects.number as number,
      projects.name as name,
      projects.cost as projects_cost,
      projects_members_months.month as month,
      sum(projects_members_months.cost) as cost
    SQL
    .joins(:project => :group)
    .joins("left join projects_members_months on projects_members_months.id = projects_members.projects_members_month_id")
    .group(<<-SQL)
      projects.id,
      projects_members_months.month
    SQL
  }

end
