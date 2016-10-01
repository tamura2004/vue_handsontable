# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Work < ApplicationRecord
  include Pivot

  belongs_to :member
  has_one :group, through: :member

  validates :cost,presence: true, numericality: {greater_than: 0}

end
