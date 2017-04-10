Summary::PlansQuery = <<-SQL
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
    project_number = ? and
    m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + m10 + m11 + m12 > 0
  group by
    category,
    project_number,
    project_name

SQL
