class Projects::AllocsController < ApplicationController
  include AllocModule

  before_action :set_project, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
    @plan = Plan.project(@project.number)&.first
    @assigns =  Assign.with_allocs.where(project_id: @project).decorate
  end

  private
    def set_project
      @project = Project.find(params[:project_id]).decorate
    end

end