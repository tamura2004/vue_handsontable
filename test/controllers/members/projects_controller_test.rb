require 'test_helper'

class Members::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_projects_index_url
    assert_response :success
  end

end
