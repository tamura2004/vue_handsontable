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

  scope :project_chart, -> {
    find_by_sql(Charts::ProjectsAssignsQuery)
  }

  scope :report_by_member, -> {
    find_by_sql(Reports::MembersAssignsQuery)
  }

  scope :report, -> {
    find_by_sql(Reports::AssignsQuery)
  }

end
