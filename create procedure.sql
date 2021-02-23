create or replace procedure inserter(NAME varchar, DATE_BEGIN timestamp, DATE_END timestamp)
language plpgsql    
as $$
begin
insert into T_CONTRACTOR_WORK_DAY (NAME, DATE_BEGIN, DATE_END)
(select name, 
case when d='д' then date_begin+interval '8 hour' 
when d='с' then date_begin+interval '8 hour' 
when d='н' then date_begin+interval '20 hour'
end as date_begin,
case when d='д' then date_end+interval '20 hour'
when d='с' then date_end+interval '32 hour' 
when d='н' then date_end+interval '32 hour'
end as date_end
from
(select *
from 
(select name, shedule, date_begin as date, d, row_number, date_begin+(row_number * interval'1 day') as date_begin, 
date_begin+(row_number * interval'1 day') as date_end  from 
(select name, shedule, date_begin, d, row_number () over (partition by shedule, name order by name) from 
(select name, shedule, date_begin, regexp_split_to_table(shedule, '\s*') d from T_CONTRACTOR_SHERULER) as a1) 
as a2) as a3 
where d!='в') as a4);
commit;
end;$$
