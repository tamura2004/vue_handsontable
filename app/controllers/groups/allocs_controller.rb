class Groups::AllocsController < ApplicationController
  before_action :set_group, only: :index

  def index
    @groups = Group.all
    @members = Member.where(group_id: @group)
      .includes(:group)
      .includes(:job_title)
      .includes(:assigns)
      .includes(:allocs)
      .order(:job_title_id, :number)
      .decorate   
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

end
