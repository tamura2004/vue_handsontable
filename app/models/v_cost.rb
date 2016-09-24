# == Schema Information
#
# Table name: v_costs
#
#  group_id       :integer
#  group_name     :string
#  project_id     :integer
#  project_number :string
#  project_name   :string
#  project_cost   :float
#  project_rd     :float
#  id             :integer
#  month          :string
#  cost           :float
#  project_link   :text
#  group_link     :text
#

class VCost < ApplicationRecord
  include Pivot
end
