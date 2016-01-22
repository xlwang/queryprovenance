--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN9';
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
    set_type text,
    dataset text,
    wheresize integer
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
    exp_id integer,
    sid integer NOT NULL,
    pid integer NOT NULL,
    f_p_rate real,
    max_num_compl real,
    solver text,
    opt_queryslice integer,
    opt_attrslice integer,
    opt_query_num integer,
    opt_attr_num integer,
    opt_approx integer NOT NULL,
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
-- Name: id; Type: DEFAULT; Schema: public; Owner: xlwang
--

ALTER TABLE ONLY configs ALTER COLUMN id SET DEFAULT nextval('configs_id_seq'::regclass);


--
-- Data for Name: configs; Type: TABLE DATA; Schema: public; Owner: xlwang
--

COPY configs (id, sid, pid, num_try, logsize, db_size, skewness, range, corrupt_qidx, num_compl, set_type, dataset, wheresize) FROM stdin;
1	1	1	1	2000	7837	-1	-1	1999	1	constant	oorder_ini	1
2	1	2	1	2000	7837	-1	-1	1999	1	constant	oorder_ini	1
3	1	3	1	2000	7837	-1	-1	1999	1	constant	oorder_ini	1
4	1	4	1	2000	7837	-1	-1	1999	1	constant	oorder_ini	1
5	1	5	1	2000	7837	-1	-1	1999	1	constant	oorder_ini	1
6	1	6	1	2000	7837	-1	-1	1899	1	constant	oorder_ini	1
7	1	7	1	2000	7837	-1	-1	1899	1	constant	oorder_ini	1
8	1	8	1	2000	7837	-1	-1	1899	1	constant	oorder_ini	1
9	1	9	1	2000	7837	-1	-1	1899	1	constant	oorder_ini	1
10	1	10	1	2000	7837	-1	-1	1899	1	constant	oorder_ini	1
11	1	11	1	2000	7837	-1	-1	1799	1	constant	oorder_ini	1
12	1	12	1	2000	7837	-1	-1	1799	1	constant	oorder_ini	1
13	1	13	1	2000	7837	-1	-1	1799	1	constant	oorder_ini	1
14	1	14	1	2000	7837	-1	-1	1799	1	constant	oorder_ini	1
15	1	15	1	2000	7837	-1	-1	1799	1	constant	oorder_ini	1
16	1	16	1	2000	7837	-1	-1	1699	1	constant	oorder_ini	1
17	1	17	1	2000	7837	-1	-1	1699	1	constant	oorder_ini	1
18	1	18	1	2000	7837	-1	-1	1699	1	constant	oorder_ini	1
19	1	19	1	2000	7837	-1	-1	1699	1	constant	oorder_ini	1
20	1	20	1	2000	7837	-1	-1	1699	1	constant	oorder_ini	1
21	1	21	1	2000	7837	-1	-1	1599	1	constant	oorder_ini	1
22	1	22	1	2000	7837	-1	-1	1599	1	constant	oorder_ini	1
23	1	23	1	2000	7837	-1	-1	1599	1	constant	oorder_ini	1
24	1	24	1	2000	7837	-1	-1	1599	1	constant	oorder_ini	1
25	1	25	1	2000	7837	-1	-1	1599	1	constant	oorder_ini	1
26	1	26	1	2000	7837	-1	-1	1499	1	constant	oorder_ini	1
27	1	27	1	2000	7837	-1	-1	1499	1	constant	oorder_ini	1
28	1	28	1	2000	7837	-1	-1	1499	1	constant	oorder_ini	1
29	1	29	1	2000	7837	-1	-1	1499	1	constant	oorder_ini	1
30	1	30	1	2000	7837	-1	-1	1499	1	constant	oorder_ini	1
31	1	31	1	2000	7837	-1	-1	999	1	constant	oorder_ini	1
32	1	32	1	2000	7837	-1	-1	999	1	constant	oorder_ini	1
33	1	33	1	2000	7837	-1	-1	999	1	constant	oorder_ini	1
34	1	34	1	2000	7837	-1	-1	999	1	constant	oorder_ini	1
35	1	35	1	2000	7837	-1	-1	999	1	constant	oorder_ini	1
36	1	36	1	2000	7837	-1	-1	499	1	constant	oorder_ini	1
37	1	37	1	2000	7837	-1	-1	499	1	constant	oorder_ini	1
38	1	38	1	2000	7837	-1	-1	499	1	constant	oorder_ini	1
39	1	39	1	2000	7837	-1	-1	499	1	constant	oorder_ini	1
40	1	40	1	2000	7837	-1	-1	499	1	constant	oorder_ini	1
\.


--
-- Name: configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xlwang
--

SELECT pg_catalog.setval('configs_id_seq', 40, true);


--
-- Data for Name: exps; Type: TABLE DATA; Schema: public; Owner: xlwang
--

COPY exps (exp_id, sid, pid, f_p_rate, max_num_compl, solver, opt_queryslice, opt_attrslice, opt_query_num, opt_attr_num, opt_approx, num_compl, num_fixed_compl, fixed_rate, noise_rate, dirty_query_idx, fixed_query_idx, preproc_time, solver_prep_cons_time, solver_add_cons_time, solver_solve_time, finish_time, avg_num_cons) FROM stdin;
\N	1	1	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1999	1999	0.131188005	0.0128640002	0.00438900013	0.00703899981	0.00487399986	64
\N	1	2	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1999	1999	0.111810997	0.00288300007	0.00176000001	0.00535700005	0.00303300004	64
\N	1	3	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1999	1999	0.117223002	0.00250900001	0.00162500003	0.00545099983	0.0025549999	64
\N	1	4	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1999	1999	0.117202997	0.00212000008	0.00166099996	0.00537199993	0.00308199995	64
\N	1	5	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1999	1999	0.112402	0.00160900003	0.00171700004	0.00477099977	0.00304100011	64
\N	1	6	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1899	1899	0.110133	0.00228799996	0.00169099995	0.00420900015	0.00313400012	64
\N	1	7	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1899	1899	0.108322002	0.00161200005	0.001682	0.00465299981	0.00264899991	64
\N	1	8	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1899	1899	0.107607	0.00153799995	0.00169199996	0.00437399978	0.00224300008	64
\N	1	9	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1899	1899	0.105539002	0.00156500004	0.00162700005	0.0041629998	0.00225799996	64
\N	1	10	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1899	1899	0.109079003	0.00246599992	0.00165700004	0.00522000017	0.00269900006	64
\N	1	11	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1799	1799	0.106294997	0.001575	0.00162700005	0.00309500005	0.00221300009	64
\N	1	12	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1799	1799	0.104768001	0.00153999997	0.00166399998	0.00473299995	0.00185300002	64
\N	1	13	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1799	1799	0.108461	0.001697	0.00168999995	0.00401300006	0.00251000002	64
\N	1	14	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1799	1799	0.106536999	0.00155100005	0.00165999995	0.00526699983	0.00204199995	64
\N	1	15	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1799	1799	0.108709	0.00155199994	0.00163700001	0.00506799994	0.00223800004	64
\N	1	16	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1699	1699	0.109222002	0.00260400004	0.00165400002	0.00523900008	0.00201299996	64
\N	1	17	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1699	1699	0.100938998	0.00286799995	0.00278900005	0.00490200007	0.00350999995	64
\N	1	18	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1699	1699	0.105595998	0.00167300005	0.00169299997	0.0046740002	0.00221699988	64
\N	1	19	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1699	1699	0.108308002	0.00196200004	0.001666	0.00566599984	0.0025200001	64
\N	1	20	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1699	1699	0.105068997	0.00165899994	0.00165300001	0.00551000005	0.001865	64
\N	1	21	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1599	1599	0.110437997	0.00160800002	0.00168099999	0.00527299987	0.002721	64
\N	1	22	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1599	1599	0.111161001	0.00285400008	0.00308900001	0.00478299987	0.0025559999	64
\N	1	23	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1599	1599	0.106035002	0.00156100001	0.00160700001	0.00497699995	0.00209899992	64
\N	1	24	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1599	1599	0.110000998	0.00168400002	0.00156600005	0.00572100002	0.00272800005	64
\N	1	25	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1599	1599	0.107626997	0.001498	0.00151800003	0.00576699991	0.00254100002	64
\N	1	26	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1499	1499	0.0996640027	0.00139300001	0.00127600005	0.00479000015	0.001834	64
\N	1	27	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1499	1499	0.109669998	0.00147300004	0.00145500002	0.00512199989	0.00268899999	64
\N	1	28	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1499	1499	0.108865	0.00143199996	0.00133700005	0.00378199993	0.00259399996	64
\N	1	29	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1499	1499	0.111541003	0.00142800005	0.00131199998	0.00557000004	0.00222999998	64
\N	1	30	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	1499	1499	0.109944999	0.001376	0.00129000004	0.00403300021	0.00213399995	64
\N	1	31	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	999	999	0.107423	0.00145400001	0.00130100001	0.00537599996	0.00238399999	64
\N	1	32	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	999	999	0.100681998	0.00150200003	0.001361	0.00529799983	0.00281600002	64
\N	1	33	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	999	999	0.0975349993	0.00136800006	0.00132399995	0.00516999979	0.00208000001	64
\N	1	34	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	999	999	0.101745002	0.00236600009	0.00129199994	0.00345900003	0.00207099994	64
\N	1	35	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	999	999	0.100236997	0.00144200004	0.00130700006	0.00512599992	0.0020930001	64
\N	1	36	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	499	499	0.102783002	0.00252999994	0.00161399995	0.00537100015	0.00210199994	64
\N	1	37	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	499	499	0.103602998	0.00146499998	0.00130400003	0.00472000008	0.00254900008	64
\N	1	38	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	499	499	0.103044003	0.00136899995	0.00128800003	0.00479400018	0.00182899996	64
\N	1	39	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	499	499	0.107841998	0.001437	0.00129799999	0.00567500014	0.00230999989	64
\N	1	40	1	100000000	t,inc-1st	0	0	2000	7	7	1	0	1	0	499	499	0.107340001	0.00153899996	0.00129599997	0.00383300008	0.00213099993	64
\.


--
-- Name: exps_pkey; Type: CONSTRAINT; Schema: public; Owner: xlwang; Tablespace: 
--

ALTER TABLE ONLY exps
    ADD CONSTRAINT exps_pkey PRIMARY KEY (sid, pid, opt_approx);


--
-- PostgreSQL database dump complete
--

