class Member < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :job_title, optional: true

  has_many :projects_members

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

end
