class Chart::MonthlySeriesBuilder  < Chart::SeriesBuilder

  POINTS = 12.times.map do |i|
    {
      label: Date.today.months_ago(3).months_since(i).strftime("%Y%m"),
      y: 0
    }
  end

  # [
  #   { label: "202001", y: 0 },
  #   { label: "202002", y: 0 },
  #   { label: "202003", y: 0 },
  #   { label: "202004", y: 0 },
  #   { label: "202005", y: 0 },
  #   { label: "202006", y: 0 },
  #   { label: "202007", y: 0 },
  #   { label: "202008", y: 0 },
  #   { label: "202009", y: 0 },
  #   { label: "202010", y: 0 },
  #   { label: "202011", y: 0 },
  #   { label: "202012", y: 0 }
  # ]

  LABEL = {
    indexLabel: "",
    indexLabelPlacement: "outside",
    indexLabelFontSize: 12,
    indexLabelMaxWidth: 120
  }

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

  def set_label(month: "", name: "", **options)
    label = LABEL.deep_dup.merge(indexLabel: name).merge(options)
    @series[:dataPoints].each do |point|
      if point[:label] == month
        point.merge!(label)
      end
    end
  end

end
