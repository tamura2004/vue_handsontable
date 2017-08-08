module Chart
  class MemberAllocsPieDirector
    def self.build(member, month)
      total = member.work_cost
      BaseBuilder.build do |chart|
        PieSeriesBuilder.build(chart) do |series|
          member.assigns.each do |assign|
            assign.allocs.each do |alloc|
              if alloc.month == month && alloc.cost > 0
                series.set_pie(assign.project_name, alloc.cost)
                total -= alloc.cost
              end
            end
          end
          if total > 0.1
            series.set_pie("▲#{total.round(2)}人月", total, indexLabelFontSize: 16, indexLabelFontColor: "red")
          end
        end
      end
    end
  end
end
