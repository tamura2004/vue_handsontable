require 'test_helper'

class AssignsControllerTest < ActionDispatch::IntegrationTest

  test "メンバー毎の帳票：画面" do
    get assigns_member_report_url
    assert_response :success
  end

  test "メンバー毎の帳票：添付ファイル" do
    get assigns_member_report_url(format: "xlsx")
    assert_response :success
  end

  test "サマリ帳票：添付ファイル" do
    get assigns_allocs_report_url(format: "xlsx")
    assert_response :success
  end

  test "プロジェクト毎の帳票：画面" do
    get assigns_projects_report_url
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
