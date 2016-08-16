class GroupsProjectsController < ApplicationController
  def index

    gon.records = Project.connection.select_all(<<-"SQL").to_a
      select
        name,
        label,
        sum(cost) as total,
        #{months_pivot_sql}
      from (
          select
            groups.name as name,
            label,
            month,
            costs.cost
          from (
            select
              "案件" as label,
              project_id,
              month,
              cost
            from projects_monthly_allocations
            union all
            select
              "要員" as label,
              project_id,
              month,
              cost
            from projects_members
            inner join projects_members_months on projects_members.id = projects_member_id
          ) as costs
          inner join projects on projects.id = project_id
          inner join groups on groups.id = group_id
        ) as tmp
      group by name,label
    SQL

    gon.options = {
      dataSchema: months_schema.merge(
        name: nil,
        label: nil,
        total: nil
      ),
      colHeaders: [
        "グループ名",
        "区分",
        "合計",
        *months_headers
      ],
      columns: [
        {
          data: "name"
        },
        {
          data: "label"
        },
        {
          type: "numeric",
          format: "0.0",
          data: "total",
          readOnly: true
        },
        *months_columns
      ],
    }

  end
end
