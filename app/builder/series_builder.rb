class SeriesBuilder
  attr_accessor :series

  OPTIONS = {
    stackedArea: {
      type: "stackedArea",
      markerType: "none",
      indexLabelFontSize: 9,
      dataPoints: []
    },
    line: {
      type: "line",
      markerSize:12,
      lineThickness: 4,
      dataPoints: []
    }
  }

  def initialize(type = :stackedArea)
    @series = OPTIONS[type].deep_dup
    yield self if block_given?
  end

  def add_point(label, y)
    PointBuilder.new(label, y) do |point|
      yield point if block_given?
      @series[:dataPoints] << point
    end
  end

  def []=(key, value)
    @series[key] = value
  end

end
