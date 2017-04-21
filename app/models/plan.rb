# == Schema Information
#
# Table name: plans
#
#  id                         :integer          not null, primary key
#  category                   :string
#  main_group_name            :string
#  project_number             :string
#  project_name               :string
#  accuracy                   :string
#  dept_name                  :string
#  group_name                 :string
#  sub_number                 :string
#  system_name                :string
#  contract_type              :string
#  company_name               :string
#  member_rank                :string
#  unit_price                 :integer
#  manhour_last_month_landing :float
#  manhour_performance        :float
#  manhour_development_plan   :float
#  manhour_landing            :float
#  manhour_divergence         :float
#  manhour_ernings            :float
#  money_last_month_landing   :float
#  money_performance          :float
#  money_development_plan     :float
#  money_landing              :float
#  money_divergence           :float
#  money_ernings              :float
#  cost_rate_plan             :float
#  cost_rate_landing          :float
#  gross_profit_plan          :float
#  gross_profit_landing       :float
#  gross_profit_divergence    :float
#  to_be_confirmed            :string
#  m1                         :float
#  m2                         :float
#  m3                         :float
#  m4                         :float
#  m5                         :float
#  m6                         :float
#  m7                         :float
#  m8                         :float
#  m9                         :float
#  m10                        :float
#  m11                        :float
#  m12                        :float
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Plan < ApplicationRecord
  validates :category, uniqueness: { scope: [:main_group_name, :project_number, :project_name, :accuracy, :dept_name, :group_name, :sub_number, :system_name, :contract_type, :company_name, :member_rank]}

  scope :projects, -> { find_by_sql Summary::Plans::IndexProjectsQuery }

  scope :project, -> (project_number) {
    find_by_sql([Summary::Plans::ShowProjectQuery, project_number])
  }

  scope :compare_with_spro, -> {
    find_by_sql(Summary::Plans::UnionWithAllocationQuery)
  }

  after_save Plans::AfterSaveCallback.new

end
