class SeriesBuilder
  attr_accessor :series
  delegate :[]=, to: :series

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

  OPTIONS = {
    stackedArea: {
      type: "stackedArea",
      markerType: "none",
      indexLabelFontSize: 9,
      dataPoints: POINTS
    },
    line: {
      type: "line",
      markerSize:12,
      lineThickness: 4,
      dataPoints: POINTS
    },
    circle: {
      type: "pie",
      radius: "70%",
      startAngle: -90,
      indexLabelFontSize: 16,
      dataPoints: []
    }
  }

  def initialize(type = :stackedArea)
    @series = OPTIONS[type].deep_dup
    yield self if block_given?
  end

  def set_point(label, y)
    @series[:dataPoints].each do |point|
      if point[:label] == label
        point[:y] = y || 0
        yield point if block_given?
        break
      end
    end
  end

  def set_pie(indexLabel, y, options={})
    options.merge!({ indexLabel: indexLabel, y: y})
    @series[:dataPoints] << options
  end

end
