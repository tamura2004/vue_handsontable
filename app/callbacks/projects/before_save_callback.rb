class Projects::BeforeSaveCallback

  def before_save(project)
    if project.group_name.present?
      project.group = Group.find_by(name: project.group_name)
    end
  end

end

