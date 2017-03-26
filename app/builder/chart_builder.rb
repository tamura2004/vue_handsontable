class ChartBuilder
  attr_accessor :chart

  DEFAULT_CHART = {
    animationEnabled: true,
    theme: "theme4",
    title: {
      text: "タイトル未設定"
    },
    legend: {
      reversed: true,
      dockInsidePlotArea: true,
      fontSize: 12,
      verticalAlign: "center"
    },
    data: []
  }

  def initialize(title, options = {})
    @chart = DEFAULT_CHART.merge(options).deep_dup
    @chart[:title][:text] = title
    yield self if block_given?
  end

  def add_series(type = :stackedArea)
    builder = SeriesBuilder.new(type)
    yield builder if block_given?
    @chart[:data] << builder.series
  end

  def self.build(title, options = {})
    builder = ChartBuilder.new(title, options) do |chart|
      yield chart if block_given?
    end
    builder.chart
  end

end