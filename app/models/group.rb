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
end
