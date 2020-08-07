# == Schema Information
#
# Table name: allocs
#
#  id         :integer          not null, primary key
#  assign_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Alloc < ApplicationRecord
  belongs_to :assign

  has_one :project, through: :assign
  has_one :member, through: :assign
  has_one :job_title, through: :member

  validates :cost, presence: true, numericality: {greater_than: 0}

  scope :recent, -> {
    where(month: MonthTypes.keys)
  }

  scope :member_chart, -> {
    joins(:member)
    .where("month > ?", "201703")
    .group("members.job_title_id")
    .group("members.id")
    .group("members.number")
    .group("members.name")
    .group(:month)
    .order("members.job_title_id")
    .order("members.number")
    .order(:month)
    .sum(:cost)
    .group_by{|k,v|[k[1],k[3]]}
  }

  scope :project_chart, -> {
    joins(:project)
    .where("month > ?", "201703")
    .group("projects.id")
    .group("projects.number")
    .group("projects.name")
    .group(:month)
    .order("projects.number")
    .order(:month)
    .sum(:cost)
    .group_by{|k,v|[k[0],k[1],k[2]]}
  }

end
