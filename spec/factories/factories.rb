FactoryGirl.define do
  sequence :month do |n|
    "20%02d%02d" % [((n/12)%2)+16, (n%12)+1]
  end

  sequence :cost do |n|
    n.to_f / 10.0
  end
end
