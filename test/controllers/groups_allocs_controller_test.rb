require 'test_helper'

class GroupsAllocsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get group_allocs_url(groups(:one))
    assert_response :success
  end
end
