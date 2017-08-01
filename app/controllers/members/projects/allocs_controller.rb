class Members::Projects::AllocsController < ApplicationController
  def circle_chart
    @month = params[:month] || Date.today.strftime("%Y%m")
    @members = Member.where(group_id: current_group.id).where("job_title_id > 2").circle_chart(@month).decorate
  end
end
