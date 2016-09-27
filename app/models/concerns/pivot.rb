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
      all.to_a.group_by(&:header).map do |header,rows|
        rows.pivot(header)
      end
    }
  end

end
