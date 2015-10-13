
drop table if exists configs cascade;

      CREATE TABLE configs (
        id serial primary key,
        pid int references plots(id),
        runidx int,
        notes text,
        N_D int,
        N_dim int,
        N_q int,
        N_pred int,
        N_ins int,
        N_set int,
        N_where int,
        N_corrupt int,
        N_corrupt_vals int,
        N_corrupt_set int,
        N_corrupt_where int,
        gen_mode int,
        idx float,
        p_I float,
        p_pk float,
        p_fp float,
        p_fn float,
        exptype int,
        epsilon float,
        M float,
        solvertype int,
        batchsize int,
        niterations int,
        approx int,
        alg2_attrsize int,
        alg2_obj int,
        alg2_objratio int,
        alg2_fixq int,
        alg2_fixattr int
      );

drop table  if exists plots cascade;
      CREATE TABLE plots (
        id serial primary key,
        name text,
        x text,
        y text,
        opts text
      );

drop table if exists  qlogs cascade;
      CREATE TABLE qlogs (
        id serial primary key,
        cid int,
        qidx int,
        oldtname text,
        newtname text,
        mode text,
        type varchar,
        vals text,
        set text,
        wherec text,
        query text
      );

drop table if exists  exps cascade;
      CREATE TABLE exps (
        id serial primary key,
        cid int,
        iter int,
        nbadcomplaints int,
        nfixedcomplaints int,
        removerate numeric,
        noiserate numeric,
        prep_time numeric,
        solver_prep_cons_time numeric,
        solver_add_cons_time numeric,
        solve_time numeric,
        post_proc_time numeric,
        p_fp numeric,
        avgnconstraints int,
        avgnvariables int
      );
