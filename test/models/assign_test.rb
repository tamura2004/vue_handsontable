# == Schema Information
#
# Table name: assigns
#
#  id         :integer          not null, primary key
#  project_id :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class AssignTest < ActiveSupport::TestCase
  setup do
    @assign = Assign.new do |s|
      s.member = assigns(:one).member
      s.project = assigns(:one).project
    end
  end

  test "メンバーとプロジェクトの重複はエラー" do
    Member.find_each do |member|
      Project.find_each do |project|
        assign = Assign.new(member: member, project: project)
        if Assign.find_by(member: member, project: project)
          assert assign.invalid?
          assert assign.errors.messages[:member_id].present?
        else
          assert assign.valid?
        end
      end
    end
  end

  test "メンバーが必要" do
    @assign.member = nil
    assert @assign.invalid?
    assert @assign.errors.messages[:member_id].present?
  end

  test "プロジェクトが必要" do
    @assign.project = nil
    assert @assign.invalid?
    assert @assign.errors.messages[:project_id].present?
  end

  instance_methods = %i[
    allocs
    group
    job_title
    member
    project
  ]

  instance_methods.each do |method|
    test "インスタンスメソッドを持つ #{method}" do
      assert_respond_to @assign, method
    end
  end

  static_methods = %i[
    recent
    with_allocs
  ]

  static_methods.each do |method|
    test "スタティックメソッドを持つ #{method}" do
      assert_respond_to Assign, method
    end
  end
end
