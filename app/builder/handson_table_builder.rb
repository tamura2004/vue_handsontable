class HandsonTableBuilder < Jbuilder

  def column!(data: nil, renderer: nil, type: nil, format: nil)
    ignore_nil!
    child! do
      set! :data, data
      set! :renderer, renderer
      set! :type, type
      set! :format, format
    end
  end

  def self.build(*args, &block)
    new(*args, &block).attributes!
  end
end
