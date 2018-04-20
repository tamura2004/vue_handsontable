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
            monthType = MonthTypes.parse(i)
            if monthType.nil?
              puts i
            else
              month = monthType.key
              series.set_point(month, cost)
            end
          end
        end
      end
    end
  end
end