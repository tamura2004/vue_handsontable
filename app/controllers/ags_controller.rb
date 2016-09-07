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

    @assigns = Project.all.inject({}) do |memo,project|
      memo.merge project => HtblParamsFactory.new do |t|
        t.model = Assign.where(job_title_name:"AGS").where(project_id: project.id)
        t.id_field = :member_id
        t.fields = :member_number,:member_link
      end
    end


    # @assigns = HtblParamsFactory.new do |t|
    #   t.model = Assign.where(job_title_name: "AGS").order(:project_number)
    #   t.id_field = :member_id
    #   t.fields = :member_number,:member_link
    #   t.group = :project_number,:project_name
    #   t.json = false
    # end

  end
end
