class AssignDecorator < Draper::Decorator
  delegate_all

  decorates_association :project
  decorates_association :member

  def project_number
    project&.number
  end

  def project_link
    project&.link
  end

  def group_name
    member&.group&.name
  end

  def member_number
    member&.number
  end

  def member_name
    member&.name
  end

  def member_link
    member&.link
  end

  def job_title_name
    member&.job_title&.name
  end

  def job_title_link
    member&.job_title&.link(group)
  end

  def project_number
    project&.number
  end

  def project_name
    project&.name
  end

  # def add_series(chart, name, label)
  #   Chart::StackedAreaSeriesBuilder.build(chart) do |series|
  #     MonthTypes.costs(cols: allocs).each_with_index do |cost, i|
  #       options = MonthTypes.parse(i).key == label[:month] ? label[:options] : {}
  #       series.set_point(month, cost, options)
  #     end
  #   end
  # end

end
