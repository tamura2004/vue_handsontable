require 'test_helper'

class GroupsJobTitlesAssignsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get group_job_title_assigns_url(groups(:one),job_titles(:one))
    assert_response :success
  end
end
