require 'test_helper'

class MembersProjectsAllocsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get members_projects_allocs_circle_chart_url
    assert_response :success
  end
end
