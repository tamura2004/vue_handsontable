module Pivot
  extend ActiveSupport::Concern

  def header
    attributes.reject do |key,_|
      %(month cost).include? key
    end
  end

  included do
    using ArrayPivot

    scope :htbl_params, -> id_field, fields {
      HtblParamsFactory.new(all,id_field,fields)
    }

    scope :pivot, -> {
      all.group_by(&:header).map do |header,rows|
        rows.pivot(header)
      end
    }
  end

end
