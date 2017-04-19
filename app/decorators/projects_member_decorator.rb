class ProjectsMemberDecorator < Draper::Decorator
  delegate_all

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
