require 'test_helper'

class ProjectsAllocsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get project_allocs_url(projects(:one))
    assert_response :success
  end
end
