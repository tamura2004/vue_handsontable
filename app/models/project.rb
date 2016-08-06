class Project < ApplicationRecord
  belongs_to :group
  has_many :projects_monthly_allocations
  attr_accessor :group_name

  before_save do
    if group_name.present?
      self.group = Group.find_or_create_by(name: group_name)
    end
  end

end
