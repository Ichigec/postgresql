select count(d), name
from
(select *
from 
(select name, shedule, date_begin as date, d, row_number, date_begin+(row_number * interval'1 day') as date_begin, 
date_begin+(row_number * interval'1 day') as date_end  from 
(select name, shedule, date_begin, d, row_number () over (partition by shedule, name order by name) from 
(select name, shedule, date_begin, regexp_split_to_table(shedule, '\s*') d from T_CONTRACTOR_SHERULER) as a1) 
as a2) as a3 
where d!='в') as a4
where d='д'
group by name;

select * from (select name, count(d)
from
(select *
from 
(select name, shedule, date_begin as date, d, row_number, date_begin+(row_number * interval'1 day') as date_begin, 
date_begin+(row_number * interval'1 day') as date_end  from 
(select name, shedule, date_begin, d, row_number () over (partition by shedule, name order by name) from 
(select name, shedule, date_begin, regexp_split_to_table(shedule, '\s*') d from T_CONTRACTOR_SHERULER) as a1) 
as a2) as a3 
where d!='в') as a4
where extract (month from date_begin)=1
group by name) as a5
where count>=10;

select distinct(name) from
(select *
from 
(select name, shedule, date_begin as date, d, row_number, date_begin+(row_number * interval'1 day') as date_begin, 
date_begin+(row_number * interval'1 day') as date_end  from 
(select name, shedule, date_begin, d, row_number () over (partition by shedule, name order by name) from 
(select name, shedule, date_begin, regexp_split_to_table(shedule, '\s*') d from T_CONTRACTOR_SHERULER) as a1) 
as a2) as a3 
where d!='в') as a4
where extract (month from date_begin)=1 and extract (day from date_begin) in (14, 15, 16);