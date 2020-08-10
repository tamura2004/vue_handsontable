class Members::AssignsController < ApplicationController
  before_action :set_member, only: [:index,:create]
  before_action :set_assign, only: :destroy

  def index
    @projects = Project.available.same_group(@member)
  end

  def create
    @assign = Assign.new(assign_params)

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
    def set_member
      @member = Member.find(params[:member_id]).decorate
    end

    def set_assign
      @assign = Assign.find(params[:id])
    end

    def assign_params
      params.require(:assign).permit(:project_id, :member_id)
    end
end
