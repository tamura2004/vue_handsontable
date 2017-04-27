json.array! assigns do |assign|
  json.extract! assign, :id, :project_number, :project_link
  json.merge! assign.project_allocs_pivot
end
