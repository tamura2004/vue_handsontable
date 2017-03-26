Reports::MembersAssignsQuery = <<-SQL
  select
    groups.id as group_uid,
    groups.name as group_name,
    job_titles.id as job_title_uid,
    job_titles.name as job_title_name,
    members.number as member_number,
    members.name as member_name,
    '合計' as project_number,
    '合計' as project_name,

    sum(case when projects_members_months.month = '201704' then projects_members_months.cost else 0 end) as "201704",
    sum(case when projects_members_months.month = '201705' then projects_members_months.cost else 0 end) as "201705",
    sum(case when projects_members_months.month = '201706' then projects_members_months.cost else 0 end) as "201706",
    sum(case when projects_members_months.month = '201707' then projects_members_months.cost else 0 end) as "201707",
    sum(case when projects_members_months.month = '201708' then projects_members_months.cost else 0 end) as "201708",
    sum(case when projects_members_months.month = '201709' then projects_members_months.cost else 0 end) as "201709",
    sum(case when projects_members_months.month = '201710' then projects_members_months.cost else 0 end) as "201710",
    sum(case when projects_members_months.month = '201711' then projects_members_months.cost else 0 end) as "201711",
    sum(case when projects_members_months.month = '201712' then projects_members_months.cost else 0 end) as "201712",
    sum(case when projects_members_months.month = '201801' then projects_members_months.cost else 0 end) as "201801",
    sum(case when projects_members_months.month = '201802' then projects_members_months.cost else 0 end) as "201802",
    sum(case when projects_members_months.month = '201803' then projects_members_months.cost else 0 end) as "201803"

  from projects_members
  left join projects_members_months
  on projects_members_months.projects_member_id = projects_members.id
  inner join members
  on projects_members.member_id = members.id
  left join job_titles
  on members.job_title_id = job_titles.id
  left join groups
  on members.group_id = groups.id
  inner join projects
  on projects_members.project_id = projects.id

  where projects_members_months.month > '201703'
  group by
    group_uid,
    group_name,
    job_title_uid,
    job_title_name,
    member_number,
    member_name

  order by
    group_uid,
    job_title_uid,
    member_number;
SQL