require 'test_helper'

class ProjectsMembersMothlyAllocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projects_members_mothly_allocation = projects_members_mothly_allocations(:one)
  end

  test "should get index" do
    get projects_members_mothly_allocations_url
    assert_response :success
  end

  test "should get new" do
    get new_projects_members_mothly_allocation_url
    assert_response :success
  end

  test "should create projects_members_mothly_allocation" do
    assert_difference('ProjectsMembersMothlyAllocation.count') do
      post projects_members_mothly_allocations_url, params: { projects_members_mothly_allocation: { cost: @projects_members_mothly_allocation.cost, member_id: @projects_members_mothly_allocation.member_id, month: @projects_members_mothly_allocation.month, project_id: @projects_members_mothly_allocation.project_id } }
    end

    assert_redirected_to projects_members_mothly_allocation_url(ProjectsMembersMothlyAllocation.last)
  end

  test "should show projects_members_mothly_allocation" do
    get projects_members_mothly_allocation_url(@projects_members_mothly_allocation)
    assert_response :success
  end

  test "should get edit" do
    get edit_projects_members_mothly_allocation_url(@projects_members_mothly_allocation)
    assert_response :success
  end

  test "should update projects_members_mothly_allocation" do
    patch projects_members_mothly_allocation_url(@projects_members_mothly_allocation), params: { projects_members_mothly_allocation: { cost: @projects_members_mothly_allocation.cost, member_id: @projects_members_mothly_allocation.member_id, month: @projects_members_mothly_allocation.month, project_id: @projects_members_mothly_allocation.project_id } }
    assert_redirected_to projects_members_mothly_allocation_url(@projects_members_mothly_allocation)
  end

  test "should destroy projects_members_mothly_allocation" do
    assert_difference('ProjectsMembersMothlyAllocation.count', -1) do
      delete projects_members_mothly_allocation_url(@projects_members_mothly_allocation)
    end

    assert_redirected_to projects_members_mothly_allocations_url
  end
end
