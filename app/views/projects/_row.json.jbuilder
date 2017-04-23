p = Json::MonthTypesPresenter.new(project, json)

project.instance_eval do
  json.id id
  json.project_number number
  json.project_link link
  p.to_row(cols)
end
