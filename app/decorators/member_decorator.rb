class MemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :job_title
  decorates_association :projects
  decorates_association :assigns
  decorates_association :allocs
  decorates_association :works

  def member_number
    number
  end

  def member_name
    name
  end

  def member_link
    link
  end

  def text_for_search
    full_name.to_json
  end

  def full_name
    [number, name].join(" ")
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
    MonthTypes.pivot(cols: works)
  end

  def full_allocs
    MonthTypes.pivot(cols: allocs)
  end

  def label
    h.render "members/assigns/label.json", member: self
  end

  def work_cost(month = nil)
    month ||= Date.today.strftime("%Y%m")
    works.find_by(month: month)&.cost || 0
  end

  def projects_circle_chart_options
    total = work_cost
    Chart::BaseBuilder.build("") do |chart|
      chart.add_series(:circle) do |series|
        assigns.each do |assign|
          assign.allocs.each do |alloc|
            if alloc.month == "201705" && alloc.cost > 0
              series.set_pie(assign.project_name, alloc.cost)
              total -= alloc.cost
            end
          end
        end
        if total > 0.1
          series.set_pie("未割り当て", total, indexLabelFontSize: 24, indexLabelFontColor: "red")
        end
      end
    end
  end

end
