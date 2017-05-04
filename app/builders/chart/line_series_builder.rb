module Chart
  class LineSeriesBuilder < MonthlySeriesBuilder
    def data
      {
        type: "line",
        markerSize:12,
        lineThickness: 4,
        dataPoints: POINTS
      }
    end
  end
end
