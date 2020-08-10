# == Schema Information
#
# Table name: assigns
#
#  id         :integer          not null, primary key
#  project_id :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Assign < ApplicationRecord
  # rails_admin do
  #   visible false
  # end

  belongs_to :project
  belongs_to :member
  has_one :job_title, through: :member
  has_one :group, through: :member
  # has_many :allocs, -> { recent }, dependent: :destroy
  has_many :allocs, dependent: :destroy

  validates :member_id, presence: true
  validates :project_id, presence: true
  validates :member_id, uniqueness: { scope: [:project_id] }

  scope :recent, -> { joins(:allocs).distinct }

  scope :with_allocs, -> {
    eager_load(:allocs)
    .eager_load(:project)
    .eager_load(:member)
    .eager_load(:job_title)
    .eager_load(:group)
    # .where("allocs.month > ?","201703")
  }

  scope :view, -> {
    select("*")
    .select("members.number as member_number")
    .select("projects.number as project_number")
    .select("members.name as member_name")
    .select("projects.name as project_name")
    .select("job_titles.name as job_title_name")
    .select("groups.name as group_name")
    .joins(member: :group)
    .joins(:job_title)
    .joins(:project)
    .left_outer_joins(:allocs)
  }
end
