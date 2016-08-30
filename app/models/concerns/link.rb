module Pivot
  extend ActiveSupport::Concern

  def header
    attributes.reject do |key,_|
      %(month cost).include? key
    end
  end

  included do
    using ArrayPivot

    scope :pivot, -> {
      [*pivot_specify, pivot_total]
    }

    scope :pivot_specify, -> {
      all.group_by(&:header).map do |header,rows|
        rows.pivot(header)
      end
    }

    scope :pivot_total, -> {
      all.to_a.pivot({name:"合計"})
    }

  end
end
