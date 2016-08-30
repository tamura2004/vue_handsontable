require 'test_helper'

class Member::AssignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member_assign = member_assigns(:one)
  end

  test "should get index" do
    get member_assigns_url
    assert_response :success
  end

  test "should get new" do
    get new_member_assign_url
    assert_response :success
  end

  test "should create member_assign" do
    assert_difference('Member::Assign.count') do
      post member_assigns_url, params: { member_assign: {  } }
    end

    assert_redirected_to member_assign_url(Member::Assign.last)
  end

  test "should show member_assign" do
    get member_assign_url(@member_assign)
    assert_response :success
  end

  test "should get edit" do
    get edit_member_assign_url(@member_assign)
    assert_response :success
  end

  test "should update member_assign" do
    patch member_assign_url(@member_assign), params: { member_assign: {  } }
    assert_redirected_to member_assign_url(@member_assign)
  end

  test "should destroy member_assign" do
    assert_difference('Member::Assign.count', -1) do
      delete member_assign_url(@member_assign)
    end

    assert_redirected_to member_assigns_url
  end
end
