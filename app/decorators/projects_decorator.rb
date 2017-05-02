class ProjectsDecorator < Draper::CollectionDecorator

  def allocs_rows
    h.render "projects/allocs/row.json", projects: self
  end

end
