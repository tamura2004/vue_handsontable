class AgsController < ApplicationController


  def index

    @options = {
      colHeaders:[
        "name",
        *months_headers,
        "total"
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

    @allocs = ProjectsMembersMonth.ags_member_view.pivot.to_json
    @works = Work.ags_view.pivot.to_json

  end
end
