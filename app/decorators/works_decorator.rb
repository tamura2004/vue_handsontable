class WorksDecorator < Draper::CollectionDecorator
  def pivot
    MonthTypes.pivot(cols: self, key: :month, value: :cost)
  end
end
