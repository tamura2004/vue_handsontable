require 'rails_helper'

RSpec.describe "Departments", type: :request do
  let(:params){{department: attributes_for(:department)}}
  let(:id){1}
  before{create :department, id: id}
  before{create :group}

  describe "GET /departments" do
    it{should == 200}
  end

  describe "POST /departments" do
    it {should == 200}
  end

  describe "PATCH /departments/:id" do
    it{should == 200}
  end

  describe "DELETE /departments/:id" do
    it{should == 204}
  end
end
