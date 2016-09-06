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

    @allocs = ProjectsMembersMonth.ags_member_view
      .pivot
      .to_json

    base = months_values.inject({}){|memo,month|memo.merge month => ""}

    @works = Work.ags_view.pivot.map do |w|
      base.merge w
    end.to_json

  end
end
