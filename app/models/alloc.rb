# == Schema Information
#
# Table name: allocs
#
#  id             :integer
#  assign_id      :integer
#  member_id      :integer
#  member_number  :string
#  member_name    :string
#  group_id       :integer
#  group_name     :string
#  job_title_id   :integer
#  job_title_name :string
#  project_id     :integer
#  project_number :string
#  project_name   :string
#  project_cost   :float
#  project_rd     :float
#  month          :string
#  cost           :float
#  member_link    :text
#  project_link   :text
#  job_title_link :text
#

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
