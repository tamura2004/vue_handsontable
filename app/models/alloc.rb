class Alloc < ApplicationRecord
  include Pivot

  scope :member, -> member {
    where(member_id: member.id)
  }

  scope :project_view, -> {
    select(
      :project_number,
      :project_link,
      :month,
      :cost
    )
    .select("assign_id as id")
    .order(:project_number)
  }

  scope :project_total_view, -> {
    select(
      :project_number,
      :project_link,
      :month,
      :cost
    )
    .select("project_id as id")
    .order(:project_number)
  }

  scope :member_view, -> {
    select(
      :member_number,
      :member_link,
      :month,
      :cost
    )
    .select("assign_id as id")
    .order(:member_number)
  }

  scope :member_total_view, -> {
    select(
      :member_number,
      :member_link,
      :month,
      :cost
    )
    .select("member_id as id")
    .order(:member_number)
  }


end
