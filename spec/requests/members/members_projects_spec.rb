require 'rails_helper'

RSpec.describe "Members::Projects", type: :request do
  describe "GET /members_projects" do
    it "works! (now write some real specs)" do
      get members_projects_index_path
      expect(response).to have_http_status(200)
    end
  end
end
