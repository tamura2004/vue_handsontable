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
  has_many :allocs, -> { recent }, through: :assigns
  has_many :assigns
  has_many :projects, through: :assigns

  attr_accessor :group_name, :job_title_name

  scope :recent, -> {
    distinct
    .joins(:works)
    .merge(Work.recent)
  }

  scope :job_order, -> {
    joins(:job_title)
    .order(:job_title_id, :number)
  }

  scope :admin, -> {
    where("job_title_id <= 2")
  }

  scope :sofia, -> {
    where("3 <= job_title_id and job_title_id <= 8")
  }

  scope :bp, -> {
    where("job_title_id > 8")
  }


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

  scope :circle_chart, -> month {
    with_allocs
    .eager_load(:works)
    .where("works.month = ?", month)
    .joins(:allocs)
    .where("allocs.month = ?", month)
  }

end
