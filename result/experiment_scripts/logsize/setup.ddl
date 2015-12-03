alter table exps add column solver2 text;
update exps set solver2 = solver || opt_approx; 

alter table configs alter corrupt_qidx type int using corrupt_qidx::int;



create table names(sname text, name text);
insert into names values ('cplex-attr-slicing', 'a')
,('cplex-query-slicing', 'q')
,('cplex-tuple-slicing', 't')
,('cplex-all-opt', 'taq')
,('cplex-all','No Optimizations');
insert into names values
('cplex0',    'ta,inc-1st')
,('cplex1',    'tq,inc-1st')
,('cplex2',    'taq,inc-1st')
,('cplex3',    't,inc-1st');

