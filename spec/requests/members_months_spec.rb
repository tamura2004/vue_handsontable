require 'rails_helper'

RSpec.describe "MembersMonths", type: :request do
  let(:id){1}
  let(:params){{members_month: attributes_for(:members_month)}}
  before{create :members_month, id: id}

  describe "GET /members_months" do
    it{should == 200}
  end

  describe "GET /members_months/:id" do
    it{should == 200}
  end

  describe "POST /members_months" do
    it {should == 200}
  end

  describe "PATCH /members_months/1" do
    it{should == 200}
  end

  describe "DELETE /members_months/1" do
    it{should == 204}
  end
end
