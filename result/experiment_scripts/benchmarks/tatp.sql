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
1	1	1	1	2000	5000	-1	-1	1999	2	constant	subscriber_ini	1
2	1	2	1	2000	5000	-1	-1	1999	2	constant	subscriber_ini	1
3	1	3	1	2000	5000	-1	-1	1999	2	constant	subscriber_ini	1
4	1	4	1	2000	5000	-1	-1	1999	2	constant	subscriber_ini	1
5	1	5	1	2000	5000	-1	-1	1999	2	constant	subscriber_ini	1
6	1	6	1	2000	5000	-1	-1	1899	2	constant	subscriber_ini	1
7	1	7	1	2000	5000	-1	-1	1899	2	constant	subscriber_ini	1
8	1	8	1	2000	5000	-1	-1	1899	2	constant	subscriber_ini	1
9	1	9	1	2000	5000	-1	-1	1899	2	constant	subscriber_ini	1
10	1	10	1	2000	5000	-1	-1	1899	2	constant	subscriber_ini	1
11	1	11	1	2000	5000	-1	-1	1799	2	constant	subscriber_ini	1
12	1	12	1	2000	5000	-1	-1	1799	2	constant	subscriber_ini	1
13	1	13	1	2000	5000	-1	-1	1799	2	constant	subscriber_ini	1
14	1	14	1	2000	5000	-1	-1	1799	2	constant	subscriber_ini	1
15	1	15	1	2000	5000	-1	-1	1799	2	constant	subscriber_ini	1
16	1	16	1	2000	5000	-1	-1	1699	2	constant	subscriber_ini	1
17	1	17	1	2000	5000	-1	-1	1699	2	constant	subscriber_ini	1
18	1	18	1	2000	5000	-1	-1	1699	2	constant	subscriber_ini	1
19	1	19	1	2000	5000	-1	-1	1699	2	constant	subscriber_ini	1
20	1	20	1	2000	5000	-1	-1	1699	2	constant	subscriber_ini	1
21	1	21	1	2000	5000	-1	-1	1599	2	constant	subscriber_ini	1
22	1	22	1	2000	5000	-1	-1	1599	2	constant	subscriber_ini	1
23	1	23	1	2000	5000	-1	-1	1599	2	constant	subscriber_ini	1
24	1	24	1	2000	5000	-1	-1	1599	2	constant	subscriber_ini	1
25	1	25	1	2000	5000	-1	-1	1599	2	constant	subscriber_ini	1
26	1	26	1	2000	5000	-1	-1	1499	2	constant	subscriber_ini	1
27	1	27	1	2000	5000	-1	-1	1499	1	constant	subscriber_ini	1
28	1	28	1	2000	5000	-1	-1	1499	2	constant	subscriber_ini	1
29	1	29	1	2000	5000	-1	-1	1499	2	constant	subscriber_ini	1
30	1	30	1	2000	5000	-1	-1	1499	1	constant	subscriber_ini	1
36	1	36	1	2000	5000	-1	-1	499	2	constant	subscriber_ini	1
37	1	37	1	2000	5000	-1	-1	499	1	constant	subscriber_ini	1
38	1	38	1	2000	5000	-1	-1	499	2	constant	subscriber_ini	1
39	1	39	1	2000	5000	-1	-1	499	2	constant	subscriber_ini	1
40	1	40	1	2000	5000	-1	-1	499	2	constant	subscriber_ini	1
\.


--
-- Name: configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xlwang
--

SELECT pg_catalog.setval('configs_id_seq', 40, true);


--
-- Data for Name: exps; Type: TABLE DATA; Schema: public; Owner: xlwang
--

COPY exps (exp_id, sid, pid, f_p_rate, max_num_compl, solver, opt_queryslice, opt_attrslice, opt_query_num, opt_attr_num, opt_approx, num_compl, num_fixed_compl, fixed_rate, noise_rate, dirty_query_idx, fixed_query_idx, preproc_time, solver_prep_cons_time, solver_add_cons_time, solver_solve_time, finish_time, avg_num_cons) FROM stdin;
\N	1	1	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1999	1999	0.169937998	0.0131799998	0.00735499989	0.00839100033	0.0042679999	214
\N	1	2	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1999	1999	0.161765993	0.00428400002	0.00379400002	0.00629399996	0.00705299992	214
\N	1	3	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1999	1999	0.154321	0.00285200006	0.00389100006	0.00607000012	0.00323099992	214
\N	1	4	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1999	1999	0.146250993	0.00262299995	0.00393200014	0.0059150001	0.0034109999	214
\N	1	5	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1999	1999	0.160044	0.00428099977	0.00387499994	0.00624099979	0.00309800007	214
\N	1	6	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1899	1899	1.14872706	0.0475330018	0.0617990009	0.0463659987	0.00236900011	501
\N	1	7	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1899	1899	1.17444396	0.0317840017	0.0471079983	0.0492299981	0.00244700001	501
\N	1	8	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1899	1899	1.17667794	0.0245719999	0.0303889997	0.0458679982	0.00331200007	501
\N	1	9	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1899	1899	1.17394698	0.0141460001	0.0196889993	0.0465519987	0.00317099993	501
\N	1	10	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1899	1899	1.17381406	0.0123950001	0.0204050001	0.0489309989	0.00247900002	501
\N	1	11	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1799	1799	1.84943902	0.0263780002	0.0483199991	0.0836130008	0.00238399999	706
\N	1	12	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1799	1799	2.01961899	0.0309009999	0.0539579988	0.0829610005	0.00221400009	706
\N	1	13	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1799	1799	1.95106494	0.0223619994	0.0446709991	0.0808570012	0.00263300003	706
\N	1	14	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1799	1799	2.00548697	0.0289050005	0.0537349992	0.0797289982	0.00246199989	706
\N	1	15	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1799	1799	1.91209698	0.0251829997	0.0497119986	0.085277997	0.00231599994	706
\N	1	16	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1699	1699	2.89781594	0.0473419987	0.0923599973	0.123020999	0.00326599996	952
\N	1	17	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1699	1699	2.86954403	0.0523290001	0.0880950019	0.118790001	0.00289099989	952
\N	1	18	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1699	1699	2.96577096	0.138968006	0.0998409986	0.118367001	0.00293399999	952
\N	1	19	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1699	1699	2.88664794	0.0452090017	0.0864000022	0.126369998	0.00252599991	952
\N	1	20	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1699	1699	2.93675089	0.160071	0.0984959975	0.122472003	0.00279799988	952
\N	1	21	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1599	1599	3.86268902	0.0745619982	0.149267003	0.164777994	0.00292299991	1198
\N	1	22	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1599	1599	3.82726002	0.0752319992	0.150529996	0.143061996	0.00325300009	1198
\N	1	23	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1599	1599	3.65770292	0.165998995	0.148131996	0.166596994	0.00292299991	1198
\N	1	24	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1599	1599	4.01185799	0.180879995	0.162945002	0.158456996	0.00234799995	1198
\N	1	25	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1599	1599	3.81458592	0.172574997	0.152602002	0.167835996	0.00298699993	1198
\N	1	26	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1499	1499	4.76770306	0.101506002	0.207174003	0.182740003	0.00250299997	1403
\N	1	27	1	100000000	t,inc-1st	0	0	2000	33	7	1	0	1	0	1499	1033	9.55825901	0.236138999	0.397239	0.372018993	0.0030749999	1316
\N	1	28	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1499	1499	5.01445293	0.0979959965	0.217712	0.197924003	0.00301199988	1444
\N	1	29	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	1499	1499	4.81647301	0.162199005	0.196581006	0.185359001	0.00313000008	1403
\N	1	30	1	100000000	t,inc-1st	0	0	2000	33	7	1	0	1	0	1499	1033	9.87588215	0.242360994	0.395229012	0.413919985	0.00241900003	1316
\N	1	36	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	499	499	15.9777193	0.977171004	1.98641598	1.07989097	0.0027650001	4150
\N	1	37	1	100000000	t,inc-1st	0	0	2000	33	7	1	0	1	0	499	1033	10.0362587	0.249761	0.374392986	0.39489001	0.00248000002	1316
\N	1	38	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	499	499	15.5741997	0.82813102	1.98889899	1.10601604	0.00291200005	4150
\N	1	39	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	499	499	15.4647655	1.00529504	2.03130102	1.07488406	0.00271199993	4150
\N	1	40	1	100000000	t,inc-1st	0	0	2000	33	7	2	0	1	0	499	499	15.0376644	1.00595999	2.04773998	1.05831695	0.00311199995	4150
\.


--
-- Name: exps_pkey; Type: CONSTRAINT; Schema: public; Owner: xlwang; Tablespace: 
--

ALTER TABLE ONLY exps
    ADD CONSTRAINT exps_pkey PRIMARY KEY (sid, pid, opt_approx);


--
-- PostgreSQL database dump complete
--

