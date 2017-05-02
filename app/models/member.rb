# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  name         :string
#  group_id     :integer
#  job_title_id :integer
#  number       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Member < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :job_title, optional: true

  has_many :works, dependent: :destroy
  has_many :assigns, class_name: "ProjectsMember"
  has_many :projects_members, dependent: :destroy
  has_many :projects, through: :projects_members
  has_many :allocs, -> { where month: MonthTypes.keys }, through: :assigns

  attr_accessor :group_name, :job_title_name

  scope :same_group, -> project {
    where(group: project.group_id)
  }

  scope :with_works, -> {
    eager_load(:works)
    .eager_load(:group)
    .eager_load(:job_title)
    .order(:job_title_id, :number)
  }

  scope :with_allocs, -> {
    eager_load(:assigns)
    .eager_load(:allocs)
    .eager_load(:projects)
    .eager_load(:group)
    .eager_load(:job_title)
    .order(:job_title_id, :number)
  }

  scope :circle_chart, -> {
    with_allocs
    .eager_load(:works)
    .where("works.month = ?", "201705")
    .joins(:allocs)
    .where("projects_members_months.month = ?", "201705")
  }

end
