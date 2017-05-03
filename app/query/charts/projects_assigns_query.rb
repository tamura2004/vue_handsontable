Charts::ProjectsAssignsQuery = <<-SQL
  select
    1 as id,
    projects.id as project_id,
    projects.number as project_number,
    projects.name as project_name,
    projects.total_cost as total_cost,
    base_month as month,
    sum(allocs.cost) as cost

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
        sum(allocs.cost) as total_cost

      from projects

      left outer join assigns
        on projects.id = assigns.project_id

      left outer join allocs
        on allocs.assign_id = assigns.id and allocs.month > '201702'

      group by projects.id, projects.number, projects.name
      having sum(allocs.cost) > 0
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

  left outer join assigns
    on projects.id = assigns.project_id

  left outer join allocs
    on allocs.assign_id = assigns.id and allocs.month = base_month

  group by projects.id, projects.number, projects.name, total_cost, base_month

  order by projects.total_cost desc, projects.number, projects.id, base_month;

SQL