# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  name         :string
#  group_id     :integer
#  job_title_id :integer
#  number       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require "test_helper"

class MemberTest < ActiveSupport::TestCase
  setup do
    @member = Member.new
  end

  test "is valid" do
    assert @member.valid?
  end

  instance_methods = %i[
    allocs
    assigns
    group
    group_name
    job_title
    job_title_name
    projects
    works
  ]
  
  instance_methods.each do |method|
    test "has instance #{method}" do
      assert_respond_to @member, method 
    end
  end
  
  static_methods = %i[
    admin
    bp
    circle_chart
    job_order
    recent
    same_group
    sofia
    with_allocs
    with_works
    worker
  ]
  
  static_methods.each do |method|
    test "has static #{method}" do
      assert_respond_to Member, method
    end
  end

end
