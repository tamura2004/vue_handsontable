require 'test_helper'

class AgsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ags_index_url
    assert_response :success
  end

end
