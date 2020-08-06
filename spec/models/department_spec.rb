# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe Department, type: :model do
  context "適正なパラメータ" do
    subject { build :department }
    it { should be_valid }
  end

  context "nameは空であってはならない" do
    subject { build :department, name: "" }
    it { should_not be_valid }
  end

  context "nameは重複してはならない" do
    let(:other) { create :department }
    subject { build :department, name: other.name }
    it { should_not be_valid }
  end
end
