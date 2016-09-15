class CreateVProjectView < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create view v_project as
      select
        groups.id as group_id,
        groups.name as group_name,
        projects.id as project_id,
        projects.number as project_number,
        projects.name as project_name,
        projects.cost as project_cost,
        projects.rd as project_rd,
        '<a href="/projects/' || projects.id || '/assigns">' || projects.name || '</a>' as project_link,
        '<a href="/groups/' || groups.id || '/assigns">' || groups.name || '</a>' as group_link

      from projects
      left join groups
      on projects.group_id = groups.id;
    SQL
  end

  def down
    execute <<-SQL
      drop view v_project;
    SQL
  end
end
