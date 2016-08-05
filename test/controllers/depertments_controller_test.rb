require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @depertment = depertments(:one)
  end

  test "should get index" do
    get depertments_url
    assert_response :success
  end

  test "should get new" do
    get new_depertment_url
    assert_response :success
  end

  test "should create depertment" do
    assert_difference('Department.count') do
      post depertments_url, params: { depertment: { name: @depertment.name } }
    end

    assert_redirected_to depertment_url(Department.last)
  end

  test "should show depertment" do
    get depertment_url(@depertment)
    assert_response :success
  end

  test "should get edit" do
    get edit_depertment_url(@depertment)
    assert_response :success
  end

  test "should update depertment" do
    patch depertment_url(@depertment), params: { depertment: { name: @depertment.name } }
    assert_redirected_to depertment_url(@depertment)
  end

  test "should destroy depertment" do
    assert_difference('Department.count', -1) do
      delete depertment_url(@depertment)
    end

    assert_redirected_to depertments_url
  end
end
