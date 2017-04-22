class Projects::AssignsController < ApplicationController
  before_action :set_project, only: [:index, :create]
  before_action :set_assign, only: :destroy

  def index
    @members = Member.same_group(@project)

    @assigns = @project.assigns
  end

  def create
    @assign = ProjectsMember.new(assign_params)
    # @assign.project = @project

    if @assign.save
      render json: @assign, status: :ok
    else
      render json: @assign.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @assign.destroy
    head :no_content
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_assign
      @assign = ProjectsMember.find(params[:id])
    end

    def assign_params
      params.require(:assign).permit(:project_id, :member_id)
    end
end
