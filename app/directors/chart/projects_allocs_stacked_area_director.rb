module Chart
  class ProjectsAllocsStackedAreaDirector
    def self.build(projects, works, plans_costs)
      labels = projects.map do |project|
        {
          month: index_label_month(project.allocs),
          name: project.full_name,
          indexLabelMaxWidth: 120,
        }
      end

      BaseBuilder.build do |chart|
        StackedAreaSeriesBuilder.build(chart) do |series|
          if label = labels.first
            series.set_label(label.merge({
              indexLabelFontSize: 9,
              indexLabelMaxWidth: 240
            }))
          end
        end
        projects.each_with_index do |project, i|
          StackedAreaSeriesBuilder.build(chart) do |series|
            if label = labels[i+1]
              series.set_label(label.merge({
            indexLabelFontSize: 9,
            indexLabelMaxWidth: 240
          }))
            end
            ::MonthTypes.pivot(cols: project.allocs).each do |month, cost|
              series.set_point(month, cost)
            end
          end
        end
      end
    end

    def self.index_label_month(allocs)
      month_value_total = allocs.inject(0) do |acc, alloc|
        acc += MonthTypes.parse(alloc.month).value
      end
      if allocs.size.zero?
        "201912"
      else
        weighted_averate_month = MonthTypes.parse(month_value_total/allocs.size).key
      end
    end

  end
end