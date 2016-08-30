class CreateAllocView < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create view allocs as
      select
        self.id as id,
        projects_members.id as assign_id,
        members.id as member_id,
        members.number as member_number,
        members.name as member_name,
        groups.id as group_id,
        groups.name as group_name,
        job_titles.id as job_title_id,
        job_titles.name as job_title_name,
        projects.id as project_id,
        projects.number as project_number,
        projects.name as project_name,
        projects.cost as project_cost,
        projects.rd as project_rd,
        self.month as month,
        self.cost as cost,
        '<a href="/members/' || members.id || '/assigns">' || members.name || '</a>' as member_link,
        '<a href="/projects/' || projects.id || '/assigns">' || projects.name || '</a>' as project_link

      from projects_members_months as self
      inner join projects_members
      on self.projects_member_id = projects_members.id
      inner join members
      on projects_members.member_id = members.id
      left join job_titles
      on members.job_title_id = job_titles.id
      left join groups
      on members.group_id = groups.id
      inner join projects
      on projects_members.project_id = projects.id;
    SQL
  end

  def down
    execute <<-SQL
      drop view allocs;
    SQL
  end
end
