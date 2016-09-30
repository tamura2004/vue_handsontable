# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  number     :string
#  name       :string
#  cost       :float
#  rd         :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Project, type: :model do

  context "valid?" do
    subject{build :project}
    it {should be_valid}
  end

  context "by_group_name valid" do
    let(:group){create :group}
    let(:project){build :project, group_name: group.name}

    subject{->{project.save}}
    it{should change{project.group_id}}
  end

end
