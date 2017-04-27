class HtblBuilder < Jbuilder

  def column!(data: nil, renderer: nil, type: nil, format: nil)
    ignore_nil!
    child! do
      set! :data, data
      set! :renderer, renderer
      set! :type, type
      set! :format, format
    end
  end

  def months_columns!
    ::MonthTypes.keys.each do |month|
      column! data: month, type: "numeric", format: "0.00"
    end
  end

end
