select
  projects.id as id,
  projects.number as number,
  projects.name as name,
  projects.total_cost as total_cost,
  base_month,
  sum(assign.cost) as cost

from (
  select
    projects.id as id,
    projects.number as number,
    projects.name as name,
    projects.total_cost as total_cost,
    base_month

  from (
    select
      projects.id as id,
      projects.number as number,
      projects.name as name,
      sum(assign.cost) as total_cost

    from projects

    left outer join projects_members as alloc
      on projects.id = alloc.project_id

    left outer join projects_members_months as assign
      on assign.projects_member_id = alloc.id and assign.month > '201702'

    group by projects.id, projects.number, projects.name
    having sum(assign.cost) > 0
    order by sum(assign.cost) desc
  ) as projects

  cross join unnest(array[
    '201704',
    '201705',
    '201706',
    '201707',
    '201708',
    '201709',
    '201710',
    '201711',
    '201712',
    '201801',
    '201802',
    '201803'
  ]) as base_month

  order by total_cost desc, number, base_month
) as projects

left outer join projects_members as alloc
  on projects.id = alloc.project_id

left outer join projects_members_months as assign
  on assign.projects_member_id = alloc.id and assign.month = base_month

group by projects.id, projects.number, projects.name, total_cost, base_month

order by projects.number, projects.id, base_month;
