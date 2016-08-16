require 'test_helper'

class GroupsProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get groups_projects_index_url
    assert_response :success
  end

end
