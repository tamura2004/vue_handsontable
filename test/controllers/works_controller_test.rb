require 'test_helper'

class WorksControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get group_works_url(groups(:one))
    assert_response :success
  end

  test "update" do
    skip "write me later."
  end
end
