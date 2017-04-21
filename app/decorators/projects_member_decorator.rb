class ProjectsMemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :project
  decorates_association :member

  def costs
    Array.new(12,0).tap do |array|
      model.allocs.each do |alloc|
        if enum = MonthTypes.parse(alloc.month)
          array[enum.value] += alloc.cost
        end
      end
    end
  end

end
