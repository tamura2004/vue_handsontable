class ProjectDecorator < Draper::Decorator
  delegate_all

  def text_for_search
    [number, name].join.to_json
  end

  def full_name
    [number, name].join(" ")
  end

  def link
    h.link_to name, h.project_allocs_path(id)
  end

  def full_allocs
    @full_allocs ||= Array.new(12,0).tap do |array|
      allocs.each do |alloc|
        if enum = MonthTypes.parse(alloc.month)
          array[enum.value] += alloc.cost
        end
      end
    end
  end

  def total_allocs
    allocs.sum(:cost)
  end

  def allocs_row
    HandsonTableBuilder.build do |obj|
      obj.id id
      obj.project_number number
      obj.project_link link
      MonthTypes.each do |enum|1
        obj.set! enum.key, full_allocs[enum.value]
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
