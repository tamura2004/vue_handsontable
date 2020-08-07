# == Schema Information
#
# Table name: allocs
#
#  id         :integer          not null, primary key
#  assign_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class AllocTest < ActiveSupport::TestCase
  setup do
    @alloc = Alloc.new do |s|
      s.cost = 0.1
    end
  end

  test "適正である" do
    assert @alloc.valid?
  end

  test "コストが必要" do
    @alloc.cost = nil
    assert @alloc.invalid?
    assert @alloc.errors.messages[:cost].present?
  end

  instance_methods = %i[
    assign
    job_title
    member
    project
  ]

  instance_methods.each do |method|
    test "インスタンスメソッドを持つ #{method}" do
      assert_respond_to @alloc, method
    end
  end

  static_methods = %i[
    member_chart
    project_chart
  ]

  static_methods.each do |method|
    test "スタティックメソッドを持つ #{method}" do
      assert_respond_to Alloc, method
    end
  end
end