Alloc.delete_all
Assign.delete_all
Work.delete_all

Department.seed do |s|
  s.id = 1
  s.name = Faker::University.name
end

job_title_names = %w(部長 課長 TL CF AS)

job_title_names.each_with_index do |name,id|
  JobTitle.seed do |s|
    s.id = id + 1
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

6.times do |id|
  Project.seed do |s|
    s.id = id
    name = [Faker::University, Faker::Company].sample.name
    s.group_id = Group.ids.sample
    s.number = sprintf("27%08d-00-a",rand(100000000))
    s.name = sprintf("%sシステムの更改", name)
  end
end

6.times do |id|
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
  Project.ids.sample(3).each do |project_id|
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






