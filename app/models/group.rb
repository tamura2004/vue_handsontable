class Group < ApplicationRecord
  belongs_to :department, optional: true
  has_many :projects
  has_many :members
  attr_accessor :department_name

  before_save do
    if department_name.present?
      self.department = Department.find_or_create_by(name: department_name)
    end
  end

end
