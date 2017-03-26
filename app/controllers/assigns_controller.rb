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
    # 案件別要員割当
    @assigns = Assign.project_chart.map(&:attributes).group_by{|a|a["project_name"]}

    # 要員数
    @works =
      Work.joins(:member)
        .merge(Member.where(group_id: 1))
        .where("month > ?", "201703")
        .order(:month)
        .group(:month)
        .sum(:cost)

    # 案件工数
    @costs = ProjectsMonthlyAllocation.joins(:group)
      .merge(Group.where(id: 1))
      .where("month > ?", "201703")
      .group(:month)
      .order(:month)
      .sum(:cost)

    # グラフビルダ    
    @options = ChartBuilder.build("案件アサイン") do |chart|
      @assigns.each do |project_name, assigns|
        chart.add_series do |series|
          assigns.each do |assign|
            series.add_point(assign["month"], assign["cost"]) do |point|

              if assign["month"] == "201705" && assign["total_cost"] > 3
                series[:legendText] = "#{project_name}：#{assign['total_cost']}人月"
                series[:showInLegend] = true
                point[:indexLabel] = project_name
                point[:indexLabelPlacement] = "inside"
              end

            end
          end
        end
      end

      chart.add_series(:line) do |series|
        @works.each do |month, cost|
          series.add_point(month, cost) do |point|
            point[:indexLabel] = "要員数" if month == "201707"
          end
        end
      end

      chart.add_series(:line) do |series|
        @costs.each do |month, cost|
          series.add_point(month, cost) do |point|
            point[:indexLabel] = "案件受注" if month == "201707"
          end
        end
      end
    end
  end

  def member_chart
    @members = ProjectsMembersMonth.joins(:member)
      .where("month > ?", "201703")
      .group("members.job_title_id")
      .group("members.number")
      .group("members.name")
      .group(:month)
      .order("members.job_title_id")
      .order("members.number")
      .order(:month)
      .sum(:cost)
      .group_by{|k,v|k[2]}

    @options = @members.map do |name, assigns|
      ChartBuilder.build(name) do |chart|
        chart.add_series(:line) do |series|
          months_values.each do |base_month|
            exists = false
            assigns.each do |assign, cost|
              job_title_id, member_number, member_name, month = *assign
              if base_month == month
                series.add_point(month, cost)
                exists = true
                break
              end
            end
            if !exists
              series.add_point(base_month, 0)
            end
          end
        end
      end
    end
  end
end

