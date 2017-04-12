class CostDecorator < Draper::Decorator
  delegate_all

  def color
    model > 0 ? 'bar' : ''
  end

  def decimal
    model > 0 ? model&.round(2) : ""
  end
end
