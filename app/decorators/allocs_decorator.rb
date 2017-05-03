class AllocsDecorator < Draper::CollectionDecorator
  delegate :where

  def pivot
    MonthTypes.pivot(cols: self)
  end

  # def index_label_month
  #   allocs = where(month: MonthTypes.keys)
  #   cost_total = allocs.sum(:cost)
  #   weighted_total_month = allocs.inject(0) do |acc, alloc|
  #     acc += MonthTypes.parse(alloc.month).value * alloc.cost
  #   end
  #   if cost_total != 0
  #     weighted_averate_month = MonthTypes.parse((weighted_total_month / cost_total).to_i)&.key || "201705"
  #   else
  #     weighted_total_month = "201705"
  #   end
  # end
end
