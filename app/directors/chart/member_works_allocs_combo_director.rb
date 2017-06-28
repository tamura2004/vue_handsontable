module Chart
  class MemberWorksAllocsComboDirector
    def self.build(member)
      BaseBuilder.build do |chart|
        chart[:link_id] = member.id
        chart[:link_label] = member.full_name
        StackedAreaSeriesBuilder.build(chart) do |series|
          MonthTypes.pivot(cols: member.works).each do |month, cost|
            series.set_point(month, cost)
          end
        end
        LineSeriesBuilder.build(chart) do |series|
          MonthTypes.pivot(cols: member.allocs).each do |month, cost|
            if Date.today.strftime("%Y%m") == month
              series.set_point(month, cost,
                markerSize: 18,
                indexLabel: "今月",
                indexLabelFontSize: 12,
              )
            else
              series.set_point(month, cost)
            end
          end
        end
      end
    end
  end
end