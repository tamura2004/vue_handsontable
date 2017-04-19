class Members::AllocsController < ApplicationController
  include AllocModule

  before_action :set_member, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
    @header = HtblParamsFactory.new do |t|
      t.model = VWork.where(member_id: @member).where("month > ?", "201703")
      t.id_field = :member_id
      t.fields = :job_title_link,:member_number,:member_link
    end

    @assigns = HtblParamsFactory.new do |t|
      t.model = Assign.where(member_id: @member).where("month > ? or month is null", "201703").order(:project_number)
      t.id_field = :id
      t.fields = :project_number, :project_link
    end

    @allocs = ProjectsMembersMonth.where("members.id = ?", @member.id).members_projects_chart
    # @works = Work.member_chart

    @allocs[:tail] = ["",""]

    @option = ChartBuilder.build("FY2017案件アサイン計画：" + @member.name) do |chart|
      @allocs.each_cons(2) do |h,pre|
        k,v = *h
        chart.add_series(:stackedArea) do |series|
          v.each do |project, cost|
            _,_,_,month = *project
            series.set_point(month, cost) do |point|
              if month == "201705"
                point[:indexLabel] = pre[0][1]
                point[:indexLabelPlacement] = "outside"
                point[:indexLabelFontSize] = 12
              end
            end
          end
        end
        chart.add_series(:line) do |series|
          months_values.each do |month|
            series.set_point(month, 1.2) do |point|
              if month == "201710"
                point[:indexLabel] = "残業含む"
              end
            end
          end
        end
        chart.add_series(:line) do |series|
          months_values.each do |month|
            series.set_point(month, 1.0) do |point|
              if month == "201712"
                point[:indexLabel] = "残業なし"
              end
            end
          end
        end
      end
    end

  end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end

end
