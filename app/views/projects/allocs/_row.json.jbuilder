json.array! projects do |project|
  json.extract! project, :id, :project_number, :project_link
  json.merge! project.allocs.pivot
end


