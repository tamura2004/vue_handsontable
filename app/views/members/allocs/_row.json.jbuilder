json.array! members do |member|
  json.extract! member, :id, :member_number, :member_link, :job_title_link
  json.merge! member.allocs.pivot
end
