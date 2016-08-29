class ProjectsMembersMonth < ApplicationRecord
  include Pivot

  belongs_to :projects_member #, dependent: :destroy
  belongs_to :assignment, class_name: "ProjectsMember", foreign_key: "projects_member_id"

  has_one :project, through: :assignment
  has_one :member, through: :assignment
  has_one :job_title, through: :member

  validates :cost, presence: true, numericality: {greater_than: 0}

  scope :ags_view, -> {
    select(<<-SQL)
      projects.number as number,
      projects.name as project,
      members.name as name,
      projects_members_months.month as month,
      projects_members_months.cost as cost
    SQL
    .joins(:project)
    .joins(:member => :job_title)
    .joins(:member => :group)
    .where("job_titles.name = 'AGS'")
    .where("groups.name = 'オープン系共通基盤'")
  }

  scope :ags_total_view, -> {
    select(<<-SQL)
      1 as number,
      '' as project,
      'AGS' as name,
      projects_members_months.month as month,
      projects_members_months.cost as cost
    SQL
    .joins(:project)
    .joins(:member => :job_title)
    .joins(:member => :group)
    .where("job_titles.name = 'AGS'")
    .where("groups.name = 'オープン系共通基盤'")
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
    .group(<<-SQL)
      members.id,
      groups.name,
      job_titles.name,
      projects_members_months.month
    SQL
  }
      # members.number,
      # members.name,

  scope :project_view, -> {
    select(<<-SQL)
      projects.number as number,
      projects.name as name,
      projects.cost as projects_cost,
      projects_members_months.month as month,
      sum(projects_members_months.cost) as cost
    SQL
    .joins(:project => :group)
    .group(<<-SQL)
      projects.id,
      projects_members_months.month
    SQL
  }

end
