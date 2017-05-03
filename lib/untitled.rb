def hoge(xs)
  y = 10

  xs.each do |x|
    yield y,*x
  end
end

hs = {a:1,b:2}

hoge(hs) do |y,x1,x2|
  p [y,x1,x2]
end

hoge([1,2,3]) do |y,x1|
  p [y,x1]
end
