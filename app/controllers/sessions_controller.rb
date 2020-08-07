class SessionsController < ApplicationController
  def create
    group_id = params[:group_id]
    group = Group.find(group_id)
    session[:group_id] = group.id
    cookies.permanent.signed[:group_id] = group.id
    redirect_to root_path
  end
end
