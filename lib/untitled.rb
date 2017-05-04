require "ostruct"

o = OpenStruct.new

o.a = 1
o.b = 2

p o.to_h.to_json
