drop table if exists  qlogs cascade;
      CREATE TABLE qlogs (
        id serial primary key,
        pid int,
	test_size	int,
        qidx int,
        mode text,
        type varchar,
        vals text,
	attrs	text,
        setc text,
        wherec text,
        query text
      );

drop table if exists  exps cascade;
      CREATE TABLE exps (
       exp_id serial primary key,
	pid int,
	test_size  int, 
	f_p_rate real,
	f_n_rate real,
	solver	text,
	opt_queryslice		int,
	opt_attrslice	int,
	opt_query_num	int,
        opt_attr_num int,
	opt_approx	int,
	num_compl	int,
	num_fixed_compl	int,
	fixed_rate	real,
	noise_rate	real,
	dirty_query_idx	text,
	fixed_query_idx	text,
	preproc_time	real,
	solver_prep_cons_time	real,
	solver_add_cons_time	real,
	solver_solve_time	real,
	finish_time	real,
	avg_num_cons	int      
      );

drop table if exists exps_detail cascade;
      CREATE TABLE exps_detail (
        id serial primary key,
	exp_id int,
        querylog_size int,
        query_index int,
	feasible int,
	avgnconstraints int,
        solver_prep_cons_time numeric,
        solver_add_cons_time numeric,
        solve_time numeric,
	obj_val real
      );


SELECT a1.qidx FROM qlogs as a1  where a1.query not in (select query  from qlogs where pid = 0 and mode = 'dirty' and test_size = 10) and pid = 0 and mode = 'clean' and qidx < 10;
