module Chart
  class StackedAreaSeriesBuilder < MonthlySeriesBuilder
    def data
      {
        type: "stackedArea",
        markerType: "none",
        indexLabelFontSize: 9,
        dataPoints: POINTS
      }
    end
  end
end