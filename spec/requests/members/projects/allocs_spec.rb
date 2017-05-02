require 'rails_helper'

RSpec.describe "Members::Projects::Assigns", type: :request do
  let(:alloc){create :alloc}
  before { create :group, { id: 1} }

  describe "GET /members/projects/allocs/circle_chart" do
    it{should == 200}
  end

end
