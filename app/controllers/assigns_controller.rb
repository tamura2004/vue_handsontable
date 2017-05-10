class AssignsController < ApplicationController

  def member_report
    @assigns = Assign.recent.decorate

    respond_to do |format|
      format.html
      format.xlsx do
        set_attached_xlsx_filename("assigns")
      end
    end
  end

  def allocs_report
    @allocs = Alloc.recent

    respond_to do |format|
      format.xlsx do
        set_attached_xlsx_filename("allocs")
      end
    end
  end

  def projects_report
    @assigns = Assign.recent.decorate
  end

  def chart
    @projects = Project.recent.decorate
    @works = Work.recent
    @plans_costs = Plan.costs
  end

  def member_chart
    @members = Member.recent.where(group_id: 1).job_order.decorate
  end

  def project_chart
    @projects = Project.recent.decorate
  end

  private
    def set_attached_xlsx_filename(name)
      timestamp = Time.zone.now.strftime("%Y%m%d%H%M%S")
      filename = "#{name}_#{timestamp}.xlsx"
      response.headers['Content-Disposition'] = "attachment; filename=#{filename}"
    end

end

