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
    MonthTypes.pivot(cols: allocs, key: :month, value: :cost)
  end

  def total_allocs
    allocs.sum(:cost)
  end

  def allocs_row
    h.render "projects/row.json", project: self, cols: full_allocs
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

  def hoge
    return h.render "projects/hoge", object: object
  end

end
