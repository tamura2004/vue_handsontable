class MemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :job_title
  decorates_association :projects
  decorates_association :assigns

  def text_for_search
    [number, name, job_title.name].join.to_json
  end

  def job_title_name
    job_title.try(:name) || ""
  end

  def group_name
    group.try(:name) || ""
  end

  def link
    h.link_to name, h.member_allocs_path(id)
  end

  def job_title_link
    job_title&.link(group)
  end

  def full_works
    MonthTypes.fill(works)
  end

  def full_allocs
    MonthTypes.fill(allocs)
  end

  def label
    h.render "members/assigns/label.json", member: self, cols: full_works
  end

  def works_row
    h.render "members/row.json", member: self, cols: full_works
  end

  def allocs_row
    h.render "members/row.json", member: self, cols: full_allocs
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
