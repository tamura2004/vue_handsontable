module Chart
  class MemberWorksAllocsComboDirector
    def self.build(member)
      BaseBuilder.build do |chart|
        chart[:link_id] = member.id
        chart[:link_label] = member.full_name
        LineSeriesBuilder.build(chart) do |series|
          MonthTypes.pivot(cols: member.allocs).each do |month, cost|
            series.set_point(month, cost)
          end
        end
        StackedAreaSeriesBuilder.build(chart) do |series|
          MonthTypes.pivot(cols: member.works).each do |month, cost|
            series.set_point(month, cost)
          end
        end
      end
    end
  end
end