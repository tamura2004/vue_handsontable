class CreateVMemberView < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create view v_members as
      select
        members.id as id,
        members.number as member_number,
        members.name as member_name,
        groups.id as group_id,
        groups.name as group_name,
        job_titles.id as job_title_id,
        job_titles.name as job_title_name,
        '<a href="/members/' || members.id || '/assigns">' || members.name || '</a>' as member_link,
        '<a href="/groups/' || groups.id || '/job_titles/' || job_titles.id || '/assigns">' || job_titles.name || '</a>' as job_title_link,
        '<a href="/groups/' || groups.id || '/assigns">' || groups.name || '</a>' as group_link
      from members
      left join job_titles
      on members.job_title_id = job_titles.id
      left join groups
      on members.group_id = groups.id;
    SQL
  end

  def down
    execute <<-SQL
      drop view v_works;
    SQL
  end
end
