require 'rails_helper'

RSpec.describe "Works", type: :request do
  let(:work){create :work}
  let(:group_id){work.member.group.id}

  describe "GET /groups/:group_id/works" do
    it{should == 200}
  end

  describe "PATCH /groups/:group_id/works/:id" do
    let(:id){work.member.id}
    let(:params){{:"201608" => 10}}
    it{should == 200}
  end

end
