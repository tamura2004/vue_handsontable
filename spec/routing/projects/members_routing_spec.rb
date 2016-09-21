require "rails_helper"

RSpec.describe Projects::MembersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/projects/1/members").to route_to(controller:"projects/members",action:"index",project_id:"1")
    end

  end
end
