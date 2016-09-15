class Projects::AssignsController < ApplicationController

  def index
    @project = HtblParamsFactory.new do |t|
      t.model = Project.where(id: params[:project_id])
      t.fields = :number,:name
      t.pivot = false
    end

    @assigns = HtblParamsFactory.new do |t|
      t.model = Assign.where(project_id: params[:project_id])
      t.id_field = :member_id
      t.fields = :job_title_link, :member_number, :member_link
    end

  end

end