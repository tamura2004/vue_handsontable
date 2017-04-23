p = Json::MonthTypesPresenter.new(member, json)

member.instance_eval do
  json.id id
  json.member_number number
  json.member_link link
  json.job_title_link job_title_link
  p.to_row(cols)
end
