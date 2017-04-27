generate :model, :place, "name"
generate :model, :room, "name place:references"

generate :model, :operation, "project:references description:text place:references start_time:time remarks:text is_done:boolean"
generate :model, :operator, "operation:references member:references"
generate :model, :review, "operation:references memo:text room:references start_time:time end_time:time is_done:boolean"
generate :model, :reviewer, "review:references member:references"
generate :model, :reviewee, "review:references member:references"

