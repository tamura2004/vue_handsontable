class MembersProjectsMonth < ApplicationRecord
  belongs_to :projects_member
  validates :cost, presence: true, greater_than: 0
end
