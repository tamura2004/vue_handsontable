require 'test_helper'

class MembersAllocsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get member_allocs_url(members(:one))
    assert_response :success
  end
end
