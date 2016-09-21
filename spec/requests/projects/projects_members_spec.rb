require 'rails_helper'

RSpec.describe "Projects::Members", type: :request do
  describe "GET /project_members" do

    before{create :project}
    before{create :group}

    it "プロジェクトメンバー候補一覧が表示される" do
      get project_members_path(1)
      expect(response).to have_http_status(200)
    end
  end
end
