require 'rails_helper'

RSpec.describe "Works", type: :request do
  let(:month){"201704"}
  let(:work){create :work, month: month}
  let(:id){work.member.id}
  let(:group_id){work.member.group.id}

  describe "GET /groups/:group_id/works" do
    it{should == 200}
  end

  describe "PATCH /groups/:group_id/works/:id" do
    let(:params){{month => 10}}
    it{should == 200}
  end

  describe "PATCH /groups/:group_id/works/:id" do
    let(:params){{"201705" => 10}}
    it{should == 200}
  end

  describe "PATCH /groups/:group_id/works/:id" do
    let(:params){{month => 0}}
    it{should == 204}
  end

end
