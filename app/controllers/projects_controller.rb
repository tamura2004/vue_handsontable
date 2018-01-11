class ProjectsController < ApplicationController
  before_action :set_group, only: :index

  def index
    @projects = Project.where(group_id: @group).order(:number).decorate
  end

  private

    def set_group
      @group = current_group
    end
end
