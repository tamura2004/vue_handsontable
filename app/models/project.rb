# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  number     :string
#  name       :string
#  cost       :float
#  rd         :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ApplicationRecord
  belongs_to :group, optional: true
  has_many :costs, class_name: "ProjectsMonthlyAllocation", dependent: :destroy
  has_many :projects_members, dependent: :destroy

  has_many :assigns, class_name: "ProjectsMember"
  has_many :members, through: :assigns
  has_many :allocs, through: :assigns, class_name: "ProjectsMembersMonth"

  attr_accessor :group_name

  validates :name, presence: true

  before_save Projects::BeforeSaveCallback.new

  scope :same_group, -> member {
    where(group: member.group_id)
  }

  scope :with_allocs, -> {
    eager_load(:members)
    .eager_load(:group)
    .eager_load(:assigns)
    .eager_load(:allocs)
    .order(:number)
  }

  scope :recent, -> {
    includes(:allocs)
    .merge(ProjectsMembersMonth.where(month: MonthTypes.keys))
  }

end
