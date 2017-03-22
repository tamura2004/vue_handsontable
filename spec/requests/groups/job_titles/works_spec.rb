require 'rails_helper'

RSpec.describe "Groups::JobTitles::Works", type: :request do
  let(:work){create :work, month: "201704"}
  let(:params){{"201704" => 100}}

  let(:group_id){work.member.group.id}
  let(:job_title_id){work.member.job_title.id}
  let(:id){work.member.id}

  describe "PATCH /groups/:group_id/job_titles/:job_title_id/works/:id" do
    it{should == 200}
  end
end
