# == Schema Information
#
# Table name: projects_members_months
#
#  id                 :integer          not null, primary key
#  projects_member_id :integer
#  month              :string
#  cost               :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ProjectsMembersMonth < ApplicationRecord
  include Pivot

  rails_admin do
    visible false
  end

  belongs_to :projects_member
  belongs_to :assignment, class_name: "ProjectsMember", foreign_key: "projects_member_id"
  belongs_to :assign, class_name: "ProjectsMember", foreign_key: "projects_member_id"

  has_one :project, through: :assignment
  has_one :member, through: :assignment
  has_one :job_title, through: :member

  validates :cost, presence: true, numericality: {greater_than: 0}

  scope :member_chart, -> {
    joins(:member)
    .where("month > ?", "201703")
    .group("members.job_title_id")
    .group("members.id")
    .group("members.number")
    .group("members.name")
    .group(:month)
    .order("members.job_title_id")
    .order("members.number")
    .order(:month)
    .sum(:cost)
    .group_by{|k,v|[k[1],k[3]]}
  }

  scope :project_chart, -> {
    joins(:project)
    .where("month > ?", "201703")
    .group("projects.id")
    .group("projects.number")
    .group("projects.name")
    .group(:month)
    .order("projects.number")
    .order(:month)
    .sum(:cost)
    .group_by{|k,v|[k[0],k[1],k[2]]}
  }

end
