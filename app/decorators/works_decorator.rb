class WorksDecorator < Draper::CollectionDecorator
  delegate :where, :find_by

  def pivot
    MonthTypes.pivot(cols: self)
  end
end
