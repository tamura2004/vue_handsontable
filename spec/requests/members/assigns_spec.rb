require 'rails_helper'

RSpec.describe "Members::Assigns", type: :request do
  let(:assign){create :assign}
  let(:member_id){assign.member.id}
  let(:id){assign.id}
  let(:params){{assign: build(:assign).attributes}}

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