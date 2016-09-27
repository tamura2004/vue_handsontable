require 'rails_helper'

RSpec.describe "Departments", type: :request do
  let(:id){1}
  let(:params){{department: attributes_for(:department)}}
  before{create :department, id: id}
  before{create :group}

  describe "GET /departments" do
    it{should == 200}
  end

  describe "GET /departments/:id" do
    it{should == 200}
  end

  describe "POST /departments" do
    it {should == 200}
  end

  describe "PATCH /departments/1" do
    it{should == 200}
  end

  describe "DELETE /departments/1" do
    it{should == 200}
  end
end
