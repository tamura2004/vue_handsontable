require 'rails_helper'

RSpec.describe "Projects::Assigns", type: :request do
  let(:assign){create :assign}
  let(:project_id){assign.project.id}
  let(:id){assign.id}
  let(:params){{assign: build(:assign).attributes}}

  describe "GET /projects/:project_id/assigns" do
    it{should == 200}
  end

  describe "POST /projects/:project_id/assigns" do
    it{should == 200}
  end

  describe "DELETE /projects/:project_id/assigns/:id" do
    it{should == 204}
  end
end
