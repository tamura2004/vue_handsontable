require 'test_helper'

class MembersProjectsMonthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @members_projects_month = members_projects_months(:one)
  end

  test "should get index" do
    get members_projects_months_url
    assert_response :success
  end

  test "should get new" do
    get new_members_projects_month_url
    assert_response :success
  end

  test "should create members_projects_month" do
    assert_difference('MembersProjectsMonth.count') do
      post members_projects_months_url, params: { members_projects_month: { cost: @members_projects_month.cost, month: @members_projects_month.month, projects_member_id: @members_projects_month.projects_member_id } }
    end

    assert_redirected_to members_projects_month_url(MembersProjectsMonth.last)
  end

  test "should show members_projects_month" do
    get members_projects_month_url(@members_projects_month)
    assert_response :success
  end

  test "should get edit" do
    get edit_members_projects_month_url(@members_projects_month)
    assert_response :success
  end

  test "should update members_projects_month" do
    patch members_projects_month_url(@members_projects_month), params: { members_projects_month: { cost: @members_projects_month.cost, month: @members_projects_month.month, projects_member_id: @members_projects_month.projects_member_id } }
    assert_redirected_to members_projects_month_url(@members_projects_month)
  end

  test "should destroy members_projects_month" do
    assert_difference('MembersProjectsMonth.count', -1) do
      delete members_projects_month_url(@members_projects_month)
    end

    assert_redirected_to members_projects_months_url
  end
end
