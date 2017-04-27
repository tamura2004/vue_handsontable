class Groups::JobTitles::AssignsController < ApplicationController
  before_action :set_job_title, only: [:index]
  before_action :set_group, only: [:index]

  def index
    @members_works = Member.with_works
      .where(group_id: @group)
      .where(job_title_id: @job_title)
      .decorate

    @members_allocs = Member.with_allocs
      .where(group_id: @group)
      .where(job_title_id: @job_title)
      .decorate

    @projects = Project.with_allocs
      .where(group_id: @group)
      .merge(Member.where job_title_id: @job_title)
      .decorate

    @members_htbl_options = Htbl::MembersBuilder.htbl_options
    @projects_htbl_options = Htbl::ProjectsBuilder.htbl_options

  end

  private
    def set_job_title
      @job_title = ::JobTitle.find(params[:job_title_id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

end
