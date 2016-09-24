# == Schema Information
#
# Table name: assigns
#
#  id             :integer
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

  scope :ags, -> {
    where(job_title_name: "AGS")
    .where(group_name: "オープン系共通基盤")
    .group_by do |row|
      row.project_number + " " + row.project_name
    end
  }

end
