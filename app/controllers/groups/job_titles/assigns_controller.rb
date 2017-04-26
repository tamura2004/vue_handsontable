class Groups::JobTitles::AssignsController < ApplicationController
  before_action :set_job_title, only: [:index]
  before_action :set_group, only: [:index]

  def index
    @members = Member.where(group_id: @group)
      .where(job_title_id: @job_title)
      .includes(:works)
      .includes(:assigns)
      .includes(:allocs)
      .includes(:group)
      .includes(:job_title)
      .order(:number)
      .decorate

    @projects = Project.where(group_id: @group)
      .merge(Member.where job_title_id: @job_title)
      .with_allocs
      .decorate

  end

  private
    def set_job_title
      @job_title = ::JobTitle.find(params[:job_title_id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

end
