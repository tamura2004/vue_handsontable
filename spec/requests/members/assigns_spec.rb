require 'rails_helper'

RSpec.describe "Members::Projects", type: :request do
  let(:assign){create :projects_member}
  let(:member_id){assign.member.id}
  let(:id){assign.id}
  let(:params){{projects_member: build(:assign).attributes}}

  describe "GET /members/:member_id/assigns" do
    it {should == 200}
  end

  describe "POST /members/:member_id/assigns" do
    it{should == 200}
  end

  describe "DELETE /members/:member_id/assigns/:id" do
    it{should == 204}
  end
end