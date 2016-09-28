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
  has_many :works
  has_many :assigns, class_name: "ProjectsMember"

  attr_accessor :group_name, :job_title_name

  # scope :view, -> {
  #   joins(:group)
  #   .joins(:job_title)
  #   .select(<<-SQL)
  #     members.id as id,
  #     groups.name as group_name,
  #     job_titles.name as job_title_name,
  #     members.number as member_number,
  #     members.name as member_name
  #   SQL
  #   .order("members.group_id,members.job_title_id")
  # }


end
