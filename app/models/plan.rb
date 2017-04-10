class Plan < ApplicationRecord
  validates :category, uniqueness: { scope: [:main_group_name, :project_number, :project_name, :accuracy, :dept_name, :group_name, :sub_number, :system_name, :contract_type, :company_name, :member_rank]}

  scope :project, -> (project_number) {
    find_by_sql([Summary::PlansQuery, project_number])
  }

  scope :compare_with_spro, -> {
    find_by_sql(Summary::CompareWithSproQuery)
  }

  after_save do |plan|
    if project = Project.find_by(number: plan.project_number)
      # 名称が類似している場合一致させる
      d = Levenshtein.normalized_distance(project.name, plan.project_name)
      if 0 < d && d < 0.8
        project.update(name: plan.project_name)
      end
    else
      Project.create(group_id: 1, number: plan.project_number, name: plan.project_name)
    end
  end
end
