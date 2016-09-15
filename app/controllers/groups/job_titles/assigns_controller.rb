class Groups::JobTitles::AssignsController < ApplicationController
  before_action :set_job_title, only: [:index]
  before_action :set_group, only: [:index]

  def index
    @works = HtblParamsFactory.new do |t|
      t.model = VWork.where(group_id: @group)
      t.id_field = :member_id
      t.fields = :member_number,:member_link
    end

    @assigns = HtblParamsFactory.new do |t|
      t.model = Alloc.where(group_id: @group)
        .where(job_title_id: @job_title)
      t.id_field = :member_id
      t.fields = :member_number, :member_link
    end

    @allocs = HtblParamsFactory.new do |t|
      t.model = Alloc.where(job_title_id:@job_title)
      t.id_field = :assign_id
      t.fields = :project_number,:project_link
    end

  end

  private
    def set_job_title
      @job_title = ::JobTitle.find(params[:job_title_id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

end
