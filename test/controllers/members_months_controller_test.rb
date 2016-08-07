require 'test_helper'

class MembersMonthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @members_month = members_months(:one)
  end

  test "should get index" do
    get members_months_url
    assert_response :success
  end

  test "should get new" do
    get new_members_month_url
    assert_response :success
  end

  test "should create members_month" do
    assert_difference('MembersMonth.count') do
      post members_months_url, params: { members_month: { cost: @members_month.cost, member_id: @members_month.member_id, month: @members_month.month } }
    end

    assert_redirected_to members_month_url(MembersMonth.last)
  end

  test "should show members_month" do
    get members_month_url(@members_month)
    assert_response :success
  end

  test "should get edit" do
    get edit_members_month_url(@members_month)
    assert_response :success
  end

  test "should update members_month" do
    patch members_month_url(@members_month), params: { members_month: { cost: @members_month.cost, member_id: @members_month.member_id, month: @members_month.month } }
    assert_redirected_to members_month_url(@members_month)
  end

  test "should destroy members_month" do
    assert_difference('MembersMonth.count', -1) do
      delete members_month_url(@members_month)
    end

    assert_redirected_to members_months_url
  end
end
