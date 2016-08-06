require 'test_helper'

class ProjectsMembersMonthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projects_members_month = projects_members_months(:one)
  end

  test "should get index" do
    get projects_members_months_url
    assert_response :success
  end

  test "should get new" do
    get new_projects_members_month_url
    assert_response :success
  end

  test "should create projects_members_month" do
    assert_difference('ProjectsMembersMonth.count') do
      post projects_members_months_url, params: { projects_members_month: { cost: @projects_members_month.cost, month: @projects_members_month.month, projects_member_id: @projects_members_month.projects_member_id } }
    end

    assert_redirected_to projects_members_month_url(ProjectsMembersMonth.last)
  end

  test "should show projects_members_month" do
    get projects_members_month_url(@projects_members_month)
    assert_response :success
  end

  test "should get edit" do
    get edit_projects_members_month_url(@projects_members_month)
    assert_response :success
  end

  test "should update projects_members_month" do
    patch projects_members_month_url(@projects_members_month), params: { projects_members_month: { cost: @projects_members_month.cost, month: @projects_members_month.month, projects_member_id: @projects_members_month.projects_member_id } }
    assert_redirected_to projects_members_month_url(@projects_members_month)
  end

  test "should destroy projects_members_month" do
    assert_difference('ProjectsMembersMonth.count', -1) do
      delete projects_members_month_url(@projects_members_month)
    end

    assert_redirected_to projects_members_months_url
  end
end
