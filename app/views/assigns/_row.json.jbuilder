p = Json::MonthTypesPresenter.new(assign, json)

assign.instance_eval do
  json.id id
  json.project_number project.number
  json.project_link project.link
  p.to_row(cols)
end
