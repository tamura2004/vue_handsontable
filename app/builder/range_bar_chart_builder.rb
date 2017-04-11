class RangeBarChartBuilder
  attr_accessor :chart
  delegate :[]=, to: :chart

  DEFAULT_CHART = {
    animationEnabled: true,
    theme: "theme4",
    title: {
      text: "タイトル未設定",
      dockInsidePlotArea: true,
      fontSize: 16
    },
    # axisY: {
    #   includeZero: false,
    #   interval: 1,
    #   valueFormatString: "MMM月"
    # },
    data: [
      type: "rangeBar",
      dataPoints: []
    ]
  }

  def initialize(title, options = {})
    @chart = DEFAULT_CHART.merge(options).deep_dup
    @chart[:title][:text] = title
    yield self if block_given?
  end

  def add_bar(plan)
    builder = RangeBarBuilder.new(plan) 
    yield builder if block_given?
    @chart[:data][0][:dataPoints] << builder.bar
  end

  def self.build(title, options = {})
    builder = RangeBarChartBuilder.new(title, options) do |chart|
      yield chart if block_given?
    end
    builder.chart
  end
end
