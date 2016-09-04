class GroupsProjectsController < ApplicationController
  def index

    @records =
      ProjectsMonthlyAllocation.group_view.pivot

    @options = {
      colHeaders: [
        "グループ名",
        *months_headers,
        "合計"
      ],
      columns: [
        {data: "groups_name"},
        *months_columns,
        {data: "total", type: "numeric", format: "0.0"}
      ],
    }

  end

end
