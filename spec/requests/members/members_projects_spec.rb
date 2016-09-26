require 'rails_helper'

RSpec.describe "MembersProjects", type: :request do
  let(:id){1}
  let(:params){{members_project: attributes_for(:members_project)}}
  before{create :members_project, id: id}

  describe "GET /members_projects" do
    it{should == 200}
  end

  describe "GET /members_projects/:id" do
    it{should == 200}
  end

  describe "POST /members_projects" do
    it {should == 200}
  end

  describe "PATCH /members_projects/1" do
    it{should == 200}
  end

  describe "DELETE /members_projects/1" do
    it{should == 204}
  end
end
