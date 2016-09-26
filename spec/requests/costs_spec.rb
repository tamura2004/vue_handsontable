require 'rails_helper'

RSpec.describe "Costs", type: :request do
  let(:id){1}
  let(:params){{cost: attributes_for(:cost)}}
  before{create :cost, id: id}

  describe "GET /costs" do
    it{should == 200}
  end

  describe "GET /costs/:id" do
    it{should == 200}
  end

  describe "POST /costs" do
    it {should == 200}
  end

  describe "PATCH /costs/1" do
    it{should == 200}
  end

  describe "DELETE /costs/1" do
    it{should == 204}
  end
end
