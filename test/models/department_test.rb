# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class DepartmentTest < ActiveSupport::TestCase
  setup do
    # 名前が重複するケース
    @department = Department.new do |s|
      s.name = departments(:one).name
    end
  end

  test "名前が重複してはいけない" do
    assert @department.invalid?
  end
  
  test "名前が重複しなければ適正である" do
    departments(:one).update(name: "other")
    assert @department.valid?
  end

  test "名前が必要" do
    assert Department.new.invalid?
  end
  
  test "グループを持つ" do
    assert_respond_to @department, :groups
  end
end
