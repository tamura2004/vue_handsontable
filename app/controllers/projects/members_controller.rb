class Projects::MembersController < ApplicationController
  before_action :set_project, only: [:index]

  def index
    @members = Member.view.map(&:attributes)
    @assignments = @project.assignments
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

end
