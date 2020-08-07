# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  group_id    :integer
#  number      :string
#  name        :string
#  cost        :float
#  rd          :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  start_month :string
#  end_month   :string
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:group){create :group}
  let(:group_id){->{project.group_id}}

  context "valid?" do
    subject{build :project}
    it {should be_valid}
  end

  context "invalid?" do
    subject{build :project, name: ""}
    it {should_not be_valid}
  end

  context "グループ名が存在する場合、セーブ前にグループIDがセットされること" do
    let(:project){build :project, group_id: nil, group_name: group.name}
    subject{->{project.save}}
    it{should change(&group_id).to group.id}
  end

  context "グループ名が存在しない場合、セーブ前にグループIDにnilがセットされること" do
    let(:project){create :project, group_id: nil, group_name: group.name + "@@@"}
    subject{project.group_id}
    it{should == nil}
  end

end
