class Members::ProjectsController < ApplicationController
  before_action :set_memgber, only: [:index]

  def index
    gon.projects =
      Project
        .where("groups.id = ?", @member.group.try(:id))
        .view
        .map(&:attributes)
    gon.member = @member
    gon.assignments = @member.assignments
  end

  private
    def set_memgber
      @member = Member.find(params[:member_id])
    end
end
