# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  department_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "rails_helper"

RSpec.describe Group, type: :model do
  let(:dep) { create :department }

  context "valid?" do
    subject { build :group }
    it { should be_valid }
  end

  describe "#group_name" do
    context "present?" do
      let(:group) { create :group, department_name: dep.name }
      subject { group.department_id }
      it { should == dep.id }
    end

    context "not present?" do
      let(:group) { create :group, department_name: dep.name + "@@@" }
      subject { group.department_id }
      it { should == nil }
    end
  end
end
