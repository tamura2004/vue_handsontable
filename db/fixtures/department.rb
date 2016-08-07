department_names= %w(未来技術推進部 アウトレット部)

department_names.each_with_index do |name,id|
  Department.seed do |s|
    s.id = id
    s.name = name
  end
end

job_title_names = %w(部長 課長 TL CF AS ABC)

job_title_names.each_with_index do |name,id|
  JobTitle.seed do |s|
    s.id = id
    s.name = name
  end
end

Group.seed do |s|
  s.id = 1
  s.department_id = 1
  s.name = "イノベーショングループ"
end

Group.seed do |s|
  s.id = 2
  s.department_id = 1
  s.name = "エンタープライズグループ"
end

Group.seed do |s|
  s.id = 3
  s.department_id = 2
  s.name = "調査発掘グループ"
end

Project.seed do |s|
  s.group_id = 1
  s.number = "a123456"
  s.name = "すごいシステムの更改"
  s.cost = 10
  s.rd = 2
end

Project.seed do |s|
  s.group_id = 2
  s.number = "b456123"
  s.name = "やばいシステムの更改"
  s.cost = 10
  s.rd = 2
end

Member.seed do |s|
  s.id = 1
  s.number = "b1122001"
  s.name = "樋口　真一"
  s.job_title_id = 1
  s.group_id = 1
end

ProjectsMember.seed do |s|
  s.id = 1
  s.member_id = 1
  s.project_id = 1
end

ProjectsMembersMonth.seed do |s|
  s.projects_member_id = 1
  s.month = "201608"
  s.cost = 1.2
end

ProjectsMonthlyAllocation.seed do |s|
  s.id = 1
  s.project_id = 1
  s.month = "201608"
  s.cost = 1.2
end



