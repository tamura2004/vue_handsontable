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

require "test_helper"

class GroupTest < ActiveSupport::TestCase
  setup do
    @group = Group.new do |s|
      s.name = "火星グループ"
    end
  end
  
  test "適正である" do
    assert @group.valid?
  end

  test "名前が必要" do
    @group.name = nil
    assert @group.invalid?
  end
  
  test "所属を持てる" do
    assert_respond_to @group, :department
  end
  
  test "プロジェクトを持つ" do
    assert_respond_to @group, :projects
  end
  
  test "メンバーを持つ" do
    assert_respond_to @group, :members
  end
  
end
