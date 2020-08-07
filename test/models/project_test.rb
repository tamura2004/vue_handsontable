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

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = Project.new do |s|
      s.name = "テストプロジェクト"
    end
  end

  test "適正である" do
    assert @project.valid?
  end

  test "名前が必要" do
    @project.name = nil
    assert @project.invalid?
  end

  instance_methods = %i[
    allocs
    assigns
    group
    group_name
    members
  ]

  instance_methods.each do |method|
    test "インスタンスメソッドを持つ #{method}" do
      assert_respond_to @project, method
    end
  end

  static_methods = %i[
    available
    recent
    same_group
    with_allocs
  ]

  static_methods.each do |method|
    test "スタティックメソッドを持つ #{method}" do
      assert_respond_to Project, method
    end
  end
end
