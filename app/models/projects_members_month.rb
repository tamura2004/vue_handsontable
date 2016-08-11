class ProjectsMembersMonth < ApplicationRecord
  belongs_to :projects_member, dependent: :destroy
  validates :cost, presence: true, numericality: {greater_than: 0}
end
