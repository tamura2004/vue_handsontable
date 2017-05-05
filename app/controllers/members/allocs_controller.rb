class Members::AllocsController < ApplicationController
  include AllocModule

  before_action :set_member, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
  end

  private
    def set_member
      @member = Member.find(params[:member_id]).decorate
    end

end
