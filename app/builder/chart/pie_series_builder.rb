class Chart::PieSeriesBuilder < Chart::SeriesBuilder

  OPTIONS = {
    circle: {
      type: "pie",
      radius: "70%",
      startAngle: -90,
      indexLabelFontSize: 16,
      dataPoints: []
    }
  }

  LABEL = {
    indexLabel: "",
    indexLabelPlacement: "outside",
    indexLabelFontSize: 12,
    indexLabelMaxWidth: 80
  }

  def initialize(type = :stackedArea, options = {})
    @series = OPTIONS[type].merge(options).deep_dup
    yield self if block_given?
  end

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

  def set_label(month: "", name: "")
    label = LABEL.deep_dup.merge(indexLabel: name)

    @series[:dataPoints].each do |point|
      if point[:label] == month
        point.merge!(label)
      end
    end
  end

  def set_pie(indexLabel, y, options = {})
    options.merge!({ indexLabel: indexLabel, y: y})
    @series[:dataPoints] << options
  end

end
