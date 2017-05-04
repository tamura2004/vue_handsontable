class Chart::SeriesBuilder
  attr_accessor :series
  delegate :[]=, to: :series

  def initialize(**options)
    @series = data.deep_dup.merge(options)
    yield self if block_given?
  end

  def self.build(chart, **options, &block)
    chart.chart[:data] << new(options, &block).series
  end

end
