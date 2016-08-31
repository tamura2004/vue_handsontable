class Assign < ApplicationRecord
  include Pivot

  scope :project_view, -> {
    select(
      :project_number,
      :project_link,
      :month,
      :cost
    )
    .order(:project_number)
  }

  scope :member_view, -> {
    select(
      :group_name,
      :job_title_link,
      :member_number,
      :member_link,
      :month,
      :cost
    )
    .order(:job_title_id, :member_number)
  }

end
