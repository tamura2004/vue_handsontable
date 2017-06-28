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
  validates :category, uniqueness: { scope: [:main_group_name, :project_number, :project_name, :accuracy, :dept_name, :group_name, :sub_number, :system_name, :contract_type, :company_name, :member_rank, :month]}

  scope :projects, -> { find_by_sql Summary::Plans::IndexProjectsQuery }

  scope :project, -> (project_number) {
    find_by_sql([Summary::Plans::ShowProjectQuery, project_number])
  }

  scope :compare_with_spro, -> {
    find_by_sql(Summary::Plans::UnionWithAllocationQuery)
  }

  scope :costs, -> {
    pluck(:m1,:m2,:m3,:m4,:m5,:m6,:m7,:m8,:m9,:m10,:m11,:m12)
    .transpose
    .map(&:compact)
    .map(&:sum)
  }

  after_save Plans::AfterSaveCallback.new

  def self.migrate!
    find_each do |plan|
      plan.migrate!
    end
  end

  def migrate!
    category_id = Category.find_or_create_by(name: category).id

    project = Project.find_or_create_by(number: project_number)
    project.update_attributes({
      name: project_name,
      category_id: category_id
    })

    self.project_id = project.id

    if system_name =~ /\[(.*)\]/
      system = System.find_or_create_by(number: $1)
      self.system_id = system.id
    end

    save

  #   match = system_name&.scan(/\[(.*)\](.*)/)
  #   system = nil
  #   system_id = nil
  #   unless match.nil? || match.empty?
  #     number, name = *match.first
  #     system = System.find_or_create_by(number: number) do |system|
  #       system.name = name
  #     end
  #   end

  #   12.times do |i|
  #     cost = self["m#{i+1}"]
  #     if cost > 0
  #       plan = Plan.find_or_create_by(project_id: project, month: MonthTypes.parse(i).key)
  #       plan.update_attributes({
  #         cost: cost,
  #         category: category,
  #         main_group_name: main_group_name,
  #         project_number: project_number,
  #         project_name: project_name,
  #         accuracy: accuracy,
  #         dept_name: dept_name,
  #         group_name: group_name,
  #         sub_number: sub_number,
  #         system_name: system_name,
  #         contract_type: contract_type,
  #         company_name: company_name,
  #         member_rank: member_rank,
  #         system_id: system.id,
  #         system_id: project.id
  #       })
  #     end
  #   end
  end

end
