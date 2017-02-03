alter table exps add column solver2 text;
update exps set solver2 = solver || opt_approx; 

-- alter table configs alter corrupt_qidx type int using corrupt_qidx::int;




-- for multi-corruption experiments
alter table configs add column idx int;
update configs set idx = 1 where corrupt_qidx = '0';
update configs set idx = 2 where corrupt_qidx = '0,10';
update configs set idx = 3 where corrupt_qidx = '0,10,20';
update configs set idx = 4 where corrupt_qidx = '0,10,20,30';
update configs set idx = 5 where corrupt_qidx = '0,10,20,30,40';

drop table if exists names;
create table if not exists names(sname text, name text);
insert into names values 
('cplex_allqueries', 'All Queries')
,('cplex_singlequery', 'Single Query')
,('cplex_singlequery3', 'Single Query')
,('Naive_cplex', 'Exh')
,('cplex_searchall', 'inc-all')
,('cplex_searchall_1iter',  'inc-all')
,('cplex_stopearly', 'inc-1st')
,('cplex_stopearly_1iter', 'inc-1st')
,('cplex_stopearly_2iter',   't,inc-1st')
,('cplex-attr-slicing', 'a')
,('cplex-query-slicing', 'q')
,('cplex-tuple-slicing', 't')
,('cplex-all-opt', 'taq')
,('cplex-all','No Optimizations')
,('cplex0',    'ta,inc-1st')
,('cplex1',    'tq,inc-1st')
,('cplex2',    'taq,inc-1st')
,('cplex3',  't,inc-1st')
,('heuristic', 'heuristic')
,('t,inc-1st' ,    't,inc-1st')
,('ta,inc-1st' ,    'ta,inc-1st')
,('tq,inc-1st' ,    'tq,inc-1st')
,('taq,inc-1st',    'taq,inc-1st')
,('t,inc-1st',    't,inc-1st')
,('tq,inc-1st1', 'tq,inc-1st')
,('taq,inc-1st2', 'taq,inc-1st')
,('ta,inc-1st', 'ta,inc-1st')
,('inc-1st', 'inc-1st')
,('tq,inc-1st, equalcons', 'tq,inc-1st')
,('t,inc-1st,equalcons', 't,inc-1st')
,('t,inc-1st,partial-inc', 't,part-inc-1st')
,('tq,inc-1st,partial-inc', 'tq,part-inc-1st')
,('taq,inc-1st,partial-inc', 'taq,part-inc-1st')
,('ta,inc-1st,partial-inc', 'ta,part-inc-1st')
,('t,inc-1st3', 't,inc-1st');

