require 'rails_helper'

RSpec.describe "Groups::JobTitles::Assigns", type: :request do
  let(:alloc){create :alloc}
  let(:group_id){alloc.member.group.id}
  let(:job_title_id){alloc.member.job_title.id}

  describe "GET /groups/:group_id/job_titles/:job_title_id/assigns" do
    it{should == 200}
  end
end
