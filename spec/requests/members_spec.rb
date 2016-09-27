require 'rails_helper'

RSpec.describe "Member", type: :request do
  let(:id){1}
  let(:params){{member: attributes_for(:member)}}
  before{create :member, id: id}

  describe "GET /members" do
    it{should == 200}
  end

  describe "POST /members.json" do
    it {should == 201}
  end

  describe "PATCH /members/:id.json" do
    it{should == 200}
  end

  describe "DELETE /members/:id.json" do
    it{should == 204}
  end
end
