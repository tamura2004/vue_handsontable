class WorkDecorator < Draper::Decorator
  delegate_all
  decorates_association :member
end
