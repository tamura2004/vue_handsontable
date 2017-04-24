project.instance_eval do
  json.child! do
    json.id id
    json.project_number number
    json.project_link link
    allocs.pivot.each do |month, cost|
      json.set! month, cost
    end
  end
end
