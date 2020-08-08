Alloc.delete_all
Assign.delete_all
Work.delete_all
Plan.delete_all

Department.seed do |s|
  s.id = 1
  s.name = Faker::University.name
end

job_title_names = %w(部長 課長 PM TL CF AS BP)

job_title_names.each_with_index do |name,id|
  JobTitle.seed do |s|
    s.id = id + 3
    s.name = name
  end
end

3.times do |id|
  Group.seed do |s|
    s.id = id
    s.department_id = Department.ids.sample
    s.name = Faker::Company.name
  end
end

ACTIONS = %w(更改 構築 機能追加 改善)

12.times do |id|
  Project.seed do |s|
    s.id = id
    name = [Faker::University, Faker::Company].sample.name
    s.group_id = Group.ids.sample
    s.number = sprintf("27%08d-00-a",rand(100000000))
    s.name = sprintf("%sシステムの%s", name, ACTIONS.sample)
  end
end

30.times do |id|
  Member.seed do |s|
    s.id = id
    s.number = "b%06d" % rand(1000000)
    s.name = Faker::Name.name
    s.job_title_id = JobTitle.ids.sample
    s.group_id = Group.ids.sample
  end
end

Member.find_each do |member|
  ::MonthTypes.submonth.each do |month|
    Work.seed do |s|
      s.month = month
      s.cost = 1
      s.member_id = member.id
    end
  end
end

Member.find_each do |member|
  Project.ids.sample(rand(5)+1).each do |project_id|
    Assign.seed do |s|
      s.member_id = member.id
      s.project_id = project_id
    end
  end
end

Member.find_each do |member|
  member.assigns.each do |assign|
    ::MonthTypes.submonth.each do |month|
      Alloc.seed do |s|
        s.assign_id = assign.id
        s.month = month
        s.cost = (rand(5)/5.0 + 0.2).round(2)
      end
    end
  end
end

Project.find_each do |project|
  Plan.seed do |s|
    s.category = "plan"
    s.project_number = project.number
    s.project_name = project.name

    12.times do |i|
      s.send("m#{i+1}=", 0)
    end

    ::MonthTypes.submonth.each do |month|
      field = "m%d=" % (MonthTypes.parse(month).value + 1)
      s.send(field, rand(5)/5.0 + 0.2)
    end
  end
end






