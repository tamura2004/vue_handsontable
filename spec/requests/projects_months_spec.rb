require 'rails_helper'

RSpec.describe "ProjectsMonths", type: :request do
  let(:id){1}
  let(:params){{projects_month: attributes_for(:projects_month)}}
  before{create :projects_month, id: id}

  describe "GET /projects_months" do
    it{should == 200}
  end

  describe "GET /projects_months/:id" do
    it{should == 200}
  end

  describe "POST /projects_months" do
    it {should == 200}
  end

  describe "PATCH /projects_months/1" do
    it{should == 200}
  end

  describe "DELETE /projects_months/1" do
    it{should == 204}
  end
end
