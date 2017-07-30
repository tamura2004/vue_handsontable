class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private
  def current_group
    id = cookies.signed[:group_id] || session[:group_id] || 1
    @current_group ||= Group.find(id)
  end

  def current_members
    Member.where(group_id: current_group.id)
  end

  helper_method :current_group
end
