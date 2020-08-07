require 'test_helper'

class MembersAssignsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get member_assigns_url(members(:one))
    assert_response :success
  end

  test "create" do
    skip "write me later."
  end

  test "destroy" do
    skip "write me later."
  end
end
