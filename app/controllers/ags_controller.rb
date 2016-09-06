class AgsController < ApplicationController

  def index

    @options = {
      colHeaders:[
        "要員名",
        *months_headers,
        "合計"
      ],
      columns: [
        {data:"member_name"},
        *months_columns,
        {data:"total", type:"numeric", format: "0.0"}
      ]
    }.to_json

    @assigns =
      Assign.where(job_title_name: "AGS")
        .pivot
        .group_by{|h|
          [h["project_number"],h["project_name"]]
        }

    @allocs = HtblParamsFactory.new do |t|
      t.model = Assign.where(job_title_name: "AGS")
      t.id_field = :member_id
      t.fields = [:member_link]
    end

    @works = HtblParamsFactory.new do |t|
      t.model = VWork.where(job_title_name: "AGS")
    end

  end
end
