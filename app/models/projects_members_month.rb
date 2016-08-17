class ProjectsMembersMonth < ApplicationRecord
  belongs_to :projects_member, dependent: :destroy
  belongs_to :assignment, class_name: "ProjectsMember", foreign_key: "projects_member_id"

  has_one :project, through: :assignment
  has_one :group, through: :project


  validates :cost, presence: true, numericality: {greater_than: 0}
end
