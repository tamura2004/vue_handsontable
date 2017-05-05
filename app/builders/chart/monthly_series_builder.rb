class Chart::MonthlySeriesBuilder  < Chart::SeriesBuilder

  POINTS = [
    { label: "201704", y: 0 },
    { label: "201705", y: 0 },
    { label: "201706", y: 0 },
    { label: "201707", y: 0 },
    { label: "201708", y: 0 },
    { label: "201709", y: 0 },
    { label: "201710", y: 0 },
    { label: "201711", y: 0 },
    { label: "201712", y: 0 },
    { label: "201801", y: 0 },
    { label: "201802", y: 0 },
    { label: "201803", y: 0 }
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
