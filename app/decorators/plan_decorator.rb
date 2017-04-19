class PlanDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def filter
    "$root.query === '' || ~'#{model.project_number}'.indexOf($root.query) || ~'#{model.project_name}'.indexOf($root.query) || ~'#{model.category}'.indexOf($root.query)"
  end

  def row_color
    model.category == '-99' ? 'danger' : 'default'
  end

  def costs
    12.times.map { |i| CostDecorator.decorate(cost(i)) }
  end

  def cost(i)
    model["t#{i+1}"]
  end

  # def schedule_color(i)
  #   cost(i) > 0 ? 'bar' : ''
  # end

  # def schedule_cost(i)
  #   cost(i) > 0 ? cost(i)&.round(2) : ""
  # end

end