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

  scope :view, -> {
    joins(:group)
    .joins(:job_title)
    .joins("left join works on members.id = works.member_id")
    .select(<<-SQL)
      members.id as id,
      job_titles.name as jobs_name,
      members.number as number,
      members.name as name,
      works.month as month,
      works.cost as cost
    SQL
    .order("members.group_id,members.job_title_id")
  }

  # scope :total_view, -> {
  #   joins(:group)
  #   .joins("left join works on members.id = works.member_id")
  #   .select(<<-SQL)
  #     1 as id,
  #     '合計' as name,
  #     works.month as month,
  #     sum(works.cost) as cost
  #   SQL
  #   .group(:month)
  # }

  # # 月、コストにより、ピボットテーブルを作成
  # scope :pivot, -> {
  #   all.group_by(&:id).map{|_,rows|
  #     init = rows.first.attributes.reject{|key,_|
  #       %(month cost).include? key
  #     }.merge total: rows.map(&:cost).compact.sum
  #     rows.inject(init){|memo,row|
  #       memo.merge row.month => row.cost
  #     }
  #   }
  # }

end
