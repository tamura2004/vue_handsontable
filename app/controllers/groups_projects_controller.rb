class GroupsProjectsController < ApplicationController
  def index

    gon.records =
      ProjectsMonthlyAllocation.pivot(:group_id).push
        ProjectsMonthlyAllocation.pivot_total_row

    gon.options = {
      colHeaders: [
        "グループ名",
        *months_headers,
        "合計"
      ],
      columns: [
        {data: "group_name"},
        *months_columns,
        {data: "total", type: "numeric", format: "0.0"}
      ],
    }

  end

end
