class Plans::AfterSaveCallback

  def after_save(plan)
    if project = Project.find_by(number: plan.project_number)
      # 名称が類似している場合一致させる
      distance = Levenshtein.normalized_distance(project.name, plan.project_name)
      if distance < 0.3 && 0 < distance
        project.update(name: plan.project_name)
      end

    elsif project = Project.find_by(name: plan.project_name)
      project.update(number: plan.project_number)

    else
      Project.create(group_id: 1, number: plan.project_number, name: plan.project_name)
    end
  end

end
