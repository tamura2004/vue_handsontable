class Work < ApplicationRecord
  belongs_to :member
  has_one :group, through: :member

  validates :cost,presence: true, numericality: {greater_than: 0}




end
