class MembersMonth < ApplicationRecord
  belongs_to :member
  validates :cost, presence: true, numericality: {greater_than: 0}
end
