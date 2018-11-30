class Chart::MonthlySeriesBuilder  < Chart::SeriesBuilder

  POINTS = [
    { label: "201809", y: 0 },
    { label: "201810", y: 0 },
    { label: "201811", y: 0 },
    { label: "201812", y: 0 },
    { label: "201901", y: 0 },
    { label: "201902", y: 0 },
    { label: "201903", y: 0 },
    { label: "201904", y: 0 },
    { label: "201905", y: 0 },
    { label: "201906", y: 0 },
    { label: "201907", y: 0 },
    { label: "201908", y: 0 }
  ]

  LABEL = {
    indexLabel: "",
    indexLabelPlacement: "outside",
    indexLabelFontSize: 12,
    indexLabelMaxWidth: 120
  }

  def set_point(label, y, options = {})
    @series[:dataPoints].each do |point|
      if point[:label] == label
        point.merge!(options)
        point[:y] = y || 0
        yield point if block_given?
        break
      end
    end
  end
  
  def set_label(month: "", name: "", **options)
    label = LABEL.deep_dup.merge(indexLabel: name).merge(options)
    @series[:dataPoints].each do |point|
      if point[:label] == month
        point.merge!(label)
      end
    end
  end

end
