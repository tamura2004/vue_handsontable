class Work < ApplicationRecord
  include Pivot

  belongs_to :member
  has_one :group, through: :member

  validates :cost,presence: true, numericality: {greater_than: 0}

  scope :ags_view, -> {
    select(<<-SQL)
      members.name as name,
      works.month as month,
      works.cost as cost
    SQL
    .joins(:member => :job_title)
    .joins(:member => :group)
    .where("job_titles.name = 'AGS'")
    .where("groups.name = 'オープン系共通基盤'")
  }



end
