require 'rails_helper'

RSpec.describe "Groups::Allocs", type: :request do
  let(:alloc){
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
    create :alloc
  }
  let(:group_id){alloc.member.group.id}

  describe "GET /groups/:group_id/allocs" do
    it{should == 200}
  end
end
