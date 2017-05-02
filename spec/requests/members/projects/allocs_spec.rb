require 'rails_helper'

RSpec.describe "Members::Projects::Assigns", type: :request do
  let(:group){create :group}
  let(:alloc){create :alloc}

  describe "GET /members/projects/allocs/circle_chart" do
    it{should == 200}
  end

end
