class MonthTypesDecorator < Draper::Decorator
  delegate_all

  def self.decorate
    super(MonthTypes)
  end
end
