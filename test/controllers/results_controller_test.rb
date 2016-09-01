require 'test_helper'

class ResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get results_upload_url
    assert_response :success
  end

end
