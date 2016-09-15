class Members::ProjectsController < ApplicationController
  before_action :set_memgber, only: [:index]

  def index
    @projects =
      Project
        .where("groups.id = ?", @member.group.try(:id))
        .view
        .map(&:attributes)

    @assigns = @member.assignments
  end

  private
    def set_memgber
      @member = Member.find(params[:member_id])
    end
end
