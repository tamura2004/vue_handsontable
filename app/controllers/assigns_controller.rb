class AssignsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        @assigns = Assign.report
      end

      format.xlsx do
        timestamp = Time.zone.now.strftime("%Y%m%d%H%M%S")
        filename = "assigns_#{timestamp}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=#{filename}"
        @assigns = Assign.report
      end
    end
  end
end
