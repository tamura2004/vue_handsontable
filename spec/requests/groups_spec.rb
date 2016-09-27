require 'rails_helper'

RSpec.describe "Groups", type: :request do
  let(:id){1}
  let(:params){{group: attributes_for(:group)}}
  before{create :group, id: id}

  describe "GET /groups" do
    it{should == 200}
  end

  describe "POST /groups" do
    it {should == 200}
  end

  describe "PATCH /groups/1" do
    it{should == 200}
  end

  describe "DELETE /groups/1" do
    it{should == 204}
  end
end
