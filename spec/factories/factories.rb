FactoryGirl.define do
  sequence :month do |n|
    Date.new(2017,3,1).months_since(n).strftime("%Y%m")
    # "20%02d%02d" % [((n/12)%2)+17, (n%12)+1]
  end

  sequence :cost do |n|
    n.to_f / 10.0
  end
end
