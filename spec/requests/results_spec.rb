require 'rails_helper'

RSpec.describe "Results", type: :request do
  let(:id){1}
  let(:params){{result: attributes_for(:result)}}
  before{create :result, id: id}

  describe "GET /results" do
    it{should == 200}
  end

  describe "GET /results/:id" do
    it{should == 200}
  end

  describe "POST /results" do
    it {should == 200}
  end

  describe "PATCH /results/1" do
    it{should == 200}
  end

  describe "DELETE /results/1" do
    it{should == 204}
  end
end
