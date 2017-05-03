Summary::Plans::UnionWithAllocationQuery = <<-SQL
  select
    -99 as category,
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
  where
    m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + m10 + m11 + m12 > 0
  group by
    category,
    project_number,
    project_name
  union all
  select
    projects.id as category,
    projects.number as project_number,
    projects.name as project_name,

    sum(case when allocs.month = '201704' then allocs.cost else 0 end) as t1,
    sum(case when allocs.month = '201705' then allocs.cost else 0 end) as t2,
    sum(case when allocs.month = '201706' then allocs.cost else 0 end) as t3,
    sum(case when allocs.month = '201707' then allocs.cost else 0 end) as t4,
    sum(case when allocs.month = '201708' then allocs.cost else 0 end) as t5,
    sum(case when allocs.month = '201709' then allocs.cost else 0 end) as t6,
    sum(case when allocs.month = '201710' then allocs.cost else 0 end) as t7,
    sum(case when allocs.month = '201711' then allocs.cost else 0 end) as t8,
    sum(case when allocs.month = '201712' then allocs.cost else 0 end) as t9,
    sum(case when allocs.month = '201801' then allocs.cost else 0 end) as t10,
    sum(case when allocs.month = '201802' then allocs.cost else 0 end) as t11,
    sum(case when allocs.month = '201803' then allocs.cost else 0 end) as t12

  from allocs
  left join assigns
    on allocs.assign_id = assigns.id
  inner join projects
    on assigns.project_id = projects.id

  where allocs.month > '201703'

  group by
    category,
    project_number,
    project_name

  order by
    project_number,
    category
SQL