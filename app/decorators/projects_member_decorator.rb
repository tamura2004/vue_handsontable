class ProjectsMemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :project
  decorates_association :member

  def full_allocs
    MonthTypes.fill(allocs)
  end

  def allocs_row
    HandsonTableBuilder.build do |obj|
      obj.id id
      obj.project_number project.number
      obj.project_link project.link
      full_allocs.each_with_index do |cost, i|
        obj.set! MonthTypes.parse(i).key, cost.zero? ? "" : cost
      end
    end
  end

  def add_series(chart, name)
    chart.add_series(:stackedArea) do |series|
      full_allocs.each_with_index do |cost, i|
        month = MonthTypes.parse(i).key
        series.set_point(month, cost) do |point|
          if month == "201705"
            point[:indexLabel] = name
            point[:indexLabelPlacement] = "outside"
            point[:indexLabelFontSize] = 12
          end
        end
      end
    end
  end

end
