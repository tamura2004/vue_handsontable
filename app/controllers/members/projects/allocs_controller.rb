class Members::Projects::AllocsController < ApplicationController
  def circle_chart
    @month = params[:month] || Date.today.strftime("%Y%m")
    # @members = current_members.worker.circle_chart(@month).decorate
    @members = Member.where(group_id: current_group.id)
		.where("works.month = ?", current_month)
    	.where("3 <= job_title_id")
		.order(:job_title_id,:number)
	    .includes(:assigns)
	    .includes(:allocs)
	    .includes(:projects)
	    .includes(:group)
	    .includes(:job_title)
	    .joins(:works)
	    .decorate
  end
end
