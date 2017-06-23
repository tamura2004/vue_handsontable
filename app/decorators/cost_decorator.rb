class CostDecorator < Draper::Decorator
  delegate_all

  def color
    model.to_i > 0 ? 'bar' : ''
  end

  def decimal
    model.to_i > 0 ? model&.round(2) : ""
  end

  def round2
    model.to_i > 0 ? model&.round(2) : "0.00"
  end

end
