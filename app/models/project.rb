class Project < ApplicationRecord
  belongs_to :group, optional: true
  has_many :projects_monthly_allocations
  has_many :projects_members

  has_many :assignments, class_name: "ProjectsMember"
  has_many :allocations, through: :assignments, class_name: "ProjectsMembersMonth"

  attr_accessor :group_name

  validates :name, presence: true

  before_save do
    if group_name.present?
      self.group = Group.find_or_create_by(name: group_name)
    end
  end

  scope :view, -> {
    joins(:group)
    .joins("left join projects_monthly_allocations on projects.id = projects_monthly_allocations.project_id")
    .select(<<-SQL)
      projects.id as id,
      projects.number as number,
      projects.name as name,
      projects_monthly_allocations.month as month,
      projects_monthly_allocations.cost as cost
    SQL
    .order("projects.number")
  }

  scope :total_view, -> {
    joins(:group)
    .joins("left join projects_monthly_allocations on projects.id = projects_monthly_allocations.project_id")
    .select(<<-SQL)
      1 as id,
      '合計' as name,
      projects_monthly_allocations.month as month,
      sum(projects_monthly_allocations.cost) as cost
    SQL
    .group(:month)
  }

  # 月、コストにより、ピボットテーブルを作成
  scope :pivot, -> {
    all.group_by(&:id).map{|_,rows|
      init = rows.first.attributes.reject{|key,_|
        %(month cost).include? key
      }.merge total: rows.map(&:cost).compact.sum
      rows.inject(init){|memo,row|
        memo.merge row.month => row.cost
      }
    }
  }

end
