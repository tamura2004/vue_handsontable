require 'rails_helper'

RSpec.describe "Assign", type: :request do
  before do
    3.times do 
      member = create :member
      assign = create :assign, { member_id: member.id }
      MonthTypes.keys.each do |month|
        create :work, { month: month, member_id: member.id }
        create :alloc, { month: month, assign_id: assign.id }
      end
    end
  end

  let(:project) { create :project }
  before {
    create :plan, {
      category: "test",
      project_number: project.number,
      project_name: project.name,
      m1: 0.5,
      m2: 0.5,
      m3: 0.5,
      m4: 0.5,
      m5: 0.5,
      m6: 0.5,
      m7: 0.5,
      m8: 0.5,
      m9: 0.5,
      m10: 0.5,
      m11: 0.5,
      m12: 0.5
    } 
  }

  before { create :group, { id: 1 } }

  describe "GET /assigns/member_report" do
    it{should == 200}
  end

  describe "GET /assigns/member_report.xlsx" do
    it{should == 200}
  end

  describe "GET /assigns/allocs_report.xlsx" do
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
