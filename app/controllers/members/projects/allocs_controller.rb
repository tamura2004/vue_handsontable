class Members::Projects::AllocsController < ApplicationController
  def circle_chart
    @month = params[:month] || Date.today.strftime("%Y%m")
    @members = current_members.worker.circle_chart(@month).decorate
  end
end
