class AssignsController < ApplicationController
  def index
    @assigns = Assign.report
    @members_assigns = Assign.group_by_member

    @members = Hash.new{ |h,k| h[k] = [] }
    
    @assigns.each do |assign|
      @members["#{assign.member_number} #{assign.member_name} #{assign.job_title_name}"] << assign
    end

    @members_assigns.each do |assign|
      assign.project_number = "合計"
      assign.project_name = "合計"
      @members["#{assign.member_number} #{assign.member_name} #{assign.job_title_name}"] << assign
    end

    respond_to do |format|
      format.html

      format.xlsx do
        timestamp = Time.zone.now.strftime("%Y%m%d%H%M%S")
        filename = "assigns_#{timestamp}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=#{filename}"
      end
    end
  end
end
