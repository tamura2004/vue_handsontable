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
        text: "案件別要員アサイン"
      },
      legend: {
        reversed: true,
        dockInsidePlotArea: true,
        fontSize: 12,
        verticalAlign: "center"
      },
      data: []
    }

    @assigns.each do |project_name, assigns|
      series = {
        type: "stackedArea",
        markerType: "none",
        indexLabelFontSize: 9,
        # indexLabelFontColor: "white",
        dataPoints: []
      }

      assigns.each do |assign|
        point = { label: assign["month"], y: assign["cost"] || 0 }
        if assign["month"] == "201705" && assign["total_cost"] > 5
          point[:indexLabel] = project_name
          point[:indexLabelPlacement] = "inside"
        end
        series[:dataPoints] << point
        if assign["total_cost"] > 5
          series[:legendText] = "#{project_name}：#{assign['total_cost']}人月"
          series[:showInLegend] = true
        end
      end

      @options[:data] << series
    end

    @works =
      Work.joins(:member)
        .merge(Member.where(group_id: 1))
        .where("month > ?", "201703")
        .order(:month)
        .group(:month)
        .sum(:cost)

    series = {
      type: "line",
      markerSize: 12,
      lineThickness: 4,
      dataPoints: []
    }

    @works.each do |month, cost|
      point = { label: month, y: cost || 0 }
      if month == "201707"
        point[:indexLabel] = "要員数"
      end
      series[:dataPoints] << point
    end

    @options[:data] << series

    @costs = ProjectsMonthlyAllocation.joins(:group)
      .merge(Group.where(id: 1))
      .where("month > ?", "201703")
      .group(:month)
      .order(:month)
      .sum(:cost)

    series = {
      type: "line",
      markerSize: 12,
      lineThickness: 4,
      dataPoints: []
    }

    @costs.each do |month, cost|
      point = { label: month, y: cost || 0 }
      if month == "201710"
        point[:indexLabel] = "案件工数"
      end
      series[:dataPoints] << point
    end

    @options[:data] << series

  end
end
