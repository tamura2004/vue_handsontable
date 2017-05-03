# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  department_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Group < ApplicationRecord
  belongs_to :department, optional: true
  has_many :projects
  has_many :members

  attr_accessor :department_name

  before_save do
    if department_name.present?
      self.department = Department.find_by(name: department_name)
    end
  end

end
