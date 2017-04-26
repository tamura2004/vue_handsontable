json.array! assigns do |assign|
  json.extract! assign, :id
  json.extract! assign.member, :member_number, :member_link, :job_title_link
  json.merge! assign.member.allocs.pivot
end
