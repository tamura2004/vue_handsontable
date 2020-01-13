class MonthTypes < Inum::Base
  # 処理範囲を当月の３ヶ月前〜９ヶ月後に設定する。
  SYMS = %i(JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC)
  MONTH = Time.now.month + (12 - 3) - 1 #MOD12で3ヶ月前(0 origin)
  12.times do |i|
    j = (i + MONTH) % 12;
    define SYMS[j], i
  end

  # define :JAN, 0
  # define :FEB, 1
  # define :MAR, 2
  # define :APR, 3
  # define :MAY, 4
  # define :JUN, 5
  # define :JUL, 6
  # define :AUG, 7
  # define :SEP, 8
  # define :OCT, 9
  # define :NOV, 10
  # define :DEC, 11

  def key
    Date.today.months_ago(3).months_since(value).strftime("%Y%m")
    # Date.new(2020, 1, 1).months_since(value).strftime("%Y%m")
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
    Array.new(15, 0).tap do |array|
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
