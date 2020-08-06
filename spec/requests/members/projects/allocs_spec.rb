require 'rails_helper'

RSpec.describe "Members::Projects::Assigns", type: :request do
  let(:member) { create :member }
  let(:assign) { create :assign, member_id: member.id }
  before { create :work, member_id: member.id, month: "201705", cost: 1 }
  before { create :alloc, assign_id: assign.id, month: "201705", cost: 0.5 }
  before { create :group, { id: 3} }

  describe "GET /members/projects/allocs/circle_chart" do
    it { should == 200 }
  end

end
