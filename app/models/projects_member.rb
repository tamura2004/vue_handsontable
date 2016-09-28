# == Schema Information
#
# Table name: projects_members
#
#  id         :integer          not null, primary key
#  project_id :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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

  # scope :member_view, -> {
  #   select(<<-SQL)
  #     members.id as id,
  #     groups.name as group,
  #     job_titles.name as job,
  #     members.number as number,
  #     members.name as name,
  #     projects_members_months.month as month,
  #     projects_members_months.cost as cost
  #   SQL
  #   .joins(:project)
  #   .joins(:member => :job_title)
  #   .joins(:member => :group)
  #   .left_joins(:projects_members_months)
  # }

  # scope :project_view, -> {
  #   select(<<-SQL)
  #     projects.id as id,
  #     projects.number as number,
  #     projects.name as name,
  #     projects.cost as projects_cost,
  #     projects_members_months.month as month,
  #     projects_members_months.cost as cost
  #   SQL
  #   .joins(:project => :group)
  #   .left_joins(:projects_members_months)
  # }


end
