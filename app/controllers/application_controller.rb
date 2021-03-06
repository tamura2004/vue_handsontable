class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # before_action :miniprofiler

  private

  # def miniprofiler
  #   Rack::MiniProfiler.authorize_request
  # end

  def current_group
    id = cookies.signed[:group_id] || session[:group_id] || Group.first&.id
    @current_group ||= Group.find(id)
  end

  def current_month
    Date.today.strftime("%Y%m")
  end

  def current_members
    Member.where(group_id: current_group.id)
      .joins(:works)
      .where("works.month = ?", current_month)
      .order(:job_title_id,:number)
  end

  helper_method :current_group
end
