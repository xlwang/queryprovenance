alter table configs add column idx int;
update configs set idx = 1 where corrupt_qidx = '0';
update configs set idx = 2 where corrupt_qidx = '0,10';
update configs set idx = 3 where corrupt_qidx = '0,10,20';
update configs set idx = 4 where corrupt_qidx = '0,10,20,30';
update configs set idx = 5 where corrupt_qidx = '0,10,20,30,40';


create table names(sname text, name text);
insert into names values ('cplex-attr-slicing', 'a')
,('cplex-query-slicing', 'q')
,('cplex-tuple-slicing', 't')
,('cplex-all-opt', 'taq')
,('cplex-all','No Optimizations');
