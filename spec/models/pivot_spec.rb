require 'rails_helper'

RSpec.describe Pivot, type: :model do

  context "module ArrayPivot" do
    using ArrayPivot
    Row = Struct.new(:month,:cost)

    it {
      expect(
        [
          Row.new("201604",10),
          Row.new("201605",20),
          Row.new("201606",30),
          Row.new("201606",40)
        ].pivot({name:"alice",age:19})
      ).to eq(
        {
          name: "alice",
          age: 19,
          "201604" => 10,
          "201605" => 20,
          "201606" => 70
        }
      )
    }
  end
end
