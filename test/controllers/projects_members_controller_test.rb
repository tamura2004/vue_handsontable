require 'test_helper'

class ProjectsMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projects_member = projects_members(:one)
  end

  test "should get index" do
    get projects_members_url
    assert_response :success
  end

  test "should get new" do
    get new_projects_member_url
    assert_response :success
  end

  test "should create projects_member" do
    assert_difference('ProjectsMember.count') do
      post projects_members_url, params: { projects_member: { member_id: @projects_member.member_id, project_id: @projects_member.project_id } }
    end

    assert_redirected_to projects_member_url(ProjectsMember.last)
  end

  test "should show projects_member" do
    get projects_member_url(@projects_member)
    assert_response :success
  end

  test "should get edit" do
    get edit_projects_member_url(@projects_member)
    assert_response :success
  end

  test "should update projects_member" do
    patch projects_member_url(@projects_member), params: { projects_member: { member_id: @projects_member.member_id, project_id: @projects_member.project_id } }
    assert_redirected_to projects_member_url(@projects_member)
  end

  test "should destroy projects_member" do
    assert_difference('ProjectsMember.count', -1) do
      delete projects_member_url(@projects_member)
    end

    assert_redirected_to projects_members_url
  end
end
