# == Schema Information
#
# Table name: projects_monthly_allocations
#
#  id         :integer          not null, primary key
#  project_id :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProjectsMonthlyAllocation < ApplicationRecord
  include Pivot

  rails_admin do
    visible false
  end

  belongs_to :project
  has_one :group, through: :project

  validates :cost, presence: true, numericality: {greater_than: 0}

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
