class V1::Members::AllocsController < ApplicationController
  def index
    cookies[:member_id] = params[:member_id]
  end
end
