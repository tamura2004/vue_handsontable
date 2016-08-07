class ProjectsMember < ApplicationRecord
  belongs_to :project
  belongs_to :member

  has_many :projects_members_months

  validates :member_id, presence: true
  validates :project_id, presence: true

  validates :member_id, uniqueness: {
    scope: [:project_id]
  }
end
