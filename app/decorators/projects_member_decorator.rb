class ProjectsMemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :project
  decorates_association :member

  def full_allocs
    MonthTypes.fill(allocs)
  end

  def allocs_row
    h.render "assigns/row.json", assign: self, cols: full_allocs
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
