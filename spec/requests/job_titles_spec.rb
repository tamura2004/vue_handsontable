require 'rails_helper'

RSpec.describe "JobTitles", type: :request do
  let(:id){1}
  let(:params){{job_title: attributes_for(:job_title)}}
  before{create :job_title, id: id}
  before{create :group}

  describe "GET /job_titles" do
    it{should == 200}
  end

  describe "POST /job_titles" do
    it {should == 200}
  end

  describe "PATCH /job_titles/1" do
    it{should == 200}
  end

  describe "DELETE /job_titles/1" do
    it{should == 200}
  end
end
