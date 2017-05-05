module Chart
  class ProjectPlansAllocsComboDirector
    def self.build(project)
      BaseBuilder.build do |chart|
        chart[:link_id] = project.id
        chart[:link_label] = project.full_name
        LineSeriesBuilder.build(chart) do |series|
          MonthTypes.pivot(cols: project.allocs).each do |month, cost|
            series.set_point(month, cost)
          end
        end
        StackedAreaSeriesBuilder.build(chart) do |series|
          @costs = Plan.where(project_number: project.number).costs
          @costs.each_with_index do |cost, i|
            month = MonthTypes.parse(i).key
            series.set_point(month, cost)
          end
        end
      end
    end
  end
end