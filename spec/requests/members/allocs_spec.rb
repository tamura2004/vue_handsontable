require 'rails_helper'

RSpec.describe "Members::Assigns", type: :request do
  let(:alloc){create :alloc,month:"201608",cost:10}
  let(:id){alloc.assign.id}
  let(:member_id){alloc.projects_member.member.id}

  describe "GET /members/:member_id/allocs" do
    it{should == 200}
  end

  describe "PATCH /members/:member_id/allocs/:id" do
    let(:params){{"201608" => 100}}
    it{should == 200}
  end

  describe "PATCH /members/:member_id/allocs/:id" do
    let(:params){{"201609" => 20}}
    it{should == 200}
  end

  describe "PATCH /members/:member_id/allocs/:id" do
    let(:params){{"201608" => 0}}
    it{should == 204}
  end
end
