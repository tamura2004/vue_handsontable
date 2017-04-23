class Json::MonthTypesPresenter < Json::BasePresenter
  def to_row(cols)
    MonthTypes.each do |enum|
      json.set! *enum.to_pair(cols)
    end
  end
end
