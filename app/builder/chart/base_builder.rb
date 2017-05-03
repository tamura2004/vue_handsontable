module Chart
  class BaseBuilder
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

    def add_series(type: :stackedArea, models: nil, **options)
      builder = SeriesBuilder.new(type, options)

      if models.respond_to? :each
        models.each do |model|
          yield builder, *model if block_given?
        end
      else
        yield builder if block_given?
      end
      
      @chart[:data] << builder.series
    end

    def self.build(title, options = {})
      builder = BaseBuilder.new(title, options) do |chart|
        yield chart if block_given?
      end
      builder.chart
    end

  end
end