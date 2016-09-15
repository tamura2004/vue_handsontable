class Projects::AssignsController < ApplicationController
  before_action :set_project, only: :index

  def index
    @header = HtblParamsFactory.new do |t|
      t.model = VCost.where(project_id: @project)
      t.id_field = :project_id
      t.fields = :project_number, :project_link
    end

    @assigns = HtblParamsFactory.new do |t|
      t.model = Assign.where(project_id: @project)
      t.id_field = :member_id
      t.fields = :job_title_link, :member_number, :member_link
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

end