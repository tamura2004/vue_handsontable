class AgsController < ApplicationController
  def index
    gon.records =
      ProjectsMembersMonth.order("projects.number").ags_view.pivot
    gon.options = {
      colHeaders:[
        "number",
        "project",
        "name",
        *months_headers,
        "total"
      ],
      columns: [
        {data:"number"},
        {data:"project"},
        {data:"name"},
        *months_columns,
        {data:"total", type:"numeric", format: "0.0"}
      ]
    }

    gon.by_member = {}
    gon.by_member["records"] =
      ProjectsMembersMonth.order("members.name").ags_view.pivot
    gon.by_member["options"] = {
      colHeaders:[
        "number",
        "project",
        "name",
        *months_headers,
        "total"
      ],
      columns: [
        {data:"number"},
        {data:"project"},
        {data:"name"},
        *months_columns,
        {data:"total", type:"numeric", format: "0.0"}
      ]
    }
  end
end
