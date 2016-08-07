class ProjectsMembersMonth < ApplicationRecord
  belongs_to :projects_member
  validates :cost, presence: true, numericality: {greater_than: 0}
end
