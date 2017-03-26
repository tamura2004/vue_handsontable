class PointBuilder
  attr_accessor :point

  def initialize(label, y)
    @point = { label: label, y: y || 0 }
    yield @point if block_given?
  end

end
