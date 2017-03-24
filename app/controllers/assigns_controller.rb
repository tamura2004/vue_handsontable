class AssignsController < ApplicationController
  def index
    @assigns = Assign.report
    @members_assigns = Assign.report_by_member

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

  def chart
    @assigns = Assign.project_chart.map(&:attributes).group_by{|a|a["project_name"]}

    @options = {
      animationEnabled: true,
      theme: "theme4",
      title: {
        text: "案件別積上グラフ"
      },
      legend: {
        fontSize: 12,
        verticalAlign: "bottom"
      },
      data: []
    }

    @assigns.each do |project_name, assigns|
      series = {
        type: "stackedArea",
        legendText: project_name,
        showInLegend: true,
        dataPoints: []
      }

      assigns.each do |assign|
        series[:dataPoints] << { label: assign["month"], y: assign["cost"] || 0 }
      end

      @options[:data] << series
    end
  end
end
