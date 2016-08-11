class Project < ApplicationRecord
  belongs_to :group, optional: true
  has_many :projects_monthly_allocations
  has_many :projects_members
  has_many :assignments, class_name: "ProjectsMember"

  attr_accessor :group_name

  validates :name, presence: true

  before_save do
    if group_name.present?
      self.group = Group.find_or_create_by(name: group_name)
    end
  end

end
