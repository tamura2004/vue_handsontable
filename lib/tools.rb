require 'active_support'
require 'active_support/core_ext'

now = Time.local(2016,4)

12.times do |i|
  printf("\"%s\":nil,",now.since(i.month).strftime("%Y-%m"))
  # printf "{data: \"m%02d\"},\n",i+1
end
