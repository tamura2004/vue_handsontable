module Chart
  class PieSeriesBuilder < SeriesBuilder
    def data
      {
        type: "pie",
        radius: "70%",
        startAngle: -90,
        indexLabelFontSize: 16,
        dataPoints: []
      }
    end
    def set_pie(indexLabel, y, **options)
      options.merge!({ indexLabel: indexLabel, y: y})
      @series[:dataPoints] << options
    end
  end
end