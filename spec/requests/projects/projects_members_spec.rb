require 'rails_helper'

RSpec.describe "ProjectsMembers", type: :request do
  let(:id){1}
  let(:params){{projects_member: attributes_for(:projects_member)}}
  before{create :projects_member, id: id}

  describe "GET /projects_members" do
    it{should == 200}
  end

  describe "GET /projects_members/:id" do
    it{should == 200}
  end

  describe "POST /projects_members" do
    it {should == 200}
  end

  describe "PATCH /projects_members/1" do
    it{should == 200}
  end

  describe "DELETE /projects_members/1" do
    it{should == 204}
  end
end
