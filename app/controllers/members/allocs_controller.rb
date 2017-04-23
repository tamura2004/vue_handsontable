class Members::AllocsController < ApplicationController
  include AllocModule

  before_action :set_member, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
    @assigns = ProjectsMember.where(member_id: @member)
      .eager_load(:project)
      .eager_load(:allocs)
      .order("projects.number")
      .decorate

    @member = @member.decorate
  end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end

end
