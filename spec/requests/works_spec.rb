require 'rails_helper'

RSpec.describe "Works", type: :request do
  let(:id){1}
  let(:params){{work: attributes_for(:work)}}
  before{create :work, id: id}

  describe "GET /works" do
    it{should == 200}
  end

  describe "GET /works/:id" do
    it{should == 200}
  end

  describe "POST /works" do
    it {should == 200}
  end

  describe "PATCH /works/1" do
    it{should == 200}
  end

  describe "DELETE /works/1" do
    it{should == 204}
  end
end
