json.array! assigns do |assign|
  json.extract! assign, :id, :member_number, :member_link, :job_title_link
  json.merge! assign.member_allocs_pivot
end
