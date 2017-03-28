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

  scope :recent, -> {
    where("month > ?", "201703")
  }

  scope :project_subtotal, -> {
    recent
    .group(:project_id)
    .group(:month)
    .order(:project_id)
    .order(:month)
    .sum(:cost)
  }

  scope :project_total, -> {
    recent
    .group(:project_id)
    .order("sum(cost) desc")
    .sum(:cost)
  }

end
