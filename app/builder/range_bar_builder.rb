class RangeBarBuilder
  attr_accessor :bar
  delegate :[]=, to: :bar

  def initialize(plan)
    @bar = {
      x: plan.project_name,
      # y: [ plan.start_month, plan.end_month ]
      y: [ rand(10), rand(10) + 10 ]
    }
    yield self if block_given?
  end

end
