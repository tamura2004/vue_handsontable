require 'test_helper'

class Project::AssignsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_assigns_index_url
    assert_response :success
  end

end
