require 'rails_helper'

RSpec.describe "Results", type: :request do
  let(:result){create :result}

  describe "GET /results" do
    it{should == 200}
  end

  describe "POST /results/upload" do
    it{should == 200}
  end

  describe "DELETE /results/:id" do
    let(:id){result.id}
    it{should == 204}
  end
end
