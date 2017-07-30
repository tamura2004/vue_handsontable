class Members::Projects::AllocsController < ApplicationController
  def circle_chart
    @month = params[:month] || Date.today.strftime("%Y%m")
    @members = Member.where(group_id: current_group.id).circle_chart(@month).decorate
  end
end
