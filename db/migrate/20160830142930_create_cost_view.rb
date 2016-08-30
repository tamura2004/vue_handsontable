class CreateCostView < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create view v_costs as
      select
        groups.id as group_id,
        groups.name as group_name,
        projects.id as project_id,
        projects.number as project_number,
        projects.name as project_name,
        projects.cost as project_cost,
        projects.rd as project_rd,
        projects_monthly_allocations.id as id,
        projects_monthly_allocations.month as month,
        projects_monthly_allocations.cost as cost,
        '<a href="/projects/' || projects.id || '/assigns">' || projects.name || '</a>' as project_link,
        '<a href="/groups/' || groups.id || '/assigns">' || groups.name || '</a>' as group_link

      from projects_monthly_allocations
      inner join projects
      on projects_monthly_allocations.project_id = projects.id
      left join groups
      on projects.group_id = groups.id;
    SQL
  end

  def down
    execute <<-SQL
      drop view v_costs;
    SQL
  end
end
