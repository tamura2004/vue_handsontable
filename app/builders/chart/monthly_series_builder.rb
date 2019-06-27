class Chart::MonthlySeriesBuilder  < Chart::SeriesBuilder

  POINTS = [
    { label: "201904", y: 0 },
    { label: "201905", y: 0 },
    { label: "201906", y: 0 },
    { label: "201907", y: 0 },
    { label: "201908", y: 0 },
    { label: "201909", y: 0 },
    { label: "201910", y: 0 },
    { label: "201911", y: 0 },
    { label: "201912", y: 0 },
    { label: "202001", y: 0 },
    { label: "202002", y: 0 },
    { label: "202003", y: 0 }
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
