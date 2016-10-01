# == Schema Information
#
# Table name: projects_members_months
#
#  id                 :integer          not null, primary key
#  projects_member_id :integer
#  month              :string
#  cost               :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ProjectsMembersMonth < ApplicationRecord
  include Pivot

  belongs_to :projects_member #, dependent: :destroy
  belongs_to :assignment, class_name: "ProjectsMember", foreign_key: "projects_member_id"
  belongs_to :assign, class_name: "ProjectsMember", foreign_key: "projects_member_id"

  has_one :project, through: :assignment
  has_one :member, through: :assignment
  has_one :job_title, through: :member

  validates :cost, presence: true, numericality: {greater_than: 0}

end
