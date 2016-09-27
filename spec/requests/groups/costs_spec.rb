require 'rails_helper'

RSpec.describe "Costs", type: :request do
  let(:cost){create :projects_monthly_allocation}
  let(:group_id){cost.project.group.id}

  describe "GET /groups/:group_id/costs" do
    it{should == 200}
  end

  describe "PATCH /groups/:group_id/costs/:id" do
    let(:id){cost.project.id}
    let(:params){{:"201608" => 10}}

    it{should == 200}
  end
end
