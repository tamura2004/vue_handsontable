class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private
  def current_group
    if id = session[:group_id]
      @current_group ||= Group.find(id)
    end
  end

  helper_method :current_group
end
