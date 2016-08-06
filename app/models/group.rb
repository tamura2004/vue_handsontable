class Group < ApplicationRecord
  belongs_to :department, optional: true
  attr_accessor :department_name

  before_save do
    if department_name.present?
      self.department = Department.find_or_create_by(name: department_name)
    end
  end

end
