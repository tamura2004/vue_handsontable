class Projects::AllocsController < ApplicationController
  include AllocModule

  before_action :set_project, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
    @plan = Plan.project(@project.number)&.first

    @header = HtblParamsFactory.new do |t|
      t.model = VCost.where(project_id: @project)
      t.id_field = :project_id
      t.fields = :project_number, :project_link
    end

    @assigns = HtblParamsFactory.new do |t|
      t.model = Assign.where(project_id: @project)
      t.id_field = :id
      t.fields = :job_title_link, :member_number, :member_link
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

end