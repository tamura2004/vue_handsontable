class Groups::JobTitles::AssignsController < ApplicationController
  before_action :set_job_title, only: [:index]
  before_action :set_group, only: [:index]

  def index
    @members = Member.recent
      .where(group_id: @group)
      .where(job_title_id: @job_title)
      .decorate

    @projects = Project.recent
      .where(group_id: @group)
      .joins(:members)
      .merge(Member.where job_title_id: @job_title)
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
