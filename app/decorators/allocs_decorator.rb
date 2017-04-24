class AllocsDecorator < Draper::CollectionDecorator
  def pivot
    MonthTypes.pivot(cols: self)
  end
end
