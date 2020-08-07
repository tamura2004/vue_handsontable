require 'test_helper'

class AssignsControllerTest < ActionDispatch::IntegrationTest
  test "メンバー毎の帳票" do
    get assigns_member_report_url
    assert_response :success
  end

  test "全体グラフ" do
    get assigns_chart_url
    assert_response :success
  end

  test "メンバーごとのグラフ" do
    get assigns_member_chart_url
    assert_response :success
  end

  test "プロジェクトごとのグラフ" do
    get assigns_project_chart_url
    assert_response :success
  end

end
