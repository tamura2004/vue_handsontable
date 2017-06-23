Summary::Plans::IndexProjectsQuery = <<-SQL
  select
    category,
    max(projects.id) as project_id,
    project_number,
    project_name,
    sum(m1) as t1,
    sum(m2) as t2,
    sum(m3) as t3,
    sum(m4) as t4,
    sum(m5) as t5,
    sum(m6) as t6,
    sum(m7) as t7,
    sum(m8) as t8,
    sum(m9) as t9,
    sum(m10) as t10,
    sum(m11) as t11,
    sum(m12) as t12
  from
    plans
  left join projects
    on projects.number = project_number and projects.name = project_name
  where
    m1 > 0 or
    m2 > 0 or
    m3 > 0 or
    m4 > 0 or
    m5 > 0 or
    m6 > 0 or
    m7 > 0 or
    m8 > 0 or
    m9 > 0 or
    m10 > 0 or
    m11 > 0 or
    m12 > 0
  group by
    category,
    project_number,
    project_name
  order by
    category,
    project_number
SQL
