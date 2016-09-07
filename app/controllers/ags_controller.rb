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

    @assigns = HtblParamsFactory.new do |t|
      t.model = Assign.where(job_title_name: "AGS").order(:project_number)
      t.id_field = :member_id
      t.fields = :project_number,:project_name,:member_number,:member_link
    end

  end
end
