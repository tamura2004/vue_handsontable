json.array! members do |member|
  json.extract! assign, :id
  json.extract! member, :member_number, :member_link, :job_title_link
  json.merge! member.allocs.pivot
end
