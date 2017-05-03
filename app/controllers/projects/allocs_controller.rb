class Projects::AllocsController < ApplicationController
  include AllocModule

  before_action :set_project, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
    @plan = Plan.project(@project.number)&.first
    # @members = Member.with_allocs.merge(Project.where(id: @project)).decorate
    # @members_htbl_options = Htbl::MembersBuilder.htbl_options
    @assigns =  Assign.with_allocs.where(project_id: @project).decorate
  end

  private
    def set_project
      @project = Project.find(params[:project_id]).decorate
    end

end