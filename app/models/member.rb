class Member < ApplicationRecord
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

  scope :_total, -> {
    select(<<-"SQL")
      members.id as id,
      members.name as name,
      works.month as month,
      sum(works.cost) as cost
    SQL
  }

  scope :_group, -> key = nil {
    key ? group(key, :month) : group(:month)
  }

  scope :total, -> key = nil {
    _total._group(key)
  }

  # 月、コストにより、ピボットテーブルを作成
  scope :pivot, -> key {
    total(key).group_by(&key).map{|_,rows|
      init = rows.first.attributes.reject{|key,_|
        %(month cost).include? key
      }.merge total: rows.map(&:cost).sum
      rows.inject(init) do |memo,row|
        memo.merge row.month => row.cost
      end
    } + [pivot_total_row]
  }

  # 合計行
  scope :pivot_total_row, -> {
    total.inject(name: "合計"){|memo,row|
      memo.merge row.month => row.cost
    }.merge total: total.map(&:cost).sum
  }

end
