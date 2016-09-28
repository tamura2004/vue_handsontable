require 'rails_helper'

RSpec.describe "Projects::Allocs", type: :request do
  let(:alloc){create :alloc,month:"201608",cost:10}
  let(:id){alloc.assign.id}
  let(:project_id){alloc.project.id}

  describe "GET /projects/:project_id/allocs" do
    it{should == 200}
  end

  describe "PATCH /projects/:project_id/allocs/:id" do
    let(:params){{"201608" => 100}}
    it{should == 200}
  end

  describe "PATCH /projects/:project_id/allocs/:id" do
    let(:params){{"201609" => 20}}
    it{should == 200}
  end

  describe "PATCH /projects/:project_id/allocs/:id" do
    let(:params){{"201608" => 0}}
    it{should == 204}
  end
end
