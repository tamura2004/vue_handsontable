# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  name         :string
#  group_id     :integer
#  job_title_id :integer
#  number       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Member < ApplicationRecord
  include Pivot

  belongs_to :group, optional: true
  belongs_to :job_title, optional: true

  # has_many :projects_members
  has_many :works, dependent: :destroy
  has_many :assigns, class_name: "ProjectsMember"
  has_many :projects_members, dependent: :destroy
  has_many :projects, through: :projects_members
  has_many :allocs, through: :assigns

  attr_accessor :group_name, :job_title_name

  scope :same_group, -> project {
    where(group: project.group_id)
  }

end
