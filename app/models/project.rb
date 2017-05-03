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

  has_many :assigns
  has_many :members, through: :assigns
  has_many :allocs, through: :assigns

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
    distinct
    .joins(:allocs)
    .merge(Alloc.recent)
  }
  
  scope :project_chart, -> {
    find_by_sql(Charts::ProjectsAssignsQuery)
  }

end
