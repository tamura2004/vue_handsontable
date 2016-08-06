class Project < ApplicationRecord
  belongs_to :group, optional: true
  has_many :projects_monthly_allocations
  has_many :projects_members

  attr_accessor :group_name

  before_save do
    if group_name.present?
      self.group = Group.find_or_create_by(name: group_name)
    end
  end

end
