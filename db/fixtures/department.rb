department_names= %w(オープン技術推進部 第四開発部)

department_names.each_with_index do |name,id|
  Department.seed do |s|
    s.id = id
    s.name = name
  end
end

job_title_names = %w(部長 課長 TL CF AS AGS)

job_title_names.each_with_index do |name,id|
  JobTitle.seed do |s|
    s.id = id
    s.name = name
  end
end

Group.seed do |s|
  s.id = 1
  s.department_id = 1
  s.name = "オープン系共通基盤グループ"
end

Group.seed do |s|
  s.id = 2
  s.department_id = 1
  s.name = "イントラネットグループ"
end

Group.seed do |s|
  s.id = 3
  s.department_id = 2
  s.name = "融資グループ"
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


