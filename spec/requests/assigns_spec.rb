require 'rails_helper'

RSpec.describe "Assign", type: :request do
  before { create :group, { id: 1 } }
  before { create :alloc }

  describe "GET /assigns/member_report" do
    it{should == 200}
  end

  describe "GET /assigns/projects_report" do
    it{should == 200}
  end

  describe "GET /assigns/chart" do
    it{should == 200}
  end

  describe "GET /assigns/member_chart" do
    it{should == 200}
  end

  describe "GET /assigns/project_chart" do
    it{should == 200}
  end
end
