class ProjectDecorator < Draper::Decorator
  delegate_all
  decorates_association :assigns
  decorates_association :allocs
  
  def text_for_search
    [number, name].join.to_json
  end

  def full_name
    [number, name].join(" ")
  end

  def link
    h.link_to name, h.project_allocs_path(id)
  end

  def project_number
    number
  end

  def project_name
    name
  end

  def project_link
    link
  end

  def chart_options
    ChartBuilder.build("FY2017案件アサイン計画：#{number} #{name}") do |chart|
      [*assigns, nil].each_cons(2) do |assign, next_assign|
        assign.add_series(chart, next_assign ? next_assign.member.name : "")
      end
    end
  end

end
