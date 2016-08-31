class Member < ApplicationRecord
  include Pivot

  belongs_to :group, optional: true
  belongs_to :job_title, optional: true

  has_many :projects_members
  has_many :works

  attr_accessor :group_name, :job_title_name

  before_save do
    if group_name.present?
      self.group = Group.find_or_create_by(name: group_name)
    end

    if job_title_name.present?
      self.job_title = JobTitle.find_or_create_by(name: job_title_name)
    end
  end

  def full_name
    "#{job_title.name} #{name}"
  end

  # def group_name
  #   group.try(:name)
  # end

  # def job_title_name
  #   job_title.try(:name)
  # end

  scope :view, -> {
    joins(:group)
    .joins(:job_title)
    .select(<<-SQL)
      members.id as id,
      groups.name as group_name,
      job_titles.name as job_title_name,
      members.number as member_number,
      members.name as member_name
    SQL
    .order("members.group_id,members.job_title_id")
  }


end
