require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get projects_url
    assert_response :success
  end
end
