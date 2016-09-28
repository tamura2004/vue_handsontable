class Members::AssignsController < ApplicationController
  before_action :set_memgber, only: [:index,:create]
  before_action :set_assign, only: :destroy

  def index
    @projects =
      Project
        .where("groups.id = ?", @member.group.try(:id))
        .view
        .map(&:attributes)

    @assigns = @member.assigns
  end

  def create
    @assign = ProjectsMember.new(assign_params)
    # @assign.member = @member

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
    def set_memgber
      @member = Member.find(params[:member_id])
    end

    def set_assign
      @assign = ProjectsMember.find(params[:id])
    end

    def assign_params
      params.require(:assign).permit(:project_id, :member_id)
    end
end
