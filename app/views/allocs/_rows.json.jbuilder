json.array! allocs do |alloc|
  json.partial! "row", alloc: alloc
end
