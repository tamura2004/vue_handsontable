class MonthTypes < Inum::Base
  define :APR, 0
  define :MAY, 1
  define :JUN, 2
  define :JUL, 3
  define :AUG, 4
  define :SEP, 5
  define :OCT, 6
  define :NOV, 7
  define :DEC, 8
  define :JAN, 9
  define :FEB, 10
  define :MAR, 11

  def key
    Date.new(2017,4,1).months_since(value).strftime("%Y%m")
  end

  def self.keys
    map(&:key)
  end

  def self.parse(object)
    if enum = @enums.find{|enum|enum.key == object}
      enum
    else
      super(object)
    end
  end

  def self.costs(cols: [], zero_to_blank: false)
    Array.new(12, 0).tap do |array|
      cols.each do |col|
        if enum = parse(col.month)
          array[enum.value] += col.cost
        end
      end
      if zero_to_blank
        array.map! do |value|
          value.zero? ? "" : value
        end
      end
    end
  end

  def self.pivot(cols: [])
    Hash[keys.zip(costs(cols: cols))]
  end

  def self.add_series(chart, at, label, cost)
    Chart::LineSeriesBuilder.build(chart) do |series|
      keys.each do |month|
        series.set_point(month, cost) do |point|
          if month == at
            point[:indexLabel] = label
          end
        end
      end
    end
  end

  def self.submonth
    pair = values.combination(2).to_a.sample
    Range.new(*pair).to_a.map{|i| parse(i).key }
  end

end
