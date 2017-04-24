json.array! members do |member|
  json.partial! "members/works/row.json", member: member
end
