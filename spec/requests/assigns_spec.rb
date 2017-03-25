require 'rails_helper'

RSpec.describe "Assign", type: :request do
  before{create :group}

  describe "GET /assigns" do
    it{should == 200}
  end

  describe "GET /assigns.xlsx" do
    it{should == 200}
  end

  describe "GET /assigns/chart" do
    it{should == 200}
  end

end
