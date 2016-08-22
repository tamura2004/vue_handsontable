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

  # 月、コストにより、ピボットテーブルを作成
  scope :pivot, -> key {
    all.group_by(&key).map{|_,rows|
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
    all.inject(name: "合計"){|memo,row|
      memo.merge row.month => row.cost
    }.merge total: all.map(&:cost).sum
  }

end
