class PlanDecorator < Draper::Decorator
  delegate_all

  def filter
    <<-JAVASCRIPT
      $root.query === '' ||
      ~'#{model.project_number}'.indexOf($root.query) ||
      ~'#{model.project_name}'.indexOf($root.query) ||
      ~'#{model.category}'.indexOf($root.query)
    JAVASCRIPT
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

end
