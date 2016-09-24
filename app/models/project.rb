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
  include Pivot

  belongs_to :group, optional: true
  has_many :projects_monthly_allocations
  has_many :projects_members

  has_many :assignments, class_name: "ProjectsMember"
  has_many :members, through: :assignments
  has_many :allocations, through: :assignments, class_name: "ProjectsMembersMonth"

  attr_accessor :group_name

  validates :name, presence: true

  before_save do
    if group_name.present?
      self.group = Group.find_or_create_by(name: group_name)
    end
  end

  scope :view, -> {
    joins(:group)
    .select(<<-SQL)
      projects.id as id,
      projects.number as number,
      projects.name as name,
      groups.name as group_name,
      groups.id as group_id
    SQL
    .order("projects.number")
  }

end
