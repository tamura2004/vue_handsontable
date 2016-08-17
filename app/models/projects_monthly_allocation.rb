class ProjectsMonthlyAllocation < ApplicationRecord
  belongs_to :project
  has_one :group, through: :project

  validates :cost, presence: true, numericality: {greater_than: 0}

  scope :_total, -> {
    select(<<-"SQL").joins(:group)
      groups.id as group_id,
      groups.name as group_name,
      projects.id as project_id,
      projects.name as project_name,
      projects_monthly_allocations.month as month,
      sum(projects_monthly_allocations.cost) as cost
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
    total(key).group_by(&key).map do |_,rows|

      init = rows.first.attributes.reject{|key,_|
        %(month cost).include? key
      }.merge total: rows.map(&:cost).sum

      rows.inject(init) do |memo,row|
        memo.merge row.month => row.cost
      end

    end
  }

  # 合計行
  scope :pivot_total_row, -> {
    total.inject(group_name:"グループ合計", project_name: "案件合計") do |memo,row|
      memo.merge row.month => row.cost
    end
  }

end




