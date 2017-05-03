module Chart
  class StackedAreaBuilder
    def self.build(object)
      assigns = object.assigns.recent
      other = (object.kind_of? Member) ? :project : :member
      labels = assigns.map do |assign|
        {
          month: index_label_month(assign.allocs.recent),
          name: assign.send(other).decorate.full_name,
        }
      end

      BaseBuilder.build("#{object.decorate.full_name}") do |chart|
        chart.add_series do |series|
          series.set_label(labels.first)
        end
        assigns.each_with_index do |assign, i|
          chart.add_series do |series|
            if label = labels[i+1]
              series.set_label(label)
            end
            assign.allocs.each do |alloc|
              series.set_point(alloc.month, alloc.cost)
            end
          end
        end
        yield chart if block_given?
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