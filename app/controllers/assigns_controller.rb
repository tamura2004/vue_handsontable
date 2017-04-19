class AssignsController < ApplicationController

  def member_report
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

  def projects_report
    @assigns = ProjectsMemberDecorator.decorate_collection(
      ProjectsMember.recent
    )
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
            series.set_point(assign["month"], assign["cost"]) do |point|

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
          series.set_point(month, cost) do |point|
            point[:indexLabel] = "要員数" if month == "201709"
          end
        end
      end

      chart.add_series(:line) do |series|
        @works.each do |month, cost|
          series.set_point(month, cost + 3) do |point|
            point[:indexLabel] = "要員数(残業込)" if month == "201709"
          end
        end
      end

      chart.add_series(:line) do |series|
        @costs.each do |month, cost|
          series.set_point(month, cost) do |point|
            point[:indexLabel] = "案件受注" if month == "201709"
          end
        end
      end
    end
  end

  def member_chart
    @members = ProjectsMembersMonth.member_chart
    @works = Work.member_chart

    @options = @members.map do |name, assigns|
      ChartBuilder.build("") do |chart|
        chart[:link_id] = name[0]
        chart[:link_label] = name[1]
        chart.add_series(:line) do |series|
          assigns.each do |assign, cost|
            job_title_id, member_id, member_number, member_name, month = *assign
            series.set_point(month, cost)
          end
        end
        next unless @works[name]
        chart.add_series(:stackedArea) do |series|
          @works[name].each do |works, cost|
            _, _, month = *works
            series.set_point(month, cost)
          end
        end
      end
    end
  end

  def project_chart
    @projects = ProjectsMembersMonth.project_chart
    @plans = ProjectsMonthlyAllocation.project_chart

    @options = @projects.map do |name, assigns|
      ChartBuilder.build("") do |chart|
        chart[:link_id] = name[0]
        chart[:link_label] = name[1] + name[2]
        chart.add_series(:line) do |series|
          assigns.each do |assign, cost|
            id, project_number, project_name, month = *assign
            series.set_point(month, cost)
          end
        end
        if @plans[name]
          chart.add_series(:stackedArea) do |series|
            @plans[name].each do |plan, cost|
              _, _, _, month = *plan
              series.set_point(month, cost)
            end
          end
          @plans.delete(name)
        end
      end
    end

    # puts JSON.pretty_generate(@plans)

    @options += @plans.map do |key, plans|
      ChartBuilder.build("") do |chart|
        chart[:link_id] = key[0]
        chart[:link_label] = key[1] + key[2]
        chart.add_series(:stackedArea) do |series|
          plans.each do |plan, cost|
            id, number, name, month = *plan
            series.set_point(month, cost)
          end
        end
      end
    end
  end

end

