# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class WorkTest < ActiveSupport::TestCase
  setup do
    @work = Work.new do |s|
      s.cost = 0.1
    end
  end

  test "適正である" do
    assert @work.valid?
  end

  test "コストが必要" do
    @work.cost = nil
    assert @work.invalid?
  end

  test "コストは数値" do
    @work.cost = "string"
    assert @work.invalid?
  end

  test "コストは正の数" do
    @work.cost = -1
    assert @work.invalid?
  end

  instance_methods = %i[
    cost
    group
    job_title
    member
  ]

  instance_methods.each do |method|
    test "インスタンスメソッドを持つ #{method}" do
      assert_respond_to @work, method
    end
  end

  static_methods = %i[
    recent
    member_chart
  ]

  static_methods.each do |method|
    test "スタティックメソッドを持つ #{method}" do
      assert_respond_to Work, method
    end
  end

end
