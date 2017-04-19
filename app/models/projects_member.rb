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

  rails_admin do
    visible false
  end

  belongs_to :project
  belongs_to :member

  has_many :projects_members_months, dependent: :destroy
  has_many :allocations, class_name: "ProjectsMembersMonth"
  has_many :allocs, class_name: "ProjectsMembersMonth"

  validates :member_id, presence: true
  validates :project_id, presence: true

  validates :member_id, uniqueness: {
    scope: [:project_id]
  }

  scope :recent, -> {
    joins(:allocs)
    .includes(:project)
    .includes(:member)
    .where("projects_members_months.month > ?","201703")
  }


end
