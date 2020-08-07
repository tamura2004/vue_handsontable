require 'test_helper'

class ProjectsAssignsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get project_assigns_url(projects(:one))
    assert_response :success
  end

  test "create" do
    skip "write me later."
  end

  test "destroy" do
    skip "write me later."
  end
end
