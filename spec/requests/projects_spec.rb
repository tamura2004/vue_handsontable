require 'rails_helper'

RSpec.describe "Project", type: :request do
  let(:id){1}
  let(:params){{project: attributes_for(:project)}}
  before{create :project, id: id}

  describe "GET /projects" do
    it{should == 200}
  end

  describe "POST /projects" do
    let(:params){{project: attributes_for(:project)}}
    it {should == 200}
  end

  describe "POST /projects" do
    let(:params){{project: attributes_for(:project, name:"")}}
    it {should == 422}
  end

  describe "PATCH /projects/:id.json" do
    it{should == 200}
  end

  describe "DELETE /projects/:id.json" do
    it{should == 204}
  end
end
