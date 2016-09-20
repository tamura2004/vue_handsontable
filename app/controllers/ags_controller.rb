class AgsController < ApplicationController

  def index

    @allocs = HtblParamsFactory.new do |t|
      t.model = Assign.where(job_title_name: "AGS")
      t.id_field = :member_id
      t.fields = :member_number,:member_link
    end

    @works = HtblParamsFactory.new do |t|
      t.model = VWork.where(job_title_name: "AGS")
      t.id_field = :member_id
      t.fields = :member_number,:member_link
    end

    @assigns = {}

    Project.all.each do |project|
      
      params = HtblParamsFactory.new do |t|
        t.model = Assign.where(job_title_name:"AGS").where(project_id: project.id)
        t.id_field = :member_id
        t.fields = :member_number,:member_link
      end

      if !params.rows.empty?
        @assigns[project] = params
      end

    end
  end
end
