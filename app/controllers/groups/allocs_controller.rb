class Groups::AllocsController < ApplicationController
  before_action :set_group, only: :index

  def index
    @members = Member.where(group_id: @group)
      .includes(:assigns)
      .includes(:allocs)
      .includes(:projects)
      .includes(:group)
      .includes(:job_title)
      .order(:job_title_id, :number)
      .decorate
  end

  private

    def set_group
      @group = current_group
    end

end
