require 'rails_helper'

RSpec.describe "MembersProjectMonths", type: :request do
  let(:id){1}
  let(:params){{members_project_month: attributes_for(:members_project_month)}}
  before{create :members_project_month, id: id}

  describe "GET /members_project_months" do
    it{should == 200}
  end

  describe "GET /members_project_months/:id" do
    it{should == 200}
  end

  describe "POST /members_project_months" do
    it {should == 200}
  end

  describe "PATCH /members_project_months/1" do
    it{should == 200}
  end

  describe "DELETE /members_project_months/1" do
    it{should == 204}
  end
end
