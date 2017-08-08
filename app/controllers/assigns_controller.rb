class AssignsController < ApplicationController

  def member_report
    @assigns = Assign.joins(:member).merge(current_members.worker).recent.decorate

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
    @assigns = Assign.joins(:member).merge(current_members).recent.decorate
  end

  def chart
    @projects = Project.recent.where(group_id: current_group.id).decorate
    @works = Work.joins(:member).merge(current_members.worker).recent
    @plans_costs = Plan.where.not(m1: nil).costs
  end

  def member_chart
    @members = current_members.worker.decorate
  end

  def project_chart
    @projects = Project.recent.where(group_id: current_group.id).decorate
  end

  private
    def set_attached_xlsx_filename(name)
      timestamp = Time.zone.now.strftime("%Y%m%d%H%M%S")
      filename = "#{name}_#{timestamp}.xlsx"
      response.headers['Content-Disposition'] = "attachment; filename=#{filename}"
    end

end

