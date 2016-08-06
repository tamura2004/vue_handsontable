require 'test_helper'

class ProjectsMonthlyAllocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projects_monthly_allocation = projects_monthly_allocations(:one)
  end

  test "should get index" do
    get projects_monthly_allocations_url
    assert_response :success
  end

  test "should get new" do
    get new_projects_monthly_allocation_url
    assert_response :success
  end

  test "should create projects_monthly_allocation" do
    assert_difference('ProjectsMonthlyAllocation.count') do
      post projects_monthly_allocations_url, params: { projects_monthly_allocation: { cost: @projects_monthly_allocation.cost, month: @projects_monthly_allocation.month, project_id: @projects_monthly_allocation.project_id } }
    end

    assert_redirected_to projects_monthly_allocation_url(ProjectsMonthlyAllocation.last)
  end

  test "should show projects_monthly_allocation" do
    get projects_monthly_allocation_url(@projects_monthly_allocation)
    assert_response :success
  end

  test "should get edit" do
    get edit_projects_monthly_allocation_url(@projects_monthly_allocation)
    assert_response :success
  end

  test "should update projects_monthly_allocation" do
    patch projects_monthly_allocation_url(@projects_monthly_allocation), params: { projects_monthly_allocation: { cost: @projects_monthly_allocation.cost, month: @projects_monthly_allocation.month, project_id: @projects_monthly_allocation.project_id } }
    assert_redirected_to projects_monthly_allocation_url(@projects_monthly_allocation)
  end

  test "should destroy projects_monthly_allocation" do
    assert_difference('ProjectsMonthlyAllocation.count', -1) do
      delete projects_monthly_allocation_url(@projects_monthly_allocation)
    end

    assert_redirected_to projects_monthly_allocations_url
  end
end
