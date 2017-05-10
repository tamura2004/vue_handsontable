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
  # rails_admin do
  #   visible false
  # end

  belongs_to :member
  has_one :group, through: :member
  has_one :job_title, through: :member

  validates :cost, presence: true, numericality: {greater_than: 0}

  scope :recent, -> {
    where(month: MonthTypes.keys)
  }

  scope :member_chart, -> {
    joins(:member)
    .where("month > ?", "201703")
    .group("members.id")
    .group("members.name")
    .group(:month)
    .order("members.name")
    .order(:month)
    .sum(:cost)
    .group_by{|k,v|[k[0],k[1]]}
  }

end
