--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: configs; Type: TABLE; Schema: public; Owner: xlwang; Tablespace: 
--

CREATE TABLE configs (
    id integer NOT NULL,
    sid integer,
    pid integer,
    num_try integer,
    logsize integer,
    db_size integer,
    skewness real,
    range real,
    corrupt_qidx text,
    num_compl integer,
    set_type text
);


ALTER TABLE public.configs OWNER TO xlwang;

--
-- Name: configs_id_seq; Type: SEQUENCE; Schema: public; Owner: xlwang
--

CREATE SEQUENCE configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configs_id_seq OWNER TO xlwang;

--
-- Name: configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xlwang
--

ALTER SEQUENCE configs_id_seq OWNED BY configs.id;


--
-- Name: exps; Type: TABLE; Schema: public; Owner: xlwang; Tablespace: 
--

CREATE TABLE exps (
    exp_id integer NOT NULL,
    sid integer,
    pid integer,
    f_p_rate real,
    f_n_rate real,
    solver text,
    opt_queryslice integer,
    opt_attrslice integer,
    opt_query_num integer,
    opt_attr_num integer,
    opt_approx integer,
    num_compl integer,
    num_fixed_compl integer,
    fixed_rate real,
    noise_rate real,
    dirty_query_idx text,
    fixed_query_idx text,
    preproc_time real,
    solver_prep_cons_time real,
    solver_add_cons_time real,
    solver_solve_time real,
    finish_time real,
    avg_num_cons integer
);


ALTER TABLE public.exps OWNER TO xlwang;

--
-- Name: exps_exp_id_seq; Type: SEQUENCE; Schema: public; Owner: xlwang
--

CREATE SEQUENCE exps_exp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exps_exp_id_seq OWNER TO xlwang;

--
-- Name: exps_exp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xlwang
--

ALTER SEQUENCE exps_exp_id_seq OWNED BY exps.exp_id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: xlwang
--

ALTER TABLE ONLY configs ALTER COLUMN id SET DEFAULT nextval('configs_id_seq'::regclass);


--
-- Name: exp_id; Type: DEFAULT; Schema: public; Owner: xlwang
--

ALTER TABLE ONLY exps ALTER COLUMN exp_id SET DEFAULT nextval('exps_exp_id_seq'::regclass);


--
-- Data for Name: configs; Type: TABLE DATA; Schema: public; Owner: xlwang
--

COPY configs (id, sid, pid, num_try, logsize, db_size, skewness, range, corrupt_qidx, num_compl, set_type) FROM stdin;
1	0	0	1	10	1000	0	0.00999999978	0	29	constant
2	0	1	1	20	1000	0	0.00999999978	0	18	constant
3	0	2	1	40	1000	0	0.00999999978	0	27	constant
4	0	3	1	60	1000	0	0.00999999978	0	24	constant
5	0	4	1	80	1000	0	0.00999999978	0	24	constant
6	0	5	1	100	1000	0	0.00999999978	0	21	constant
7	0	6	1	120	1000	0	0.00999999978	0	21	constant
\.


--
-- Name: configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xlwang
--

SELECT pg_catalog.setval('configs_id_seq', 7, true);


--
-- Data for Name: exps; Type: TABLE DATA; Schema: public; Owner: xlwang
--

COPY exps (exp_id, sid, pid, f_p_rate, f_n_rate, solver, opt_queryslice, opt_attrslice, opt_query_num, opt_attr_num, opt_approx, num_compl, num_fixed_compl, fixed_rate, noise_rate, dirty_query_idx, fixed_query_idx, preproc_time, solver_prep_cons_time, solver_add_cons_time, solver_solve_time, finish_time, avg_num_cons) FROM stdin;
1	0	0	1	100000000	cplex_allqueries	0	0	10	11	0	29	0	1	0	0	0	0.0088449996	0.044698	0.0726289973	0.253425002	0.341704994	6438
2	0	0	1	100000000	cplex_singlequery	0	0	10	11	1	29	0	1	0	0	0	0.00440300023	0.076586999	0.198382005	0.0564499982	0.302374005	3828
3	0	1	1	100000000	cplex_allqueries	0	0	20	11	0	18	0	1	0	0	0	0.000395999989	0.0212299991	0.0373720005	0.292650014	0.138739005	7596
4	0	1	1	100000000	cplex_singlequery	0	0	20	11	1	18	0	1	0	0	0	0.00869899988	0.156141996	0.419158995	0.115681998	0.139945	4176
7	0	3	1	100000000	cplex_allqueries	0	0	60	11	0	24	0	1	0	0	0	0.0101570003	0.129578993	0.180669993	509.892029	0.488350004	29328
8	0	3	1	100000000	cplex_singlequery	0	0	60	11	1	24	0	1	0	0	0	0.0439300016	1.60469306	4.44979715	2.09971404	0.435746014	15168
9	0	4	1	100000000	cplex_allqueries	0	0	80	11	0	24	24	0	0	0		0.000980000012	0.0401129983	0.192254007	1000.20502	0	38928
10	0	4	1	100000000	cplex_singlequery	0	0	80	11	1	24	0	1	0	0	0	0.0572329983	2.59204412	7.90524197	4.89819193	0.444032997	19968
11	0	2	1	100000000	cplex_allqueries	0	0	40	11	0	27	0	1	0	0	0	0.00998600014	0.141034007	0.152864993	17.4220867	0.342902988	22194
12	0	2	1	100000000	cplex_singlequery	0	0	40	11	1	27	0	1	0	0	0	0.0267239995	0.877632976	2.29410291	0.751717985	0.315230995	11664
\.


--
-- Name: exps_exp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xlwang
--

SELECT pg_catalog.setval('exps_exp_id_seq', 12, true);


--
-- Name: exps_pkey; Type: CONSTRAINT; Schema: public; Owner: xlwang; Tablespace: 
--

ALTER TABLE ONLY exps
    ADD CONSTRAINT exps_pkey PRIMARY KEY (exp_id);


--
-- PostgreSQL database dump complete
--

