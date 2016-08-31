class Projects::MembersController < ApplicationController
  before_action :set_project, only: [:index]

  def index
    gon.members = Member.view.map(&:attributes)
    gon.project = @project
    gon.assignments = @project.assignments
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

end
