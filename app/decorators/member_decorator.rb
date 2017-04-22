class MemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :job_title
  decorates_association :projects
  decorates_association :assigns

  def text_for_search
    [number, name, job_title.name].join.to_json
  end

  def to_vue
    Jbuilder.encode do |json|
      json.id id
      json.number number
      json.name name
      json.job_title_name job_title.try(:name)
      json.group_name group.try(:name)
    end
  end

  def link
    h.link_to name, h.member_allocs_path(id)
  end

  def full_works
    @full_works ||= Array.new(12,"").tap do |array|
      works.each do |work|
        if enum = MonthTypes.parse(work.month)
          array[enum.value] = work.cost
        end
      end
    end
  end

  def full_allocs
    @full_allocs ||= Array.new(12,"").tap do |array|
      allocs.each do |alloc|
        if enum = MonthTypes.parse(alloc.month)
          array[enum.value] = array[enum.value].to_i + alloc.cost
        end
      end
    end
  end

  def works_row
    HandsonTableBuilder.build do |obj|
      obj.id id
      obj.member_number number
      obj.member_link link
      obj.job_title_link job_title&.link(group)
      MonthTypes.each do |enum|
        obj.set! enum.key, full_works[enum.value]
      end
    end
  end

  def allocs_row
    HandsonTableBuilder.build do |obj|
      obj.id id
      obj.member_number number
      obj.member_link link
      obj.job_title_link job_title&.link(group)
      MonthTypes.each do |enum|
        obj.set! enum.key, full_allocs[enum.value]
      end
    end
  end

  def chart_options
    ChartBuilder.build("FY2017案件アサイン計画：#{number} #{name}") do |chart|
      [*assigns, nil].each_cons(2) do |assign, next_assign|
        assign.add_series(chart, next_assign ? next_assign.project.name : "")
      end
      MonthTypes.add_series(chart, "201710", "残業含む", 1.2)
      MonthTypes.add_series(chart, "201712", "残業なし", 1.0)
    end
  end

end
