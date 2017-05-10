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
          series.set_label(labels.first.merge({
            indexLabelFontSize: 9,
            indexLabelMaxWidth: 240
          }))
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

        Chart::LineSeriesBuilder.build(chart) do |series|
          ::MonthTypes.pivot(cols: works).each do |month, cost|
            series.set_point(month, cost)
            series.set_label(month: "201712", name: "要員数", indexLabelFontSize: 18)
          end
        end

        Chart::LineSeriesBuilder.build(chart) do |series|
          ::MonthTypes.pivot(cols: works).each do |month, cost|
            series.set_point(month, cost + 3)
            series.set_label(month: "201711", name: "要員数(残業込み)", indexLabelFontSize: 18)
          end
        end

        Chart::LineSeriesBuilder.build(chart) do |series|
          plans_costs.each_with_index do |cost, i|
            month = MonthTypes.parse(i).key
            series.set_point(month, cost)
            series.set_label(month: "201801", name: "案件受注", indexLabelFontSize: 18)
          end
        end

      end
    end

    def self.index_label_month(allocs)
      month_value_total = allocs.inject(0) do |acc, alloc|
        acc += MonthTypes.parse(alloc.month).value
      end
      weighted_averate_month = MonthTypes.parse(month_value_total/allocs.size).key
    end

  end
end