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


end
