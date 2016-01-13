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
    exp_id integer NOT NULL,
    sid integer,
    pid integer,
    f_p_rate real,
    max_num_compl real,
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

COPY configs (id, sid, pid, num_try, logsize, db_size, skewness, range, corrupt_qidx, num_compl, set_type, dataset, wheresize) FROM stdin;
1	12	720	1	1000	4570	-1	-1	999	2	constant	tpcc	3
2	12	721	1	1000	4570	-1	-1	999	2	constant	tpcc	3
3	12	722	1	1000	4570	-1	-1	999	2	constant	tpcc	3
4	12	723	1	1000	4570	-1	-1	999	2	constant	tpcc	3
5	12	724	1	1000	4570	-1	-1	999	2	constant	tpcc	3
6	12	725	1	1000	4570	-1	-1	974	2	constant	tpcc	3
7	12	726	1	1000	4570	-1	-1	974	2	constant	tpcc	3
8	12	727	1	1000	4570	-1	-1	974	2	constant	tpcc	3
9	12	728	1	1000	4570	-1	-1	974	2	constant	tpcc	3
10	12	729	1	1000	4570	-1	-1	974	2	constant	tpcc	3
11	12	730	1	1000	4570	-1	-1	949	2	constant	tpcc	3
12	12	731	1	1000	4570	-1	-1	949	2	constant	tpcc	3
13	12	732	1	1000	4570	-1	-1	949	2	constant	tpcc	3
14	12	733	1	1000	4570	-1	-1	949	2	constant	tpcc	3
15	12	734	1	1000	4570	-1	-1	949	2	constant	tpcc	3
16	12	735	1	1000	4570	-1	-1	899	2	constant	tpcc	3
17	12	736	1	1000	4570	-1	-1	899	2	constant	tpcc	3
18	12	737	1	1000	4570	-1	-1	899	1	constant	tpcc	3
19	12	738	1	1000	4570	-1	-1	899	2	constant	tpcc	3
20	12	739	1	1000	4570	-1	-1	899	2	constant	tpcc	3
21	12	740	1	1000	4570	-1	-1	799	2	constant	tpcc	3
22	12	741	1	1000	4570	-1	-1	799	2	constant	tpcc	3
23	12	742	1	1000	4570	-1	-1	799	2	constant	tpcc	3
24	12	743	1	1000	4570	-1	-1	799	2	constant	tpcc	3
25	12	744	1	1000	4570	-1	-1	799	2	constant	tpcc	3
26	12	745	1	1000	4570	-1	-1	749	2	constant	tpcc	3
27	12	746	1	1000	4570	-1	-1	749	2	constant	tpcc	3
28	12	747	1	1000	4570	-1	-1	749	2	constant	tpcc	3
29	12	748	1	1000	4570	-1	-1	749	2	constant	tpcc	3
30	12	749	1	1000	4570	-1	-1	749	2	constant	tpcc	3
1	13	750	1	650	8842	-1	-1	649	1	constant	auctionmark	3
2	13	751	1	650	8842	-1	-1	649	1	constant	auctionmark	3
3	13	752	1	650	8842	-1	-1	649	1	constant	auctionmark	3
4	13	753	1	650	8842	-1	-1	649	1	constant	auctionmark	3
5	13	754	1	650	8842	-1	-1	649	1	constant	auctionmark	3
6	13	755	5	650	8842	-1	-1	624	0	constant	auctionmark	3
7	13	756	5	650	8842	-1	-1	624	0	constant	auctionmark	3
8	13	757	5	650	8842	-1	-1	624	0	constant	auctionmark	3
9	13	758	5	650	8842	-1	-1	624	0	constant	auctionmark	3
10	13	759	5	650	8842	-1	-1	624	0	constant	auctionmark	3
11	13	760	5	650	8842	-1	-1	599	0	constant	auctionmark	3
12	13	761	5	650	8842	-1	-1	599	0	constant	auctionmark	3
13	13	762	5	650	8842	-1	-1	599	0	constant	auctionmark	3
14	13	763	5	650	8842	-1	-1	599	0	constant	auctionmark	3
15	13	764	5	650	8842	-1	-1	599	0	constant	auctionmark	3
16	13	765	1	650	8842	-1	-1	549	2	constant	auctionmark	3
17	13	766	1	650	8842	-1	-1	549	2	constant	auctionmark	3
18	13	767	1	650	8842	-1	-1	549	2	constant	auctionmark	3
19	13	768	1	650	8842	-1	-1	549	2	constant	auctionmark	3
20	13	769	1	650	8842	-1	-1	549	2	constant	auctionmark	3
21	13	770	1	650	8842	-1	-1	449	1	constant	auctionmark	3
22	13	771	1	650	8842	-1	-1	449	1	constant	auctionmark	3
23	13	772	1	650	8842	-1	-1	449	1	constant	auctionmark	3
24	13	773	1	650	8842	-1	-1	449	1	constant	auctionmark	3
25	13	774	1	650	8842	-1	-1	449	1	constant	auctionmark	3
26	13	775	5	650	8842	-1	-1	399	0	constant	auctionmark	3
27	13	776	5	650	8842	-1	-1	399	0	constant	auctionmark	3
28	13	777	5	650	8842	-1	-1	399	0	constant	auctionmark	3
29	13	778	5	650	8842	-1	-1	399	0	constant	auctionmark	3
30	13	779	5	650	8842	-1	-1	399	0	constant	auctionmark	3
87	7	446	1	300	1000	1	8	249	9	constant	synth	3
88	7	447	1	300	1000	1	8	249	8	constant	synth	3
89	7	448	1	300	1000	1	8	249	7	constant	synth	3
90	7	449	1	300	1000	1	8	249	6	constant	synth	3
91	7	450	1	300	1000	1	8	199	8	constant	synth	3
92	7	451	1	300	1000	1	8	199	9	constant	synth	3
93	7	452	1	300	1000	1	8	199	4	constant	synth	3
94	7	453	1	300	1000	1	8	199	5	constant	synth	3
95	7	454	1	300	1000	1	8	199	7	constant	synth	3
96	7	455	1	300	1000	1	8	199	7	constant	synth	3
97	7	456	1	300	1000	1	8	199	7	constant	synth	3
98	7	457	1	300	1000	1	8	199	3	constant	synth	3
99	7	458	1	300	1000	1	8	199	7	constant	synth	3
100	7	459	1	300	1000	1	8	199	3	constant	synth	3
101	7	460	1	300	1000	1	8	99	12	constant	synth	3
102	7	461	1	300	1000	1	8	99	7	constant	synth	3
103	7	462	1	300	1000	1	8	99	5	constant	synth	3
104	7	463	1	300	1000	1	8	99	7	constant	synth	3
105	7	464	1	300	1000	1	8	99	5	constant	synth	3
106	7	465	1	300	1000	1	8	99	6	constant	synth	3
107	7	466	1	300	1000	1	8	99	8	constant	synth	3
108	7	467	1	300	1000	1	8	99	6	constant	synth	3
109	7	468	1	300	1000	1	8	99	3	constant	synth	3
110	7	469	1	300	1000	1	8	99	4	constant	synth	3
111	7	470	1	300	1000	1	8	49	10	constant	synth	3
112	7	471	1	300	1000	1	8	49	10	constant	synth	3
113	7	472	1	300	1000	1	8	49	9	constant	synth	3
114	7	473	1	300	1000	1	8	49	6	constant	synth	3
115	7	474	1	300	1000	1	8	49	11	constant	synth	3
116	7	475	1	300	1000	1	8	49	9	constant	synth	3
117	7	476	1	300	1000	1	8	49	11	constant	synth	3
118	7	477	1	300	1000	1	8	49	10	constant	synth	3
12	10	611	1	300	10000	1	8	274	38	constant	synth	1
13	10	612	1	300	10000	1	8	274	31	constant	synth	1
14	10	613	1	300	10000	1	8	274	35	constant	synth	1
12	11	671	1	300	100000	1	8	274	33	constant	synth	1
13	11	672	1	300	100000	1	8	274	29	constant	synth	1
14	11	673	1	300	100000	1	8	274	28	constant	synth	1
36	11	695	1	300	100000	1	8	199	32	constant	synth	1
37	11	696	1	300	100000	1	8	199	28	constant	synth	1
38	11	697	1	300	100000	1	8	199	27	constant	synth	1
39	11	698	1	300	100000	1	8	199	29	constant	synth	1
40	11	699	1	300	100000	1	8	199	35	constant	synth	1
41	11	700	1	300	100000	1	8	99	42	constant	synth	1
42	11	701	1	300	100000	1	8	99	36	constant	synth	1
43	11	702	1	300	100000	1	8	99	28	constant	synth	1
44	11	703	1	300	100000	1	8	99	38	constant	synth	1
45	11	704	1	300	100000	1	8	99	30	constant	synth	1
46	11	705	1	300	100000	1	8	99	29	constant	synth	1
47	11	706	1	300	100000	1	8	99	30	constant	synth	1
48	11	707	1	300	100000	1	8	99	29	constant	synth	1
49	11	708	1	300	100000	1	8	99	34	constant	synth	1
50	11	709	1	300	100000	1	8	99	46	constant	synth	1
51	11	710	1	300	100000	1	8	49	36	constant	synth	1
52	11	711	1	300	100000	1	8	49	28	constant	synth	1
53	11	712	1	300	100000	1	8	49	31	constant	synth	1
54	11	713	1	300	100000	1	8	49	31	constant	synth	1
55	11	714	1	300	100000	1	8	49	41	constant	synth	1
56	11	715	1	300	100000	1	8	49	35	constant	synth	1
11	8	490	1	300	100	1	8	274	35	constant	synth	1
4	8	483	2	300	100	1	8	299	42	constant	synth	1
57	11	716	1	300	100000	1	8	49	27	constant	synth	1
58	11	717	1	300	100000	1	8	49	28	constant	synth	1
19	8	498	1	300	100	1	8	274	53	constant	synth	1
40	8	519	1	300	100	1	8	199	22	constant	synth	1
39	8	518	1	300	100	1	8	199	23	constant	synth	1
54	8	533	1	300	100	1	8	49	41	constant	synth	1
59	8	538	1	300	100	1	8	49	9	constant	synth	1
2	8	481	1	300	100	1	8	299	9	constant	synth	1
33	8	512	1	300	100	1	8	199	22	constant	synth	1
38	8	517	1	300	100	1	8	199	22	constant	synth	1
5	8	484	1	300	100	1	8	299	24	constant	synth	1
55	8	534	1	300	100	1	8	49	9	constant	synth	1
41	8	520	1	300	100	1	8	99	11	constant	synth	1
20	8	499	1	300	100	1	8	274	33	constant	synth	1
27	8	506	1	300	100	1	8	249	5	constant	synth	1
34	8	513	1	300	100	1	8	199	23	constant	synth	1
50	8	529	2	300	100	1	8	99	3	constant	synth	1
35	8	514	1	300	100	1	8	199	22	constant	synth	1
17	8	496	1	300	100	1	8	274	33	constant	synth	1
60	6	419	1	300	1000	1	8	49	14	constant	synth	2
119	7	478	1	300	1000	1	8	49	7	constant	synth	3
120	7	479	1	300	1000	1	8	49	8	constant	synth	3
1	6	360	1	300	1000	1	8	299	6	constant	synth	2
2	6	361	1	300	1000	1	8	299	16	constant	synth	2
3	6	362	1	300	1000	1	8	299	12	constant	synth	2
4	6	363	1	300	1000	1	8	299	6	constant	synth	2
5	6	364	1	300	1000	1	8	299	12	constant	synth	2
6	6	365	1	300	1000	1	8	299	8	constant	synth	2
7	6	366	1	300	1000	1	8	299	9	constant	synth	2
8	6	367	1	300	1000	1	8	299	5	constant	synth	2
9	6	368	1	300	1000	1	8	299	12	constant	synth	2
10	6	369	1	300	1000	1	8	299	6	constant	synth	2
11	6	370	1	300	1000	1	8	274	16	constant	synth	2
12	6	371	1	300	1000	1	8	274	15	constant	synth	2
13	6	372	1	300	1000	1	8	274	9	constant	synth	2
14	6	373	1	300	1000	1	8	274	11	constant	synth	2
15	6	374	1	300	1000	1	8	274	11	constant	synth	2
16	6	375	1	300	1000	1	8	274	13	constant	synth	2
17	6	376	1	300	1000	1	8	274	10	constant	synth	2
18	6	377	1	300	1000	1	8	274	12	constant	synth	2
19	6	378	1	300	1000	1	8	274	11	constant	synth	2
20	6	379	1	300	1000	1	8	274	13	constant	synth	2
21	6	380	1	300	1000	1	8	249	9	constant	synth	2
22	6	381	1	300	1000	1	8	249	7	constant	synth	2
61	7	420	1	300	1000	1	8	299	12	constant	synth	3
62	7	421	1	300	1000	1	8	299	6	constant	synth	3
63	7	422	1	300	1000	1	8	299	7	constant	synth	3
64	7	423	1	300	1000	1	8	299	10	constant	synth	3
65	7	424	1	300	1000	1	8	299	16	constant	synth	3
66	7	425	1	300	1000	1	8	299	9	constant	synth	3
67	7	426	1	300	1000	1	8	299	12	constant	synth	3
68	7	427	1	300	1000	1	8	299	13	constant	synth	3
69	7	428	1	300	1000	1	8	299	7	constant	synth	3
70	7	429	1	300	1000	1	8	299	8	constant	synth	3
71	7	430	1	300	1000	1	8	274	4	constant	synth	3
72	7	431	1	300	1000	1	8	274	2	constant	synth	3
73	7	432	1	300	1000	1	8	274	3	constant	synth	3
23	6	382	1	300	1000	1	8	249	6	constant	synth	2
24	6	383	1	300	1000	1	8	249	10	constant	synth	2
25	6	384	1	300	1000	1	8	249	8	constant	synth	2
26	6	385	1	300	1000	1	8	249	10	constant	synth	2
27	6	386	1	300	1000	1	8	249	4	constant	synth	2
28	6	387	1	300	1000	1	8	249	3	constant	synth	2
29	6	388	1	300	1000	1	8	249	9	constant	synth	2
30	6	389	1	300	1000	1	8	249	8	constant	synth	2
31	6	390	1	300	1000	1	8	199	17	constant	synth	2
32	6	391	1	300	1000	1	8	199	18	constant	synth	2
33	6	392	1	300	1000	1	8	199	18	constant	synth	2
34	6	393	1	300	1000	1	8	199	17	constant	synth	2
35	6	394	1	300	1000	1	8	199	12	constant	synth	2
36	6	395	1	300	1000	1	8	199	16	constant	synth	2
37	6	396	1	300	1000	1	8	199	20	constant	synth	2
38	6	397	1	300	1000	1	8	199	21	constant	synth	2
39	6	398	1	300	1000	1	8	199	16	constant	synth	2
40	6	399	1	300	1000	1	8	199	14	constant	synth	2
41	6	400	1	300	1000	1	8	99	11	constant	synth	2
42	6	401	1	300	1000	1	8	99	10	constant	synth	2
43	6	402	1	300	1000	1	8	99	6	constant	synth	2
44	6	403	1	300	1000	1	8	99	10	constant	synth	2
45	6	404	1	300	1000	1	8	99	7	constant	synth	2
46	6	405	1	300	1000	1	8	99	8	constant	synth	2
47	6	406	1	300	1000	1	8	99	11	constant	synth	2
48	6	407	1	300	1000	1	8	99	12	constant	synth	2
49	6	408	1	300	1000	1	8	99	14	constant	synth	2
50	6	409	1	300	1000	1	8	99	13	constant	synth	2
51	6	410	1	300	1000	1	8	49	14	constant	synth	2
52	6	411	1	300	1000	1	8	49	11	constant	synth	2
53	6	412	1	300	1000	1	8	49	19	constant	synth	2
54	6	413	1	300	1000	1	8	49	14	constant	synth	2
55	6	414	1	300	1000	1	8	49	12	constant	synth	2
56	6	415	1	300	1000	1	8	49	13	constant	synth	2
57	6	416	1	300	1000	1	8	49	19	constant	synth	2
58	6	417	1	300	1000	1	8	49	13	constant	synth	2
59	6	418	1	300	1000	1	8	49	15	constant	synth	2
74	7	433	1	300	1000	1	8	274	5	constant	synth	3
75	7	434	1	300	1000	1	8	274	6	constant	synth	3
76	7	435	1	300	1000	1	8	274	2	constant	synth	3
77	7	436	1	300	1000	1	8	274	4	constant	synth	3
78	7	437	1	300	1000	1	8	274	2	constant	synth	3
79	7	438	1	300	1000	1	8	274	1	constant	synth	3
80	7	439	1	300	1000	1	8	274	2	constant	synth	3
81	7	440	1	300	1000	1	8	249	8	constant	synth	3
82	7	441	1	300	1000	1	8	249	6	constant	synth	3
83	7	442	1	300	1000	1	8	249	5	constant	synth	3
84	7	443	1	300	1000	1	8	249	12	constant	synth	3
85	7	444	1	300	1000	1	8	249	8	constant	synth	3
86	7	445	1	300	1000	1	8	249	7	constant	synth	3
38	9	577	1	300	1000	1	8	199	9	constant	synth	1
39	9	578	1	300	1000	1	8	199	13	constant	synth	1
40	9	579	1	300	1000	1	8	199	31	constant	synth	1
41	9	580	1	300	1000	1	8	99	14	constant	synth	1
42	9	581	1	300	1000	1	8	99	13	constant	synth	1
43	9	582	1	300	1000	1	8	99	3	constant	synth	1
44	9	583	1	300	1000	1	8	99	15	constant	synth	1
45	9	584	1	300	1000	1	8	99	13	constant	synth	1
46	9	585	1	300	1000	1	8	99	11	constant	synth	1
47	9	586	1	300	1000	1	8	99	37	constant	synth	1
48	9	587	1	300	1000	1	8	99	22	constant	synth	1
49	9	588	1	300	1000	1	8	99	21	constant	synth	1
50	9	589	1	300	1000	1	8	99	15	constant	synth	1
51	9	590	1	300	1000	1	8	49	34	constant	synth	1
52	9	591	1	300	1000	1	8	49	34	constant	synth	1
53	9	592	1	300	1000	1	8	49	35	constant	synth	1
54	9	593	1	300	1000	1	8	49	48	constant	synth	1
55	9	594	1	300	1000	1	8	49	38	constant	synth	1
56	9	595	1	300	1000	1	8	49	37	constant	synth	1
57	9	596	1	300	1000	1	8	49	31	constant	synth	1
58	9	597	1	300	1000	1	8	49	36	constant	synth	1
59	9	598	1	300	1000	1	8	49	34	constant	synth	1
60	9	599	1	300	1000	1	8	49	48	constant	synth	1
1	11	660	1	300	100000	1	8	299	24	constant	synth	1
2	11	661	1	300	100000	1	8	299	23	constant	synth	1
3	11	662	1	300	100000	1	8	299	36	constant	synth	1
4	11	663	1	300	100000	1	8	299	24	constant	synth	1
5	11	664	1	300	100000	1	8	299	28	constant	synth	1
6	11	665	1	300	100000	1	8	299	22	constant	synth	1
7	11	666	1	300	100000	1	8	299	24	constant	synth	1
8	11	667	1	300	100000	1	8	299	23	constant	synth	1
9	11	668	1	300	100000	1	8	299	25	constant	synth	1
10	11	669	1	300	100000	1	8	299	23	constant	synth	1
11	11	670	1	300	100000	1	8	274	31	constant	synth	1
25	8	504	1	300	100	1	8	249	4	constant	synth	1
32	8	511	1	300	100	1	8	199	22	constant	synth	1
21	8	500	1	300	100	1	8	249	10	constant	synth	1
12	8	491	1	300	100	1	8	274	57	constant	synth	1
18	8	497	1	300	100	1	8	274	53	constant	synth	1
26	8	505	4	300	100	1	8	249	5	constant	synth	1
10	8	489	1	300	100	1	8	299	21	constant	synth	1
29	8	508	1	300	100	1	8	249	5	constant	synth	1
56	8	535	1	300	100	1	8	49	37	constant	synth	1
28	8	507	2	300	100	1	8	249	5	constant	synth	1
57	8	536	1	300	100	1	8	49	9	constant	synth	1
22	8	501	4	300	100	1	8	249	5	constant	synth	1
43	8	522	1	300	100	1	8	99	3	constant	synth	1
1	8	480	1	300	100	1	8	299	13	constant	synth	1
36	8	515	1	300	100	1	8	199	22	constant	synth	1
23	8	502	1	300	100	1	8	249	11	constant	synth	1
24	8	503	3	300	100	1	8	249	4	constant	synth	1
45	8	524	1	300	100	1	8	99	45	constant	synth	1
44	8	523	1	300	100	1	8	99	9	constant	synth	1
16	8	495	1	300	100	1	8	274	33	constant	synth	1
15	10	614	1	300	10000	1	8	274	35	constant	synth	1
16	10	615	1	300	10000	1	8	274	52	constant	synth	1
17	10	616	1	300	10000	1	8	274	34	constant	synth	1
18	10	617	1	300	10000	1	8	274	32	constant	synth	1
19	10	618	1	300	10000	1	8	274	38	constant	synth	1
20	10	619	1	300	10000	1	8	274	38	constant	synth	1
21	10	620	1	300	10000	1	8	249	28	constant	synth	1
22	10	621	1	300	10000	1	8	249	20	constant	synth	1
23	10	622	1	300	10000	1	8	249	22	constant	synth	1
24	10	623	1	300	10000	1	8	249	29	constant	synth	1
25	10	624	1	300	10000	1	8	249	28	constant	synth	1
26	10	625	1	300	10000	1	8	249	43	constant	synth	1
27	10	626	1	300	10000	1	8	249	26	constant	synth	1
28	10	627	1	300	10000	1	8	249	25	constant	synth	1
29	10	628	1	300	10000	1	8	249	28	constant	synth	1
30	10	629	1	300	10000	1	8	249	20	constant	synth	1
31	10	630	1	300	10000	1	8	199	26	constant	synth	1
32	10	631	1	300	10000	1	8	199	26	constant	synth	1
33	10	632	1	300	10000	1	8	199	24	constant	synth	1
34	10	633	1	300	10000	1	8	199	28	constant	synth	1
35	10	634	1	300	10000	1	8	199	27	constant	synth	1
36	10	635	1	300	10000	1	8	199	22	constant	synth	1
37	10	636	1	300	10000	1	8	199	25	constant	synth	1
38	10	637	1	300	10000	1	8	199	28	constant	synth	1
39	10	638	1	300	10000	1	8	199	22	constant	synth	1
40	10	639	1	300	10000	1	8	199	30	constant	synth	1
41	10	640	1	300	10000	1	8	99	33	constant	synth	1
42	10	641	1	300	10000	1	8	99	26	constant	synth	1
43	10	642	1	300	10000	1	8	99	39	constant	synth	1
59	11	718	1	300	100000	1	8	49	32	constant	synth	1
60	11	719	1	300	100000	1	8	49	32	constant	synth	1
30	8	509	4	300	100	1	8	249	5	constant	synth	1
42	8	521	1	300	100	1	8	99	45	constant	synth	1
6	8	485	1	300	100	1	8	299	24	constant	synth	1
47	8	526	1	300	100	1	8	99	3	constant	synth	1
8	8	487	2	300	100	1	8	299	24	constant	synth	1
51	8	530	1	300	100	1	8	49	29	constant	synth	1
58	8	537	1	300	100	1	8	49	41	constant	synth	1
13	8	492	1	300	100	1	8	274	68	constant	synth	1
49	8	528	1	300	100	1	8	99	15	constant	synth	1
52	8	531	1	300	100	1	8	49	42	constant	synth	1
15	11	674	1	300	100000	1	8	274	30	constant	synth	1
16	11	675	1	300	100000	1	8	274	32	constant	synth	1
17	11	676	1	300	100000	1	8	274	25	constant	synth	1
18	11	677	1	300	100000	1	8	274	27	constant	synth	1
19	11	678	1	300	100000	1	8	274	31	constant	synth	1
20	11	679	1	300	100000	1	8	274	23	constant	synth	1
21	11	680	1	300	100000	1	8	249	23	constant	synth	1
22	11	681	1	300	100000	1	8	249	32	constant	synth	1
23	11	682	1	300	100000	1	8	249	28	constant	synth	1
24	11	683	1	300	100000	1	8	249	27	constant	synth	1
25	11	684	1	300	100000	1	8	249	30	constant	synth	1
26	11	685	1	300	100000	1	8	249	29	constant	synth	1
27	11	686	1	300	100000	1	8	249	26	constant	synth	1
28	11	687	1	300	100000	1	8	249	39	constant	synth	1
29	11	688	1	300	100000	1	8	249	32	constant	synth	1
30	11	689	1	300	100000	1	8	249	32	constant	synth	1
31	11	690	1	300	100000	1	8	199	31	constant	synth	1
32	11	691	1	300	100000	1	8	199	33	constant	synth	1
33	11	692	1	300	100000	1	8	199	37	constant	synth	1
34	11	693	1	300	100000	1	8	199	32	constant	synth	1
35	11	694	1	300	100000	1	8	199	31	constant	synth	1
15	8	494	1	300	100	1	8	274	35	constant	synth	1
60	8	539	1	300	100	1	8	49	38	constant	synth	1
1	10	600	1	300	10000	1	8	299	26	constant	synth	1
2	10	601	1	300	10000	1	8	299	27	constant	synth	1
3	10	602	1	300	10000	1	8	299	26	constant	synth	1
4	10	603	1	300	10000	1	8	299	26	constant	synth	1
5	10	604	1	300	10000	1	8	299	39	constant	synth	1
6	10	605	1	300	10000	1	8	299	39	constant	synth	1
7	10	606	1	300	10000	1	8	299	28	constant	synth	1
8	10	607	1	300	10000	1	8	299	30	constant	synth	1
9	10	608	1	300	10000	1	8	299	23	constant	synth	1
10	10	609	1	300	10000	1	8	299	33	constant	synth	1
11	10	610	1	300	10000	1	8	274	32	constant	synth	1
3	8	482	2	300	100	1	8	299	13	constant	synth	1
31	8	510	1	300	100	1	8	199	22	constant	synth	1
9	8	488	1	300	100	1	8	299	21	constant	synth	1
53	8	532	1	300	100	1	8	49	38	constant	synth	1
7	8	486	2	300	100	1	8	299	13	constant	synth	1
37	8	516	1	300	100	1	8	199	22	constant	synth	1
48	8	527	1	300	100	1	8	99	9	constant	synth	1
18	9	557	1	300	1000	1	8	274	20	constant	synth	1
19	9	558	1	300	1000	1	8	274	31	constant	synth	1
20	9	559	1	300	1000	1	8	274	23	constant	synth	1
21	9	560	1	300	1000	1	8	249	15	constant	synth	1
22	9	561	1	300	1000	1	8	249	20	constant	synth	1
23	9	562	1	300	1000	1	8	249	30	constant	synth	1
24	9	563	1	300	1000	1	8	249	25	constant	synth	1
25	9	564	1	300	1000	1	8	249	16	constant	synth	1
26	9	565	1	300	1000	1	8	249	16	constant	synth	1
27	9	566	1	300	1000	1	8	249	22	constant	synth	1
28	9	567	1	300	1000	1	8	249	18	constant	synth	1
29	9	568	1	300	1000	1	8	249	31	constant	synth	1
30	9	569	1	300	1000	1	8	249	19	constant	synth	1
31	9	570	1	300	1000	1	8	199	16	constant	synth	1
32	9	571	1	300	1000	1	8	199	12	constant	synth	1
33	9	572	1	300	1000	1	8	199	11	constant	synth	1
34	9	573	1	300	1000	1	8	199	14	constant	synth	1
44	10	643	1	300	10000	1	8	99	26	constant	synth	1
45	10	644	1	300	10000	1	8	99	34	constant	synth	1
46	10	645	1	300	10000	1	8	99	31	constant	synth	1
47	10	646	1	300	10000	1	8	99	31	constant	synth	1
48	10	647	1	300	10000	1	8	99	29	constant	synth	1
49	10	648	1	300	10000	1	8	99	36	constant	synth	1
50	10	649	1	300	10000	1	8	99	37	constant	synth	1
51	10	650	1	300	10000	1	8	49	25	constant	synth	1
14	8	493	1	300	100	1	8	274	68	constant	synth	1
46	8	525	1	300	100	1	8	99	11	constant	synth	1
52	10	651	1	300	10000	1	8	49	28	constant	synth	1
53	10	652	1	300	10000	1	8	49	32	constant	synth	1
54	10	653	1	300	10000	1	8	49	33	constant	synth	1
55	10	654	1	300	10000	1	8	49	25	constant	synth	1
56	10	655	1	300	10000	1	8	49	35	constant	synth	1
57	10	656	1	300	10000	1	8	49	35	constant	synth	1
58	10	657	1	300	10000	1	8	49	27	constant	synth	1
59	10	658	1	300	10000	1	8	49	27	constant	synth	1
60	10	659	1	300	10000	1	8	49	30	constant	synth	1
1	9	540	1	300	1000	1	8	299	22	constant	synth	1
2	9	541	1	300	1000	1	8	299	18	constant	synth	1
3	9	542	1	300	1000	1	8	299	17	constant	synth	1
4	9	543	1	300	1000	1	8	299	18	constant	synth	1
5	9	544	1	300	1000	1	8	299	16	constant	synth	1
6	9	545	1	300	1000	1	8	299	15	constant	synth	1
7	9	546	1	300	1000	1	8	299	17	constant	synth	1
8	9	547	1	300	1000	1	8	299	52	constant	synth	1
9	9	548	1	300	1000	1	8	299	35	constant	synth	1
10	9	549	1	300	1000	1	8	299	6	constant	synth	1
11	9	550	1	300	1000	1	8	274	25	constant	synth	1
12	9	551	1	300	1000	1	8	274	20	constant	synth	1
13	9	552	1	300	1000	1	8	274	39	constant	synth	1
14	9	553	1	300	1000	1	8	274	30	constant	synth	1
15	9	554	1	300	1000	1	8	274	42	constant	synth	1
16	9	555	1	300	1000	1	8	274	23	constant	synth	1
17	9	556	1	300	1000	1	8	274	23	constant	synth	1
35	9	574	1	300	1000	1	8	199	6	constant	synth	1
36	9	575	1	300	1000	1	8	199	12	constant	synth	1
37	9	576	1	300	1000	1	8	199	31	constant	synth	1
1	0	0	1	300	1000	0	8	299	31	constant	synth	1
20	0	19	1	300	1000	0	8	274	19	constant	synth	1
21	0	20	1	300	1000	0	8	249	55	constant	synth	1
22	0	21	1	300	1000	0	8	249	20	constant	synth	1
23	0	22	1	300	1000	0	8	249	42	constant	synth	1
24	0	23	1	300	1000	0	8	249	37	constant	synth	1
25	0	24	1	300	1000	0	8	249	40	constant	synth	1
26	0	25	1	300	1000	0	8	249	26	constant	synth	1
27	0	26	1	300	1000	0	8	249	51	constant	synth	1
28	0	27	1	300	1000	0	8	249	27	constant	synth	1
29	0	28	1	300	1000	0	8	249	46	constant	synth	1
30	0	29	1	300	1000	0	8	249	65	constant	synth	1
31	0	30	1	300	1000	0	8	199	27	constant	synth	1
32	0	31	1	300	1000	0	8	199	21	constant	synth	1
33	0	32	1	300	1000	0	8	199	14	constant	synth	1
34	0	33	1	300	1000	0	8	199	23	constant	synth	1
35	0	34	1	300	1000	0	8	199	18	constant	synth	1
36	0	35	1	300	1000	0	8	199	19	constant	synth	1
37	0	36	1	300	1000	0	8	199	44	constant	synth	1
38	0	37	1	300	1000	0	8	199	18	constant	synth	1
39	0	38	1	300	1000	0	8	199	17	constant	synth	1
40	0	39	1	300	1000	0	8	199	10	constant	synth	1
41	0	40	1	300	1000	0	8	99	32	constant	synth	1
42	0	41	1	300	1000	0	8	99	35	constant	synth	1
43	0	42	1	300	1000	0	8	99	26	constant	synth	1
44	0	43	1	300	1000	0	8	99	21	constant	synth	1
45	0	44	1	300	1000	0	8	99	45	constant	synth	1
46	0	45	1	300	1000	0	8	99	29	constant	synth	1
47	0	46	1	300	1000	0	8	99	22	constant	synth	1
48	0	47	1	300	1000	0	8	99	54	constant	synth	1
49	0	48	1	300	1000	0	8	99	25	constant	synth	1
50	0	49	1	300	1000	0	8	99	24	constant	synth	1
51	0	50	1	300	1000	0	8	49	24	constant	synth	1
52	0	51	1	300	1000	0	8	49	18	constant	synth	1
53	0	52	1	300	1000	0	8	49	21	constant	synth	1
54	0	53	1	300	1000	0	8	49	21	constant	synth	1
55	0	54	1	300	1000	0	8	49	12	constant	synth	1
56	0	55	1	300	1000	0	8	49	26	constant	synth	1
57	0	56	1	300	1000	0	8	49	19	constant	synth	1
58	0	57	1	300	1000	0	8	49	29	constant	synth	1
59	0	58	1	300	1000	0	8	49	23	constant	synth	1
60	0	59	1	300	1000	0	8	49	20	constant	synth	1
61	1	60	1	300	1000	0.5	8	299	24	constant	synth	1
62	1	61	1	300	1000	0.5	8	299	25	constant	synth	1
63	1	62	1	300	1000	0.5	8	299	23	constant	synth	1
64	1	63	1	300	1000	0.5	8	299	25	constant	synth	1
65	1	64	1	300	1000	0.5	8	299	28	constant	synth	1
66	1	65	1	300	1000	0.5	8	299	41	constant	synth	1
67	1	66	1	300	1000	0.5	8	299	27	constant	synth	1
68	1	67	1	300	1000	0.5	8	299	27	constant	synth	1
69	1	68	1	300	1000	0.5	8	299	33	constant	synth	1
70	1	69	1	300	1000	0.5	8	299	22	constant	synth	1
71	1	70	1	300	1000	0.5	8	274	10	constant	synth	1
72	1	71	1	300	1000	0.5	8	274	16	constant	synth	1
75	1	74	1	300	1000	0.5	8	274	14	constant	synth	1
76	1	75	1	300	1000	0.5	8	274	16	constant	synth	1
77	1	76	1	300	1000	0.5	8	274	8	constant	synth	1
79	1	78	1	300	1000	0.5	8	274	3	constant	synth	1
80	1	79	1	300	1000	0.5	8	274	5	constant	synth	1
81	1	80	1	300	1000	0.5	8	249	16	constant	synth	1
82	1	81	1	300	1000	0.5	8	249	18	constant	synth	1
83	1	82	1	300	1000	0.5	8	249	15	constant	synth	1
84	1	83	1	300	1000	0.5	8	249	20	constant	synth	1
85	1	84	1	300	1000	0.5	8	249	16	constant	synth	1
86	1	85	1	300	1000	0.5	8	249	12	constant	synth	1
87	1	86	1	300	1000	0.5	8	249	21	constant	synth	1
88	1	87	1	300	1000	0.5	8	249	18	constant	synth	1
89	1	88	1	300	1000	0.5	8	249	20	constant	synth	1
90	1	89	1	300	1000	0.5	8	249	10	constant	synth	1
91	1	90	1	300	1000	0.5	8	199	21	constant	synth	1
92	1	91	1	300	1000	0.5	8	199	34	constant	synth	1
93	1	92	1	300	1000	0.5	8	199	65	constant	synth	1
94	1	93	1	300	1000	0.5	8	199	25	constant	synth	1
95	1	94	1	300	1000	0.5	8	199	38	constant	synth	1
96	1	95	1	300	1000	0.5	8	199	13	constant	synth	1
97	1	96	1	300	1000	0.5	8	199	14	constant	synth	1
74	1	73	2	300	1000	0.5	8	274	17	constant	synth	1
78	1	77	1	300	1000	0.5	8	274	5	constant	synth	1
98	1	97	1	300	1000	0.5	8	199	16	constant	synth	1
99	1	98	1	300	1000	0.5	8	199	19	constant	synth	1
100	1	99	1	300	1000	0.5	8	199	21	constant	synth	1
101	1	100	1	300	1000	0.5	8	99	30	constant	synth	1
102	1	101	1	300	1000	0.5	8	99	27	constant	synth	1
103	1	102	1	300	1000	0.5	8	99	34	constant	synth	1
104	1	103	1	300	1000	0.5	8	99	20	constant	synth	1
105	1	104	1	300	1000	0.5	8	99	36	constant	synth	1
106	1	105	1	300	1000	0.5	8	99	20	constant	synth	1
107	1	106	1	300	1000	0.5	8	99	25	constant	synth	1
108	1	107	1	300	1000	0.5	8	99	27	constant	synth	1
109	1	108	1	300	1000	0.5	8	99	25	constant	synth	1
110	1	109	1	300	1000	0.5	8	99	26	constant	synth	1
111	1	110	1	300	1000	0.5	8	49	15	constant	synth	1
112	1	111	1	300	1000	0.5	8	49	7	constant	synth	1
113	1	112	1	300	1000	0.5	8	49	14	constant	synth	1
114	1	113	1	300	1000	0.5	8	49	15	constant	synth	1
115	1	114	1	300	1000	0.5	8	49	13	constant	synth	1
116	1	115	1	300	1000	0.5	8	49	17	constant	synth	1
117	1	116	1	300	1000	0.5	8	49	15	constant	synth	1
118	1	117	1	300	1000	0.5	8	49	10	constant	synth	1
119	1	118	1	300	1000	0.5	8	49	14	constant	synth	1
120	1	119	1	300	1000	0.5	8	49	14	constant	synth	1
121	2	120	1	300	1000	1	8	299	14	constant	synth	1
122	2	121	1	300	1000	1	8	299	11	constant	synth	1
123	2	122	1	300	1000	1	8	299	21	constant	synth	1
124	2	123	1	300	1000	1	8	299	2	constant	synth	1
125	2	124	1	300	1000	1	8	299	14	constant	synth	1
126	2	125	1	300	1000	1	8	299	16	constant	synth	1
127	2	126	1	300	1000	1	8	299	34	constant	synth	1
128	2	127	1	300	1000	1	8	299	18	constant	synth	1
129	2	128	1	300	1000	1	8	299	12	constant	synth	1
130	2	129	1	300	1000	1	8	299	14	constant	synth	1
131	2	130	1	300	1000	1	8	274	25	constant	synth	1
132	2	131	1	300	1000	1	8	274	27	constant	synth	1
133	2	132	1	300	1000	1	8	274	29	constant	synth	1
134	2	133	1	300	1000	1	8	274	21	constant	synth	1
135	2	134	1	300	1000	1	8	274	50	constant	synth	1
136	2	135	1	300	1000	1	8	274	42	constant	synth	1
137	2	136	1	300	1000	1	8	274	18	constant	synth	1
138	2	137	1	300	1000	1	8	274	20	constant	synth	1
139	2	138	1	300	1000	1	8	274	27	constant	synth	1
140	2	139	1	300	1000	1	8	274	19	constant	synth	1
141	2	140	1	300	1000	1	8	249	39	constant	synth	1
142	2	141	1	300	1000	1	8	249	26	constant	synth	1
143	2	142	1	300	1000	1	8	249	22	constant	synth	1
144	2	143	1	300	1000	1	8	249	24	constant	synth	1
145	2	144	1	300	1000	1	8	249	25	constant	synth	1
146	2	145	1	300	1000	1	8	249	134	constant	synth	1
147	2	146	1	300	1000	1	8	249	42	constant	synth	1
148	2	147	1	300	1000	1	8	249	25	constant	synth	1
149	2	148	1	300	1000	1	8	249	134	constant	synth	1
150	2	149	1	300	1000	1	8	249	26	constant	synth	1
151	2	150	1	300	1000	1	8	199	72	constant	synth	1
152	2	151	1	300	1000	1	8	199	52	constant	synth	1
153	2	152	1	300	1000	1	8	199	49	constant	synth	1
154	2	153	1	300	1000	1	8	199	60	constant	synth	1
155	2	154	1	300	1000	1	8	199	54	constant	synth	1
156	2	155	1	300	1000	1	8	199	46	constant	synth	1
157	2	156	1	300	1000	1	8	199	63	constant	synth	1
158	2	157	1	300	1000	1	8	199	50	constant	synth	1
159	2	158	1	300	1000	1	8	199	43	constant	synth	1
160	2	159	1	300	1000	1	8	199	63	constant	synth	1
161	2	160	1	300	1000	1	8	99	13	constant	synth	1
162	2	161	1	300	1000	1	8	99	18	constant	synth	1
163	2	162	1	300	1000	1	8	99	16	constant	synth	1
164	2	163	1	300	1000	1	8	99	30	constant	synth	1
165	2	164	1	300	1000	1	8	99	30	constant	synth	1
166	2	165	1	300	1000	1	8	99	14	constant	synth	1
167	2	166	1	300	1000	1	8	99	11	constant	synth	1
168	2	167	1	300	1000	1	8	99	12	constant	synth	1
169	2	168	1	300	1000	1	8	99	17	constant	synth	1
170	2	169	1	300	1000	1	8	99	16	constant	synth	1
171	2	170	1	300	1000	1	8	49	30	constant	synth	1
172	2	171	1	300	1000	1	8	49	21	constant	synth	1
173	2	172	1	300	1000	1	8	49	38	constant	synth	1
174	2	173	1	300	1000	1	8	49	28	constant	synth	1
175	2	174	1	300	1000	1	8	49	29	constant	synth	1
176	2	175	1	300	1000	1	8	49	25	constant	synth	1
177	2	176	1	300	1000	1	8	49	28	constant	synth	1
178	2	177	1	300	1000	1	8	49	28	constant	synth	1
179	2	178	1	300	1000	1	8	49	25	constant	synth	1
180	2	179	1	300	1000	1	8	49	37	constant	synth	1
181	3	180	3	300	1000	3	8	299	77	constant	synth	1
182	3	181	3	300	1000	3	8	299	12	constant	synth	1
183	3	182	2	300	1000	3	8	299	9	constant	synth	1
184	3	183	4	300	1000	3	8	299	1	constant	synth	1
185	3	184	1	300	1000	3	8	299	137	constant	synth	1
186	3	185	2	300	1000	3	8	299	12	constant	synth	1
187	3	186	3	300	1000	3	8	299	23	constant	synth	1
188	3	187	1	300	1000	3	8	299	39	constant	synth	1
189	3	188	2	300	1000	3	8	299	4	constant	synth	1
190	3	189	4	300	1000	3	8	299	29	constant	synth	1
191	3	190	1	300	1000	3	8	274	4	constant	synth	1
192	3	191	1	300	1000	3	8	274	4	constant	synth	1
193	3	192	1	300	1000	3	8	274	4	constant	synth	1
194	3	193	1	300	1000	3	8	274	4	constant	synth	1
195	3	194	1	300	1000	3	8	274	4	constant	synth	1
196	3	195	1	300	1000	3	8	274	25	constant	synth	1
197	3	196	1	300	1000	3	8	274	4	constant	synth	1
198	3	197	1	300	1000	3	8	274	4	constant	synth	1
199	3	198	1	300	1000	3	8	274	6	constant	synth	1
200	3	199	1	300	1000	3	8	274	9	constant	synth	1
201	3	200	3	300	1000	3	8	249	35	constant	synth	1
202	3	201	2	300	1000	3	8	249	2	constant	synth	1
203	3	202	1	300	1000	3	8	249	69	constant	synth	1
204	3	203	1	300	1000	3	8	249	11	constant	synth	1
205	3	204	2	300	1000	3	8	249	9	constant	synth	1
206	3	205	4	300	1000	3	8	249	6	constant	synth	1
207	3	206	2	300	1000	3	8	249	21	constant	synth	1
208	3	207	1	300	1000	3	8	249	92	constant	synth	1
209	3	208	1	300	1000	3	8	249	39	constant	synth	1
210	3	209	4	300	1000	3	8	249	5	constant	synth	1
211	3	210	1	300	1000	3	8	199	97	constant	synth	1
212	3	211	1	300	1000	3	8	199	22	constant	synth	1
213	3	212	2	300	1000	3	8	199	34	constant	synth	1
214	3	213	1	300	1000	3	8	199	37	constant	synth	1
215	3	214	2	300	1000	3	8	199	10	constant	synth	1
216	3	215	3	300	1000	3	8	199	37	constant	synth	1
217	3	216	1	300	1000	3	8	199	11	constant	synth	1
218	3	217	3	300	1000	3	8	199	62	constant	synth	1
219	3	218	1	300	1000	3	8	199	2	constant	synth	1
220	3	219	4	300	1000	3	8	199	5	constant	synth	1
221	3	220	1	300	1000	3	8	99	8	constant	synth	1
222	3	221	1	300	1000	3	8	99	2	constant	synth	1
223	3	222	1	300	1000	3	8	99	4	constant	synth	1
224	3	223	1	300	1000	3	8	99	5	constant	synth	1
225	3	224	2	300	1000	3	8	99	9	constant	synth	1
226	3	225	2	300	1000	3	8	99	8	constant	synth	1
227	3	226	1	300	1000	3	8	99	2	constant	synth	1
228	3	227	1	300	1000	3	8	99	38	constant	synth	1
229	3	228	1	300	1000	3	8	99	22	constant	synth	1
230	3	229	4	300	1000	3	8	99	5	constant	synth	1
231	3	230	1	300	1000	3	8	49	19	constant	synth	1
232	3	231	1	300	1000	3	8	49	33	constant	synth	1
233	3	232	1	300	1000	3	8	49	21	constant	synth	1
234	3	233	1	300	1000	3	8	49	44	constant	synth	1
235	3	234	1	300	1000	3	8	49	24	constant	synth	1
236	3	235	1	300	1000	3	8	49	8	constant	synth	1
237	3	236	1	300	1000	3	8	49	8	constant	synth	1
238	3	237	1	300	1000	3	8	49	27	constant	synth	1
239	3	238	1	300	1000	3	8	49	24	constant	synth	1
240	3	239	1	300	1000	3	8	49	8	constant	synth	1
241	4	240	1	300	1000	5	8	299	160	constant	synth	1
242	4	241	1	300	1000	5	8	299	160	constant	synth	1
243	4	242	1	300	1000	5	8	299	190	constant	synth	1
244	4	243	1	300	1000	5	8	299	160	constant	synth	1
245	4	244	1	300	1000	5	8	299	160	constant	synth	1
246	4	245	1	300	1000	5	8	299	282	constant	synth	1
247	4	246	1	300	1000	5	8	299	160	constant	synth	1
248	4	247	1	300	1000	5	8	299	160	constant	synth	1
249	4	248	1	300	1000	5	8	299	160	constant	synth	1
250	4	249	1	300	1000	5	8	299	205	constant	synth	1
251	4	250	1	300	1000	5	8	274	45	constant	synth	1
252	4	251	1	300	1000	5	8	274	45	constant	synth	1
253	4	252	1	300	1000	5	8	274	45	constant	synth	1
254	4	253	1	300	1000	5	8	274	45	constant	synth	1
255	4	254	1	300	1000	5	8	274	45	constant	synth	1
256	4	255	1	300	1000	5	8	274	45	constant	synth	1
257	4	256	1	300	1000	5	8	274	45	constant	synth	1
258	4	257	1	300	1000	5	8	274	45	constant	synth	1
259	4	258	1	300	1000	5	8	274	45	constant	synth	1
260	4	259	1	300	1000	5	8	274	45	constant	synth	1
261	4	260	1	300	1000	5	8	249	71	constant	synth	1
262	4	261	1	300	1000	5	8	249	71	constant	synth	1
263	4	262	1	300	1000	5	8	249	71	constant	synth	1
264	4	263	1	300	1000	5	8	249	110	constant	synth	1
265	4	264	1	300	1000	5	8	249	71	constant	synth	1
266	4	265	1	300	1000	5	8	249	139	constant	synth	1
267	4	266	1	300	1000	5	8	249	96	constant	synth	1
268	4	267	1	300	1000	5	8	249	139	constant	synth	1
269	4	268	1	300	1000	5	8	249	71	constant	synth	1
270	4	269	1	300	1000	5	8	249	77	constant	synth	1
271	4	270	4	300	1000	5	8	199	43	constant	synth	1
272	4	271	2	300	1000	5	8	199	2	constant	synth	1
273	4	272	1	300	1000	5	8	199	5	constant	synth	1
274	4	273	3	300	1000	5	8	199	2	constant	synth	1
275	4	274	1	300	1000	5	8	199	2	constant	synth	1
276	4	275	5	300	1000	5	8	199	45	constant	synth	1
277	4	276	6	300	1000	5	8	199	2	constant	synth	1
278	4	277	1	300	1000	5	8	199	5	constant	synth	1
279	4	278	2	300	1000	5	8	199	21	constant	synth	1
280	4	279	5	300	1000	5	8	199	5	constant	synth	1
281	4	280	2	300	1000	5	8	99	3	constant	synth	1
282	4	281	4	300	1000	5	8	99	14	constant	synth	1
283	4	282	1	300	1000	5	8	99	19	constant	synth	1
284	4	283	1	300	1000	5	8	99	45	constant	synth	1
285	4	284	1	300	1000	5	8	99	59	constant	synth	1
286	4	285	3	300	1000	5	8	99	25	constant	synth	1
287	4	286	1	300	1000	5	8	99	40	constant	synth	1
288	4	287	1	300	1000	5	8	99	1	constant	synth	1
289	4	288	2	300	1000	5	8	99	25	constant	synth	1
290	4	289	1	300	1000	5	8	99	3	constant	synth	1
291	4	290	1	300	1000	5	8	49	38	constant	synth	1
292	4	291	1	300	1000	5	8	49	5	constant	synth	1
293	4	292	1	300	1000	5	8	49	13	constant	synth	1
294	4	293	1	300	1000	5	8	49	63	constant	synth	1
295	4	294	1	300	1000	5	8	49	25	constant	synth	1
296	4	295	1	300	1000	5	8	49	23	constant	synth	1
297	4	296	1	300	1000	5	8	49	8	constant	synth	1
298	4	297	1	300	1000	5	8	49	12	constant	synth	1
299	4	298	1	300	1000	5	8	49	29	constant	synth	1
300	4	299	1	300	1000	5	8	49	20	constant	synth	1
73	1	72	1	300	1000	0.5	8	274	24	constant	synth	1
1	0	0	1	300	1000	0	8	299	31	constant	synth	1
2	0	1	1	300	1000	0	8	299	18	constant	synth	1
3	0	2	1	300	1000	0	8	299	25	constant	synth	1
4	0	3	1	300	1000	0	8	299	38	constant	synth	1
5	0	4	1	300	1000	0	8	299	39	constant	synth	1
6	0	5	1	300	1000	0	8	299	27	constant	synth	1
7	0	6	1	300	1000	0	8	299	40	constant	synth	1
8	0	7	1	300	1000	0	8	299	30	constant	synth	1
9	0	8	1	300	1000	0	8	299	22	constant	synth	1
10	0	9	1	300	1000	0	8	299	29	constant	synth	1
11	0	10	1	300	1000	0	8	274	22	constant	synth	1
12	0	11	1	300	1000	0	8	274	30	constant	synth	1
13	0	12	1	300	1000	0	8	274	15	constant	synth	1
14	0	13	1	300	1000	0	8	274	19	constant	synth	1
15	0	14	1	300	1000	0	8	274	20	constant	synth	1
16	0	15	1	300	1000	0	8	274	18	constant	synth	1
17	0	16	1	300	1000	0	8	274	29	constant	synth	1
18	0	17	1	300	1000	0	8	274	29	constant	synth	1
19	0	18	1	300	1000	0	8	274	23	constant	synth	1
20	0	19	1	300	1000	0	8	274	19	constant	synth	1
21	0	20	1	300	1000	0	8	249	55	constant	synth	1
22	0	21	1	300	1000	0	8	249	20	constant	synth	1
23	0	22	1	300	1000	0	8	249	42	constant	synth	1
24	0	23	1	300	1000	0	8	249	37	constant	synth	1
25	0	24	1	300	1000	0	8	249	40	constant	synth	1
26	0	25	1	300	1000	0	8	249	26	constant	synth	1
27	0	26	1	300	1000	0	8	249	51	constant	synth	1
28	0	27	1	300	1000	0	8	249	27	constant	synth	1
29	0	28	1	300	1000	0	8	249	46	constant	synth	1
30	0	29	1	300	1000	0	8	249	65	constant	synth	1
31	0	30	1	300	1000	0	8	199	27	constant	synth	1
32	0	31	1	300	1000	0	8	199	21	constant	synth	1
33	0	32	1	300	1000	0	8	199	14	constant	synth	1
34	0	33	1	300	1000	0	8	199	23	constant	synth	1
35	0	34	1	300	1000	0	8	199	18	constant	synth	1
36	0	35	1	300	1000	0	8	199	19	constant	synth	1
37	0	36	1	300	1000	0	8	199	44	constant	synth	1
38	0	37	1	300	1000	0	8	199	18	constant	synth	1
39	0	38	1	300	1000	0	8	199	17	constant	synth	1
40	0	39	1	300	1000	0	8	199	10	constant	synth	1
41	0	40	1	300	1000	0	8	99	32	constant	synth	1
42	0	41	1	300	1000	0	8	99	35	constant	synth	1
43	0	42	1	300	1000	0	8	99	26	constant	synth	1
44	0	43	1	300	1000	0	8	99	21	constant	synth	1
45	0	44	1	300	1000	0	8	99	45	constant	synth	1
46	0	45	1	300	1000	0	8	99	29	constant	synth	1
47	0	46	1	300	1000	0	8	99	22	constant	synth	1
48	0	47	1	300	1000	0	8	99	54	constant	synth	1
49	0	48	1	300	1000	0	8	99	25	constant	synth	1
50	0	49	1	300	1000	0	8	99	24	constant	synth	1
51	0	50	1	300	1000	0	8	49	24	constant	synth	1
52	0	51	1	300	1000	0	8	49	18	constant	synth	1
53	0	52	1	300	1000	0	8	49	21	constant	synth	1
54	0	53	1	300	1000	0	8	49	21	constant	synth	1
55	0	54	1	300	1000	0	8	49	12	constant	synth	1
56	0	55	1	300	1000	0	8	49	26	constant	synth	1
57	0	56	1	300	1000	0	8	49	19	constant	synth	1
58	0	57	1	300	1000	0	8	49	29	constant	synth	1
59	0	58	1	300	1000	0	8	49	23	constant	synth	1
60	0	59	1	300	1000	0	8	49	20	constant	synth	1
61	1	60	1	300	1000	0.5	8	299	24	constant	synth	1
62	1	61	1	300	1000	0.5	8	299	25	constant	synth	1
63	1	62	1	300	1000	0.5	8	299	23	constant	synth	1
64	1	63	1	300	1000	0.5	8	299	25	constant	synth	1
65	1	64	1	300	1000	0.5	8	299	28	constant	synth	1
66	1	65	1	300	1000	0.5	8	299	41	constant	synth	1
67	1	66	1	300	1000	0.5	8	299	27	constant	synth	1
68	1	67	1	300	1000	0.5	8	299	27	constant	synth	1
69	1	68	1	300	1000	0.5	8	299	33	constant	synth	1
70	1	69	1	300	1000	0.5	8	299	22	constant	synth	1
71	1	70	1	300	1000	0.5	8	274	10	constant	synth	1
72	1	71	1	300	1000	0.5	8	274	16	constant	synth	1
73	1	72	1	300	1000	0.5	8	274	4	constant	synth	1
74	1	73	2	300	1000	0.5	8	274	1	constant	synth	1
75	1	74	1	300	1000	0.5	8	274	14	constant	synth	1
76	1	75	1	300	1000	0.5	8	274	16	constant	synth	1
77	1	76	1	300	1000	0.5	8	274	8	constant	synth	1
78	1	77	1	300	1000	0.5	8	274	4	constant	synth	1
79	1	78	1	300	1000	0.5	8	274	3	constant	synth	1
80	1	79	1	300	1000	0.5	8	274	5	constant	synth	1
81	1	80	1	300	1000	0.5	8	249	16	constant	synth	1
82	1	81	1	300	1000	0.5	8	249	18	constant	synth	1
83	1	82	1	300	1000	0.5	8	249	15	constant	synth	1
84	1	83	1	300	1000	0.5	8	249	20	constant	synth	1
85	1	84	1	300	1000	0.5	8	249	16	constant	synth	1
86	1	85	1	300	1000	0.5	8	249	12	constant	synth	1
87	1	86	1	300	1000	0.5	8	249	21	constant	synth	1
88	1	87	1	300	1000	0.5	8	249	18	constant	synth	1
89	1	88	1	300	1000	0.5	8	249	20	constant	synth	1
90	1	89	1	300	1000	0.5	8	249	10	constant	synth	1
91	1	90	1	300	1000	0.5	8	199	21	constant	synth	1
92	1	91	1	300	1000	0.5	8	199	34	constant	synth	1
93	1	92	1	300	1000	0.5	8	199	65	constant	synth	1
94	1	93	1	300	1000	0.5	8	199	25	constant	synth	1
95	1	94	1	300	1000	0.5	8	199	38	constant	synth	1
96	1	95	1	300	1000	0.5	8	199	13	constant	synth	1
97	1	96	1	300	1000	0.5	8	199	14	constant	synth	1
98	1	97	1	300	1000	0.5	8	199	16	constant	synth	1
99	1	98	1	300	1000	0.5	8	199	19	constant	synth	1
100	1	99	1	300	1000	0.5	8	199	21	constant	synth	1
101	1	100	1	300	1000	0.5	8	99	30	constant	synth	1
102	1	101	1	300	1000	0.5	8	99	27	constant	synth	1
103	1	102	1	300	1000	0.5	8	99	34	constant	synth	1
104	1	103	1	300	1000	0.5	8	99	20	constant	synth	1
105	1	104	1	300	1000	0.5	8	99	36	constant	synth	1
106	1	105	1	300	1000	0.5	8	99	20	constant	synth	1
107	1	106	1	300	1000	0.5	8	99	25	constant	synth	1
108	1	107	1	300	1000	0.5	8	99	27	constant	synth	1
109	1	108	1	300	1000	0.5	8	99	25	constant	synth	1
110	1	109	1	300	1000	0.5	8	99	26	constant	synth	1
111	1	110	1	300	1000	0.5	8	49	15	constant	synth	1
112	1	111	1	300	1000	0.5	8	49	7	constant	synth	1
113	1	112	1	300	1000	0.5	8	49	14	constant	synth	1
114	1	113	1	300	1000	0.5	8	49	15	constant	synth	1
115	1	114	1	300	1000	0.5	8	49	13	constant	synth	1
116	1	115	1	300	1000	0.5	8	49	17	constant	synth	1
117	1	116	1	300	1000	0.5	8	49	15	constant	synth	1
118	1	117	1	300	1000	0.5	8	49	10	constant	synth	1
119	1	118	1	300	1000	0.5	8	49	14	constant	synth	1
120	1	119	1	300	1000	0.5	8	49	14	constant	synth	1
121	2	120	1	300	1000	1	8	299	14	constant	synth	1
122	2	121	1	300	1000	1	8	299	11	constant	synth	1
123	2	122	1	300	1000	1	8	299	21	constant	synth	1
124	2	123	1	300	1000	1	8	299	2	constant	synth	1
125	2	124	1	300	1000	1	8	299	14	constant	synth	1
126	2	125	1	300	1000	1	8	299	16	constant	synth	1
127	2	126	1	300	1000	1	8	299	34	constant	synth	1
128	2	127	1	300	1000	1	8	299	18	constant	synth	1
129	2	128	1	300	1000	1	8	299	12	constant	synth	1
130	2	129	1	300	1000	1	8	299	14	constant	synth	1
131	2	130	1	300	1000	1	8	274	25	constant	synth	1
132	2	131	1	300	1000	1	8	274	27	constant	synth	1
133	2	132	1	300	1000	1	8	274	29	constant	synth	1
134	2	133	1	300	1000	1	8	274	21	constant	synth	1
135	2	134	1	300	1000	1	8	274	50	constant	synth	1
136	2	135	1	300	1000	1	8	274	42	constant	synth	1
137	2	136	1	300	1000	1	8	274	18	constant	synth	1
138	2	137	1	300	1000	1	8	274	20	constant	synth	1
139	2	138	1	300	1000	1	8	274	27	constant	synth	1
140	2	139	1	300	1000	1	8	274	19	constant	synth	1
141	2	140	1	300	1000	1	8	249	39	constant	synth	1
142	2	141	1	300	1000	1	8	249	26	constant	synth	1
143	2	142	1	300	1000	1	8	249	22	constant	synth	1
144	2	143	1	300	1000	1	8	249	24	constant	synth	1
145	2	144	1	300	1000	1	8	249	25	constant	synth	1
146	2	145	1	300	1000	1	8	249	134	constant	synth	1
147	2	146	1	300	1000	1	8	249	42	constant	synth	1
148	2	147	1	300	1000	1	8	249	25	constant	synth	1
149	2	148	1	300	1000	1	8	249	134	constant	synth	1
150	2	149	1	300	1000	1	8	249	26	constant	synth	1
151	2	150	1	300	1000	1	8	199	72	constant	synth	1
152	2	151	1	300	1000	1	8	199	52	constant	synth	1
153	2	152	1	300	1000	1	8	199	49	constant	synth	1
154	2	153	1	300	1000	1	8	199	60	constant	synth	1
155	2	154	1	300	1000	1	8	199	54	constant	synth	1
156	2	155	1	300	1000	1	8	199	46	constant	synth	1
157	2	156	1	300	1000	1	8	199	63	constant	synth	1
158	2	157	1	300	1000	1	8	199	50	constant	synth	1
159	2	158	1	300	1000	1	8	199	43	constant	synth	1
160	2	159	1	300	1000	1	8	199	63	constant	synth	1
161	2	160	1	300	1000	1	8	99	13	constant	synth	1
162	2	161	1	300	1000	1	8	99	18	constant	synth	1
163	2	162	1	300	1000	1	8	99	16	constant	synth	1
164	2	163	1	300	1000	1	8	99	30	constant	synth	1
165	2	164	1	300	1000	1	8	99	30	constant	synth	1
166	2	165	1	300	1000	1	8	99	14	constant	synth	1
167	2	166	1	300	1000	1	8	99	11	constant	synth	1
168	2	167	1	300	1000	1	8	99	12	constant	synth	1
169	2	168	1	300	1000	1	8	99	17	constant	synth	1
170	2	169	1	300	1000	1	8	99	16	constant	synth	1
171	2	170	1	300	1000	1	8	49	30	constant	synth	1
172	2	171	1	300	1000	1	8	49	21	constant	synth	1
173	2	172	1	300	1000	1	8	49	38	constant	synth	1
174	2	173	1	300	1000	1	8	49	28	constant	synth	1
175	2	174	1	300	1000	1	8	49	29	constant	synth	1
176	2	175	1	300	1000	1	8	49	25	constant	synth	1
177	2	176	1	300	1000	1	8	49	28	constant	synth	1
178	2	177	1	300	1000	1	8	49	28	constant	synth	1
179	2	178	1	300	1000	1	8	49	25	constant	synth	1
180	2	179	1	300	1000	1	8	49	37	constant	synth	1
181	3	180	3	300	1000	3	8	299	77	constant	synth	1
182	3	181	3	300	1000	3	8	299	12	constant	synth	1
183	3	182	2	300	1000	3	8	299	9	constant	synth	1
184	3	183	4	300	1000	3	8	299	1	constant	synth	1
185	3	184	1	300	1000	3	8	299	137	constant	synth	1
186	3	185	2	300	1000	3	8	299	12	constant	synth	1
187	3	186	3	300	1000	3	8	299	23	constant	synth	1
188	3	187	1	300	1000	3	8	299	39	constant	synth	1
189	3	188	2	300	1000	3	8	299	4	constant	synth	1
190	3	189	4	300	1000	3	8	299	29	constant	synth	1
191	3	190	1	300	1000	3	8	274	4	constant	synth	1
192	3	191	1	300	1000	3	8	274	4	constant	synth	1
193	3	192	1	300	1000	3	8	274	4	constant	synth	1
194	3	193	1	300	1000	3	8	274	4	constant	synth	1
195	3	194	1	300	1000	3	8	274	4	constant	synth	1
196	3	195	1	300	1000	3	8	274	25	constant	synth	1
197	3	196	1	300	1000	3	8	274	4	constant	synth	1
198	3	197	1	300	1000	3	8	274	4	constant	synth	1
199	3	198	1	300	1000	3	8	274	6	constant	synth	1
200	3	199	1	300	1000	3	8	274	9	constant	synth	1
201	3	200	3	300	1000	3	8	249	35	constant	synth	1
202	3	201	2	300	1000	3	8	249	2	constant	synth	1
203	3	202	1	300	1000	3	8	249	69	constant	synth	1
204	3	203	1	300	1000	3	8	249	11	constant	synth	1
205	3	204	2	300	1000	3	8	249	9	constant	synth	1
206	3	205	4	300	1000	3	8	249	6	constant	synth	1
207	3	206	2	300	1000	3	8	249	21	constant	synth	1
208	3	207	1	300	1000	3	8	249	92	constant	synth	1
209	3	208	1	300	1000	3	8	249	39	constant	synth	1
210	3	209	4	300	1000	3	8	249	5	constant	synth	1
211	3	210	1	300	1000	3	8	199	97	constant	synth	1
212	3	211	1	300	1000	3	8	199	22	constant	synth	1
213	3	212	2	300	1000	3	8	199	34	constant	synth	1
214	3	213	1	300	1000	3	8	199	37	constant	synth	1
215	3	214	2	300	1000	3	8	199	10	constant	synth	1
216	3	215	3	300	1000	3	8	199	37	constant	synth	1
217	3	216	1	300	1000	3	8	199	11	constant	synth	1
218	3	217	3	300	1000	3	8	199	62	constant	synth	1
219	3	218	1	300	1000	3	8	199	2	constant	synth	1
220	3	219	4	300	1000	3	8	199	5	constant	synth	1
221	3	220	1	300	1000	3	8	99	8	constant	synth	1
222	3	221	1	300	1000	3	8	99	2	constant	synth	1
223	3	222	1	300	1000	3	8	99	4	constant	synth	1
224	3	223	1	300	1000	3	8	99	5	constant	synth	1
225	3	224	2	300	1000	3	8	99	9	constant	synth	1
226	3	225	2	300	1000	3	8	99	8	constant	synth	1
227	3	226	1	300	1000	3	8	99	2	constant	synth	1
228	3	227	1	300	1000	3	8	99	38	constant	synth	1
229	3	228	1	300	1000	3	8	99	22	constant	synth	1
230	3	229	4	300	1000	3	8	99	5	constant	synth	1
231	3	230	1	300	1000	3	8	49	19	constant	synth	1
232	3	231	1	300	1000	3	8	49	33	constant	synth	1
233	3	232	1	300	1000	3	8	49	21	constant	synth	1
234	3	233	1	300	1000	3	8	49	44	constant	synth	1
235	3	234	1	300	1000	3	8	49	24	constant	synth	1
236	3	235	1	300	1000	3	8	49	8	constant	synth	1
237	3	236	1	300	1000	3	8	49	8	constant	synth	1
238	3	237	1	300	1000	3	8	49	27	constant	synth	1
239	3	238	1	300	1000	3	8	49	24	constant	synth	1
240	3	239	1	300	1000	3	8	49	8	constant	synth	1
241	4	240	1	300	1000	5	8	299	160	constant	synth	1
242	4	241	1	300	1000	5	8	299	160	constant	synth	1
243	4	242	1	300	1000	5	8	299	190	constant	synth	1
244	4	243	1	300	1000	5	8	299	160	constant	synth	1
245	4	244	1	300	1000	5	8	299	160	constant	synth	1
246	4	245	1	300	1000	5	8	299	282	constant	synth	1
247	4	246	1	300	1000	5	8	299	160	constant	synth	1
248	4	247	1	300	1000	5	8	299	160	constant	synth	1
249	4	248	1	300	1000	5	8	299	160	constant	synth	1
250	4	249	1	300	1000	5	8	299	205	constant	synth	1
251	4	250	1	300	1000	5	8	274	45	constant	synth	1
252	4	251	1	300	1000	5	8	274	45	constant	synth	1
253	4	252	1	300	1000	5	8	274	45	constant	synth	1
254	4	253	1	300	1000	5	8	274	45	constant	synth	1
255	4	254	1	300	1000	5	8	274	45	constant	synth	1
256	4	255	1	300	1000	5	8	274	45	constant	synth	1
257	4	256	1	300	1000	5	8	274	45	constant	synth	1
258	4	257	1	300	1000	5	8	274	45	constant	synth	1
259	4	258	1	300	1000	5	8	274	45	constant	synth	1
260	4	259	1	300	1000	5	8	274	45	constant	synth	1
261	4	260	1	300	1000	5	8	249	71	constant	synth	1
262	4	261	1	300	1000	5	8	249	71	constant	synth	1
263	4	262	1	300	1000	5	8	249	71	constant	synth	1
264	4	263	1	300	1000	5	8	249	110	constant	synth	1
265	4	264	1	300	1000	5	8	249	71	constant	synth	1
266	4	265	1	300	1000	5	8	249	139	constant	synth	1
267	4	266	1	300	1000	5	8	249	96	constant	synth	1
268	4	267	1	300	1000	5	8	249	139	constant	synth	1
269	4	268	1	300	1000	5	8	249	71	constant	synth	1
270	4	269	1	300	1000	5	8	249	77	constant	synth	1
271	4	270	4	300	1000	5	8	199	43	constant	synth	1
272	4	271	2	300	1000	5	8	199	2	constant	synth	1
273	4	272	1	300	1000	5	8	199	5	constant	synth	1
274	4	273	3	300	1000	5	8	199	2	constant	synth	1
275	4	274	1	300	1000	5	8	199	2	constant	synth	1
276	4	275	5	300	1000	5	8	199	45	constant	synth	1
277	4	276	6	300	1000	5	8	199	2	constant	synth	1
278	4	277	1	300	1000	5	8	199	5	constant	synth	1
279	4	278	2	300	1000	5	8	199	21	constant	synth	1
280	4	279	5	300	1000	5	8	199	5	constant	synth	1
281	4	280	2	300	1000	5	8	99	3	constant	synth	1
282	4	281	4	300	1000	5	8	99	14	constant	synth	1
283	4	282	1	300	1000	5	8	99	19	constant	synth	1
284	4	283	1	300	1000	5	8	99	45	constant	synth	1
285	4	284	1	300	1000	5	8	99	59	constant	synth	1
286	4	285	3	300	1000	5	8	99	25	constant	synth	1
287	4	286	1	300	1000	5	8	99	40	constant	synth	1
288	4	287	1	300	1000	5	8	99	1	constant	synth	1
289	4	288	2	300	1000	5	8	99	25	constant	synth	1
290	4	289	1	300	1000	5	8	99	3	constant	synth	1
291	4	290	1	300	1000	5	8	49	38	constant	synth	1
292	4	291	1	300	1000	5	8	49	5	constant	synth	1
293	4	292	1	300	1000	5	8	49	13	constant	synth	1
294	4	293	1	300	1000	5	8	49	63	constant	synth	1
295	4	294	1	300	1000	5	8	49	25	constant	synth	1
296	4	295	1	300	1000	5	8	49	23	constant	synth	1
297	4	296	1	300	1000	5	8	49	8	constant	synth	1
298	4	297	1	300	1000	5	8	49	12	constant	synth	1
299	4	298	1	300	1000	5	8	49	29	constant	synth	1
2	0	1	1	300	1000	0	8	299	18	constant	synth	1
3	0	2	1	300	1000	0	8	299	25	constant	synth	1
4	0	3	1	300	1000	0	8	299	38	constant	synth	1
5	0	4	1	300	1000	0	8	299	39	constant	synth	1
6	0	5	1	300	1000	0	8	299	27	constant	synth	1
7	0	6	1	300	1000	0	8	299	40	constant	synth	1
8	0	7	1	300	1000	0	8	299	30	constant	synth	1
9	0	8	1	300	1000	0	8	299	22	constant	synth	1
10	0	9	1	300	1000	0	8	299	29	constant	synth	1
11	0	10	1	300	1000	0	8	274	22	constant	synth	1
12	0	11	1	300	1000	0	8	274	30	constant	synth	1
13	0	12	1	300	1000	0	8	274	15	constant	synth	1
14	0	13	1	300	1000	0	8	274	19	constant	synth	1
15	0	14	1	300	1000	0	8	274	20	constant	synth	1
16	0	15	1	300	1000	0	8	274	18	constant	synth	1
17	0	16	1	300	1000	0	8	274	29	constant	synth	1
18	0	17	1	300	1000	0	8	274	29	constant	synth	1
19	0	18	1	300	1000	0	8	274	23	constant	synth	1
300	4	299	1	300	1000	5	8	49	20	constant	synth	1
301	5	300	1	300	1000	0	8	299	37	constant	synth	1
340	5	339	2	300	1000	0	8	199	29	constant	synth	1
341	5	340	1	300	1000	0	8	99	30	constant	synth	1
342	5	341	1	300	1000	0	8	99	23	constant	synth	1
343	5	342	1	300	1000	0	8	99	21	constant	synth	1
344	5	343	1	300	1000	0	8	99	34	constant	synth	1
345	5	344	1	300	1000	0	8	99	23	constant	synth	1
346	5	345	1	300	1000	0	8	99	31	constant	synth	1
347	5	346	1	300	1000	0	8	99	28	constant	synth	1
348	5	347	1	300	1000	0	8	99	19	constant	synth	1
349	5	348	1	300	1000	0	8	99	22	constant	synth	1
350	5	349	1	300	1000	0	8	99	25	constant	synth	1
351	5	350	1	300	1000	0	8	49	23	constant	synth	1
352	5	351	1	300	1000	0	8	49	19	constant	synth	1
353	5	352	1	300	1000	0	8	49	18	constant	synth	1
354	5	353	1	300	1000	0	8	49	24	constant	synth	1
355	5	354	1	300	1000	0	8	49	28	constant	synth	1
356	5	355	1	300	1000	0	8	49	25	constant	synth	1
357	5	356	1	300	1000	0	8	49	23	constant	synth	1
358	5	357	1	300	1000	0	8	49	21	constant	synth	1
359	5	358	1	300	1000	0	8	49	25	constant	synth	1
360	5	359	1	300	1000	0	8	49	19	constant	synth	1
302	5	301	1	300	1000	0	8	299	38	constant	synth	1
303	5	302	1	300	1000	0	8	299	28	constant	synth	1
304	5	303	2	300	1000	0	8	299	24	constant	synth	1
305	5	304	1	300	1000	0	8	299	25	constant	synth	1
306	5	305	1	300	1000	0	8	299	27	constant	synth	1
307	5	306	2	300	1000	0	8	299	34	constant	synth	1
308	5	307	1	300	1000	0	8	299	23	constant	synth	1
309	5	308	1	300	1000	0	8	299	26	constant	synth	1
310	5	309	2	300	1000	0	8	299	28	constant	synth	1
311	5	310	1	300	1000	0	8	274	22	constant	synth	1
312	5	311	1	300	1000	0	8	274	33	constant	synth	1
313	5	312	1	300	1000	0	8	274	24	constant	synth	1
314	5	313	1	300	1000	0	8	274	22	constant	synth	1
315	5	314	1	300	1000	0	8	274	26	constant	synth	1
316	5	315	1	300	1000	0	8	274	23	constant	synth	1
317	5	316	1	300	1000	0	8	274	19	constant	synth	1
318	5	317	1	300	1000	0	8	274	18	constant	synth	1
319	5	318	2	300	1000	0	8	274	25	constant	synth	1
320	5	319	2	300	1000	0	8	274	17	constant	synth	1
321	5	320	1	300	1000	0	8	249	9	constant	synth	1
322	5	321	1	300	1000	0	8	249	30	constant	synth	1
323	5	322	1	300	1000	0	8	249	18	constant	synth	1
324	5	323	1	300	1000	0	8	249	27	constant	synth	1
325	5	324	1	300	1000	0	8	249	19	constant	synth	1
326	5	325	1	300	1000	0	8	249	11	constant	synth	1
327	5	326	1	300	1000	0	8	249	15	constant	synth	1
328	5	327	1	300	1000	0	8	249	21	constant	synth	1
329	5	328	1	300	1000	0	8	249	24	constant	synth	1
330	5	329	1	300	1000	0	8	249	12	constant	synth	1
331	5	330	1	300	1000	0	8	199	18	constant	synth	1
332	5	331	1	300	1000	0	8	199	19	constant	synth	1
333	5	332	1	300	1000	0	8	199	20	constant	synth	1
334	5	333	1	300	1000	0	8	199	39	constant	synth	1
335	5	334	1	300	1000	0	8	199	23	constant	synth	1
336	5	335	1	300	1000	0	8	199	23	constant	synth	1
337	5	336	1	300	1000	0	8	199	18	constant	synth	1
338	5	337	1	300	1000	0	8	199	18	constant	synth	1
339	5	338	1	300	1000	0	8	199	17	constant	synth	1
\.


--
-- Name: configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xlwang
--

SELECT pg_catalog.setval('configs_id_seq', 30, true);


--
-- Data for Name: exps; Type: TABLE DATA; Schema: public; Owner: xlwang
--

COPY exps (exp_id, sid, pid, f_p_rate, max_num_compl, solver, opt_queryslice, opt_attrslice, opt_query_num, opt_attr_num, opt_approx, num_compl, num_fixed_compl, fixed_rate, noise_rate, dirty_query_idx, fixed_query_idx, preproc_time, solver_prep_cons_time, solver_add_cons_time, solver_solve_time, finish_time, avg_num_cons) FROM stdin;
45086	9	548	1	10	cplex	1	1	290	3	2	35	7	1	0.699999988	299	299	0.00472499989	0.000445000012	0.00121100002	0.0918700024	0.186802998	180
45087	9	548	1	15	cplex	1	1	290	3	2	35	7	1	0.466666996	299	299	0.00449200021	0.000554000027	0.00168300001	0.0450760014	0.172683001	270
45088	9	549	1	5	cplex	1	1	290	3	2	6	0	1	0	299	299	0.00401100004	0.000224999996	0.000699000026	0.00570699992	0.156025007	90
45089	9	549	1	10	cplex	1	1	290	3	2	6	0	1	0	299	299	0.004189	0.000266999996	0.000783000025	0.00719100004	0.150849	108
45090	9	549	1	15	cplex	1	1	290	3	2	6	0	1	0	299	299	0.00413999986	0.000255999999	0.000791000028	0.00704800012	0.152251005	108
45091	9	550	1	5	cplex	1	1	292	6	2	25	0	1	0	274	274	0.0426339991	0.0977820009	0.137613997	0.221976995	0.189849004	1325
45092	9	550	1	10	cplex	1	1	282	9	2	25	0	1	0	274	274	0.0147040002	0.142849997	0.205193996	0.247518003	0.198493004	4127
45093	9	550	1	15	cplex	1	1	282	9	2	25	0	1	0	274	274	0.0217240006	0.146346003	0.291624993	0.352741003	0.203637004	6191
45094	9	551	1	5	cplex	1	1	283	9	2	20	0	1	0	274	274	0.0115470001	0.0937720016	0.099345997	0.161192998	0.204542994	1975
45095	9	551	1	10	cplex	1	1	282	9	2	20	0	1	0	274	274	0.0245440006	0.122243002	0.192404002	0.244589001	0.203312993	4127
45096	9	551	1	15	cplex	1	1	282	9	2	20	0	1	0	274	274	0.0199829992	0.238487005	0.287930995	0.36086899	0.230423003	6191
45097	9	552	1	5	cplex	1	1	283	9	2	39	15	1	3	274	274	0.0191539992	0.0490010008	0.097130999	0.200556993	0.19551	1975
45098	9	552	1	10	cplex	1	1	283	9	2	39	0	1	0	274	274	0.0277319998	0.147450998	0.205679998	0.254574001	0.517418981	3951
45099	9	552	1	15	cplex	1	1	283	9	2	39	0	1	0	274	274	0.0290089995	0.174238995	0.30519399	0.378998011	0.454340994	5926
45100	9	553	1	5	cplex	1	1	292	6	2	30	0	1	0	274	274	0.0318089984	0.114908002	0.129603997	0.227971002	0.659085989	1325
45101	9	553	1	10	cplex	1	1	282	9	2	30	0	1	0	274	274	0.0210430007	0.132848993	0.185501993	0.261445999	0.640788972	4127
45102	9	553	1	15	cplex	1	1	282	9	2	30	0	1	0	274	274	0.0248610005	0.284081995	0.282761991	0.357744992	0.650439024	6191
45103	9	554	1	5	cplex	1	1	292	6	2	42	0	1	0	274	274	0.0269600004	0.0681769997	0.129887998	0.226459995	0.651686013	1325
45104	9	554	1	10	cplex	1	1	292	6	2	42	0	1	0	274	274	0.0352270007	0.132482007	0.269930005	0.376044989	0.626640022	2651
45105	9	554	1	15	cplex	1	1	292	6	2	42	0	1	0	274	274	0.0375850014	0.215829	0.409429014	0.514586985	1.13264704	3976
45106	9	555	1	5	cplex	1	1	292	6	2	23	0	1	0	274	274	0.0277120005	0.103634998	0.131089002	0.231841996	0.726818025	1325
45107	9	555	1	10	cplex	1	1	282	9	2	23	0	1	0	274	274	0.0172429997	0.134360999	0.188220993	0.243579999	0.730376005	4127
45108	9	555	1	15	cplex	1	1	282	9	2	23	0	1	0	274	274	0.0200580005	0.130504996	0.285403997	0.36403501	0.719174981	6191
45109	9	556	1	5	cplex	1	1	292	6	2	23	0	1	0	274	274	0.0255089998	0.066223003	0.128166005	0.216625005	0.237662002	1325
45110	9	556	1	10	cplex	1	1	282	9	2	23	0	1	0	274	274	0.0121649997	0.131436005	0.185405999	0.246598005	0.243230999	4127
45111	9	556	1	15	cplex	1	1	282	9	2	23	0	1	0	274	274	0.0290520005	0.149803996	0.282189995	0.354247004	0.243265003	6191
45112	9	557	1	5	cplex	1	1	292	6	2	20	0	1	0	274	274	0.0292419996	0.244158	0.136451006	0.248692006	0.975450993	1325
45113	9	557	1	10	cplex	1	1	282	9	2	20	0	1	0	274	274	0.0256299991	0.0877309963	0.187379003	0.278504997	0.861415982	4127
45114	9	557	1	15	cplex	1	1	282	9	2	20	0	1	0	274	274	0.0288539995	0.152406007	0.28183499	0.356135011	0.903361976	6191
45115	9	558	1	5	cplex	1	1	292	6	2	31	0	1	0	274	274	0.0280280001	0.0654549971	0.130399004	0.243135005	0.522494972	1325
45116	9	558	1	10	cplex	1	1	285	9	2	31	0	1	0	274	274	0.0305749997	0.124467999	0.233138993	0.298299015	0.506056011	3732
45117	9	558	1	15	cplex	1	1	282	9	2	31	0	1	0	274	274	0.0224290006	0.156503007	0.283347011	0.347330987	0.497588009	6191
45118	9	559	1	5	cplex	1	1	292	6	2	23	0	1	0	274	274	0.0597749986	0.0688410029	0.132806003	0.219537005	0.210677996	1325
45119	9	559	1	10	cplex	1	1	282	9	2	23	0	1	0	274	274	0.0633499995	0.0898009986	0.190889999	0.246088997	0.204238996	4127
45120	9	559	1	15	cplex	1	1	282	9	2	23	0	1	0	274	274	0.0199180003	0.18524	0.285122007	0.359216005	0.202839002	6191
45121	9	560	1	5	cplex	1	1	292	8	2	15	407	1	81.4000015	249	255	0.0360619985	0.290648997	0.530036986	0.860745013	0.362015992	2527
45122	9	560	1	10	cplex	1	1	292	9	2	15	0	1	0	249	249	0.0583020002	0.865689993	1.40212798	2.05595398	1.46391296	5720
45123	9	560	1	15	cplex	1	1	292	9	2	15	0	1	0	249	249	0.105936997	0.976988018	2.05736208	3.01589108	0.922351003	8580
45124	9	561	1	5	cplex	1	1	245	11	2	20	0	1	0	249	249	0.00660800003	0.0377280004	0.0847859979	0.174326003	0.871553004	5110
45125	9	561	1	10	cplex	1	1	245	11	2	20	0	1	0	249	249	0.0109710004	0.0791660026	0.176746994	0.332765996	0.900394022	10220
45126	9	561	1	15	cplex	1	1	245	11	2	20	0	1	0	249	249	0.00817800034	0.189453006	0.264284015	0.518067002	0.873883009	15330
45127	9	562	1	5	cplex	1	1	292	9	2	30	0	1	0	249	249	0.0453790016	0.345508009	0.719633996	1.23348796	0.606700003	2860
45128	9	562	1	10	cplex	1	1	292	9	2	30	0	1	0	249	249	0.0601469986	0.754453003	1.44507301	2.20171809	0.462848991	5720
45129	9	562	1	15	cplex	1	1	292	9	2	30	0	1	0	249	249	0.0927850008	1.04769504	2.15146899	3.31146598	0.520476997	8580
45130	9	563	1	5	cplex	1	1	292	9	2	25	0	1	0	249	249	0.0423780009	0.401661992	0.710201025	1.04175603	0.225354999	2860
45131	9	563	1	10	cplex	1	1	292	9	2	25	0	1	0	249	249	0.0777800009	0.72804898	1.47579396	1.98332298	0.208439007	5720
45132	9	563	1	15	cplex	1	1	292	9	2	25	0	1	0	249	249	0.0785040036	1.23299205	2.14490199	2.85941505	0.207521006	8580
45133	9	564	1	5	cplex	1	1	292	8	2	16	408	1	81.5999985	249	255	0.0317710005	0.272114009	0.542513013	0.852087975	0.357203007	2527
45134	9	564	1	10	cplex	1	1	292	9	2	16	0	1	0	249	249	0.073187001	0.698617995	1.46775496	1.94313204	0.901978016	5720
45135	9	564	1	15	cplex	1	1	292	9	2	16	0	1	0	249	249	0.102434002	1.04500604	2.11597991	2.81695199	0.925361991	8580
45136	9	565	1	5	cplex	1	1	292	8	2	16	408	1	81.5999985	249	255	0.0303709991	0.247814	0.785218	0.853756011	0.346935987	2527
45137	9	565	1	10	cplex	1	1	292	9	2	16	0	1	0	249	249	0.0985860005	0.634939015	1.47715795	1.89319301	0.918093026	5720
45138	9	565	1	15	cplex	1	1	292	9	2	16	0	1	0	249	249	0.135319993	1.01944101	2.10448289	2.8121841	0.896704018	8580
45139	9	566	1	5	cplex	1	1	292	9	2	22	0	1	0	249	249	0.058143001	0.399645001	0.723680019	1.08138096	0.214929	2860
45140	9	566	1	10	cplex	1	1	292	9	2	22	0	1	0	249	249	0.100004002	0.869305015	1.48118401	1.96258605	0.282029986	5720
45141	9	566	1	15	cplex	1	1	292	9	2	22	0	1	0	249	249	0.119682997	0.98794502	2.18132305	2.93769789	0.222335994	8580
45142	9	567	1	5	cplex	1	1	283	10	2	18	0	1	0	249	249	0.0585439987	0.348499	0.674040973	0.971180975	0.753939986	3438
45143	9	567	1	10	cplex	1	1	283	10	2	18	0	1	0	249	249	0.040022999	0.639769018	1.43876898	1.84279501	0.74693501	6876
45144	9	567	1	15	cplex	1	1	283	10	2	18	0	1	0	249	249	0.0526209995	1.21441996	2.07791996	2.64416599	0.755990982	10314
45145	9	568	1	5	cplex	1	1	292	9	2	31	0	1	0	249	249	0.0536080003	0.384808987	0.733488023	1.02645195	0.648473024	2860
45146	9	568	1	10	cplex	1	1	283	10	2	31	0	1	0	249	249	0.0652329996	0.647020996	1.39681697	1.74890399	0.647997975	6876
45147	9	568	1	15	cplex	1	1	283	10	2	31	0	1	0	249	249	0.110169999	0.931325972	2.03889298	2.62635398	0.684522986	10314
45148	9	569	1	5	cplex	1	1	292	9	2	19	0	1	0	249	249	0.0481700003	0.370112002	0.720773995	1.215312	0.886209011	2860
45149	9	569	1	10	cplex	1	1	292	9	2	19	0	1	0	249	249	0.074891001	0.675584972	1.44847906	2.199121	0.899165988	5720
45150	9	569	1	15	cplex	1	1	292	9	2	19	0	1	0	249	249	0.103486001	1.00078702	2.16411495	3.21338391	0.90468502	8580
45151	9	570	1	5	cplex	1	1	285	10	2	16	5	1	1	199	199	0.0790230036	1.46330798	3.04068804	3.73293805	0.226223007	5888
45152	9	570	1	10	cplex	1	1	285	10	2	16	1	1	0.100000001	199	199	0.098511003	2.7737329	6.00201321	7.28635979	0.815403998	11776
45153	9	570	1	15	cplex	1	1	249	11	2	16	0	1	0	199	199	0.0926849991	3.34758997	6.40005302	8.70327759	0.94067502	22122
45154	9	571	1	5	cplex	1	1	283	10	2	12	1	1	0.200000003	199	199	0.110609002	1.48026597	3.03147101	5.18967819	1.52467203	5995
45155	9	571	1	10	cplex	1	1	245	11	2	12	0	1	0	199	199	0.085729003	1.95818198	4.21019793	5.69107914	0.831333995	15293
45156	9	571	1	15	cplex	1	1	245	11	2	12	0	1	0	199	199	0.0615979992	2.6190021	4.93100786	6.77631521	0.837879002	18352
45157	9	572	1	5	cplex	1	1	245	11	2	11	1	1	0.200000003	199	199	0.0639759973	1.00910902	2.05963898	3.57059598	0.857948005	7646
45158	9	572	1	10	cplex	1	1	245	11	2	11	0	1	0	199	199	0.0699400008	1.96184397	4.19772577	6.72987318	0.87983501	15293
45159	9	572	1	15	cplex	1	1	245	11	2	11	0	1	0	199	199	0.0717089996	2.47787309	4.70203114	7.23708296	0.856280982	16823
45160	9	573	1	5	cplex	1	1	292	10	2	14	3	1	0.600000024	199	199	0.129089996	1.50226605	3.10341597	4.72458315	0.177441001	5480
45161	9	573	1	10	cplex	1	1	283	10	2	14	1	1	0.100000001	199	199	0.132942006	2.77363491	6.12091017	9.10749722	0.635950029	11991
45162	9	573	1	15	cplex	1	1	245	11	2	14	0	1	0	199	199	0.0773779973	2.72238708	5.83027077	10.3008261	0.685078025	21411
45163	9	574	1	5	cplex	1	1	249	11	2	6	0	1	0	199	199	0.0682260022	1.02825999	2.20980692	4.4812932	0.913286984	7374
45164	9	574	1	10	cplex	1	1	249	11	2	6	0	1	0	199	199	0.0585060008	1.25894701	2.65640402	5.49638891	0.904160023	8848
45165	9	574	1	15	cplex	1	1	249	11	2	6	0	1	0	199	199	0.0635360032	1.28871596	2.70391607	5.46190977	0.957145989	8848
45166	9	575	1	5	cplex	1	1	292	10	2	12	1	1	0.200000003	199	199	0.127351999	1.69025695	3.10870004	4.73801517	0.173724994	5480
45167	9	575	1	10	cplex	1	1	292	10	2	12	1	1	0.100000001	199	199	0.152944997	2.83708405	6.329669	9.3773613	0.194689006	10961
45168	9	575	1	15	cplex	1	1	249	11	2	12	0	1	0	199	199	0.0811680034	2.54860997	5.48554993	8.46061993	0.168822005	17697
45169	9	576	1	5	cplex	1	1	292	10	2	31	1	1	0.200000003	199	199	0.104222998	1.52811396	3.13266611	5.22083807	0.224777997	5480
45170	9	576	1	10	cplex	1	1	249	11	2	31	0	1	0	199	199	0.0677269995	2.069309	4.53593016	7.8166399	0.343327999	14748
45171	9	576	1	15	cplex	1	1	249	11	2	31	0	1	0	199	199	0.0779939964	2.98101997	6.67820406	10.7718668	0.247631997	22122
45172	9	577	1	5	cplex	1	1	290	10	2	9	1	1	0.200000003	199	199	0.107133001	1.50724101	3.24223709	5.07920218	0.962666988	5599
45173	9	577	1	10	cplex	1	1	249	11	2	9	0	1	0	199	199	0.0573230013	1.90153503	3.98958898	7.08916998	0.882524014	13273
45174	9	577	1	15	cplex	1	1	249	11	2	9	0	1	0	199	199	0.0660519972	2.21531105	4.00852823	7.09532213	0.967319012	13273
45175	9	578	1	5	cplex	1	1	245	11	2	13	1	1	0.200000003	199	199	0.05009	0.992872	2.18642807	3.32207203	0.178902	7646
45176	9	578	1	10	cplex	1	1	245	11	2	13	0	1	0	199	199	0.0566119999	2.06090999	4.37374306	6.51492596	0.185975	15293
45177	9	578	1	15	cplex	1	1	245	11	2	13	0	1	0	199	199	0.0775749981	2.54156399	5.61305189	8.6424551	0.277224988	19882
45178	9	579	1	5	cplex	1	1	245	11	2	31	1	1	0.200000003	199	199	0.0648960024	1.32698095	2.14128304	3.39383006	0.758786023	7646
45179	9	579	1	10	cplex	1	1	245	11	2	31	0	1	0	199	199	0.0687080026	1.974424	4.20964384	6.21168709	0.845375001	15293
45180	9	579	1	15	cplex	1	1	245	11	2	31	0	1	0	199	199	0.105971001	3.0953269	6.22314978	9.87289238	0.757476985	22940
45181	9	580	1	5	cplex	1	1	283	10	2	14	0	1	0	99	99	0.167107001	5.47035503	12.0441628	19.3257484	0.368203998	11030
45182	9	580	1	10	cplex	1	1	283	10	2	14	0	1	0	99	99	0.273102999	10.268096	24.4741249	39.6811943	0.281475008	22061
45183	9	580	1	15	cplex	1	1	283	10	2	14	0	1	0	99	99	0.326065004	15.2338762	33.7909737	58.4935684	0.292562991	30885
45184	9	581	1	5	cplex	1	1	291	10	2	13	0	1	0	99	99	0.206901997	5.75067616	12.3422298	22.7966957	0.966030002	10602
45185	9	581	1	10	cplex	1	1	290	10	2	13	0	1	0	99	99	0.237767994	11.6172056	24.6201324	46.8426895	0.937807024	21314
45186	9	581	1	15	cplex	1	1	285	10	2	13	0	1	0	99	99	0.243866995	14.2217283	31.2650871	59.3170624	0.938436985	28409
45187	9	582	1	5	cplex	1	1	291	10	2	3	0	1	0	99	99	0.151745006	3.17874098	7.15808582	13.7643433	0.953541994	6361
45188	9	582	1	10	cplex	1	1	291	10	2	3	0	1	0	99	99	0.163392007	3.24166608	7.28966618	13.7877903	0.936338007	6361
45189	9	582	1	15	cplex	1	1	291	10	2	3	0	1	0	99	99	0.201427996	4.02607203	7.67982912	13.8134813	0.901511014	6361
45190	9	583	1	5	cplex	1	1	245	11	2	15	0	1	0	99	99	0.188438997	4.94684887	11.337944	19.6283989	0.236838996	12861
45191	9	583	1	10	cplex	1	1	245	11	2	15	0	1	0	99	99	0.186039999	10.384428	23.4583302	36.5959511	0.182860002	25722
45192	9	583	1	15	cplex	1	1	245	11	2	15	0	1	0	99	99	0.234788001	16.3228264	34.7497139	57.1183662	0.344327986	38584
45193	9	584	1	5	cplex	1	1	291	10	2	13	0	1	0	99	99	0.193560004	6.02657795	12.7563772	19.0565109	0.912513971	10602
45194	9	584	1	10	cplex	1	1	283	10	2	13	0	1	0	99	99	0.246022999	10.5863333	25.5359478	39.3285828	0.929068029	22061
45195	9	584	1	15	cplex	1	1	283	10	2	13	0	1	0	99	99	0.30023399	14.1518183	31.9087887	52.8064842	0.923940003	28679
45196	9	585	1	5	cplex	1	1	291	10	2	11	0	1	0	99	99	0.205287993	5.89461708	12.7400856	19.2254677	0.927200019	10602
45197	9	585	1	10	cplex	1	1	291	10	2	11	0	1	0	99	99	0.251464009	11.8531752	25.6551666	39.7786942	0.976180971	21205
45198	9	585	1	15	cplex	1	1	291	10	2	11	0	1	0	99	99	0.290504009	13.4406967	28.5363674	44.4368057	0.902934015	23326
45199	9	586	1	5	cplex	1	1	290	10	2	37	8	1	1.60000002	99	99	0.226372004	5.79026985	12.7404804	19.2458496	0.282314003	10657
45200	9	586	1	10	cplex	1	1	282	10	2	37	8	1	0.800000012	99	99	0.26690799	11.6174498	25.2630005	39.1917915	0.277049989	22168
45201	9	586	1	15	cplex	1	1	282	10	2	37	8	1	0.533333004	99	99	0.301515013	18.3214302	38.110939	61.4904861	0.266597003	33252
45202	9	587	1	5	cplex	1	1	291	10	2	22	0	1	0	99	99	0.247612	6.03681183	12.9012394	19.2757263	0.409965008	10602
45203	9	587	1	10	cplex	1	1	282	10	2	22	0	1	0	99	99	0.271564007	11.5829849	25.9231205	39.4481163	0.254305005	22168
45204	9	587	1	15	cplex	1	1	282	10	2	22	0	1	0	99	99	0.328334987	17.7014465	37.9205132	62.6091194	0.259528995	33252
45205	9	588	1	5	cplex	1	1	282	10	2	21	0	1	0	99	99	0.184086993	5.67816114	12.6033287	21.6240749	0.420188993	11084
45206	9	588	1	10	cplex	1	1	282	10	2	21	0	1	0	99	99	0.241286993	11.3267908	25.2018127	42.7958908	0.409565985	22168
45207	9	588	1	15	cplex	1	1	282	10	2	21	0	1	0	99	99	0.310508013	17.7670479	38.2997017	62.2349739	0.402819008	33252
45208	9	589	1	5	cplex	1	1	254	10	2	15	0	1	0	99	99	0.188786	5.51619387	12.1843023	18.5812416	1.04277599	12448
45209	9	589	1	10	cplex	1	1	254	10	2	15	0	1	0	99	99	0.219091997	10.3194542	23.8621769	37.0166931	0.91672498	24896
45210	9	589	1	15	cplex	1	1	254	10	2	15	0	1	0	99	99	0.229569003	15.8044844	36.3342171	58.2883415	0.973397017	37344
45211	9	590	1	5	cplex	1	1	245	11	2	34	5	1	1	49	49	0.226083994	8.57698059	19.1274757	49.0524597	1.03024995	15386
45212	9	590	1	10	cplex	1	1	245	11	2	34	5	1	0.5	49	49	0.271856993	16.5542698	37.4854774	108.163467	0.837940991	30773
45213	9	590	1	15	cplex	1	1	245	11	2	34	0	1	0	49	49	0.321530998	25.8732777	57.2738953	103.91938	0.729270995	46159
45214	9	591	1	5	cplex	1	1	245	11	2	34	5	1	1	49	49	0.228561997	9.17283726	19.0532627	49.2760506	0.950399995	15386
45215	9	591	1	10	cplex	1	1	245	11	2	34	5	1	0.5	49	49	0.250313014	17.2429295	38.0925598	113.497566	0.317882001	30773
45061	9	540	1	5	cplex	1	1	290	3	2	22	8	1	1.60000002	299	299	0.031764999	0.014583	0.00624400005	0.0678939968	0.207562998	90
45062	9	540	1	10	cplex	1	1	290	3	2	22	0	1	0	299	299	0.0142109999	0.00335499994	0.00423099985	0.00786999986	0.328640997	180
45063	9	540	1	15	cplex	1	1	290	3	2	22	0	1	0	299	299	0.0127060004	0.00435600011	0.00466400012	0.009265	0.368225992	270
45064	9	541	1	5	cplex	1	1	290	3	2	18	6	1	1.20000005	299	299	0.00513500022	0.001116	0.00145099999	0.00578100001	0.994103014	90
45065	9	541	1	10	cplex	1	1	290	3	2	18	0	1	0	299	299	0.00584900007	0.000984000042	0.00155000004	0.00859299954	0.924412012	180
45066	9	541	1	15	cplex	1	1	290	3	2	18	0	1	0	299	299	0.00622700015	0.00135999999	0.00214300002	0.00908700004	0.980219007	270
45067	9	542	1	5	cplex	1	1	290	3	2	17	1	1	0.200000003	299	299	0.00471200002	0.000671999995	0.000805000018	0.00755700003	0.773166001	90
45068	9	542	1	10	cplex	1	1	290	3	2	17	1	1	0.100000001	299	299	0.00552000012	0.000707000028	0.00134900003	0.00744399987	0.806950986	180
45069	9	542	1	15	cplex	1	1	290	3	2	17	0	1	0	299	299	0.00656699995	0.00103699998	0.00190100004	0.00847500004	0.780117989	270
45070	9	543	1	5	cplex	1	1	290	3	2	18	7	1	1.39999998	299	299	0.00428600004	0.000373999996	0.001101	0.493752003	0.178060994	90
45071	9	543	1	10	cplex	1	1	290	3	2	18	0	1	0	299	299	0.00492399978	0.000605000008	0.00134399999	0.00791900046	0.200705007	180
45072	9	543	1	15	cplex	1	1	290	3	2	18	0	1	0	299	299	0.00589299994	0.000997000025	0.00195800001	0.00775199989	0.177399993	270
45073	9	544	1	5	cplex	1	1	290	3	2	16	1	1	0.200000003	299	299	0.00410299981	0.000342999992	0.000824999996	0.00685600005	0.910183012	90
45074	9	544	1	10	cplex	1	1	290	3	2	16	1	1	0.100000001	299	299	0.005229	0.000699000026	0.00128600001	0.0072300001	0.920154989	180
45075	9	544	1	15	cplex	1	1	290	3	2	16	0	1	0	299	299	0.00639900006	0.000944000029	0.001819	0.00794299971	1.02983499	270
45076	9	545	1	5	cplex	1	1	290	3	2	15	1	1	0.200000003	299	299	0.00411699992	0.000277999992	0.000757000002	0.00679000001	0.188883007	90
45077	9	545	1	10	cplex	1	1	290	3	2	15	0	1	0	299	299	0.00478000008	0.000511999999	0.00128900004	0.0087489998	0.180491	180
45078	9	545	1	15	cplex	1	1	290	3	2	15	0	1	0	299	299	0.00522699999	0.000782000017	0.00184200006	0.00898599997	0.195811003	270
45079	9	546	1	5	cplex	1	1	290	3	2	17	1	1	0.200000003	299	299	0.00410699984	0.000279	0.000791999977	0.00751900021	0.418006986	90
45080	9	546	1	10	cplex	1	1	290	3	2	17	1	1	0.100000001	299	299	0.00589699997	0.000788000005	0.00232500001	0.0101760002	0.437189996	180
45081	9	546	1	15	cplex	1	1	290	3	2	17	0	1	0	299	299	0.00582200009	0.0352099985	0.00251800008	0.00809799973	0.389824003	270
45082	9	547	1	5	cplex	1	1	290	3	2	52	3	1	0.600000024	299	299	0.00398299983	0.000246999989	0.00069700001	0.00783499982	0.449699014	90
45083	9	547	1	10	cplex	1	1	290	3	2	52	3	1	0.300000012	299	299	0.00482300017	0.000415999995	0.00119700003	0.00665799994	0.471388996	180
45084	9	547	1	15	cplex	1	1	290	3	2	52	1	1	0.066666998	299	299	0.005107	0.000610999996	0.00168300001	0.00905899983	0.438216001	270
45085	9	548	1	5	cplex	1	1	290	3	2	35	7	1	1.39999998	299	299	0.00401300006	0.000237	0.000690000015	0.553223014	0.195353001	90
45216	9	591	1	15	cplex	1	1	245	11	2	34	0	1	0	49	49	0.324620992	26.0397587	57.162487	99.22966	0.324497998	46159
45217	9	592	1	5	cplex	1	1	245	11	2	35	31	0	5.19999981	49	49	0.231979996	9.16032314	19.0258293	47.1202354	1.37929702	15386
45218	9	592	1	10	cplex	1	1	245	11	2	35	5	1	0.5	49	49	0.264263004	16.5441227	38.1276436	65.5471878	0.974750996	30773
45219	9	592	1	15	cplex	1	1	245	11	2	35	5	0.93333298	0.266667008	49	49	0.287187994	26.0711212	56.4575691	96.993576	1.26108396	46159
45220	9	593	1	5	cplex	1	1	245	11	2	48	48	0	8.60000038	49		0.244267002	12.5736036	27.2550564	66.8300476	0	17851
45221	9	593	1	10	cplex	1	1	245	11	2	48	48	0	3.79999995	49		0.356445014	24.0833817	55.0703545	150.933914	0	35702
45222	9	593	1	15	cplex	1	1	245	11	2	48	48	0	2.20000005	49		0.402164012	36.2258987	81.2196503	251.046494	0	53553
45223	9	594	1	5	cplex	1	1	245	11	2	38	29	0	4.80000019	49	49	0.224424005	8.15145016	18.7464333	38.8106232	1.44131601	15386
45224	9	594	1	10	cplex	1	1	245	11	2	38	9	0.699999988	0.600000024	49	49	0.257743001	16.9689083	37.8882217	93.6176376	0.964154005	30773
45225	9	594	1	15	cplex	1	1	245	11	2	38	9	0.800000012	0.400000006	49	49	0.307859004	24.4252434	55.9528732	148.785919	0.992331982	46159
45226	9	595	1	5	cplex	1	1	245	11	2	37	0	1	0	49	49	0.205154002	9.08785343	18.7620411	40.2662392	1.21082306	15386
45227	9	595	1	10	cplex	1	1	245	11	2	37	0	1	0	49	49	0.250537008	17.0867195	37.9762802	85.8196106	0.687062979	30773
45228	9	595	1	15	cplex	1	1	245	11	2	37	0	1	0	49	49	0.341937989	24.7934399	56.5612717	142.704315	0.699081004	46159
45229	9	596	1	5	cplex	1	1	245	11	2	31	5	1	1	49	49	0.209943995	8.88825035	18.860075	49.3681679	0.879809022	15386
45230	9	596	1	10	cplex	1	1	245	11	2	31	5	1	0.5	49	49	0.246441007	16.921011	38.076046	114.305672	0.886530995	30773
45231	9	596	1	15	cplex	1	1	245	11	2	31	0	1	0	49	49	0.361885995	24.0833244	57.6781082	103.305176	0.860647023	46159
45232	9	597	1	5	cplex	1	1	245	11	2	36	36	0	6.19999981	49		0.287721008	12.2512436	27.5089359	72.3722534	0.000736000016	17851
45233	9	597	1	10	cplex	1	1	245	11	2	36	36	0	2.5999999	49		0.321085989	25.0464191	55.4007378	154.190582	0	35702
45234	9	597	1	15	cplex	1	1	245	11	2	36	36	0	1.39999998	49		0.392111003	36.3893738	82.8612289	254.088272	0	53553
45235	9	598	1	5	cplex	1	1	245	11	2	34	5	1	1	49	49	0.216722995	8.08849812	18.7957878	37.6591988	0.835561991	15386
45236	9	598	1	10	cplex	1	1	245	11	2	34	5	1	0.5	49	49	0.278335989	16.9894886	38.1324043	82.4318085	0.779060006	30773
45237	9	598	1	15	cplex	1	1	245	11	2	34	0	1	0	49	49	0.293621987	25.1122646	57.226078	96.192627	0.801416993	46159
45238	9	599	1	5	cplex	1	1	245	11	2	48	48	0	8.60000038	49		0.335051	12.2877817	28.4633389	69.3384857	0	17851
45239	9	599	1	10	cplex	1	1	245	11	2	48	48	0	3.79999995	49		0.338454992	24.0737419	56.7739143	153.464325	0	35702
45240	9	599	1	15	cplex	1	1	245	11	2	48	48	0	2.20000005	49		0.392479986	37.0082588	84.9261551	252.51532	0	53553
50011	13	752	1	10000000	cplex	0	1	650	7	0	1	0	1	0	649	649	0.0548360012	0.00174500002	0.00266400003	0.00581699982	0.00225499994	49
50012	13	752	1	10000000	cplex	1	0	650	7	1	1	0	1	0	649	649	0.0557940006	0.00177500001	0.00270600012	0.005963	0.00295799994	49
50013	13	752	1	10000000	cplex	1	1	650	7	2	1	0	1	0	649	649	0.0533530004	0.00176400004	0.00270699989	0.00635700021	0.00229700003	49
50014	13	752	1	10000000	cplex	0	0	650	7	3	1	0	1	0	649	649	0.0510759987	0.00100399996	0.00154700002	0.0052939998	0.00236999989	49
50015	13	752	1	10000000	cplex	1	1	650	1	4	1	0	1	0	649	649	0.0499969982	0.00219599996	0.00263400003	0.0340979993	0.00243599992	8
50016	13	753	1	10000000	cplex	0	1	650	7	0	1	0	1	0	649	649	0.0552119985	0.000972000009	0.00149199995	0.00622100011	0.00218600011	49
50017	13	753	1	10000000	cplex	1	0	650	7	1	1	0	1	0	649	649	0.052765999	0.000973000017	0.001483	0.00558899995	0.00215899991	49
50018	13	753	1	10000000	cplex	1	1	650	7	2	1	0	1	0	649	649	0.0511449985	0.000937999983	0.001468	0.00553900003	0.00230800011	49
50019	13	753	1	10000000	cplex	0	0	650	7	3	1	0	1	0	649	649	0.0523829982	0.000960999983	0.00148199999	0.00561799994	0.00251300004	49
50020	13	753	1	10000000	cplex	1	1	650	1	4	1	0	1	0	649	649	0.0514720008	0.00251000002	0.00311299996	0.0435459986	0.00317099993	8
50021	13	754	1	10000000	cplex	0	1	650	7	0	1	0	1	0	649	649	0.054423999	0.00178000005	0.0027999999	0.0044900002	0.00218000007	49
50022	13	754	1	10000000	cplex	1	0	650	7	1	1	0	1	0	649	649	0.0556129999	0.00186299998	0.00267200009	0.00438199984	0.00222199992	49
50023	13	754	1	10000000	cplex	1	1	650	7	2	1	0	1	0	649	649	0.0516120009	0.00176799996	0.00268999999	0.00674400013	0.00300200004	49
50024	13	754	1	10000000	cplex	0	0	650	7	3	1	0	1	0	649	649	0.0569990017	0.00175599998	0.00248100003	0.00648600003	0.00197899994	49
50025	13	754	1	10000000	cplex	1	1	650	1	4	1	0	1	0	649	649	0.0546509996	0.00238600001	0.0025510001	0.032536	0.00205600006	8
50026	13	765	1	10000000	cplex	0	1	650	7	0	2	0	1	0	549	549	2.16891599	0.270496011	0.27777499	0.306098998	0.00226600002	714
50027	13	765	1	10000000	cplex	1	0	650	7	1	2	0	1	0	549	549	2.2567811	0.156138003	0.177854002	0.286552995	0.00173999998	714
50028	13	765	1	10000000	cplex	1	1	650	7	2	2	0	1	0	549	549	2.19955111	0.151951998	0.171149999	0.303676009	0.00281600002	714
50029	13	765	1	10000000	cplex	0	0	650	7	3	2	0	1	0	549	549	2.15941691	0.123382002	0.185386002	0.287239999	0.00211400003	714
50030	13	765	1	10000000	cplex	1	1	650	1	4	2	0	1	0	549	549	2.15276909	0.0531789996	0.0504669994	0.390859991	0.00186700001	92
50001	13	750	1	10000000	cplex	0	1	650	7	0	1	0	1	0	649	649	0.0696400031	0.132982999	0.00499300007	0.00766000012	0.00868800003	49
50002	13	750	1	10000000	cplex	1	0	650	7	1	1	0	1	0	649	649	0.0533489995	0.00169499998	0.00159500004	0.00575000001	0.00309500005	49
50003	13	750	1	10000000	cplex	1	1	650	7	2	1	0	1	0	649	649	0.0595999993	0.00242200005	0.001697	0.00541200023	0.00292000012	49
50004	13	750	1	10000000	cplex	0	0	650	7	3	1	0	1	0	649	649	0.0585809983	0.00246199989	0.00279000006	0.0048580002	0.00358800008	49
50005	13	750	1	10000000	cplex	1	1	650	1	4	1	0	1	0	649	649	0.0549160019	0.00222399994	0.0026740001	0.0304489993	0.00241700001	8
50006	13	751	1	10000000	cplex	0	1	650	7	0	1	0	1	0	649	649	0.0575219989	0.00173400005	0.00259699998	0.00610599993	0.00321	49
50007	13	751	1	10000000	cplex	1	0	650	7	1	1	0	1	0	649	649	0.0547490008	0.00173599995	0.0026779999	0.0061329999	0.00199300004	49
50008	13	751	1	10000000	cplex	1	1	650	7	2	1	0	1	0	649	649	0.0552540012	0.00153500005	0.00260100001	0.00576000009	0.00228699995	49
50009	13	751	1	10000000	cplex	0	0	650	7	3	1	0	1	0	649	649	0.0553219989	0.00169199996	0.00271699997	0.00592500018	0.00171500002	49
50010	13	751	1	10000000	cplex	1	1	650	1	4	1	0	1	0	649	649	0.0551679991	0.00283999997	0.00355000002	0.0335789993	0.00180600001	8
50031	13	766	1	10000000	cplex	0	1	650	7	0	2	0	1	0	549	549	2.04863095	0.124747999	0.145262003	0.312260002	0.00215899991	714
50032	13	766	1	10000000	cplex	1	0	650	7	1	2	0	1	0	549	549	2.08001208	0.108934	0.153414994	0.320219994	0.00202000001	714
50033	13	766	1	10000000	cplex	1	1	650	7	2	2	0	1	0	549	549	2.13657308	0.119599998	0.152958006	0.334152997	0.0021889999	714
50034	13	766	1	10000000	cplex	0	0	650	7	3	2	0	1	0	549	549	2.12563705	0.108863004	0.150013998	0.306827009	0.00360399997	714
50035	13	766	1	10000000	cplex	1	1	650	1	4	2	0	1	0	549	549	2.12541795	0.0362159982	0.0507409982	0.402538002	0.00189199997	92
50036	13	767	1	10000000	cplex	0	1	650	7	0	2	0	1	0	549	549	2.07742095	0.107648	0.238599002	0.319256991	0.00183800003	714
50037	13	767	1	10000000	cplex	1	0	650	7	1	2	0	1	0	549	549	2.13499093	0.127728	0.152297005	0.327169001	0.00211700005	714
50038	13	767	1	10000000	cplex	1	1	650	7	2	2	0	1	0	549	549	2.14438391	0.128050998	0.166266993	0.330103993	0.0022499999	714
50039	13	767	1	10000000	cplex	0	0	650	7	3	2	0	1	0	549	549	2.11855507	0.110279001	0.153064996	0.323536992	0.00189700001	714
50040	13	767	1	10000000	cplex	1	1	650	1	4	2	0	1	0	549	549	2.10535407	0.040713001	0.0534290001	0.401455998	0.00205900008	92
50041	13	768	1	10000000	cplex	0	1	650	7	0	2	0	1	0	549	549	2.10921693	0.128144994	0.158069998	0.322434008	0.00215699989	714
50042	13	768	1	10000000	cplex	1	0	650	7	1	2	0	1	0	549	549	2.05266094	0.128799006	0.165975004	0.336786985	0.00175299996	714
50043	13	768	1	10000000	cplex	1	1	650	7	2	2	0	1	0	549	549	2.07603002	0.127177	0.160921007	0.342887998	0.00208100001	714
50044	13	768	1	10000000	cplex	0	0	650	7	3	2	0	1	0	549	549	2.08588791	0.165622994	0.156435996	0.340360999	0.00204599998	714
50045	13	768	1	10000000	cplex	1	1	650	1	4	2	0	1	0	549	549	2.09705806	0.0379830003	0.0507550016	0.394899994	0.0019700001	92
50046	13	769	1	10000000	cplex	0	1	650	7	0	2	0	1	0	549	549	2.07718801	0.11479	0.145642996	0.299632013	0.00209499989	714
50047	13	769	1	10000000	cplex	1	0	650	7	1	2	0	1	0	549	549	2.05353689	0.103385001	0.142839	0.294164002	0.0019749999	714
50048	13	769	1	10000000	cplex	1	1	650	7	2	2	0	1	0	549	549	2.11673808	0.117888004	0.144530997	0.288753003	0.002201	714
50049	13	769	1	10000000	cplex	0	0	650	7	3	2	0	1	0	549	549	2.09646511	0.113952003	0.158329993	0.295197994	0.00215100008	714
50050	13	769	1	10000000	cplex	1	1	650	1	4	2	0	1	0	549	549	2.10548997	0.0403769985	0.0526770018	0.378347993	0.00212899991	92
50051	13	770	1	10000000	cplex	0	1	650	7	0	1	0	1	0	449	646	0.0518789999	0.000226999997	0.000492000021	0.00537300017	0.00216299994	49
50052	13	770	1	10000000	cplex	1	0	650	7	1	1	0	1	0	449	646	0.0506770015	0.000186999998	0.000486000004	0.00586599996	0.00216999999	49
50053	13	770	1	10000000	cplex	1	1	650	7	2	1	0	1	0	449	646	0.0531550013	0.000186000005	0.000547999982	0.00568199996	0.00184799999	49
50054	13	770	1	10000000	cplex	0	0	650	7	3	1	0	1	0	449	646	0.0518480018	0.000207000005	0.000506000011	0.00550199999	0.0021540001	49
50055	13	770	1	10000000	cplex	1	1	650	1	4	1	0	1	0	449	646	0.0506779999	0.000908999995	0.000967000029	0.0343579985	0.00185300002	8
50056	13	771	1	10000000	cplex	0	1	650	7	0	1	0	1	0	449	646	0.0511129983	0.000188000005	0.000508999976	0.00498900004	0.00186600001	49
50057	13	771	1	10000000	cplex	1	0	650	7	1	1	0	1	0	449	646	0.0516709983	0.000188999998	0.000482000003	0.00461600022	0.00185899995	49
50058	13	771	1	10000000	cplex	1	1	650	7	2	1	0	1	0	449	646	0.0516530015	0.000205000004	0.000495999993	0.00404800009	0.002079	49
50059	13	771	1	10000000	cplex	0	0	650	7	3	1	0	1	0	449	646	0.0517180003	0.000213000007	0.000497000001	0.00531300018	0.00195299997	49
50060	13	771	1	10000000	cplex	1	1	650	1	4	1	0	1	0	449	646	0.0532290004	0.00124300004	0.00135799998	0.0372119993	0.00210899999	8
50061	13	772	1	10000000	cplex	0	1	650	7	0	1	0	1	0	449	646	0.0520370007	0.000203999996	0.000513000006	0.00552800018	0.00285200006	49
50062	13	772	1	10000000	cplex	1	0	650	7	1	1	0	1	0	449	646	0.0512260012	0.000193999993	0.000509999983	0.00546499994	0.001789	49
50063	13	772	1	10000000	cplex	1	1	650	7	2	1	0	1	0	449	646	0.0511699989	0.000188000005	0.000518999994	0.00543999998	0.00178799999	49
50064	13	772	1	10000000	cplex	0	0	650	7	3	1	0	1	0	449	646	0.0513029993	0.000207999998	0.000523000024	0.00525900023	0.00209400011	49
50065	13	772	1	10000000	cplex	1	1	650	1	4	1	0	1	0	449	646	0.0511719994	0.000875999976	0.00101799995	0.0343719982	0.00172399997	8
50066	13	773	1	10000000	cplex	0	1	650	7	0	1	0	1	0	449	646	0.0512209982	0.000207999998	0.000490000006	0.00570200011	0.00229800004	49
50067	13	773	1	10000000	cplex	1	0	650	7	1	1	0	1	0	449	646	0.0502839983	0.000190999999	0.000523000024	0.00587699981	0.00169599999	49
50068	13	773	1	10000000	cplex	1	1	650	7	2	1	0	1	0	449	646	0.0501369983	0.000188999998	0.000526999997	0.00558200013	0.00167300005	49
50069	13	773	1	10000000	cplex	0	0	650	7	3	1	0	1	0	449	646	0.0502099991	0.000188999998	0.000515000022	0.00544299977	0.00168900006	49
50070	13	773	1	10000000	cplex	1	1	650	1	4	1	0	1	0	449	646	0.050280001	0.000977999996	0.00108700001	0.036022	0.00220900006	8
50071	13	774	1	10000000	cplex	0	1	650	7	0	1	0	1	0	449	646	0.0526980013	0.000460999989	0.000881000014	0.00625800015	0.00428099977	49
50072	13	774	1	10000000	cplex	1	0	650	7	1	1	0	1	0	449	646	0.0529490001	0.000499000016	0.000991999987	0.0065779998	0.00347399991	49
50073	13	774	1	10000000	cplex	1	1	650	7	2	1	0	1	0	449	646	0.0516449995	0.000188999998	0.000554000027	0.00614099996	0.00179400004	49
50074	13	774	1	10000000	cplex	0	0	650	7	3	1	0	1	0	449	646	0.0521580018	0.000214	0.000551000005	0.00649099983	0.00203699991	49
50075	13	774	1	10000000	cplex	1	1	650	1	4	1	0	1	0	449	646	0.0536409989	0.00110200001	0.00121799996	0.0414480008	0.00239100005	8
55001	12	720	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	999	999	0.0162930004	0.0130939996	0.00413900008	0.00751999998	0.00246499991	64
55002	12	720	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	999	999	0.00361300004	0.00214900007	0.00158499996	0.00490699988	0.00240599993	64
55003	12	720	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	999	999	0.00226800004	0.00167300005	0.001544	0.004617	0.00223600003	64
55004	12	720	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	999	999	0.00159300002	0.00125500001	0.00155399996	0.00532800006	0.00229700003	64
55005	12	720	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	999	999	0.00149599998	0.0024290001	0.00212999992	0.0279879998	0.00233800011	10
55006	12	721	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	999	999	0.00160700001	0.00117099995	0.00153799995	0.00663200021	0.00219499995	64
55007	12	721	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	999	999	0.00128600001	0.00117599999	0.00187599997	0.00580399996	0.00201699999	64
55008	12	721	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	999	999	0.00122800004	0.00121100002	0.00158599997	0.00540200016	0.00199500006	64
55009	12	721	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	999	999	0.00145099999	0.00118999998	0.001575	0.00541399978	0.00171800004	64
55010	12	721	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	999	999	0.00121300004	0.00223099999	0.00191700005	0.0250550006	0.00164699997	10
55011	12	722	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	999	999	0.00120299996	0.00120199996	0.00160399999	0.00549500016	0.00200299989	64
55012	12	722	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	999	999	0.00124400004	0.00124400004	0.00161200005	0.00609900011	0.00202000001	64
55013	12	722	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	999	999	0.00122500001	0.00121300004	0.00159400003	0.00606899988	0.00202300004	64
55014	12	722	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	999	999	0.00125500001	0.00124799996	0.00162800006	0.00599100022	0.0020659999	64
55015	12	722	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	999	999	0.00137900002	0.00225599995	0.00213199994	0.0289890002	0.001911	10
55016	12	723	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	999	999	0.00127300003	0.00123699999	0.00154299999	0.00689599989	0.00185100001	64
55017	12	723	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	999	999	0.00121799996	0.00120599999	0.00159200002	0.00558099989	0.00156	64
55018	12	723	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	999	999	0.00117599999	0.00119900005	0.00152299996	0.00542799989	0.00162300002	64
55019	12	723	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	999	999	0.00128700002	0.00120199996	0.00154600001	0.00679099979	0.00176500005	64
55020	12	723	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	999	999	0.00188200001	0.00237099989	0.00205800007	0.0287369993	0.00153899996	10
55046	12	729	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	974	974	0.00120299996	0.000830999983	0.00104899995	0.00620000018	0.00173799996	44
55047	12	729	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	974	974	0.00112300005	0.000957000011	0.00130700006	0.00642600004	0.00169099995	62
55048	12	729	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	974	974	0.001192	0.000849000004	0.00105700002	0.00748400018	0.00262099993	44
55049	12	729	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	974	974	0.00112699997	0.000957000011	0.001269	0.00511999987	0.00164499995	62
55050	12	729	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	974	974	0.00121699995	0.00163399999	0.00173999998	0.0213120002	0.00163499999	14
55051	12	730	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	949	949	0.00115499995	0.00109899999	0.00118000002	0.00530399987	0.00190599996	64
55052	12	730	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	949	949	0.001208	0.00109799998	0.001269	0.00506500015	0.00166800001	64
55053	12	730	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	949	949	0.00157099997	0.00109200005	0.00122800004	0.00508800009	0.00197299989	64
55054	12	730	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	949	949	0.001223	0.00109000003	0.00129100005	0.00469399989	0.00165200001	64
55055	12	730	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	949	949	0.00149499997	0.00227200007	0.001728	0.0270649996	0.00221699988	10
55056	12	731	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	949	949	0.00128299999	0.00107400003	0.00124500005	0.00631000008	0.00193899998	64
55057	12	731	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	949	949	0.00116700004	0.00104200002	0.00119500002	0.00545000006	0.00164399995	64
55058	12	731	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	949	949	0.001406	0.00104300003	0.00120000006	0.00557400007	0.00181199994	64
55059	12	731	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	949	949	0.00153400004	0.00113999995	0.00133100001	0.00510400021	0.00199100003	64
55060	12	731	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	949	949	0.00175699999	0.002049	0.00154800003	0.0268699992	0.001667	10
55061	12	732	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	949	949	0.00124799996	0.000951000024	0.00128900004	0.00476300018	0.001559	64
55062	12	732	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	949	949	0.00111900002	0.000983000034	0.00117900001	0.00555599993	0.001835	64
55063	12	732	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	949	949	0.00138899998	0.000953999988	0.00118799997	0.0064559998	0.00162600004	64
55064	12	732	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	949	949	0.00113700004	0.000976999989	0.00116999994	0.00558000011	0.00179200002	64
55065	12	732	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	949	949	0.00143800001	0.00208700006	0.00171999994	0.0285979994	0.00182799995	10
55066	12	733	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	949	949	0.00135499996	0.000967000029	0.00129000004	0.00560700009	0.00172900001	64
55067	12	733	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	949	949	0.00119500002	0.000967999978	0.00119099999	0.00500900019	0.00202100002	64
55068	12	733	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	949	949	0.00128800003	0.000976999989	0.00116400002	0.00541200023	0.00202000001	64
55069	12	733	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	949	949	0.00132200005	0.000988999964	0.00125199999	0.00578900008	0.00164599996	64
55070	12	733	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	949	949	0.00124300004	0.00201599998	0.00159100001	0.0282070003	0.00202200003	10
55071	12	734	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	949	949	0.00124799996	0.000950000016	0.00114900002	0.00606000004	0.00199700007	64
55072	12	734	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	949	949	0.00169599999	0.000935000018	0.00115300005	0.00477899984	0.00157199998	64
55073	12	734	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	949	949	0.00123699999	0.000959000026	0.00116500002	0.00580199994	0.00259099994	64
55074	12	734	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	949	949	0.00121200003	0.000950000016	0.00115899998	0.00558800017	0.00181799999	64
55075	12	734	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	949	949	0.00138000003	0.00215999992	0.00176999997	0.0259709992	0.00197100011	10
55076	12	735	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	899	899	0.00125800003	0.000755999994	0.001116	0.00635399995	0.00197200011	44
55077	12	735	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	899	899	0.00107799994	0.000824999996	0.001223	0.00639700005	0.00153899996	62
55078	12	735	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	899	899	0.00115000003	0.000700999983	0.00101500005	0.00593299977	0.00256399997	44
55079	12	735	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	899	899	0.00111800001	0.000813000021	0.00120000006	0.00593899982	0.001559	62
55080	12	735	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	899	899	0.00112000003	0.00140499999	0.00168400002	0.0225799996	0.00210499996	14
55081	12	736	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	899	899	0.00115799997	0.000708999985	0.000990999979	0.00672100019	0.00175599998	44
55082	12	736	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	899	899	0.00109300006	0.000826000003	0.00120199996	0.00588000007	0.00195599999	62
55083	12	736	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	899	899	0.00114199996	0.000754999986	0.00100499997	0.00528999977	0.00188500003	44
55084	12	736	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	899	899	0.00112300005	0.000768000027	0.00121999998	0.00608900003	0.00179400004	62
55085	12	736	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	899	899	0.00112200005	0.00152599998	0.00178100006	0.0230299998	0.002355	14
55091	12	737	1	10000000	cplex	0	1	1000	4	0	1	0	1	0	899	899	0.0745709985	0.0134770004	0.00438799988	0.00822199974	0.00237699994	22
55092	12	737	1	10000000	cplex	1	0	1000	7	1	1	0	1	0	899	899	0.060614001	0.00153400004	0.00105800002	0.00520099979	0.00231499993	31
55093	12	737	1	10000000	cplex	1	1	1000	4	2	1	0	1	0	899	899	0.0591510013	0.00105800002	0.000853999984	0.005076	0.00209899992	22
55094	12	737	1	10000000	cplex	0	0	1000	7	3	1	0	1	0	899	899	0.0577539988	0.000700999983	0.00100100006	0.00499900011	0.00199400005	31
55095	12	737	1	10000000	cplex	1	1	1000	1	4	1	0	1	0	899	899	0.058681	0.00131199998	0.00162	0.0209909994	0.0022760001	7
55096	12	738	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	899	899	0.0586559996	0.000951000024	0.00128700002	0.00584700005	0.00279400009	44
55097	12	738	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	899	899	0.0586480014	0.00109000003	0.00163800002	0.00372599997	0.00160900003	62
55098	12	738	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	899	899	0.0579710007	0.000896000012	0.00136700005	0.00545499986	0.00163199997	44
55099	12	738	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	899	899	0.0574509986	0.00106699998	0.001666	0.00495600002	0.00178699999	62
55100	12	738	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	899	899	0.0582350008	0.00166199997	0.00227100006	0.0182140004	0.00158200006	14
55101	12	739	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	899	899	0.0609119982	0.00166199997	0.00239700009	0.00758499978	0.00239100005	44
55102	12	739	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	899	899	0.0581610017	0.00165600004	0.00292699994	0.0059059998	0.00159100001	62
55103	12	739	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	899	899	0.0577679984	0.00091599999	0.00132799998	0.00617100019	0.00169499998	44
55104	12	739	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	899	899	0.0590769984	0.00108399999	0.001621	0.00635900022	0.00173400005	62
55105	12	739	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	899	899	0.0576799996	0.0020620001	0.00273999991	0.0246159993	0.00200200011	14
55106	12	740	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	799	799	0.057085	0.001208	0.00152199995	0.00486199977	0.00177600002	64
55107	12	740	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	799	799	0.0580670014	0.00119099999	0.00158799998	0.00432599988	0.001697	64
55108	12	740	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	799	799	0.0570829995	0.00117800001	0.00154800003	0.004739	0.00160900003	64
55109	12	740	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	799	799	0.0571639985	0.00120699999	0.00156700006	0.00538499979	0.001406	64
55110	12	740	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	799	799	0.0615839995	0.00326099992	0.00277999998	0.0298459996	0.002171	10
55111	12	741	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	799	799	0.0574150011	0.00121699995	0.00167799997	0.00444999989	0.00174600002	64
55112	12	741	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	799	799	0.0578689985	0.00125900004	0.00166399998	0.00491400016	0.00217600004	64
55113	12	741	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	799	799	0.0575090013	0.00120000006	0.00151700003	0.00461999979	0.00174800004	64
55114	12	741	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	799	799	0.0587540008	0.00120299996	0.00161499996	0.00463900017	0.0199989993	64
55115	12	741	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	799	799	0.0577870011	0.00233300007	0.00203300011	0.0241700001	0.00165999995	10
55141	12	747	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	749	749	0.0588390008	0.00144499994	0.00179999997	0.007216	0.00151800003	44
55142	12	747	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	749	749	0.0594099984	0.00184200006	0.00216299994	0.00651200023	0.00225699996	62
55143	12	747	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	749	749	0.0573250018	0.000811000005	0.00102700002	0.00502600009	0.00165899994	44
55144	12	747	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	749	749	0.0570320003	0.000922999985	0.00122900004	0.00545000006	0.00148800004	62
55145	12	747	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	749	749	0.0563750006	0.00153400004	0.00175399997	0.0211100001	0.00158899999	14
55146	12	748	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	749	749	0.0570049994	0.00109999999	0.00101699994	0.00620900001	0.00156400003	44
55147	12	748	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	749	749	0.056894999	0.000935000018	0.001208	0.00568700023	0.00153200002	62
55148	12	748	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	749	749	0.0574930012	0.000806999975	0.000991999987	0.00597799988	0.001682	44
55149	12	748	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	749	749	0.0564169995	0.000961999991	0.00129100005	0.006085	0.001636	62
55150	12	748	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	749	749	0.0567310005	0.001529	0.00165300001	0.0207049996	0.00161000004	14
55151	12	749	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	749	749	0.0571079999	0.000826000003	0.00107	0.00613200013	0.00156500004	44
55152	12	749	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	749	749	0.0572419986	0.00102299999	0.00128600001	0.00541999983	0.00152100006	62
55153	12	749	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	749	749	0.0574840009	0.000805000018	0.00103000004	0.00567900017	0.00178699999	44
55154	12	749	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	749	749	0.0562530011	0.00103799999	0.001315	0.00594000006	0.00153100002	62
55155	12	749	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	749	749	0.0569869988	0.00167300005	0.001758	0.0228330009	0.00158100005	14
55021	12	724	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	999	999	0.00132299995	0.001192	0.00162	0.00631099986	0.00181599997	64
55022	12	724	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	999	999	0.00118499994	0.00121100002	0.00165300001	0.00516499998	0.00204099994	64
55023	12	724	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	999	999	0.00129499997	0.00124100002	0.001513	0.00550300023	0.00203200011	64
55024	12	724	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	999	999	0.00117599999	0.00107999996	0.00123399997	0.00451700017	0.00198099995	64
55025	12	724	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	999	999	0.00174400001	0.00233999989	0.001834	0.0278949998	0.00190000003	10
55026	12	725	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	974	974	0.00133899995	0.00575099979	0.00468999986	0.00734800007	0.00189099996	44
55027	12	725	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	974	974	0.00113800005	0.000988999964	0.00124400004	0.00647700019	0.00178499997	62
55028	12	725	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	974	974	0.00115499995	0.000819000008	0.00103499996	0.00600400008	0.00163900002	44
55029	12	725	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	974	974	0.001116	0.000974999974	0.00126799999	0.00567700015	0.00141699996	62
55030	12	725	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	974	974	0.00119099999	0.00167300005	0.00177500001	0.0215189997	0.001712	14
55031	12	726	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	974	974	0.00118799997	0.000829999975	0.00104200002	0.00625000009	0.00164000003	44
55032	12	726	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	974	974	0.00111399998	0.000973000017	0.00125800003	0.00553799979	0.001682	62
55033	12	726	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	974	974	0.00118200004	0.000839999993	0.00101999997	0.00607400015	0.00176100002	44
55034	12	726	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	974	974	0.00110500003	0.00100399996	0.00127699994	0.0053340001	0.00155399996	62
55035	12	726	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	974	974	0.00118499994	0.00170799997	0.00202400004	0.0219139997	0.001835	14
55036	12	727	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	974	974	0.00119900005	0.000841000001	0.00103699998	0.00601800019	0.00184399995	44
55037	12	727	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	974	974	0.00111399998	0.000976999989	0.00125900004	0.00567199988	0.00163199997	62
55038	12	727	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	974	974	0.00117900001	0.000830999983	0.00102800003	0.00594699988	0.00169399998	44
55039	12	727	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	974	974	0.00111399998	0.000995000009	0.00125500001	0.00629899977	0.00160700001	62
55040	12	727	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	974	974	0.00116700004	0.00172399997	0.00181799999	0.022295	0.00185400003	14
55041	12	728	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	974	974	0.00116099999	0.000829000026	0.00104600005	0.00718299998	0.00158899999	44
55042	12	728	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	974	974	0.00110500003	0.00098500005	0.00128299999	0.00551400008	0.00181499997	62
55043	12	728	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	974	974	0.00113900006	0.000838999986	0.00104999996	0.00618299982	0.001819	44
55044	12	728	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	974	974	0.001101	0.00104899995	0.0020920001	0.00710200006	0.0351690017	62
55045	12	728	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	974	974	0.00115599995	0.00198099995	0.00212400011	0.0198459998	0.00170499994	14
55116	12	742	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	799	799	0.0578729995	0.00118499994	0.00145400001	0.005351	0.00172399997	64
55117	12	742	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	799	799	0.0565729998	0.00118100003	0.00135000004	0.0049879998	0.00148900005	64
55118	12	742	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	799	799	0.0583419986	0.00117499998	0.00134700001	0.00550899981	0.00173999998	64
55119	12	742	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	799	799	0.0579579994	0.00118200004	0.00135999999	0.005504	0.00161399995	64
55120	12	742	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	799	799	0.0608800016	0.0215959996	0.00219299993	0.0294259991	0.00167200004	10
55121	12	743	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	799	799	0.0566309988	0.00120499998	0.00150899997	0.00474700006	0.00152499997	64
55122	12	743	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	799	799	0.0568279997	0.00105099997	0.00121899997	0.00459600007	0.00159500004	64
55123	12	743	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	799	799	0.0576590002	0.00107200001	0.00119600003	0.00524300011	0.00169900001	64
55124	12	743	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	799	799	0.0577699989	0.00194999995	0.00187299994	0.00478499988	0.00179899996	64
55125	12	743	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	799	799	0.0565360002	0.00204199995	0.00155000004	0.0285500009	0.00186299998	10
55126	12	744	1	10000000	cplex	0	1	1000	7	0	2	0	1	0	799	799	0.0597449988	0.00200799992	0.00215899991	0.0051719998	0.00222799997	64
55127	12	744	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	799	799	0.0604600012	0.001055	0.00118599995	0.00438500009	0.00175299996	64
55128	12	744	1	10000000	cplex	1	1	1000	7	2	2	0	1	0	799	799	0.0600630008	0.001988	0.00149299996	0.00369499996	0.00176300004	64
55129	12	744	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	799	799	0.0576810017	0.00106299995	0.00122400001	0.00523500005	0.00215999992	64
55130	12	744	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	799	799	0.0572410002	0.00207199994	0.00156600005	0.0275619999	0.00151700003	10
55131	12	745	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	749	749	0.057204999	0.000797000015	0.00109399995	0.00613400014	0.00169199996	44
55132	12	745	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	749	749	0.0567650013	0.000942000013	0.00123299996	0.00634999992	0.00150200003	62
55133	12	745	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	749	749	0.0757839978	0.00153000001	0.00185200002	0.00685099978	0.00160199997	44
55134	12	745	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	749	749	0.0589450002	0.000949000008	0.00122600002	0.00647300016	0.00175499998	62
55135	12	745	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	749	749	0.0597960018	0.0025820001	0.0027340001	0.0247109998	0.00205100002	14
55136	12	746	1	10000000	cplex	0	1	1000	4	0	2	0	1	0	749	749	0.0601070002	0.00148400001	0.00181599997	0.00496299984	0.00191300001	44
55137	12	746	1	10000000	cplex	1	0	1000	7	1	2	0	1	0	749	749	0.0593740009	0.000988999964	0.00125199999	0.00551400008	0.00158299995	62
55138	12	746	1	10000000	cplex	1	1	1000	4	2	2	0	1	0	749	749	0.0605739988	0.000841000001	0.00105299999	0.00473000016	0.00185100001	44
55139	12	746	1	10000000	cplex	0	0	1000	7	3	2	0	1	0	749	749	0.0597129986	0.001804	0.00143199996	0.00523599982	0.00155299995	62
55140	12	746	1	10000000	cplex	1	1	1000	1	4	2	0	1	0	749	749	0.0590780005	0.00253599999	0.00276400009	0.0246559996	0.00175000005	14
41001	11	719	1	10000000	cplex	1	0	281	11	1	32	0	1	0	49	49	0.511080027	58.7048264	134.613556	310.186981	9.50196838	87294
41002	11	719	1	10000000	cplex	1	1	281	10	2	32	0	1	0	49	49	0.64249599	55.4568977	131.970291	302.420563	12.248373	86888
40822	11	684	1	10000000	cplex	0	1	300	8	0	30	0	1	0	249	249	0.139476001	2.64036989	4.58259392	4.05763388	9.38266659	14181
40823	11	684	1	10000000	cplex	1	0	289	11	1	30	0	1	0	249	249	0.194701999	1.89995694	4.66377592	4.81455898	8.94282722	19245
40824	11	684	1	10000000	cplex	1	1	289	8	2	30	0	1	0	249	249	0.111855999	1.88904095	4.25636482	3.70468092	8.96514797	17270
40825	11	684	1	10000000	cplex	0	0	300	11	3	30	0	1	0	249	249	0.255012989	2.05946493	5.04778719	5.05680084	9.03384495	16260
40826	11	684	1	10000000	cplex	1	1	289	1	4	30	0	1	0	249	249	0.178688005	0.193446994	0.379615992	3.17534399	9.26643276	1146
40827	11	685	1	10000000	cplex	0	1	300	8	0	29	0	1	0	249	249	0.123763002	2.02921009	4.3313179	4.35738802	12.0641718	13709
40828	11	685	1	10000000	cplex	1	0	289	11	1	29	0	1	0	249	249	0.191400006	1.85978901	4.52846813	3.90526009	8.99232292	18603
40829	11	685	1	10000000	cplex	1	1	289	8	2	29	0	1	0	249	249	0.122631997	1.78184605	4.14565611	3.54276609	9.12737656	16694
40830	11	685	1	10000000	cplex	0	0	300	11	3	29	0	1	0	249	249	0.113946997	2.03788495	4.94261885	4.87424707	9.29374027	15718
40831	11	685	1	10000000	cplex	1	1	289	1	4	29	0	1	0	249	249	0.172574997	0.184236005	0.357668012	3.40538502	9.12030602	1108
40832	11	686	1	10000000	cplex	0	1	300	8	0	26	0	1	0	249	249	0.228193	1.66669095	4.09784222	5.6450758	9.77535343	12290
40833	11	686	1	10000000	cplex	1	0	289	11	1	26	0	1	0	249	249	0.089440003	5.35802698	4.11638498	4.52277803	9.40305138	16679
40834	11	686	1	10000000	cplex	1	1	289	8	2	26	0	1	0	249	249	0.118940003	1.62377596	3.71633291	4.02836084	9.29477215	14967
40835	11	686	1	10000000	cplex	0	0	300	11	3	26	0	1	0	249	249	0.199141994	1.78704703	4.36704588	4.44524813	9.43385601	14092
40836	11	686	1	10000000	cplex	1	1	289	1	4	26	0	1	0	249	249	0.213780001	0.187737003	0.326344013	3.07529211	9.2444582	993
40837	11	687	1	10000000	cplex	0	1	300	8	0	39	0	1	0	249	249	0.279978991	2.75300694	6.16076183	5.67725182	9.00199795	18436
40838	11	687	1	10000000	cplex	1	0	289	11	1	39	0	1	0	249	249	0.112807997	3.01389909	6.57875204	6.31331015	8.95501137	25018
40839	11	687	1	10000000	cplex	1	1	289	8	2	39	0	1	0	249	249	0.151337996	2.41749907	5.67231703	5.634799	8.79756927	22451
40840	11	687	1	10000000	cplex	0	0	300	11	3	39	0	1	0	249	249	0.259813994	2.86873388	6.85553122	6.8016758	8.84579659	21138
40841	11	687	1	10000000	cplex	1	1	289	1	4	39	0	1	0	249	249	0.228881001	0.246791005	0.491896987	4.87089682	8.81451797	1490
40842	11	688	1	10000000	cplex	0	1	300	8	0	32	0	1	0	249	249	0.254808992	2.29523993	5.00243521	8.17708397	8.51700592	15127
40843	11	688	1	10000000	cplex	1	0	289	11	1	32	0	1	0	249	249	0.14316	2.35835505	5.28298807	5.6744318	12.2913446	20528
40844	11	688	1	10000000	cplex	1	1	289	8	2	32	0	1	0	249	249	0.163764	2.10455489	4.75934982	3.74164391	7.7968359	18421
40845	11	688	1	10000000	cplex	0	0	300	11	3	32	0	1	0	249	249	0.302352011	2.35435104	5.62747288	4.51489305	8.08681297	17344
40846	11	688	1	10000000	cplex	1	1	289	1	4	32	0	1	0	249	249	0.198226005	0.202878997	0.392874986	2.94636393	8.10571957	1223
40847	11	689	1	10000000	cplex	0	1	300	8	0	32	0	1	0	249	249	0.158968002	2.28338194	4.93099022	3.90992808	9.17406368	15127
40848	11	689	1	10000000	cplex	1	0	289	11	1	32	0	1	0	249	249	0.141631007	2.026999	5.06030798	4.19855595	8.69095993	20528
40849	11	689	1	10000000	cplex	1	1	289	8	2	32	0	1	0	249	249	0.110134996	2.11961889	4.64559412	3.74309993	8.85358715	18421
40850	11	689	1	10000000	cplex	0	0	300	11	3	32	0	1	0	249	249	0.209499002	2.36816597	5.54626083	5.10637712	13.6275969	17344
40851	11	689	1	10000000	cplex	1	1	289	1	4	32	0	1	0	249	249	0.185368001	0.209690005	0.401755989	4.24337912	8.68918705	1223
40852	11	690	1	10000000	cplex	0	1	300	9	0	31	0	1	0	199	199	0.416426003	8.29306412	19.6804676	30.4284573	10.1242809	30798
40853	11	690	1	10000000	cplex	1	0	289	11	1	31	0	1	0	199	199	0.222106993	8.59214115	19.9699364	29.3784409	9.22060966	35567
40854	11	690	1	10000000	cplex	1	1	289	9	2	31	0	1	0	199	199	0.246313006	8.07362938	19.4046421	28.1944466	9.8614397	34190
40855	11	690	1	10000000	cplex	0	0	300	11	3	31	0	1	0	199	199	0.335408002	8.78100014	20.935358	29.2763042	9.58769894	32302
40856	11	690	1	10000000	cplex	1	1	289	1	4	31	0	1	0	199	199	0.411706001	0.607654989	1.14303303	8.2159977	9.53534889	1631
40857	11	691	1	10000000	cplex	0	1	300	9	0	33	0	1	0	199	199	0.55210799	9.06966114	21.2747307	30.813015	9.39757538	32785
40858	11	691	1	10000000	cplex	1	0	289	11	1	33	0	1	0	199	199	0.210624993	8.96494865	21.5834827	30.8840942	8.59515095	37862
40859	11	691	1	10000000	cplex	1	1	289	9	2	33	0	1	0	199	199	0.320030987	8.48044586	20.704668	30.4745216	9.02319717	36396
40860	11	691	1	10000000	cplex	0	0	300	11	3	33	0	1	0	199	199	0.319458008	8.87700462	21.7659016	31.6163368	8.78738785	34386
40861	11	691	1	10000000	cplex	1	1	289	1	4	33	0	1	0	199	199	0.436742008	0.706494987	1.19097304	9.21608829	8.85046577	1736
40862	11	692	1	10000000	cplex	0	1	300	9	0	37	0	1	0	199	199	0.628081977	10.6478081	24.5201645	35.8502121	9.26161575	36759
40863	11	692	1	10000000	cplex	1	0	289	11	1	37	0	1	0	199	199	0.249430999	10.2215281	24.7416019	35.8468819	8.75217533	42451
40864	11	692	1	10000000	cplex	1	1	289	9	2	37	0	1	0	199	199	0.342198014	10.2270527	24.1320419	35.5733986	9.12503338	40807
40865	11	692	1	10000000	cplex	0	0	300	11	3	37	0	1	0	199	199	0.330036998	16.6744041	25.0983944	37.2352448	8.68787766	38554
40866	11	692	1	10000000	cplex	1	1	289	1	4	37	0	1	0	199	199	0.559947014	0.737999976	1.40973997	11.4405584	8.55979538	1947
41794	9	540	1	10000000	cplex	1	1	290	2	2	22	0	1	0	299	299	0.0110999998	0.0039789998	0.00462599983	0.00672700023	0.278227001	330
41795	9	540	1	10000000	cplex	0	0	300	11	3	22	0	1	0	299	299	0.00322300009	0.0036830001	0.00569000002	0.00870900042	0.243252993	924
41796	9	540	1	10000000	cplex	1	1	290	1	4	22	0	1	0	299	299	0.0291329995	0.00346000004	0.00506100012	0.0148369996	0.236190006	187
41797	9	541	1	10000000	cplex	0	1	300	2	0	18	0	1	0	299	299	0.00282300008	0.00142800005	0.00212799991	0.0058670002	0.919282973	270
41798	9	541	1	10000000	cplex	1	0	290	11	1	18	0	1	0	299	299	0.00673000002	0.00182300003	0.00352600007	0.00658300007	0.937829018	756
41799	9	541	1	10000000	cplex	1	1	290	2	2	18	0	1	0	299	299	0.00630200002	0.00130400003	0.00191300001	0.00520000001	0.911728024	270
41800	9	541	1	10000000	cplex	0	0	300	11	3	18	0	1	0	299	299	0.00398400007	0.00176300004	0.00351499999	0.00678700022	0.93571502	756
41801	9	541	1	10000000	cplex	1	1	290	1	4	18	0	1	0	299	299	0.00618400006	0.00129000004	0.0025510001	0.0124310004	0.887136996	153
41802	9	542	1	10000000	cplex	0	1	300	2	0	17	0	1	0	299	299	0.00357399997	0.00148700003	0.0029219999	0.00655699987	0.727966011	255
41803	9	542	1	10000000	cplex	1	0	290	11	1	17	0	1	0	299	299	0.00615799986	0.00130300003	0.00309200003	0.00730799977	0.819920003	714
41804	9	542	1	10000000	cplex	1	1	290	2	2	17	0	1	0	299	299	0.0059150001	0.000693999988	0.00161000004	0.00491400016	0.708330989	255
41805	9	542	1	10000000	cplex	0	0	300	11	3	17	0	1	0	299	299	0.00302299997	0.000974999974	0.00310399989	0.0076489998	0.719026029	714
41806	9	542	1	10000000	cplex	1	1	290	1	4	17	0	1	0	299	299	0.00562500022	0.00082299998	0.00197899994	0.0118699996	0.761233985	144
41807	9	543	1	10000000	cplex	0	1	300	2	0	18	0	1	0	299	299	0.00303200004	0.000646999979	0.00168400002	0.00718900003	0.167122006	270
41808	9	543	1	10000000	cplex	1	0	290	11	1	18	0	1	0	299	299	0.00635500019	0.001452	0.00335899997	0.00839100033	0.176923007	756
41809	9	543	1	10000000	cplex	1	1	290	2	2	18	0	1	0	299	299	0.00611399999	0.000837999978	0.00197799993	0.00722299982	0.236423999	270
41810	9	543	1	10000000	cplex	0	0	300	11	3	18	0	1	0	299	299	0.0034680001	0.00104400003	0.00335899997	0.00915899966	0.156604007	756
41811	9	543	1	10000000	cplex	1	1	290	1	4	18	0	1	0	299	299	0.00612400007	0.00100000005	0.00244499999	0.019382	0.159836993	153
41812	9	544	1	10000000	cplex	0	1	300	2	0	16	0	1	0	299	299	0.00275099999	0.000572999998	0.00157600001	0.00932599977	0.962539971	240
41813	9	544	1	10000000	cplex	1	0	290	11	1	16	0	1	0	299	299	0.00564699993	0.00112200005	0.00298799993	0.00953000039	0.860864997	672
41814	9	544	1	10000000	cplex	1	1	290	2	2	16	0	1	0	299	299	0.00610599993	0.000564999995	0.00153500005	0.00870999973	0.859773993	240
41815	9	544	1	10000000	cplex	0	0	300	11	3	16	0	1	0	299	299	0.0025810001	0.000874000019	0.00298899994	0.00914799981	0.855304003	672
41816	9	544	1	10000000	cplex	1	1	290	1	4	16	0	1	0	299	299	0.00533600012	0.000776999979	0.00196800008	0.0179910008	0.863147974	136
41817	9	545	1	10000000	cplex	0	1	300	2	0	15	0	1	0	299	299	0.00265099993	0.00057600002	0.00142900005	0.00751199992	0.165712997	225
41818	9	545	1	10000000	cplex	1	0	290	11	1	15	0	1	0	299	299	0.0051500001	0.000823999988	0.0029180001	0.00859399978	0.159089997	630
41819	9	545	1	10000000	cplex	1	1	290	2	2	15	0	1	0	299	299	0.00518199988	0.000483000011	0.00147799996	0.00834400021	0.152492002	225
41820	9	545	1	10000000	cplex	0	0	300	11	3	15	0	1	0	299	299	0.00245700008	0.000905000023	0.00290900003	0.00912700035	0.176183	630
41821	9	545	1	10000000	cplex	1	1	290	1	4	15	0	1	0	299	299	0.00581299979	0.000747999991	0.00209400011	0.0162770003	0.174850002	127
41822	9	546	1	10000000	cplex	0	1	300	2	0	17	0	1	0	299	299	0.00315700006	0.000601999986	0.00188300002	0.00937199965	0.395512998	255
41823	9	546	1	10000000	cplex	1	0	290	11	1	17	0	1	0	299	299	0.00637800014	0.000959000026	0.00324700004	0.00907899998	0.375961989	714
41824	9	546	1	10000000	cplex	1	1	290	2	2	17	0	1	0	299	299	0.00626800023	0.000630000024	0.00168300001	0.00666800002	0.384065002	255
41825	9	546	1	10000000	cplex	0	0	300	11	3	17	0	1	0	299	299	0.00313899992	0.00107799994	0.00324500003	0.00903999992	0.408214003	714
41826	9	546	1	10000000	cplex	1	1	290	1	4	17	0	1	0	299	299	0.00586199993	0.000665	0.00210699998	0.0163240004	0.386758	144
41827	9	547	1	10000000	cplex	0	1	300	2	0	52	0	1	0	299	299	0.00701900013	0.00140399998	0.00426500011	0.0126550002	0.404240996	780
41828	9	547	1	10000000	cplex	1	0	290	11	1	52	0	1	0	299	299	0.00995699968	0.00261400011	0.00902299955	0.0189570002	0.378794014	2184
41829	9	547	1	10000000	cplex	1	1	290	2	2	52	0	1	0	299	299	0.00978299975	0.00135699997	0.00421599997	0.0120339999	0.399762005	780
41830	9	547	1	10000000	cplex	0	0	300	11	3	52	0	1	0	299	299	0.00708399992	0.00239600008	0.00904799998	0.0176589992	0.411361992	2184
41831	9	547	1	10000000	cplex	1	1	290	1	4	52	0	1	0	299	299	0.0106570004	0.00185600005	0.00563600007	0.0287500005	0.404785991	442
41832	9	548	1	10000000	cplex	0	1	300	2	0	35	0	1	0	299	299	0.00527099986	0.000950000016	0.00305199996	0.0109519996	0.238506004	525
41833	9	548	1	10000000	cplex	1	0	290	11	1	35	0	1	0	299	299	0.00566399982	0.001773	0.006207	0.0152749997	0.223840997	1470
41834	9	548	1	10000000	cplex	1	1	290	2	2	35	0	1	0	299	299	0.00762999989	0.000946999993	0.00305499998	0.0113709997	0.220661998	525
41835	9	548	1	10000000	cplex	0	0	300	11	3	35	0	1	0	299	299	0.0049660001	0.00164300005	0.00621500006	0.0136280004	0.207920998	1470
41836	9	548	1	10000000	cplex	1	1	290	1	4	35	0	1	0	299	299	0.00760200014	0.001376	0.00396500016	0.0245660003	0.211930007	297
41837	9	549	1	10000000	cplex	0	1	300	2	0	6	0	1	0	299	299	0.00138399994	0.000211999999	0.000682000013	0.00870299991	0.163181007	90
41838	9	549	1	10000000	cplex	1	0	290	11	1	6	0	1	0	299	299	0.00384599995	0.00033499999	0.00131099997	0.00827199966	0.161851004	252
41839	9	549	1	10000000	cplex	1	1	290	2	2	6	0	1	0	299	299	0.00390299992	0.000209000005	0.000769999984	0.00714500016	0.168832004	90
41840	9	549	1	10000000	cplex	0	0	300	11	3	6	0	1	0	299	299	0.00122099998	0.000330999988	0.00138100004	0.00813299976	0.147499993	252
41841	9	549	1	10000000	cplex	1	1	290	1	4	6	0	1	0	299	299	0.00395900011	0.000415999995	0.000944000029	0.0135089997	0.172234997	51
41842	9	550	1	10000000	cplex	0	1	300	5	0	25	0	1	0	274	274	0.107859999	0.346731007	0.764261007	0.876758993	0.189934	5104
41843	9	550	1	10000000	cplex	1	0	282	11	1	25	0	1	0	274	274	0.0341340005	0.221045002	0.486912996	0.580061972	0.287604004	11050
41844	9	550	1	10000000	cplex	1	1	282	8	2	25	0	1	0	274	274	0.0345910005	0.194007993	0.435261995	0.537513018	0.185534999	9743
41845	9	550	1	10000000	cplex	0	0	300	11	3	25	0	1	0	274	274	0.0985509977	0.668338001	1.03894901	1.09180903	0.181273997	7300
41846	9	550	1	10000000	cplex	1	1	282	1	4	25	0	1	0	274	274	0.0344039984	0.123636	0.18919	2.14030695	0.186463997	1207
41847	9	551	1	10000000	cplex	0	1	300	6	0	20	0	1	0	274	274	0.0855149999	0.275518	0.608816981	0.698526978	0.291379988	4256
41848	9	551	1	10000000	cplex	1	0	282	11	1	20	0	1	0	274	274	0.0311680008	0.165347993	0.386907995	0.470582992	0.204776004	8840
41849	9	551	1	10000000	cplex	1	1	282	8	2	20	0	1	0	274	274	0.0330759995	0.152843997	0.343346	0.43403101	0.198250994	7795
41850	9	551	1	10000000	cplex	0	0	300	11	3	20	0	1	0	274	274	0.0706200004	0.398368001	0.836809993	0.922894001	0.209667996	5840
41851	9	551	1	10000000	cplex	1	1	282	1	4	20	20	0	0	274		0.0742029995	0.399906993	0.64665699	6.19245577	0.0870700032	1235
41852	9	552	1	10000000	cplex	0	1	300	6	0	39	0	1	0	274	274	0.208895996	0.660722971	1.29916704	1.38043594	0.476336986	8470
41853	9	552	1	10000000	cplex	1	0	282	11	1	39	0	1	0	274	274	0.0491399989	0.467810005	0.789514005	0.906888008	0.454663992	17238
41854	9	552	1	10000000	cplex	1	1	282	8	2	39	0	1	0	274	274	0.0682369992	0.352169007	0.725856006	0.84740001	0.464908004	15200
41855	9	552	1	10000000	cplex	0	0	300	11	3	39	0	1	0	274	274	0.211730003	0.72724098	1.69429398	1.646891	0.437658995	11388
41856	9	552	1	10000000	cplex	1	1	282	1	4	39	39	0	0	274		0.0290559996	0.241316006	0.413929999	3.19544601	0.0873040035	1651
41857	9	553	1	10000000	cplex	0	1	300	6	0	30	0	1	0	274	274	0.172603995	0.43492499	0.942892015	1.07356501	0.627772987	6257
41858	9	553	1	10000000	cplex	1	0	282	11	1	30	0	1	0	274	274	0.0301859993	0.341167986	0.60384202	0.724009991	0.643126011	13260
41859	9	553	1	10000000	cplex	1	1	282	8	2	30	0	1	0	274	274	0.0522180013	0.268317997	0.562246025	0.65326798	0.628039002	11692
41860	9	553	1	10000000	cplex	0	0	300	11	3	30	0	1	0	274	274	0.168394998	0.565988004	1.29496598	1.34089696	0.614057004	8760
41861	9	553	1	10000000	cplex	1	1	282	1	4	30	0	1	0	274	274	0.042888999	0.145970002	0.264429003	2.94501305	0.620604992	1279
41862	9	554	1	10000000	cplex	0	1	300	6	0	42	0	1	0	274	274	0.203489006	0.674996972	1.42931104	1.47187197	0.589774013	9219
41863	9	554	1	10000000	cplex	1	0	282	11	1	42	0	1	0	274	274	0.0519450009	0.762365997	0.8477	0.979035974	0.604812026	18564
41864	9	554	1	10000000	cplex	1	1	282	8	2	42	0	1	0	274	274	0.0687630028	0.381738991	0.794818997	0.887842	0.596795022	16369
41865	9	554	1	10000000	cplex	0	0	300	11	3	42	0	1	0	274	274	0.217225	0.788313985	1.80238998	1.76874495	0.598673999	12264
41866	9	554	1	10000000	cplex	1	1	282	1	4	42	42	0	0	274		0.0195530001	0.0305509996	0.0529959984	0.378996015	0.0665529966	1098
41867	9	555	1	10000000	cplex	0	1	300	5	0	23	0	1	0	274	274	0.135554999	0.353962004	0.738952994	0.825697005	0.692130983	4696
41868	9	555	1	10000000	cplex	1	0	282	11	1	23	0	1	0	274	274	0.0343139991	0.186996996	0.45262599	0.557910979	0.811122	10166
41869	9	555	1	10000000	cplex	1	1	282	8	2	23	0	1	0	274	274	0.0414489992	0.205730006	0.433892012	0.499132991	0.691684008	8964
41870	9	555	1	10000000	cplex	0	0	300	11	3	23	0	1	0	274	274	0.135376006	0.457471013	1.04120505	1.05425894	0.709034979	6716
41871	9	555	1	10000000	cplex	1	1	282	1	4	23	23	0	0	274		0.0499200001	0.106884003	0.187610999	1.65641105	0.0645039976	1239
41872	9	556	1	10000000	cplex	0	1	300	5	0	23	0	1	0	274	274	0.0539910011	0.462397993	0.755792975	0.82387799	0.243633002	4696
41873	9	556	1	10000000	cplex	1	0	282	11	1	23	0	1	0	274	274	0.0441620015	0.218550995	0.485466987	0.544381022	0.236154005	10166
41874	9	556	1	10000000	cplex	1	1	282	8	2	23	0	1	0	274	274	0.0436099991	0.202485994	0.432415992	0.493288994	0.249869004	8964
41875	9	556	1	10000000	cplex	0	0	300	11	3	23	0	1	0	274	274	0.101387002	0.818665028	0.989886999	1.02226603	0.251756012	6716
41876	9	556	1	10000000	cplex	1	1	282	1	4	23	0	1	0	274	274	0.0439100005	0.112483002	0.189747006	2.00403595	0.242798001	1110
41877	9	557	1	10000000	cplex	0	1	300	5	0	20	0	1	0	274	274	0.120513998	0.307702988	0.645242989	0.739943981	0.910950005	4083
41878	9	557	1	10000000	cplex	1	0	282	11	1	20	0	1	0	274	274	0.0300120004	0.162963003	0.398799002	0.479162008	0.971646011	8840
41879	9	557	1	10000000	cplex	1	1	282	8	2	20	0	1	0	274	274	0.0364670008	0.180451006	0.377236009	0.438293993	0.898786008	7795
41880	9	557	1	10000000	cplex	0	0	300	11	3	20	0	1	0	274	274	0.104914002	0.401371986	0.900636971	0.885195971	0.897737026	5840
41881	9	557	1	10000000	cplex	1	1	282	1	4	20	20	0	0	274		0.0369420014	0.0904389992	0.162413999	1.46789002	0.0610999987	1078
41882	9	558	1	10000000	cplex	0	1	300	6	0	31	0	1	0	274	274	0.176439002	0.505364001	1.04170406	1.09709203	0.468944997	6548
41883	9	558	1	10000000	cplex	1	0	282	11	1	31	0	1	0	274	274	0.053842999	0.274729997	0.638495028	0.727946997	0.469060004	13702
41884	9	558	1	10000000	cplex	1	1	282	8	2	31	0	1	0	274	274	0.0424190015	0.335657001	0.55944699	0.66159302	0.484932989	12082
41885	9	558	1	10000000	cplex	0	0	300	11	3	31	0	1	0	274	274	0.166336998	0.617123008	1.38916695	1.34544599	0.474065006	9052
41886	9	558	1	10000000	cplex	1	1	282	1	4	31	31	0	0	274		0.174339995	2.47456694	4.3592329	21.7999191	0.0685739964	3208
41887	9	559	1	10000000	cplex	0	1	300	5	0	23	0	1	0	274	274	0.0585409999	0.415697008	0.761409998	0.846864998	0.210235	4696
41888	9	559	1	10000000	cplex	1	0	282	11	1	23	0	1	0	274	274	0.0436110012	0.219936997	0.498380005	0.55497098	0.200498	10166
41889	9	559	1	10000000	cplex	1	1	282	8	2	23	0	1	0	274	274	0.0427450016	0.207633004	0.448321998	0.506542981	0.198654994	8964
41890	9	559	1	10000000	cplex	0	0	300	11	3	23	0	1	0	274	274	0.0761429965	0.431645006	1.06402194	1.04908001	0.197312996	6716
41891	9	559	1	10000000	cplex	1	1	282	1	4	23	0	1	0	274	274	0.0441140011	0.113779001	0.190590993	2.10347295	0.194701999	1110
41892	9	560	1	10000000	cplex	0	1	300	7	0	15	0	1	0	249	249	0.120632999	1.01958203	2.19991493	3.04786897	0.93819797	7033
41893	9	560	1	10000000	cplex	1	0	292	11	1	15	0	1	0	249	249	0.0993940011	1.05468798	2.37618709	3.07452106	0.923852026	9120
41894	9	560	1	10000000	cplex	1	1	292	8	2	15	0	1	0	249	249	0.139241993	1.04273498	2.14713407	2.89130402	1.29418802	8117
41895	9	560	1	10000000	cplex	0	0	300	11	3	15	0	1	0	249	249	0.12032	1.14638698	2.48942804	3.23180103	0.922918022	8130
41896	9	560	1	10000000	cplex	1	1	292	1	4	15	0	1	0	249	249	0.117115997	0.376695007	0.706435025	3.80963397	0.89120698	2324
41897	9	561	1	10000000	cplex	0	1	300	7	0	20	0	1	0	249	249	0.126458004	1.31429696	2.88602805	2.83217096	0.862200975	9464
41898	9	561	1	10000000	cplex	1	0	245	11	1	20	0	1	0	249	249	0.0152719999	0.220446005	0.374794006	0.698378026	0.869204998	20440
41899	9	561	1	10000000	cplex	1	1	245	10	2	20	0	1	0	249	249	0.0124190003	0.143179998	0.34601301	0.684156001	0.858412027	19400
41900	9	561	1	10000000	cplex	0	0	300	11	3	20	0	1	0	249	249	0.168835998	1.98070896	3.3795929	3.08295202	0.895397007	10840
41901	9	561	1	10000000	cplex	1	1	245	1	4	20	0	1	0	249	249	0.0154480003	0.0885140002	0.151674002	0.925737977	0.877416015	3250
41902	9	562	1	10000000	cplex	0	1	300	7	0	30	0	1	0	249	249	0.24267	1.93093598	4.31271601	6.47339201	0.441915989	14067
41903	9	562	1	10000000	cplex	1	0	292	11	1	30	0	1	0	249	249	0.198033005	1.92445803	4.66665792	6.7824769	0.436185002	18241
41904	9	562	1	10000000	cplex	1	1	292	8	2	30	0	1	0	249	249	0.152429998	1.82881904	4.22447586	6.46116209	0.44214201	16234
41905	9	562	1	10000000	cplex	0	0	300	11	3	30	0	1	0	249	249	0.192696005	2.04504395	4.89791298	6.98248482	0.470885009	16260
41906	9	562	1	10000000	cplex	1	1	292	1	4	30	0	1	0	249	249	0.171924993	0.770617008	1.424649	7.964746	0.412761986	4649
41907	9	563	1	10000000	cplex	0	1	300	7	0	25	0	1	0	249	249	0.163427994	1.57039702	3.60499597	5.08385611	0.233565003	11722
41908	9	563	1	10000000	cplex	1	0	292	11	1	25	0	1	0	249	249	0.157601997	1.56293797	3.89182091	4.84603786	0.239852995	15201
41909	9	563	1	10000000	cplex	1	1	292	8	2	25	0	1	0	249	249	0.102813996	1.49177396	3.54698992	4.54456902	0.228397995	13529
41910	9	563	1	10000000	cplex	0	0	300	11	3	25	0	1	0	249	249	0.142924994	1.64198601	4.12069178	5.05084896	0.248221993	13550
41911	9	563	1	10000000	cplex	1	1	292	1	4	25	0	1	0	249	249	0.162625	0.628314018	1.19306004	6.22405195	0.22507	3874
41912	9	564	1	10000000	cplex	0	1	300	7	0	16	0	1	0	249	249	0.137165993	1.01103604	2.33020902	2.96202111	0.890094995	7502
41913	9	564	1	10000000	cplex	1	0	292	11	1	16	0	1	0	249	249	0.0774760023	1.04623604	2.45774603	3.09334707	0.925657988	9728
41914	9	564	1	10000000	cplex	1	1	292	8	2	16	0	1	0	249	249	0.114051998	1.15790498	2.36966896	2.8939631	1.37955105	8658
41915	9	564	1	10000000	cplex	0	0	300	11	3	16	0	1	0	249	249	0.133208007	1.23297799	2.73459792	3.24196911	0.945362985	8672
41916	9	564	1	10000000	cplex	1	1	292	1	4	16	0	1	0	249	249	0.167174995	0.448982	0.799355984	2.92330003	0.93226099	2479
41917	9	565	1	10000000	cplex	0	1	300	7	0	16	0	1	0	249	249	0.142493993	1.165326	2.43020797	3.02558804	0.934005022	7502
41918	9	565	1	10000000	cplex	1	0	292	11	1	16	0	1	0	249	249	0.120114997	1.16529202	2.60750604	3.09556198	0.902539015	9728
41919	9	565	1	10000000	cplex	1	1	292	8	2	16	0	1	0	249	249	0.134751007	1.59651899	2.35718393	2.93626595	0.910066009	8658
41920	9	565	1	10000000	cplex	0	0	300	11	3	16	0	1	0	249	249	0.148261994	1.23719001	2.73467898	3.16717792	0.911100984	8672
41921	9	565	1	10000000	cplex	1	1	292	1	4	16	0	1	0	249	249	0.157478005	0.447241008	0.797411025	2.91980791	0.922776997	2479
41922	9	566	1	10000000	cplex	0	1	300	7	0	22	0	1	0	249	249	0.169372007	1.60843003	3.39651108	4.13872385	0.209371999	10315
41923	9	566	1	10000000	cplex	1	0	292	11	1	22	0	1	0	249	249	0.134350002	1.61791003	3.60502911	4.27217293	0.221074	13377
41924	9	566	1	10000000	cplex	1	1	292	8	2	22	0	1	0	249	249	0.119018003	1.31565499	3.19386911	4.02058411	0.242425993	11905
41925	9	566	1	10000000	cplex	0	0	300	11	3	22	0	1	0	249	249	0.103877001	1.45179296	3.64287996	4.43175793	0.230798006	11924
41926	9	566	1	10000000	cplex	1	1	292	1	4	22	0	1	0	249	249	0.138804004	0.558007002	1.05885506	4.70740795	0.244597003	3409
41927	9	567	1	10000000	cplex	0	1	300	7	0	18	0	1	0	249	249	0.118322998	1.19850898	2.64423895	3.26195002	0.709545016	8518
41928	9	567	1	10000000	cplex	1	0	283	11	1	18	0	1	0	249	249	0.0866800025	1.02452004	2.54698706	3.16931605	1.24050605	12646
41929	9	567	1	10000000	cplex	1	1	283	9	2	18	0	1	0	249	249	0.0821100026	1.01303601	2.39327192	3.02634907	0.699921012	11729
41930	9	567	1	10000000	cplex	0	0	300	11	3	18	0	1	0	249	249	0.0730229989	1.19026506	2.93551302	3.5473249	0.727401972	9756
41931	9	567	1	10000000	cplex	1	1	283	1	4	18	0	1	0	249	249	0.0984050035	0.479790986	0.926742017	5.47706318	0.748292029	1926
41932	9	568	1	10000000	cplex	0	1	300	7	0	31	0	1	0	249	249	0.154721007	1.98752296	4.57587099	5.56464481	0.641276002	14670
41933	9	568	1	10000000	cplex	1	0	283	11	1	31	0	1	0	249	249	0.0846979991	1.84697497	4.43750715	5.52385807	0.646537006	21780
41934	9	568	1	10000000	cplex	1	1	283	9	2	31	0	1	0	249	249	0.092745997	1.79003704	4.1599021	5.22814798	0.642071009	20200
41935	9	568	1	10000000	cplex	0	0	300	11	3	31	0	1	0	249	249	0.181385994	2.13155007	5.20382309	6.06577921	0.657445014	16802
41936	9	568	1	10000000	cplex	1	1	283	1	4	31	31	0	0	249		0.487093002	11.9836845	21.3477612	201.659424	0.0752979964	7976
41937	9	569	1	10000000	cplex	0	1	300	7	0	19	0	1	0	249	249	0.155334994	1.22149098	2.75921988	4.02726412	0.92334801	8909
41938	9	569	1	10000000	cplex	1	0	292	11	1	19	0	1	0	249	249	0.124744996	1.22362101	3.02948499	4.21117592	0.873941004	11552
41939	9	569	1	10000000	cplex	1	1	292	8	2	19	0	1	0	249	249	0.0910469964	1.26522303	2.7192359	4.01958179	0.881765008	10282
41940	9	569	1	10000000	cplex	0	0	300	11	3	19	0	1	0	249	249	0.133596003	1.24886703	3.22171307	4.33119106	0.876915991	10298
41941	9	569	1	10000000	cplex	1	1	292	1	4	19	0	1	0	249	249	0.120769002	0.490195006	0.925863981	5.25230885	0.883261979	2944
41942	9	570	1	10000000	cplex	0	1	300	9	0	16	0	1	0	199	199	0.202118993	5.0205512	10.0236082	12.76406	0.888040006	15659
41943	9	570	1	10000000	cplex	1	0	249	11	1	16	0	1	0	199	199	0.0737079978	3.08469391	7.23670912	9.36584663	0.890500009	23596
41944	9	570	1	10000000	cplex	1	1	249	10	2	16	0	1	0	199	199	0.113773003	3.09382892	7.02714586	10.0063763	0.924857974	22402
41945	9	570	1	10000000	cplex	0	0	300	11	3	16	0	1	0	199	199	0.204794005	4.27937889	10.2909288	12.0738697	0.925415993	16672
41946	9	570	1	10000000	cplex	1	1	249	1	4	16	16	0	0	199		0.123498	1.40541601	2.38387895	21.3617668	0.0794499964	1541
41947	9	571	1	10000000	cplex	0	1	300	9	0	12	0	1	0	199	199	0.183391005	3.37686801	7.57563877	9.54760742	0.867298007	11814
41948	9	571	1	10000000	cplex	1	0	245	11	1	12	0	1	0	199	199	0.0925820023	2.28261209	5.308321	6.84800911	0.941196024	18352
41949	9	571	1	10000000	cplex	1	1	245	10	2	12	0	1	0	199	199	0.108760998	2.26290298	5.12733889	7.25601006	0.892612994	17424
41950	9	571	1	10000000	cplex	0	0	300	11	3	12	0	1	0	199	199	0.144590005	3.40982604	8.04921913	9.14400101	0.886803985	12504
41951	9	571	1	10000000	cplex	1	1	245	1	4	12	12	0	0	199		0.0798339993	0.498407006	0.803719997	5.84811306	0.0805360004	704
41952	9	572	1	10000000	cplex	0	1	300	9	0	11	0	1	0	199	199	0.209707007	3.133533	7.07900381	11.3217802	0.904950023	10746
41953	9	572	1	10000000	cplex	1	0	245	11	1	11	0	1	0	199	199	0.0608629994	2.2024641	5.02696705	7.2022028	0.911319017	16823
41954	9	572	1	10000000	cplex	1	1	245	10	2	11	0	1	0	199	199	0.0705029964	2.16963506	4.77993584	9.59723568	0.907383025	15972
41955	9	572	1	10000000	cplex	0	0	300	11	3	11	0	1	0	199	199	0.136732996	2.91460896	7.14079618	9.5089283	0.889400005	11462
41956	9	572	1	10000000	cplex	1	1	245	1	4	11	11	0	0	199		0.0514440015	0.305752009	0.497671008	3.71686006	0.0663309991	829
41957	9	573	1	10000000	cplex	0	1	300	9	0	14	0	1	0	199	199	0.192416996	3.62038398	8.54678822	15.6234856	0.648892999	13692
41958	9	573	1	10000000	cplex	1	0	245	11	1	14	0	1	0	199	199	0.0698800012	2.85636401	6.3545022	10.295414	0.662862003	21411
41959	9	573	1	10000000	cplex	1	1	245	10	2	14	0	1	0	199	199	0.0795509964	2.77411604	6.02392817	12.492733	0.64369601	20328
41960	9	573	1	10000000	cplex	0	0	300	11	3	14	0	1	0	199	199	0.179957002	4.2318778	9.43923378	13.0089474	0.646699011	14588
41961	9	573	1	10000000	cplex	1	1	245	1	4	14	14	0	0	199		0.0867459998	0.520605028	0.882878006	5.94567013	0.0690170005	1131
41962	9	574	1	10000000	cplex	0	1	300	9	0	6	0	1	0	199	199	0.0976689979	2.41370511	3.869735	7.38470221	0.887404025	5838
41963	9	574	1	10000000	cplex	1	0	249	11	1	6	0	1	0	199	199	0.0615319982	1.31362998	2.88043094	5.53571892	0.907629013	8848
41964	9	574	1	10000000	cplex	1	1	249	10	2	6	0	1	0	199	199	0.0663819984	1.27508605	2.74168992	6.03519011	0.904384017	8400
41965	9	574	1	10000000	cplex	0	0	300	11	3	6	0	1	0	199	199	0.102982998	1.82495296	4.05171108	6.85290718	0.911689997	6252
41966	9	574	1	10000000	cplex	1	1	249	1	4	6	6	0	0	199		0.0837860033	0.59809798	1.01805997	6.55848503	0.0837439969	824
41967	9	575	1	10000000	cplex	0	1	300	9	0	12	0	1	0	199	199	0.130101994	3.60524201	7.77049923	12.9526663	0.197040007	11677
41968	9	575	1	10000000	cplex	1	0	249	11	1	12	0	1	0	199	199	0.0758220032	2.55385399	5.7289381	8.39447212	0.183369994	17697
41969	9	575	1	10000000	cplex	1	1	249	10	2	12	0	1	0	199	199	0.0855209976	2.51270795	5.45635986	10.3634062	0.193742007	16801
41970	9	575	1	10000000	cplex	0	0	300	11	3	12	0	1	0	199	199	0.145009995	3.71152091	8.08806229	10.5941706	0.194480002	12504
41971	9	575	1	10000000	cplex	1	1	249	1	4	12	12	0	0	199		0.121574998	0.995757997	1.74216604	12.4537249	0.0787620023	1570
41972	9	576	1	10000000	cplex	0	1	300	9	0	31	0	1	0	199	199	0.289472997	9.11716175	19.6280022	26.710413	0.237716004	30391
41973	9	576	1	10000000	cplex	1	0	245	11	1	31	0	1	0	199	199	0.108352996	6.05809593	13.7777596	18.9452629	0.212041005	47411
41974	9	576	1	10000000	cplex	1	1	245	10	2	31	0	1	0	199	199	0.129950002	5.89314985	13.219902	20.7386875	0.230278999	45012
41975	9	576	1	10000000	cplex	0	0	300	11	3	31	0	1	0	199	199	0.295756012	8.73169994	20.5650578	24.5717106	0.233371004	32302
41976	9	576	1	10000000	cplex	1	1	245	1	4	31	31	0	0	199		0.214412004	2.31439996	3.96795988	41.2035637	0.0829930007	2539
41977	9	577	1	10000000	cplex	0	1	300	9	0	9	0	1	0	199	199	0.189108998	2.5239501	5.67623806	10.0419722	0.886254013	8768
41978	9	577	1	10000000	cplex	1	0	249	11	1	9	0	1	0	199	199	0.0654809996	1.86653101	4.19541502	7.01687622	0.883472979	13273
41979	9	577	1	10000000	cplex	1	1	249	10	2	9	0	1	0	199	199	0.0906480029	1.74819899	3.96298003	8.06567287	0.888575017	12601
41980	9	577	1	10000000	cplex	0	0	300	11	3	9	0	1	0	199	199	0.135473996	2.55834794	5.92174101	8.92555714	0.897064984	9378
41981	9	577	1	10000000	cplex	1	1	249	1	4	9	21	0	1.33333302	199	188	0.100685	0.899726987	1.57127202	10.4180489	1.09654403	1093
41982	9	578	1	10000000	cplex	0	1	300	9	0	13	0	1	0	199	199	0.195980996	3.42053795	8.10651779	12.1262779	0.194193006	12684
41983	9	578	1	10000000	cplex	1	0	245	11	1	13	0	1	0	199	199	0.0628739968	2.43480396	5.76345778	8.54196262	0.208346993	19882
41984	9	578	1	10000000	cplex	1	1	245	10	2	13	0	1	0	199	199	0.0834899992	2.51353002	5.60907984	9.76977825	0.196897	18876
41985	9	578	1	10000000	cplex	0	0	300	11	3	13	0	1	0	199	199	0.136368006	3.84716892	8.74487495	11.2955141	0.193855003	13546
41986	9	578	1	10000000	cplex	1	1	245	1	4	13	13	0	0	199		0.104346	0.729564011	1.97046101	8.45333958	0.0797049999	1134
41987	9	579	1	10000000	cplex	0	1	300	9	0	31	0	1	0	199	199	0.265347987	8.03720379	19.4147549	25.6490517	0.892039001	30560
41988	9	579	1	10000000	cplex	1	0	245	11	1	31	0	1	0	199	199	0.105678998	5.65082216	13.733675	18.920763	0.888175011	47411
41989	9	579	1	10000000	cplex	1	1	245	10	2	31	0	1	0	199	199	0.116040997	5.75241804	12.9020481	19.5871925	0.885187984	45012
41990	9	579	1	10000000	cplex	0	0	300	11	3	31	0	1	0	199	199	0.242374003	9.73185444	20.365715	23.9339104	0.872914016	32302
41991	9	579	1	10000000	cplex	1	1	245	1	4	31	31	0	0	199		0.316536993	3.41088605	5.77410507	43.375042	0.0748889968	2280
41992	9	580	1	10000000	cplex	0	1	300	9	0	14	0	1	0	99	99	0.379007012	14.9239969	34.5728569	72.0652084	0.258087009	27003
41993	9	580	1	10000000	cplex	1	0	283	11	1	14	0	1	0	99	99	0.230642006	14.9164982	36.0138626	59.7236557	0.284388006	30943
41994	9	580	1	10000000	cplex	1	1	283	9	2	14	0	1	0	99	99	0.296036988	15.4408512	33.9394798	71.6873856	0.260574013	29326
41995	9	580	1	10000000	cplex	0	0	300	11	3	14	0	1	0	99	99	0.251109987	15.1853008	35.6315346	59.0989456	0.247265995	28588
41996	9	580	1	10000000	cplex	1	1	283	1	4	14	14	0	0	99		0.241935998	2.10843301	3.54345703	25.5051384	0.0631870031	1204
41997	9	581	1	10000000	cplex	0	1	300	9	0	13	0	1	0	99	99	0.285284996	13.9640617	31.7676945	99.0535583	0.92513299	25088
41998	9	581	1	10000000	cplex	1	0	285	11	1	13	0	1	0	99	99	0.259373009	13.8946762	32.8195152	59.5905304	0.932124019	28475
41999	9	581	1	10000000	cplex	1	1	285	9	2	13	0	1	0	99	99	0.271073014	13.2282572	32.1614456	99.2474747	0.940607011	26974
42000	9	581	1	10000000	cplex	0	0	300	11	3	13	0	1	0	99	99	0.258309007	14.5786667	33.4195137	60.5553856	0.947013021	26546
42001	9	581	1	10000000	cplex	1	1	285	1	4	13	13	0	0	99		0.564276993	5.46595478	8.8962431	67.9654465	0	2301
42002	9	582	1	10000000	cplex	0	1	300	9	0	3	0	1	0	99	99	0.180451006	3.28849792	7.18530178	18.3759022	3.96088505	5778
42003	9	582	1	10000000	cplex	1	0	291	11	1	3	0	1	0	99	99	0.144473001	3.3461771	7.45549488	13.72925	3.83133006	6389
42004	9	582	1	10000000	cplex	1	1	291	9	2	3	0	1	0	99	99	0.160859004	3.26385999	7.1566968	18.3243027	3.69820499	6039
42005	9	582	1	10000000	cplex	0	0	300	11	3	3	0	1	0	99	99	0.149655998	3.34543705	7.43021917	13.8472147	3.67023706	6126
42006	9	582	1	10000000	cplex	1	1	291	1	4	3	0	1	0	99	99	0.151179001	0.596727014	0.913168013	11.7338743	2.532722	402
42007	9	583	1	10000000	cplex	0	1	300	9	0	15	0	1	0	99	99	0.335891008	17.6793118	37.2315636	75.6210709	0.189370006	28996
42008	9	583	1	10000000	cplex	1	0	245	11	1	15	0	1	0	99	99	0.214555994	16.5731163	35.4303398	56.5637894	0.179210007	38584
42009	9	583	1	10000000	cplex	1	1	245	10	2	15	0	1	0	99	99	0.236864999	15.2029066	33.803257	71.8332825	0.186717004	36641
42010	9	583	1	10000000	cplex	0	0	300	11	3	15	0	1	0	99	99	0.36748001	17.7728062	39.0605202	60.5152397	0.172436997	30630
42011	9	583	1	10000000	cplex	1	1	245	1	4	15	114	0.066666998	6.66666698	99	144	0.226436004	0.610554993	1.04874504	5.5882411	0.225816995	1047
42012	9	584	1	10000000	cplex	0	1	300	9	0	13	0	1	0	99	99	0.28727001	15.1305456	32.2320862	65.802948	0.973748028	25104
42013	9	584	1	10000000	cplex	1	0	283	11	1	13	0	1	0	99	99	0.235174	14.6413155	33.4333229	52.4795494	0.915768027	28733
42014	9	584	1	10000000	cplex	1	1	283	9	2	13	0	1	0	99	99	0.312905997	14.2513981	31.7723789	64.7698441	0.901138008	27231
42015	9	584	1	10000000	cplex	0	0	300	11	3	13	0	1	0	99	99	0.286974013	15.4826345	34.4540024	53.1000099	0.906103015	26546
42016	9	584	1	10000000	cplex	1	1	283	1	4	13	13	0	0	99		0.191612005	1.05364799	1.72533798	9.9384594	0.062766999	867
42017	9	585	1	10000000	cplex	0	1	300	9	0	11	0	1	0	99	99	0.338420987	12.3255987	27.885191	54.1060028	0.931447029	21187
42018	9	585	1	10000000	cplex	1	0	291	11	1	11	0	1	0	99	99	0.269863009	13.684865	28.8174992	44.1952782	0.946434975	23426
42019	9	585	1	10000000	cplex	1	1	291	9	2	11	0	1	0	99	99	0.272116989	12.8621788	27.5249138	54.0796356	0.946952999	22145
42020	9	585	1	10000000	cplex	0	0	300	11	3	11	0	1	0	99	99	0.231334999	12.1071692	28.6708221	44.8468781	0.933879018	22462
42021	9	585	1	10000000	cplex	1	1	291	1	4	11	11	0	0	99		0.483512998	1.22067797	2.17900705	7.1901269	0.0755399987	1399
42125	9	590	1	10000000	cplex	0	1	300	9	0	34	0	1	0	49	49	0.343533993	21.6192398	61.5315361	86.3832855	0.562465012	48149
42126	9	590	1	10000000	cplex	1	0	245	11	1	34	0	1	0	49	49	0.213654995	19.5286942	60.1572151	69.5117798	0.461896002	61546
42127	9	590	1	10000000	cplex	1	1	245	10	2	34	0	1	0	49	49	0.243765995	19.5121708	57.9474449	84.9308243	0.895694017	58450
42128	9	590	1	10000000	cplex	0	0	300	11	3	34	0	1	0	49	49	0.266337007	20.6771412	63.6944351	70.5873718	0.476377994	50840
42129	9	590	1	10000000	cplex	1	1	245	1	4	34	141	0.911764979	4.05882406	49	49	0.285887986	6.4447422	14.1853504	141.180908	1.77715898	10557
42027	9	587	1	10000000	cplex	0	1	300	9	0	22	0	1	0	99	99	0.365523994	23.3952904	55.0643539	119.441666	0.299419999	42412
42028	9	587	1	10000000	cplex	1	0	282	11	1	22	0	1	0	99	99	0.367639989	26.9548931	58.4203987	99.154213	0.237039998	48855
42029	9	587	1	10000000	cplex	1	1	282	9	2	22	0	1	0	99	99	0.370878011	23.5122795	54.4853668	117.280884	0.252977014	46307
42030	9	587	1	10000000	cplex	0	0	300	11	3	22	0	1	0	99	99	0.348592997	25.6911354	57.8965569	99.5606232	0.235310003	44924
42031	9	587	1	10000000	cplex	1	1	282	1	4	22	22	0	0	99		0.453794986	4.88158703	8.93348312	46.4608536	0.0753270015	3006
42032	9	588	1	10000000	cplex	0	1	300	9	0	21	0	1	0	99	99	0.333543986	22.4298439	53.3178406	111.854019	0.428274006	40633
42033	9	588	1	10000000	cplex	1	0	249	11	1	21	0	1	0	99	99	0.238903999	22.9836311	50.7084312	87.0168991	0.402494997	53051
42034	9	588	1	10000000	cplex	1	1	249	10	2	21	0	1	0	99	99	0.29993099	20.7272243	48.8157082	107.531868	0.400700986	50380
42035	9	588	1	10000000	cplex	0	0	300	11	3	21	0	1	0	99	99	0.390417993	23.4357471	55.3970757	91.0597839	0.386797011	42882
42036	9	588	1	10000000	cplex	1	1	249	1	4	21	21	0	0	99		0.670692027	1.92171204	3.30368996	17.4864769	0.0844440013	1805
42037	9	589	1	10000000	cplex	0	1	300	9	0	15	0	1	0	99	99	0.344224006	16.4604149	38.0656166	75.7372742	0.944063008	29006
42038	9	589	1	10000000	cplex	1	0	254	11	1	15	0	1	0	99	99	0.249311998	18.0358067	37.5360184	58.0407257	0.943879008	37380
42039	9	589	1	10000000	cplex	1	1	254	9	2	15	0	1	0	99	99	0.250414014	15.9990072	35.8026657	73.9107666	0.939746976	35462
42152	9	595	1	10000000	cplex	1	1	245	10	2	37	0	1	0	49	49	0.261934012	24.9225426	73.727066	121.394608	0.463153005	73063
42153	9	595	1	10000000	cplex	0	0	300	11	3	37	0	1	0	49	49	0.327578008	26.5472946	81.8826752	97.4682083	0.490135014	63550
42154	9	595	1	10000000	cplex	1	1	245	1	4	37	128	0.918919027	3.37837791	49	49	0.256785989	8.62945366	17.5801659	156.582855	0.270747006	15183
42155	9	596	1	10000000	cplex	0	1	300	9	0	31	0	1	0	49	49	0.34830901	25.6777573	77.545845	122.621964	0.583015978	60187
42156	9	596	1	10000000	cplex	1	0	245	11	1	31	0	1	0	49	49	0.245486006	25.0834103	77.2131729	97.7289886	0.641008019	76932
42157	9	596	1	10000000	cplex	1	1	245	10	2	31	0	1	0	49	49	0.283237994	25.8797016	76.0827026	125.410606	0.592932999	73063
42158	9	596	1	10000000	cplex	0	0	300	11	3	31	0	1	0	49	49	0.334506989	26.3734188	81.0532532	97.9871597	0.56546402	63550
42159	9	596	1	10000000	cplex	1	1	245	1	4	31	0	1	0	49	49	0.274829	7.49510002	17.4970608	166.950974	0.600421011	15183
42160	9	597	1	10000000	cplex	0	1	300	9	0	36	36	0	0	49		0.392338008	38.7746811	111.514801	316.069275	0	71877
42161	9	597	1	10000000	cplex	1	0	245	11	1	36	0	1	0	49	49	0.218058005	24.8549252	77.8898926	100.110245	0.538325012	76932
42162	9	597	1	10000000	cplex	1	1	245	10	2	36	36	0	0	49		0.348912001	36.0197525	107.984047	317.581238	0	84770
42163	9	597	1	10000000	cplex	0	0	300	11	3	36	0	1	0	49	49	0.280119985	26.214674	82.4039536	103.361694	0.590920985	63550
42164	9	597	1	10000000	cplex	1	1	245	1	4	36	0	1	0	49	49	0.258231014	8.56439018	17.5169792	163.088486	0.539318979	15183
42165	9	598	1	10000000	cplex	0	1	300	9	0	34	0	1	0	49	49	0.329984009	27.3439369	79.2081299	123.07299	0.500953972	60229
42166	9	598	1	10000000	cplex	1	0	245	11	1	34	0	1	0	49	49	0.240029007	24.3348751	78.7334518	96.6224442	0.510158002	76932
43115	8	481	1	10000000	cplex	0	1	300	2	0	9	0	1	0	299	299	0.0171399992	0.0148290005	0.00717699993	0.32584399	0.130190998	135
43116	8	481	1	10000000	cplex	1	0	282	11	1	9	0	1	0	299	299	0.0132240001	0.00481500011	0.00779200019	0.376221001	0.115905002	378
43117	8	481	1	10000000	cplex	1	1	282	2	2	9	0	1	0	299	299	0.00881499983	0.002782	0.00368899992	0.402426988	0.105402999	135
43118	8	481	1	10000000	cplex	0	0	300	11	3	9	0	1	0	299	299	0.00228199991	0.00486700004	0.00795399956	0.457174003	0.115019999	378
43119	8	481	1	10000000	cplex	1	1	282	1	4	9	0	1	0	299	299	0.00981799979	0.00314799999	0.0038399999	0.496167988	0.115360998	76
43120	8	482	1	10000000	cplex	0	1	300	2	0	13	0	1	0	299	299	0.00283199991	0.00345700001	0.00394200021	0.664391994	0.129766002	195
43121	8	482	1	10000000	cplex	1	0	282	11	1	13	0	1	0	299	299	0.00625699991	0.00600699987	0.00865199976	0.0391889997	0.0952399969	546
43122	8	482	1	10000000	cplex	1	1	282	2	2	13	0	1	0	299	299	0.00566999987	0.00326799997	0.00391300023	0.246085003	0.120968997	195
43123	8	482	1	10000000	cplex	0	0	300	11	3	13	0	1	0	299	299	0.00283599994	0.00419599982	0.0154449996	0.294914991	0.115418002	546
43124	8	482	1	10000000	cplex	1	1	282	1	4	13	0	1	0	299	299	0.00486199977	0.00272900006	0.00431900006	0.604434013	0.0959220007	110
43125	8	483	1	10000000	cplex	0	1	300	2	0	42	0	1	0	299	299	0.00458199997	0.00741299987	0.0100509999	0.0456059985	0.145686001	630
43126	8	483	1	10000000	cplex	1	0	282	11	1	42	0	1	0	299	299	0.00621399982	0.00860499963	0.0184550006	0.0501639992	0.113394998	1764
43127	8	483	1	10000000	cplex	1	1	282	2	2	42	0	1	0	299	299	0.00956699997	0.00451900018	0.00585399987	0.0582869984	0.130625993	630
43128	8	483	1	10000000	cplex	0	0	300	11	3	42	0	1	0	299	299	0.00640500011	0.00511599984	0.0100260004	0.0513640009	0.127609998	1764
43129	8	483	1	10000000	cplex	1	1	282	1	4	42	0	1	0	299	299	0.00997699983	0.00413700007	0.00730299996	0.502602994	0.109627001	357
43130	8	484	1	10000000	cplex	0	1	300	2	0	24	0	1	0	299	299	0.00366099994	0.00193499995	0.00316000008	0.438021988	0.137237996	360
43131	8	484	1	10000000	cplex	1	0	282	11	1	24	0	1	0	299	299	0.00697400002	0.00259599998	0.00593100023	0.173631996	0.130953997	1008
43132	8	484	1	10000000	cplex	1	1	282	2	2	24	0	1	0	299	299	0.00707399985	0.00182300003	0.00292399991	0.335083008	0.145367995	360
43133	8	484	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.0033760001	0.00258399989	0.00545400009	0.274542987	0.136520997	1008
43134	8	484	1	10000000	cplex	1	1	282	1	4	24	0	1	0	299	299	0.00683500012	0.00245500007	0.00378599996	0.28598401	0.150536999	204
43135	8	485	1	10000000	cplex	0	1	300	2	0	24	0	1	0	299	299	0.00311399996	0.00174700003	0.00280699995	0.0345479995	0.103555001	360
43136	8	485	1	10000000	cplex	1	0	282	11	1	24	0	1	0	299	299	0.00658500008	0.00238900003	0.00546800019	0.0388959982	0.102706999	1008
43137	8	485	1	10000000	cplex	1	1	282	2	2	24	0	1	0	299	299	0.00651799981	0.00150599994	0.00282899989	0.0354270004	0.107276	360
43138	8	485	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.00345900003	0.00223300001	0.00559200021	0.0664810017	0.103096999	1008
43139	8	485	1	10000000	cplex	1	1	282	1	4	24	0	1	0	299	299	0.00657299999	0.00197999994	0.0038050001	0.0428010002	0.101850003	204
43140	8	486	1	10000000	cplex	0	1	300	2	0	13	0	1	0	299	299	0.00206699991	0.00078599999	0.00165300001	0.224574998	0.109402001	195
43141	8	486	1	10000000	cplex	1	0	282	11	1	13	0	1	0	299	299	0.00527499989	0.00127200002	0.00307200011	0.452861995	0.103588	546
43142	8	486	1	10000000	cplex	1	1	282	2	2	13	0	1	0	299	299	0.00500900019	0.000760999974	0.00165200001	0.401959985	0.101172	195
43143	8	486	1	10000000	cplex	0	0	300	11	3	13	0	1	0	299	299	0.001988	0.00110500003	0.00314199994	0.37510699	0.0907130018	546
43144	8	486	1	10000000	cplex	1	1	282	1	4	13	0	1	0	299	299	0.00504099997	0.00107500004	0.00218699989	0.351069987	0.0914879963	110
43145	8	487	1	10000000	cplex	0	1	300	2	0	24	0	1	0	299	299	0.00330099999	0.00130899996	0.00289499993	0.0337920003	0.10853	360
43146	8	487	1	10000000	cplex	1	0	282	11	1	24	0	1	0	299	299	0.007094	0.00220600003	0.00549100013	0.0420450009	0.176394001	1008
43147	8	487	1	10000000	cplex	1	1	282	2	2	24	0	1	0	299	299	0.00716899987	0.00153400004	0.00288400007	0.0339099988	0.118840002	360
43148	8	487	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.00321900006	0.00188899995	0.00559900003	0.0430090018	0.114312001	1008
43149	8	487	1	10000000	cplex	1	1	282	1	4	24	0	1	0	299	299	0.00618800009	0.00173000002	0.00385400001	0.0438380018	0.119511001	204
43150	8	488	1	10000000	cplex	0	1	300	2	0	21	0	1	0	299	299	0.00300500006	0.00116999994	0.002629	0.0379570015	0.107331	315
43151	8	488	1	10000000	cplex	1	0	282	11	1	21	0	1	0	299	299	0.00606200006	0.00164699997	0.00485099992	0.0867210031	0.117482997	882
40734	11	666	1	10000000	cplex	1	1	290	3	2	24	0	1	0	299	299	0.00694700005	0.000739999989	0.00243499991	0.00700099999	8.54379272	432
40735	11	666	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.0049709999	0.00153899996	0.004586	0.00956800021	8.95770359	1008
40736	11	666	1	10000000	cplex	1	1	290	1	4	24	0	1	0	299	299	0.00671900017	0.000975999981	0.00296499999	0.0161070004	8.60222816	204
40737	11	667	1	10000000	cplex	0	1	300	3	0	23	0	1	0	299	299	0.00348700001	0.000709999993	0.00235900003	0.00896700006	8.96453571	414
40738	11	667	1	10000000	cplex	1	0	290	11	1	23	0	1	0	299	299	0.00751199992	0.00144100003	0.00432199985	0.010117	8.91947746	966
40739	11	667	1	10000000	cplex	1	1	290	3	2	23	0	1	0	299	299	0.00633900007	0.000737999973	0.00237599993	0.00797899999	9.03297329	414
40740	11	667	1	10000000	cplex	0	0	300	11	3	23	0	1	0	299	299	0.00468900008	0.00141599996	0.00448400015	0.00913599972	9.07154846	966
40741	11	667	1	10000000	cplex	1	1	290	1	4	23	0	1	0	299	299	0.00722800009	0.00103599997	0.00269400002	0.0164449997	9.51777554	195
40742	11	668	1	10000000	cplex	0	1	300	3	0	25	0	1	0	299	299	0.00374200009	0.000774000015	0.0025559999	0.00915000029	9.26109028	450
40743	11	668	1	10000000	cplex	1	0	290	11	1	25	0	1	0	299	299	0.00802499987	0.00158799998	0.00471200002	0.0104029998	8.90637684	1050
40744	11	668	1	10000000	cplex	1	1	290	3	2	25	0	1	0	299	299	0.0066010002	0.000754999986	0.00253099995	0.00802200008	8.98964405	450
40745	11	668	1	10000000	cplex	0	0	300	11	3	25	0	1	0	299	299	0.00507500023	0.00157700002	0.00493599987	0.0103730001	8.6736393	1050
40746	11	668	1	10000000	cplex	1	1	290	1	4	25	0	1	0	299	299	0.00655400008	0.000945999986	0.00293900003	0.0163700003	9.76435089	212
40747	11	669	1	10000000	cplex	0	1	300	3	0	23	0	1	0	299	299	0.00462900009	0.000870999997	0.00236500008	0.00897299964	9.57854462	414
40748	11	669	1	10000000	cplex	1	0	290	11	1	23	0	1	0	299	299	0.0062330002	0.001193	0.00441099983	0.00950200018	10.3707151	966
40749	11	669	1	10000000	cplex	1	1	290	3	2	23	0	1	0	299	299	0.00684100017	0.000877999992	0.00238299998	0.00811799988	9.2925024	414
40750	11	669	1	10000000	cplex	0	0	300	11	3	23	0	1	0	299	299	0.00338499993	0.00119400001	0.00444799988	0.00990200043	10.3200464	966
40751	11	669	1	10000000	cplex	1	1	290	1	4	23	0	1	0	299	299	0.00731599983	0.000852000026	0.00264200009	0.0166859999	9.29345322	195
40752	11	670	1	10000000	cplex	0	1	300	6	0	31	0	1	0	274	274	0.0859280005	0.68561703	1.02043998	0.93374598	9.10493755	6443
40753	11	670	1	10000000	cplex	1	0	289	11	1	31	0	1	0	274	274	0.107118003	0.475493014	1.03666401	0.936573982	9.2059164	10989
40754	11	670	1	10000000	cplex	1	1	289	7	2	31	0	1	0	274	274	0.108052999	0.401053011	0.859338999	0.812032998	8.86595154	9048
40755	11	670	1	10000000	cplex	0	0	300	11	3	31	0	1	0	274	274	0.233410999	0.595741987	1.33983099	1.22980702	8.80851364	9052
40756	11	670	1	10000000	cplex	1	1	289	1	4	31	0	1	0	274	274	0.077763997	0.128148004	0.194625005	1.352512	10.4464741	1188
40757	11	671	1	10000000	cplex	0	1	300	6	0	33	0	1	0	274	274	0.157295004	0.486714005	1.05153298	0.985632002	9.39003754	6858
40758	11	671	1	10000000	cplex	1	0	289	11	1	33	0	1	0	274	274	0.0558109991	0.599820018	1.08169901	1.03257203	9.25062847	11698
40759	11	671	1	10000000	cplex	1	1	289	7	2	33	0	1	0	274	274	0.0811240003	0.376639009	0.860837996	0.963473976	9.39004803	9631
40760	11	671	1	10000000	cplex	0	0	300	11	3	33	0	1	0	274	274	0.140295997	0.667918026	1.46712697	1.33489096	9.74644089	9636
40761	11	671	1	10000000	cplex	1	1	289	1	4	33	0	1	0	274	274	0.104281999	0.125637993	0.209731996	1.45248795	9.25510406	1265
40762	11	672	1	10000000	cplex	0	1	300	6	0	29	0	1	0	274	274	0.120443001	0.402603	0.907211006	0.877802014	9.04223537	6027
40763	11	672	1	10000000	cplex	1	0	289	11	1	29	0	1	0	274	274	0.0999960005	0.440537006	0.965287983	0.883147001	8.99827671	10280
40764	11	672	1	10000000	cplex	1	1	289	7	2	29	0	1	0	274	274	0.0728060007	0.343207985	0.774524987	0.743517995	8.81600761	8464
40765	11	672	1	10000000	cplex	0	0	300	11	3	29	0	1	0	274	274	0.155365005	0.67039001	1.29159606	1.19369197	8.77828598	8468
40766	11	672	1	10000000	cplex	1	1	289	1	4	29	0	1	0	274	274	0.0840269998	0.101677001	0.183448002	1.24435699	8.81469059	1111
40767	11	673	1	10000000	cplex	0	1	300	6	0	28	0	1	0	274	274	0.0711539984	0.435274005	1.08922398	0.894701004	8.96864319	5819
40768	11	673	1	10000000	cplex	1	0	289	11	1	28	0	1	0	274	274	0.0973730013	0.364136994	0.890510023	0.855351985	8.78099918	9926
40769	11	673	1	10000000	cplex	1	1	289	7	2	28	0	1	0	274	274	0.0701989979	0.322714001	0.748624027	0.751254976	8.65723515	8172
40770	11	673	1	10000000	cplex	0	0	300	11	3	28	0	1	0	274	274	0.174780995	0.55032903	1.24221504	1.13702905	8.73977089	8176
40771	11	673	1	10000000	cplex	1	1	289	1	4	28	0	1	0	274	274	0.0729420036	0.0956090018	0.177274004	1.21598899	8.69797516	1073
40772	11	674	1	10000000	cplex	0	1	300	6	0	30	0	1	0	274	274	0.0899470001	0.404904008	0.939832985	0.882631004	10.5170097	6235
40773	11	674	1	10000000	cplex	1	0	289	11	1	30	0	1	0	274	274	0.0738560036	0.458005011	1.01003897	0.923465014	8.83141136	10635
40774	11	674	1	10000000	cplex	1	1	289	7	2	30	0	1	0	274	274	0.0729079992	0.338707	0.794817984	0.777042985	8.97724247	8756
40775	11	674	1	10000000	cplex	0	0	300	11	3	30	0	1	0	274	274	0.106393002	0.630060017	1.29434896	1.22816396	8.93082523	8760
40776	11	674	1	10000000	cplex	1	1	289	1	4	30	0	1	0	274	274	0.0740329996	0.115672	0.202363998	1.32078505	11.1655273	1150
40777	11	675	1	10000000	cplex	0	1	300	6	0	32	0	1	0	274	274	0.064937003	0.687538028	1.07839298	0.986398995	8.78726482	6651
40778	11	675	1	10000000	cplex	1	0	289	11	1	32	0	1	0	274	274	0.0784609988	0.40616399	1.00357497	0.983097017	8.60172462	11344
40779	11	675	1	10000000	cplex	1	1	289	7	2	32	0	1	0	274	274	0.0809260011	0.529393971	0.900168002	0.879796982	10.7893724	9340
40780	11	675	1	10000000	cplex	0	0	300	11	3	32	0	1	0	274	274	0.164536998	0.555137992	1.36179399	1.29014599	8.68545532	9344
40781	11	675	1	10000000	cplex	1	1	289	1	4	32	0	1	0	274	274	0.078263998	0.107712999	0.203301996	1.45951998	8.57422829	1226
40782	11	676	1	10000000	cplex	0	1	300	6	0	25	0	1	0	274	274	0.0967250019	0.335985005	0.787817001	0.834589005	10.9773989	5196
40783	11	676	1	10000000	cplex	1	0	289	11	1	25	0	1	0	274	274	0.0397799984	0.518728018	0.83940202	0.788029015	9.06090355	8862
40784	11	676	1	10000000	cplex	1	1	289	7	2	25	0	1	0	274	274	0.0692069978	0.286826015	0.675433993	0.845188022	9.0972023	7296
40785	11	676	1	10000000	cplex	0	0	300	11	3	25	0	1	0	274	274	0.123016998	0.567471027	1.11664903	1.03341305	9.04425526	7300
40786	11	676	1	10000000	cplex	1	1	289	1	4	25	0	1	0	274	274	0.0639379993	0.0876199976	0.159906	1.09198701	9.08301926	958
40787	11	677	1	10000000	cplex	0	1	300	6	0	27	0	1	0	274	274	0.130191997	0.423321009	0.91117698	0.849476993	8.81878281	5611
40788	11	677	1	10000000	cplex	1	0	289	11	1	27	0	1	0	274	274	0.0666870028	0.341627985	0.855163991	0.830666006	8.42399597	9571
40789	11	677	1	10000000	cplex	1	1	289	7	2	27	0	1	0	274	274	0.0582830012	0.330045015	0.844115973	0.727002025	8.45852757	7880
40790	11	677	1	10000000	cplex	0	0	300	11	3	27	0	1	0	274	274	0.148802996	0.479636997	1.16833997	1.08270204	10.7337704	7884
40791	11	677	1	10000000	cplex	1	1	289	1	4	27	0	1	0	274	274	0.0950070024	0.105171002	0.181143999	1.20163202	8.56247616	1035
40792	11	678	1	10000000	cplex	0	1	300	6	0	31	0	1	0	274	274	0.124558002	0.416328013	0.979848981	0.94224602	9.23667526	6443
40793	11	678	1	10000000	cplex	1	0	289	11	1	31	0	1	0	274	274	0.0486479998	0.575217009	1.04559696	0.957560003	9.22891998	10989
40794	11	678	1	10000000	cplex	1	1	289	7	2	31	0	1	0	274	274	0.0761310011	0.357623011	0.844488978	0.90141499	9.01810837	9048
40795	11	678	1	10000000	cplex	0	0	300	11	3	31	0	1	0	274	274	0.160001993	0.60668999	1.39848995	1.31777203	9.10177231	9052
40796	11	678	1	10000000	cplex	1	1	289	1	4	31	0	1	0	274	274	0.0753149986	0.107518002	0.199828997	1.57411301	9.24901009	1188
40797	11	679	1	10000000	cplex	0	1	300	6	0	23	0	1	0	274	274	0.092464	0.338353008	0.766920984	0.724228978	11.3986616	4780
40798	11	679	1	10000000	cplex	1	0	289	11	1	23	0	1	0	274	274	0.0819609985	0.354220003	0.807020009	0.712191999	9.2016983	8153
40799	11	679	1	10000000	cplex	1	1	289	7	2	23	0	1	0	274	274	0.0406129993	0.275864005	0.657809019	0.637799978	9.27299404	6713
40800	11	679	1	10000000	cplex	0	0	300	11	3	23	0	1	0	274	274	0.110703997	0.46657601	1.07480204	0.947009981	9.07217598	6716
40801	11	679	1	10000000	cplex	1	1	289	1	4	23	0	1	0	274	274	0.0836199969	0.0901720002	0.149959996	0.999391019	9.08284378	881
40802	11	680	1	10000000	cplex	0	1	300	8	0	23	0	1	0	249	249	0.155335993	1.49663305	3.35201311	3.24109507	8.91874695	10872
40803	11	680	1	10000000	cplex	1	0	289	11	1	23	0	1	0	249	249	0.111790001	1.53568006	3.49427509	3.09865308	8.82269669	14754
40804	11	680	1	10000000	cplex	1	1	289	8	2	23	0	1	0	249	249	0.109637	1.45684397	3.24492311	2.82384109	8.97390938	13240
40805	11	680	1	10000000	cplex	0	0	300	11	3	23	0	1	0	249	249	0.128543004	1.64816403	3.84960008	3.42124891	8.87978363	12466
40806	11	680	1	10000000	cplex	1	1	289	1	4	23	0	1	0	249	249	0.143603995	0.146267995	0.27976501	2.22308803	8.93281269	879
40807	11	681	1	10000000	cplex	0	1	300	8	0	32	0	1	0	249	249	0.189159006	2.01823401	4.6450758	4.25566816	8.86614227	15127
40808	11	681	1	10000000	cplex	1	0	289	11	1	32	0	1	0	249	249	0.218475997	2.05843806	4.94921112	4.26929522	8.73610783	20528
40809	11	681	1	10000000	cplex	1	1	289	8	2	32	0	1	0	249	249	0.119678997	2.0950501	4.65486622	3.91876602	8.91889095	18421
40810	11	681	1	10000000	cplex	0	0	300	11	3	32	0	1	0	249	249	0.260244995	2.14847207	5.31807995	4.62776709	8.92431736	17344
40811	11	681	1	10000000	cplex	1	1	289	1	4	32	0	1	0	249	249	0.273160011	0.234347999	0.40437001	3.19903398	9.07880974	1223
40812	11	682	1	10000000	cplex	0	1	300	8	0	28	0	1	0	249	249	0.130492002	1.76393199	4.40408278	3.75024009	8.91261578	13236
40813	11	682	1	10000000	cplex	1	0	289	11	1	28	0	1	0	249	249	0.174649	1.88178897	4.41811609	3.91467905	8.90010929	17962
40814	11	682	1	10000000	cplex	1	1	289	8	2	28	0	1	0	249	249	0.165655002	1.88477802	4.07209682	3.41021705	8.81033611	16118
40815	11	682	1	10000000	cplex	0	0	300	11	3	28	0	1	0	249	249	0.144503996	2.00803208	4.83592319	4.06948614	8.8267231	15176
40816	11	682	1	10000000	cplex	1	1	289	1	4	28	0	1	0	249	249	0.185339004	0.180277005	0.345750004	2.90309811	8.8531847	1070
40817	11	683	1	10000000	cplex	0	1	300	8	0	27	0	1	0	249	249	0.269517004	1.76815796	4.04734087	3.51726103	9.04053974	12763
40818	11	683	1	10000000	cplex	1	0	289	11	1	27	0	1	0	249	249	0.131983995	1.716694	4.18272114	3.68472791	8.94433594	17320
40819	11	683	1	10000000	cplex	1	1	289	8	2	27	0	1	0	249	249	0.110402003	1.67979395	3.82927299	3.2698729	9.04994488	15543
40820	11	683	1	10000000	cplex	0	0	300	11	3	27	0	1	0	249	249	0.136930004	1.96021998	4.63291502	3.94976211	9.13717365	14634
40821	11	683	1	10000000	cplex	1	1	289	1	4	27	27	0	0	249		0.412703991	3.18878794	5.55856705	41.5423698	3.84233689	2804
40995	11	718	1	10000000	cplex	0	1	300	10	0	32	0	1	0	49	49	0.911623001	60.6886902	133.504547	309.373291	10.3343105	80702
40996	11	718	1	10000000	cplex	1	0	281	11	1	32	0	1	0	49	49	0.580798984	57.3260193	133.640076	309.557312	8.91870022	87294
30803	6	402	1	10000000	cplex	1	1	215	11	2	10	0	1	0	99	99	0.197091997	12.1788731	22.4506073	39.2807922	0.715938985	31761
40997	11	718	1	10000000	cplex	1	1	281	10	2	32	0	1	0	49	49	0.557039022	57.8700676	134.13353	306.81427	11.9702616	86888
40998	11	718	1	10000000	cplex	0	0	300	11	3	32	0	1	0	49	49	0.626814008	58.061779	134.006927	308.212646	9.33658791	81344
40999	11	718	1	10000000	cplex	1	1	281	1	4	32	0	1	0	49	49	0.718779981	16.2441597	31.0481739	101.428596	8.92189312	15907
41000	11	719	1	10000000	cplex	0	1	300	10	0	32	0	1	0	49	49	1.12741196	56.3345757	132.897751	302.784912	10.661479	80702
40867	11	693	1	10000000	cplex	0	1	300	9	0	32	0	1	0	199	199	0.59158498	9.20612335	21.5950584	30.5610218	10.1927347	31792
40868	11	693	1	10000000	cplex	1	0	289	11	1	32	0	1	0	199	199	0.277893007	9.07537842	21.1717281	30.1429901	9.23417854	36714
40869	11	693	1	10000000	cplex	1	1	289	9	2	32	0	1	0	199	199	0.30330801	8.79452229	20.4406204	30.9254475	10.545248	35293
40870	11	693	1	10000000	cplex	0	0	300	11	3	32	0	1	0	199	199	0.249153003	8.99803543	21.5796413	32.0025787	9.05209732	33344
40871	11	693	1	10000000	cplex	1	1	289	1	4	32	0	1	0	199	199	0.249968007	0.66207999	1.39365697	10.0511618	23.5569801	1684
40872	11	694	1	10000000	cplex	0	1	300	9	0	31	0	1	0	199	199	0.535749972	9.06759167	21.6093216	31.1308422	10.192379	30798
40873	11	694	1	10000000	cplex	1	0	289	11	1	31	0	1	0	199	199	0.309002995	8.76092911	20.9251938	31.4636383	9.1166029	35567
40874	11	694	1	10000000	cplex	1	1	289	9	2	31	0	1	0	199	199	0.295736015	8.62383842	20.1478233	30.989893	8.71979713	34190
40875	11	694	1	10000000	cplex	0	0	300	11	3	31	0	1	0	199	199	0.375023007	8.71621609	21.0571766	31.7333298	9.06903839	32302
40876	11	694	1	10000000	cplex	1	1	289	1	4	31	31	0	0	199		0.390671998	2.38405704	4.20031214	48.1033516	3.72464395	3045
40877	11	695	1	10000000	cplex	0	1	300	9	0	32	0	1	0	199	199	0.567103982	9.09070587	20.9547462	32.5766563	9.38566494	31792
40878	11	695	1	10000000	cplex	1	0	289	11	1	32	0	1	0	199	199	0.210447997	9.32510185	21.4587841	30.1069317	8.52764034	36714
40879	11	695	1	10000000	cplex	1	1	289	9	2	32	0	1	0	199	199	0.228354007	8.54234028	20.7391243	30.501421	17.2750702	35293
40880	11	695	1	10000000	cplex	0	0	300	11	3	32	0	1	0	199	199	0.326424003	8.82747364	21.7017803	31.2823887	8.59089375	33344
40881	11	695	1	10000000	cplex	1	1	289	1	4	32	32	0	0	199		0.51829201	2.20793796	4.12371683	33.1474991	3.78818703	3154
40882	11	696	1	10000000	cplex	0	1	300	9	0	28	0	1	0	199	199	0.554050028	8.12226009	18.6555004	26.9592266	9.39600945	27818
40883	11	696	1	10000000	cplex	1	0	289	11	1	28	0	1	0	199	199	0.243051007	8.1179924	19.0245361	25.7312946	9.47399139	32125
40884	11	696	1	10000000	cplex	1	1	289	9	2	28	0	1	0	199	199	0.264236003	7.74716282	18.2659187	25.3131313	9.11074543	30881
40885	11	696	1	10000000	cplex	0	0	300	11	3	28	0	1	0	199	199	0.335325003	7.56230211	18.8119297	26.0080776	9.06788445	29176
40886	11	696	1	10000000	cplex	1	1	289	1	4	28	0	1	0	199	199	0.532099009	0.593508005	1.04497194	7.10802603	9.32300186	1473
40887	11	697	1	10000000	cplex	0	1	300	9	0	27	0	1	0	199	199	0.784729004	7.91697407	17.7371635	24.0819664	9.31816006	26824
40888	11	697	1	10000000	cplex	1	0	289	11	1	27	0	1	0	199	199	0.257986009	7.8666172	18.3638496	24.5963974	8.98902416	30978
40889	11	697	1	10000000	cplex	1	1	289	9	2	27	0	1	0	199	199	0.257061005	7.6159339	17.5647507	24.2790661	8.80813408	29778
40890	11	697	1	10000000	cplex	0	0	300	11	3	27	0	1	0	199	199	0.305635005	7.76007986	18.4592857	25.0966778	8.63065434	28134
40891	11	697	1	10000000	cplex	1	1	289	1	4	27	0	1	0	199	199	0.515465021	0.569971025	0.997267008	6.75938797	8.88667679	1421
40892	11	698	1	10000000	cplex	0	1	300	9	0	29	0	1	0	199	199	0.545219004	8.02959919	19.0049534	26.697443	9.82090187	28811
40893	11	698	1	10000000	cplex	1	0	289	11	1	29	0	1	0	199	199	0.240845993	8.26567841	19.8185482	26.7258778	9.3992672	33272
40894	11	698	1	10000000	cplex	1	1	289	9	2	29	0	1	0	199	199	0.297495008	7.48578501	18.5197678	26.1897659	9.59883976	31984
40895	11	698	1	10000000	cplex	0	0	300	11	3	29	0	1	0	199	199	0.267940998	7.89227581	19.5977917	27.1163979	9.44523716	30218
40896	11	698	1	10000000	cplex	1	1	289	1	4	29	0	1	0	199	199	0.416799992	0.595883012	1.09671998	7.30410814	9.24160576	1526
40897	11	699	1	10000000	cplex	0	1	300	9	0	35	0	1	0	199	199	0.639792025	9.84659672	23.0417366	32.4772491	9.64522171	34772
40898	11	699	1	10000000	cplex	1	0	289	11	1	35	0	1	0	199	199	0.245026007	10.0111752	23.8102398	33.2683754	9.34076786	40156
40899	11	699	1	10000000	cplex	1	1	289	9	2	35	0	1	0	199	199	0.266757011	9.44150829	22.854908	33.1793518	9.43920135	38601
40900	11	699	1	10000000	cplex	0	0	300	11	3	35	0	1	0	199	199	0.326651007	10.0132141	24.0454674	34.2516518	9.29707432	36470
40901	11	699	1	10000000	cplex	1	1	289	1	4	35	0	1	0	199	199	0.439056009	0.704342008	1.34453905	9.33714199	9.29131985	1842
40902	11	700	1	10000000	cplex	0	1	300	10	0	42	0	1	0	99	99	0.923497975	47.0341187	112.829857	257.079987	9.40500736	84711
40903	11	700	1	10000000	cplex	1	0	281	11	1	42	0	1	0	99	99	0.534368992	49.2611504	114.837761	263.818695	8.62729359	93527
40904	11	700	1	10000000	cplex	1	1	281	10	2	42	0	1	0	99	99	0.591844022	46.3411331	111.304398	253.628693	8.64010429	92847
40905	11	700	1	10000000	cplex	0	0	300	11	3	42	0	1	0	99	99	0.650855005	48.0494576	115.62011	261.331726	8.69159222	85764
40906	11	700	1	10000000	cplex	1	1	281	1	4	42	0	1	0	99	99	0.635410011	13.5254765	25.2229023	95.8235397	8.55815983	16473
40907	11	701	1	10000000	cplex	0	1	300	10	0	36	0	1	0	99	99	0.939855993	41.184948	95.9456863	210.041595	10.4826021	72610
40908	11	701	1	10000000	cplex	1	0	281	11	1	36	0	1	0	99	99	0.489441991	40.648632	96.4157333	210.513641	9.50951958	80166
40909	11	701	1	10000000	cplex	1	1	281	10	2	36	0	1	0	99	99	0.532260001	46.2914429	96.9521027	206.490768	10.0215473	79583
40910	11	701	1	10000000	cplex	0	0	300	11	3	36	0	1	0	99	99	0.519451976	39.8875732	96.5720139	206.787628	10.1970119	73512
40911	11	701	1	10000000	cplex	1	1	281	1	4	36	0	1	0	99	99	0.597872972	11.5840921	21.8350105	76.6311417	9.42134857	14119
40912	11	702	1	10000000	cplex	0	1	300	10	0	28	0	1	0	99	99	0.800674975	32.5653152	75.3568649	149.337509	9.79577446	56474
40913	11	702	1	10000000	cplex	1	0	281	11	1	28	0	1	0	99	99	0.450331986	31.8665161	75.3501968	148.423935	9.35708809	62351
40914	11	702	1	10000000	cplex	1	1	281	10	2	28	0	1	0	99	99	0.449247003	32.984272	74.653511	147.478912	9.00001144	61898
40915	11	702	1	10000000	cplex	0	0	300	11	3	28	0	1	0	99	99	0.466780007	31.6174946	75.1505203	146.524078	8.98406029	57176
40916	11	702	1	10000000	cplex	1	1	281	1	4	28	28	0	0	99		0.642641008	9.79756832	16.8590012	31.8039665	3.89260292	11274
40917	11	703	1	10000000	cplex	0	1	300	10	0	38	0	1	0	99	99	0.831791997	44.9726524	103.323441	224.297043	10.4264641	76644
40918	11	703	1	10000000	cplex	1	0	281	11	1	38	0	1	0	99	99	0.523765028	42.4785805	109.773682	221.41153	9.83472824	84619
40919	11	703	1	10000000	cplex	1	1	281	10	2	38	0	1	0	99	99	0.575580001	42.2486076	102.166107	220.577362	9.75365067	84004
40920	11	703	1	10000000	cplex	0	0	300	11	3	38	0	1	0	99	99	0.705317974	42.4532204	103.681328	215.945938	9.8751297	77596
40921	11	703	1	10000000	cplex	1	1	281	1	4	38	0	1	0	99	99	0.663052976	12.2800293	23.1826477	85.1716232	9.65539646	14904
40922	11	704	1	10000000	cplex	0	1	300	10	0	30	0	1	0	99	99	0.864422977	39.2049026	79.5612793	158.900223	9.89588165	60508
40923	11	704	1	10000000	cplex	1	0	281	11	1	30	0	1	0	99	99	0.426986992	34.4226646	80.3208084	162.178696	8.8695612	66805
40924	11	704	1	10000000	cplex	1	1	281	10	2	30	0	1	0	99	99	0.478087991	34.1621361	80.5712433	162.995071	9.16464901	66319
40925	11	704	1	10000000	cplex	0	0	300	11	3	30	0	1	0	99	99	0.482212007	34.5657501	81.1764755	161.520477	9.22131824	61260
40926	11	704	1	10000000	cplex	1	1	281	1	4	30	0	1	0	99	99	0.73882699	9.62351513	18.4212036	59.7214966	13.5797405	11766
40927	11	705	1	10000000	cplex	0	1	300	10	0	29	0	1	0	99	99	0.807080984	34.5157127	77.8764648	153.913834	10.6852627	58535
40928	11	705	1	10000000	cplex	1	0	280	11	1	29	0	1	0	99	99	0.419699997	32.8207245	78.8917999	157.635635	9.67230701	64921
40929	11	705	1	10000000	cplex	1	1	280	10	2	29	0	1	0	99	99	0.422156006	32.901062	77.852211	153.284744	9.72229099	64455
40930	11	705	1	10000000	cplex	0	0	300	11	3	29	0	1	0	99	99	0.44856599	31.9723072	77.6207047	154.315201	9.66620636	59218
40931	11	705	1	10000000	cplex	1	1	280	1	4	29	29	0	0	99		0.366596997	6.28263617	12.0496225	60.8112946	3.79239702	5791
40935	11	706	1	10000000	cplex	0	1	300	10	0	30	0	1	0	99	99	0.509536028	32.5231972	70.1647644	158.39093	9.30503178	60508
40936	11	706	1	10000000	cplex	1	0	281	11	1	30	0	1	0	99	99	0.422711015	31.8979855	70.1674194	161.601028	9.13130379	66805
40937	11	706	1	10000000	cplex	1	1	281	10	2	30	0	1	0	99	99	0.462922007	31.9402294	69.4352417	162.719543	9.71619511	66319
40938	11	706	1	10000000	cplex	0	0	300	11	3	30	0	1	0	99	99	0.57692802	32.6246338	71.3071136	163.232681	8.94764423	61260
40939	11	706	1	10000000	cplex	1	1	281	1	4	30	0	1	0	99	99	0.792375028	9.28561687	16.3718891	59.7233238	8.90287304	11766
40940	11	707	1	10000000	cplex	0	1	300	10	0	29	0	1	0	99	99	0.616388977	31.6148605	68.0116806	149.768906	9.07847881	58491
40941	11	707	1	10000000	cplex	1	0	281	11	1	29	0	1	0	99	99	0.434114009	31.4755592	67.839325	151.330154	9.07357788	64578
40942	11	707	1	10000000	cplex	1	1	281	10	2	29	0	1	0	99	99	0.487186998	31.9442387	67.6891937	151.73793	8.91863441	64108
40943	11	707	1	10000000	cplex	0	0	300	11	3	29	0	1	0	99	99	0.543151975	31.6439953	69.2452316	154.291702	8.93168926	59218
40944	11	707	1	10000000	cplex	1	1	281	1	4	29	0	1	0	99	99	0.632153988	9.26369953	15.9406891	55.461895	9.75728798	11374
40945	11	708	1	10000000	cplex	0	1	300	10	0	34	0	1	0	99	99	0.625057995	37.4681358	80.9965286	185.09761	9.10854435	68576
40946	11	708	1	10000000	cplex	1	0	281	11	1	34	0	1	0	99	99	0.479696006	36.264698	80.922081	182.968567	8.95413017	75712
40947	11	708	1	10000000	cplex	1	1	281	10	2	34	0	1	0	99	99	0.631595016	37.2930374	79.7620392	185.787354	8.93199253	75162
40948	11	708	1	10000000	cplex	0	0	300	11	3	34	0	1	0	99	99	0.530704021	37.0531235	81.5269318	190.291199	8.90409184	69428
40949	11	708	1	10000000	cplex	1	1	281	1	4	34	0	1	0	99	99	0.688217998	10.8373461	18.3934422	69.9599915	8.92630577	13335
40950	11	709	1	10000000	cplex	0	1	300	10	0	46	0	1	0	99	99	0.673736989	50.4241982	113.726128	286.934814	8.80770683	92779
40951	11	709	1	10000000	cplex	1	0	281	11	1	46	0	1	0	99	99	0.565694988	50.1374741	112.071938	283.449402	9.04651356	102434
40952	11	709	1	10000000	cplex	1	1	281	10	2	46	0	1	0	99	99	0.655303001	49.9488754	111.144096	279.979126	9.06390095	101689
40953	11	709	1	10000000	cplex	0	0	300	11	3	46	0	1	0	99	99	0.79864198	50.9526787	113.295624	282.793823	8.77140903	93932
40954	11	709	1	10000000	cplex	1	1	281	1	4	46	0	1	0	99	99	0.658536971	14.6871071	24.9832249	106.878403	10.4833679	18041
40955	11	710	1	10000000	cplex	0	1	300	10	0	36	0	1	0	49	49	0.725147009	62.469429	136.752319	364.13089	8.66594696	90789
40956	11	710	1	10000000	cplex	1	0	281	11	1	36	0	1	0	49	49	0.636012971	61.4940376	135.240082	356.252319	8.66902256	98206
40957	11	710	1	10000000	cplex	1	1	281	10	2	36	0	1	0	49	49	0.678458989	61.0590973	137.546646	357.261322	8.66388321	97749
40958	11	710	1	10000000	cplex	0	0	300	11	3	36	0	1	0	49	49	0.69036299	61.6743164	139.744232	361.025696	8.61692619	91512
40959	11	710	1	10000000	cplex	1	1	281	1	4	36	0	1	0	49	49	0.887172997	18.4683609	31.9980011	123.269043	10.1030293	17896
40960	11	711	1	10000000	cplex	0	1	300	10	0	28	0	1	0	49	49	0.663886011	47.9587822	107.211052	256.500671	9.06030941	70614
40961	11	711	1	10000000	cplex	1	0	281	11	1	28	0	1	0	49	49	0.488649994	47.7174225	107.026169	256.135864	9.6816473	76382
40962	11	711	1	10000000	cplex	1	1	281	10	2	28	0	1	0	49	49	0.537078023	47.6670418	107.952286	262.428528	8.99370003	76027
40963	11	711	1	10000000	cplex	0	0	300	11	3	28	0	1	0	49	49	0.531858981	49.8364372	107.255577	253.682693	9.0211792	71176
40964	11	711	1	10000000	cplex	1	1	281	1	4	28	0	1	0	49	49	0.503796995	14.234766	25.0521088	85.3381958	9.11840725	13919
40965	11	712	1	10000000	cplex	0	1	300	10	0	31	0	1	0	49	49	0.63568598	53.377533	119.329048	284.3461	8.8652916	78226
40966	11	712	1	10000000	cplex	1	0	280	11	1	31	0	1	0	49	49	0.499424994	52.7553215	120.434471	288.199188	9.1058569	84921
40967	11	712	1	10000000	cplex	1	1	280	10	2	31	0	1	0	49	49	0.710319996	52.8238144	119.176292	282.590637	8.94589615	84531
40968	11	712	1	10000000	cplex	0	0	300	11	3	31	0	1	0	49	49	0.644856989	53.0203819	120.863747	285.206757	9.23699093	78802
40969	11	712	1	10000000	cplex	1	1	280	1	4	31	99	0	2.19354796	49	224	0.291474998	0.147205994	0.235621005	0.64132601	14.6290255	543
40970	11	713	1	10000000	cplex	0	1	300	10	0	31	0	1	0	49	49	0.68246001	53.5029373	121.438759	301.341705	9.03412628	78193
40971	11	713	1	10000000	cplex	1	0	280	11	1	31	0	1	0	49	49	0.566277027	53.5060577	122.522919	293.618042	9.22275352	84921
40972	11	713	1	10000000	cplex	1	1	280	10	2	31	0	1	0	49	49	0.62647599	53.3623695	123.330681	294.351288	9.07700062	84531
40973	11	713	1	10000000	cplex	0	0	300	11	3	31	0	1	0	49	49	0.710394979	52.8531723	122.767166	288.105194	9.16302586	78802
40974	11	713	1	10000000	cplex	1	1	280	1	4	31	31	0	0	49		0.0892189965	0.721333981	1.24986005	9.53072357	3.7666049	2496
40975	11	714	1	10000000	cplex	0	1	300	10	0	41	0	1	0	49	49	1.01193094	72.7244186	166.462524	427.725159	9.99021912	103399
40976	11	714	1	10000000	cplex	1	0	281	11	1	41	0	1	0	49	49	0.702331007	72.7514038	167.924393	433.762482	9.41823673	111845
40702	11	660	1	10000000	cplex	0	1	300	3	0	24	0	1	0	299	299	0.0234329998	0.0203600004	0.0177779999	0.0305419993	11.8731861	432
40703	11	660	1	10000000	cplex	1	0	290	11	1	24	0	1	0	299	299	0.011713	0.00508699985	0.00960399956	0.00948700029	10.5060873	1008
40704	11	660	1	10000000	cplex	1	1	290	3	2	24	0	1	0	299	299	0.0120620001	0.00219599996	0.00313100009	0.00774199981	9.88150597	432
40705	11	660	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.00562399998	0.00297100004	0.00488100015	0.0103909997	9.63636971	1008
40706	11	660	1	10000000	cplex	1	1	290	1	4	24	0	1	0	299	299	0.0125850001	0.0024329999	0.00341499993	0.0167759992	9.82824135	204
40977	11	714	1	10000000	cplex	1	1	281	10	2	41	0	1	0	49	49	0.640357971	71.091011	163.887543	424.316101	9.62336731	111325
40978	11	714	1	10000000	cplex	0	0	300	11	3	41	0	1	0	49	49	0.747367978	73.1452026	169.250748	432.984589	12.7979956	104222
40979	11	714	1	10000000	cplex	1	1	281	1	4	41	0	1	0	49	49	0.948237002	20.1920147	38.3644485	149.113586	9.4974308	20381
40980	11	715	1	10000000	cplex	0	1	300	10	0	35	0	1	0	49	49	1.04399002	64.0895844	144.720322	353.341492	16.7871399	88267
40981	11	715	1	10000000	cplex	1	0	281	11	1	35	0	1	0	49	49	0.605602026	62.1275406	145.179947	352.246674	8.81833267	95478
40982	11	715	1	10000000	cplex	1	1	281	10	2	35	0	1	0	49	49	0.656949997	60.7719688	142.78421	342.908295	8.93672562	95033
40983	11	715	1	10000000	cplex	0	0	300	11	3	35	0	1	0	49	49	0.607363999	62.3682899	146.958954	350.768311	9.00305653	88970
40707	11	661	1	10000000	cplex	0	1	300	3	0	23	0	1	0	299	299	0.00531599997	0.00178000005	0.00262799999	0.00888099987	9.63787174	414
40708	11	661	1	10000000	cplex	1	0	290	11	1	23	0	1	0	299	299	0.00867700018	0.00258799992	0.004617	0.0097319996	9.72202396	966
40709	11	661	1	10000000	cplex	1	1	290	3	2	23	0	1	0	299	299	0.00690799998	0.00135000004	0.00263	0.0070150001	9.58447456	414
40710	11	661	1	10000000	cplex	0	0	300	11	3	23	0	1	0	299	299	0.00469300011	0.00159400003	0.00448000012	0.00928399991	9.27075481	966
40711	11	661	1	10000000	cplex	1	1	290	1	4	23	0	1	0	299	299	0.00692699989	0.00116700004	0.00307699991	0.0167820007	9.35309982	195
40712	11	662	1	10000000	cplex	0	1	300	3	0	36	0	1	0	299	299	0.00761999981	0.00205800007	0.0035300001	0.00934400037	9.31395721	648
40713	11	662	1	10000000	cplex	1	0	290	11	1	36	0	1	0	299	299	0.0107140001	0.00262399996	0.00654300023	0.0125940004	9.34260178	1512
40714	11	662	1	10000000	cplex	1	1	290	3	2	36	0	1	0	299	299	0.010547	0.00135999999	0.00350699993	0.010822	9.37314224	648
40715	11	662	1	10000000	cplex	0	0	300	11	3	36	0	1	0	299	299	0.00549300015	0.00202000001	0.00645900005	0.0128969997	9.50572014	1512
40716	11	662	1	10000000	cplex	1	1	290	1	4	36	0	1	0	299	299	0.00824000034	0.00152799999	0.00408500014	0.0204579998	9.74270916	306
40717	11	663	1	10000000	cplex	0	1	300	3	0	24	0	1	0	299	299	0.00522299996	0.00105099997	0.00249499991	0.00804900005	9.67041206	432
40718	11	663	1	10000000	cplex	1	0	290	11	1	24	0	1	0	299	299	0.00793700013	0.00168099999	0.0045380001	0.00949999969	9.5189333	1008
40719	11	663	1	10000000	cplex	1	1	290	3	2	24	0	1	0	299	299	0.00714700017	0.000855999999	0.00250199996	0.00782900024	9.52564716	432
40720	11	663	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.00506999996	0.00177099998	0.00455799978	0.00912300032	9.74457169	1008
40721	11	663	1	10000000	cplex	1	1	290	1	4	24	0	1	0	299	299	0.0114890002	0.00154299999	0.00516200019	0.0206790008	9.37279797	204
40722	11	664	1	10000000	cplex	0	1	300	3	0	28	0	1	0	299	299	0.0042940001	0.000867000024	0.00290099997	0.0088849999	9.1950388	504
40723	11	664	1	10000000	cplex	1	0	290	11	1	28	0	1	0	299	299	0.00873200037	0.00176599994	0.00522600021	0.0105870003	9.25021362	1176
40724	11	664	1	10000000	cplex	1	1	290	3	2	28	0	1	0	299	299	0.00716400007	0.000866000017	0.00281800004	0.00867099967	9.1184988	504
40725	11	664	1	10000000	cplex	0	0	300	11	3	28	0	1	0	299	299	0.00606000004	0.00178199995	0.00518300012	0.0110459998	9.35619736	1176
40726	11	664	1	10000000	cplex	1	1	290	1	4	28	0	1	0	299	299	0.0085789999	0.00131900003	0.00319200009	0.0175039992	9.57378864	238
40727	11	665	1	10000000	cplex	0	1	300	3	0	22	0	1	0	299	299	0.00459699985	0.000861999986	0.00231199991	0.00716099981	9.2467947	396
40728	11	665	1	10000000	cplex	1	0	290	11	1	22	0	1	0	299	299	0.00757799996	0.00136899995	0.00415300019	0.00868900027	9.15633011	924
40729	11	665	1	10000000	cplex	1	1	290	3	2	22	0	1	0	299	299	0.00627199979	0.000696000003	0.00231899996	0.00791000016	9.12541103	396
40730	11	665	1	10000000	cplex	0	0	300	11	3	22	0	1	0	299	299	0.00336800003	0.00113600004	0.00411200011	0.00977099966	9.06719398	924
40731	11	665	1	10000000	cplex	1	1	290	1	4	22	0	1	0	299	299	0.00721800001	0.000854999991	0.00258999993	0.015904	8.98386288	187
40732	11	666	1	10000000	cplex	0	1	300	3	0	24	0	1	0	299	299	0.00502200006	0.000882999972	0.00253099995	0.00927700009	8.69705391	432
40733	11	666	1	10000000	cplex	1	0	290	11	1	24	0	1	0	299	299	0.00690300018	0.00147699995	0.00447699986	0.0114580002	8.54162025	1008
43152	8	488	1	10000000	cplex	1	1	282	2	2	21	0	1	0	299	299	0.00615700008	0.00120699999	0.002569	0.0298730005	0.101002999	315
43153	8	488	1	10000000	cplex	0	0	300	11	3	21	0	1	0	299	299	0.00282500009	0.00161599996	0.00475900015	0.129271999	0.0983899981	882
43154	8	488	1	10000000	cplex	1	1	282	1	4	21	0	1	0	299	299	0.006207	0.00156200002	0.00347999996	0.0342970006	0.112690002	178
43155	8	489	1	10000000	cplex	0	1	300	2	0	21	0	1	0	299	299	0.00295899995	0.00115799997	0.002568	0.0344800018	0.0985890031	315
43156	8	489	1	10000000	cplex	1	0	282	11	1	21	0	1	0	299	299	0.00641300017	0.00167300005	0.00511500007	0.0985580012	0.101705998	882
43157	8	489	1	10000000	cplex	1	1	282	2	2	21	0	1	0	299	299	0.00635399995	0.00115999999	0.00254300004	0.0400969982	0.107238002	315
43158	8	489	1	10000000	cplex	0	0	300	11	3	21	0	1	0	299	299	0.00301599992	0.00163099996	0.00478099985	0.0379000008	0.097773999	882
43159	8	489	1	10000000	cplex	1	1	282	1	4	21	0	1	0	299	299	0.0057620001	0.001544	0.00345299998	0.0430979989	0.102906004	178
43160	8	490	1	10000000	cplex	0	1	300	6	0	35	0	1	0	274	274	0.140830994	0.580456972	1.227772	0.921350002	0.144007996	7020
43161	8	490	1	10000000	cplex	1	0	270	11	1	35	0	1	0	274	274	0.0117939999	0.0835079998	0.214279994	0.230132997	0.143014997	17220
43162	8	490	1	10000000	cplex	1	1	270	8	2	35	0	1	0	274	274	0.0126219997	0.071006	0.170203999	0.188988999	0.137128994	13317
43163	8	490	1	10000000	cplex	0	0	300	11	3	35	0	1	0	274	274	0.0776010007	0.831214011	1.64307702	1.29321694	0.154171005	10220
43164	8	490	1	10000000	cplex	1	1	270	1	4	35	35	0	0	274		0.0812209994	0.638087988	1.014009	11.3894949	0.0392890014	3249
42167	9	598	1	10000000	cplex	1	1	245	10	2	34	0	1	0	49	49	0.282357007	23.947401	74.3050919	120.081306	0.509343982	73063
42168	9	598	1	10000000	cplex	0	0	300	11	3	34	0	1	0	49	49	0.345548987	27.7519283	83.3785324	100.148132	0.482446998	63550
42169	9	598	1	10000000	cplex	1	1	245	1	4	34	0	1	0	49	49	0.277902007	8.81689739	17.6436558	176.733337	0.492318004	15183
42170	9	599	1	10000000	cplex	0	1	300	9	0	48	0	1	0	49	49	0.344449013	26.1476631	79.2037659	125.670868	0.265484989	60197
42171	9	599	1	10000000	cplex	1	0	245	11	1	48	0	1	0	49	49	0.243183002	25.7057228	77.6379089	97.2074738	0.283681005	76932
42172	9	599	1	10000000	cplex	1	1	245	10	2	48	0	1	0	49	49	0.285971999	23.9050961	75.1254272	124.214493	0.284673989	73063
42173	9	599	1	10000000	cplex	0	0	300	11	3	48	0	1	0	49	49	0.328500986	27.4551334	82.2223511	99.2117386	0.312826008	63550
42174	9	599	1	10000000	cplex	1	1	245	1	4	48	57	0.958333015	1.14583302	49	49	0.272583991	7.41573811	17.5683117	149.011902	0.232552007	15183
42092	9	586	1	10000000	cplex	0	1	300	9	0	37	0	1	0	99	99	0.627821982	38.810688	82.0377884	241.605225	0.826710999	71414
42093	9	586	1	10000000	cplex	1	0	245	11	1	37	0	1	0	99	99	0.393227994	35.7174339	79.3243484	186.148407	0.831233978	95174
42094	9	586	1	10000000	cplex	1	1	245	10	2	37	0	1	0	99	99	0.404404998	37.4039841	77.5531158	232.972275	0.787721992	90382
42095	9	586	1	10000000	cplex	0	0	300	11	3	37	0	1	0	99	99	0.602232993	40.3615074	87.6701736	194.615845	0.81508702	75554
42096	9	586	1	10000000	cplex	1	1	245	1	4	37	37	0	0	99		0.844987988	14.1207933	22.3091431	219.327576	0.0784680024	5565
40986	11	716	1	10000000	cplex	1	0	281	11	1	27	0	1	0	49	49	0.471554011	47.8802605	109.640762	247.362488	24.9059658	73654
40987	11	716	1	10000000	cplex	1	1	281	10	2	27	0	1	0	49	49	0.575139999	45.8996544	110.055473	240.877548	9.63992214	73311
40988	11	716	1	10000000	cplex	0	0	300	11	3	27	0	1	0	49	49	0.615873992	47.5069695	110.768173	241.275375	9.71469116	68634
40989	11	716	1	10000000	cplex	1	1	281	1	4	27	0	1	0	49	49	0.655970991	13.5479584	25.7324066	83.4788971	9.26871681	13422
40990	11	717	1	10000000	cplex	0	1	300	10	0	28	0	1	0	49	49	1.24716306	52.2978554	112.878212	260.318298	9.73071289	70614
40991	11	717	1	10000000	cplex	1	0	281	11	1	28	0	1	0	49	49	0.444669992	49.0950394	114.888741	256.653961	9.01634884	76382
40992	11	717	1	10000000	cplex	1	1	281	10	2	28	0	1	0	49	49	0.579936981	48.2098427	113.628845	257.562195	9.0962944	76027
40993	11	717	1	10000000	cplex	0	0	300	11	3	28	0	1	0	49	49	0.647553027	48.0186348	115.39254	252.823685	9.82361984	71176
40994	11	717	1	10000000	cplex	1	1	281	1	4	28	0	1	0	49	49	0.630807996	14.5746861	27.2921391	86.2074203	8.9522438	13919
40033	10	600	1	10000000	cplex	0	1	300	3	0	26	0	1	0	299	299	0.0240940005	0.020761	0.0179060008	0.0339739993	1.91109896	468
40034	10	600	1	10000000	cplex	1	0	286	11	1	26	0	1	0	299	299	0.0136409998	0.00596599979	0.0110299997	0.0115839997	2.70469594	1092
40984	11	715	1	10000000	cplex	1	1	281	1	4	35	0	1	0	49	49	0.703552008	17.7644539	33.6675644	118.802559	9.09759521	17398
40985	11	716	1	10000000	cplex	0	1	300	10	0	27	0	1	0	49	49	0.968806982	48.8218117	111.380058	250.781479	9.9352169	68092
43165	8	491	1	10000000	cplex	0	1	300	6	0	57	0	1	0	274	274	0.210352004	0.89606303	2.0275259	1.51738906	0.140184999	11967
43166	8	491	1	10000000	cplex	1	0	270	11	1	57	0	1	0	274	274	0.0185790006	0.152801007	0.359890997	0.378634989	0.124513	28044
43167	8	491	1	10000000	cplex	1	1	270	8	2	57	0	1	0	274	274	0.0142219998	0.441742003	0.291418999	0.308248997	0.138559997	21688
43168	8	491	1	10000000	cplex	0	0	300	11	3	57	0	1	0	274	274	0.196740001	1.04521799	2.68078899	2.06551003	0.130263001	16644
43169	8	491	1	10000000	cplex	1	1	270	1	4	57	57	0	0	274		0.0860309973	1.33325696	2.18456697	22.3435631	0.0443020016	4545
43170	8	492	1	10000000	cplex	0	1	300	6	0	68	0	1	0	274	274	0.177990004	1.29557204	2.39840603	1.80454695	0.107261002	14277
43171	8	492	1	10000000	cplex	1	0	270	11	1	68	0	1	0	274	274	0.0217160005	0.171302006	0.430579007	0.498755991	0.131852001	33456
43172	8	492	1	10000000	cplex	1	1	270	8	2	68	0	1	0	274	274	0.0192009993	0.141328007	0.336650014	0.386747003	0.128630996	25874
43173	8	492	1	10000000	cplex	0	0	300	11	3	68	0	1	0	274	274	0.174107	1.28478897	3.24681306	2.69942689	0.125028998	19856
43174	8	492	1	10000000	cplex	1	1	270	1	4	68	68	0	0	274		0.102868997	1.46135998	2.57407308	26.1229763	0.0453669988	5422
43175	8	493	1	10000000	cplex	0	1	300	6	0	68	0	1	0	274	274	0.145623997	1.10601795	2.42876697	1.82627404	0.114561997	14277
43176	8	493	1	10000000	cplex	1	0	270	11	1	68	0	1	0	274	274	0.0211110003	0.190433994	0.418974996	0.551841021	0.110271998	33456
43177	8	493	1	10000000	cplex	1	1	270	8	2	68	0	1	0	274	274	0.0208260007	0.137824997	0.338131994	0.389863014	0.115222	25874
43178	8	493	1	10000000	cplex	0	0	300	11	3	68	0	1	0	274	274	0.211438999	1.59584296	3.24185395	2.47258496	0.122838996	19856
43179	8	493	1	10000000	cplex	1	1	270	1	4	68	68	0	0	274		0.0994749963	1.55519998	2.59426808	26.0852051	0.0406449996	5422
43180	8	494	1	10000000	cplex	0	1	300	6	0	35	0	1	0	274	274	0.136612996	0.528230011	1.24910796	0.937074006	0.153662995	7020
43181	8	494	1	10000000	cplex	1	0	270	11	1	35	0	1	0	274	274	0.01339	0.0885509998	0.225113004	0.232922003	0.143384993	17220
43182	8	494	1	10000000	cplex	1	1	270	8	2	35	0	1	0	274	274	0.0131719997	0.0774160028	0.181707993	0.190808997	0.158047006	13317
43183	8	494	1	10000000	cplex	0	0	300	11	3	35	0	1	0	274	274	0.125650004	0.832409978	1.74692297	1.30274701	0.146698996	10220
43184	8	494	1	10000000	cplex	1	1	270	1	4	35	35	0	0	274		0.0906540006	0.63815999	1.07622194	12.1444197	0.0474799983	3249
43185	8	495	1	10000000	cplex	0	1	300	6	0	33	0	1	0	274	274	0.135449007	0.515901983	1.16166794	0.85443902	0.143740997	6619
43186	8	495	1	10000000	cplex	1	0	270	11	1	33	0	1	0	274	274	0.013448	0.0935819969	0.219456002	0.218686	0.147870004	16236
43187	8	495	1	10000000	cplex	1	1	270	8	2	33	0	1	0	274	274	0.0144790001	0.0792410001	0.174043998	0.178657994	0.135215998	12556
43188	8	495	1	10000000	cplex	0	0	300	11	3	33	0	1	0	274	274	0.112641998	0.684423983	1.66292298	1.23297	0.120976999	9636
41792	9	540	1	10000000	cplex	0	1	300	2	0	22	0	1	0	299	299	0.0221960004	0.0185800008	0.0159590002	0.0110719996	0.723316014	330
41793	9	540	1	10000000	cplex	1	0	290	11	1	22	0	1	0	299	299	0.0101089999	0.00971100014	0.0126719996	0.00827100035	0.320248991	924
43189	8	495	1	10000000	cplex	1	1	270	1	4	33	33	0	0	274		0.0801839978	0.608738005	1.02104902	10.5456963	0.0312270001	2905
43190	8	496	1	10000000	cplex	0	1	300	6	0	33	0	1	0	274	274	0.136509001	0.516689003	1.16709006	0.849475026	0.195859	6619
43191	8	496	1	10000000	cplex	1	0	270	11	1	33	0	1	0	274	274	0.0121250004	0.0911180004	0.217167005	0.218645006	0.164419994	16236
43192	8	496	1	10000000	cplex	1	1	270	8	2	33	0	1	0	274	274	0.0142059997	0.0771540031	0.176477	0.177515	0.122671999	12556
43193	8	496	1	10000000	cplex	0	0	300	11	3	33	0	1	0	274	274	0.144722998	0.695804	1.719769	1.25609899	0.152025998	9636
43194	8	496	1	10000000	cplex	1	1	270	1	4	33	33	0	0	274		0.0726620033	0.602806985	1.02350795	11.25315	0.0403469987	2905
43195	8	497	1	10000000	cplex	0	1	300	6	0	53	0	1	0	274	274	0.227743998	0.832741022	1.91295898	1.34668899	0.0974680036	10630
43196	8	497	1	10000000	cplex	1	0	270	11	1	53	0	1	0	274	274	0.0204889998	0.14948	0.351833999	0.349029005	0.0981620029	26076
43197	8	497	1	10000000	cplex	1	1	270	8	2	53	0	1	0	274	274	0.0136289997	0.231248006	0.271995008	0.284195989	0.105111003	20166
43198	8	497	1	10000000	cplex	0	0	300	11	3	53	0	1	0	274	274	0.226129994	1.07115805	2.6755681	1.92993999	0.0962150022	15476
43199	8	497	1	10000000	cplex	1	1	270	1	4	53	53	0	0	274		0.110004999	0.886371017	1.61330402	15.8437338	0.0415990017	4921
43200	8	498	1	10000000	cplex	0	1	300	6	0	53	0	1	0	274	274	0.181897998	0.780683994	1.85082901	1.34397304	0.0972279981	10630
43201	8	498	1	10000000	cplex	1	0	270	11	1	53	0	1	0	274	274	0.0155339995	0.137942001	0.341852009	0.347591013	0.0948169976	26076
43202	8	498	1	10000000	cplex	1	1	270	8	2	53	0	1	0	274	274	0.018189	0.112099998	0.271566987	0.288134009	0.103657	20166
43203	8	498	1	10000000	cplex	0	0	300	11	3	53	0	1	0	274	274	0.175576001	0.989481986	2.60271692	1.97248602	0.0955870003	15476
43204	8	498	1	10000000	cplex	1	1	270	1	4	53	53	0	0	274		0.103315003	0.853250027	1.58023596	14.6052303	0.0268879998	4921
43205	8	499	1	10000000	cplex	0	1	300	6	0	33	0	1	0	274	274	0.126247004	0.493986994	1.15253794	0.876132011	0.130860999	6619
43206	8	499	1	10000000	cplex	1	0	270	11	1	33	0	1	0	274	274	0.0119869998	0.0795459971	0.205805004	0.219408005	0.144675002	16236
43207	8	499	1	10000000	cplex	1	1	270	8	2	33	0	1	0	274	274	0.011442	0.0723560005	0.171348006	0.179296002	0.138116002	12556
43208	8	499	1	10000000	cplex	0	0	300	11	3	33	0	1	0	274	274	0.135961995	0.616513014	1.62232006	1.28241503	0.146546006	9636
43209	8	499	1	10000000	cplex	1	1	270	1	4	33	33	0	0	274		0.0754370019	0.565289021	1.01028204	10.2047567	0.0393900014	2905
43210	8	500	1	10000000	cplex	0	1	300	2	0	10	40	1	4	249	299	0.00154199998	0.000391000009	0.00118499994	0.00769999996	0.146400005	150
43211	8	500	1	10000000	cplex	1	0	282	11	1	10	40	1	4	249	299	0.00446600001	0.000538999971	0.00236200006	0.00836999994	0.150526002	420
43212	8	500	1	10000000	cplex	1	1	282	2	2	10	40	1	4	249	299	0.00449900003	0.000322999986	0.00117599999	0.00735299988	0.14858	150
43213	8	500	1	10000000	cplex	0	0	300	11	3	10	40	1	4	249	299	0.00157800002	0.000538999971	0.00236600009	0.00882900041	0.157860994	420
43214	8	500	1	10000000	cplex	1	1	282	1	4	10	40	1	4	249	299	0.00456300005	0.000463000004	0.00148099998	0.0133109996	0.148706004	85
43215	8	501	1	10000000	cplex	0	1	300	8	0	5	3	1	0.600000024	249	263	0.0488799997	0.192325994	0.440366	0.529309988	0.189358994	1772
43216	8	501	1	10000000	cplex	1	0	262	11	1	5	3	1	0.600000024	249	263	0.00776800001	0.0435689986	0.0970709994	0.148065999	0.194029003	3585
43217	8	501	1	10000000	cplex	1	1	262	9	2	5	3	1	0.600000024	249	263	0.00801299978	0.0399659984	0.0890860036	0.158942997	0.184686005	3278
43218	8	501	1	10000000	cplex	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0379140005	0.283751994	0.508701026	0.559907019	0.233746007	2010
43219	8	501	1	10000000	cplex	1	1	262	1	4	5	5	0	0	249		0.0205620006	0.151237994	0.243809	3.40737295	0.0465690009	296
43220	8	502	1	10000000	cplex	0	1	300	9	0	11	0	1	0	249	249	0.107155003	0.762510002	1.86452401	2.33833694	0.115379997	5394
43221	8	502	1	10000000	cplex	1	0	262	11	1	11	0	1	0	249	249	0.0215429999	0.430353999	0.940339983	1.51254296	0.128747001	9482
43222	8	502	1	10000000	cplex	1	1	262	9	2	11	0	1	0	249	249	0.0366160013	0.379826009	0.913614988	1.59627199	0.123168997	8877
43223	8	502	1	10000000	cplex	0	0	300	11	3	11	0	1	0	249	249	0.0896710008	0.795442998	2.02867508	2.23725891	0.141297996	5962
43224	8	502	1	10000000	cplex	1	1	262	1	4	11	11	0	0	249		0.0452839993	0.416359007	0.731397986	9.69351959	0.0441320017	546
43225	8	503	1	10000000	cplex	0	1	300	7	0	4	0	1	0	249	250	0.050675001	0.25949499	0.591248989	1.03027201	0.259175986	1775
43226	8	503	1	10000000	cplex	1	0	270	11	1	4	0	1	0	249	250	0.0265289992	0.188338995	0.431668997	0.754465997	0.279166996	3067
43227	8	503	1	10000000	cplex	1	1	270	9	2	4	0	1	0	249	250	0.0308480002	0.175159007	0.390969992	0.726872981	0.265958011	2770
43228	8	503	1	10000000	cplex	0	0	300	11	3	4	0	1	0	249	250	0.0478519984	0.300810009	0.705033004	1.12447798	0.339592993	2128
43229	8	503	1	10000000	cplex	1	1	270	1	4	4	0	1	0	249	250	0.0278220009	0.0451299995	0.0739270002	0.741806984	0.204956993	204
43230	8	504	1	10000000	cplex	0	1	300	7	0	4	0	1	0	249	250	0.0523030013	0.267913014	0.60421598	1.090487	0.241721004	1775
43231	8	504	1	10000000	cplex	1	0	270	11	1	4	0	1	0	249	250	0.0242309999	0.189228997	0.439824998	0.764545023	0.317288995	3067
43232	8	504	1	10000000	cplex	1	1	270	9	2	4	0	1	0	249	250	0.0271099992	0.172813997	0.390459001	0.736178994	0.266851991	2770
43233	8	504	1	10000000	cplex	0	0	300	11	3	4	0	1	0	249	250	0.0486419983	0.296187013	0.710354984	1.131266	0.232203007	2128
43234	8	504	1	10000000	cplex	1	1	270	1	4	4	0	1	0	249	250	0.0254989993	0.0444179997	0.0748990029	0.796611011	0.194197997	204
43235	8	505	1	10000000	cplex	0	1	300	8	0	5	3	1	0.600000024	249	263	0.0408239998	0.182505995	0.441446006	0.52424401	0.173297003	1772
43236	8	505	1	10000000	cplex	1	0	262	11	1	5	3	1	0.600000024	249	263	0.00779799977	0.0390340015	0.0986239985	0.149068996	0.175374001	3585
43237	8	505	1	10000000	cplex	1	1	262	9	2	5	3	1	0.600000024	249	263	0.00891899969	0.04428	0.0922549963	0.159546003	0.199414998	3278
43238	8	505	1	10000000	cplex	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0419480018	0.204900995	0.501258016	0.554610014	0.193110004	2010
43239	8	505	1	10000000	cplex	1	1	262	1	4	5	5	0	0	249		0.0166829992	0.146945	0.242403001	3.38663411	0.0442299992	296
43240	8	506	1	10000000	cplex	0	1	300	8	0	5	3	1	0.600000024	249	263	0.0410710014	0.186425	0.435409009	0.516300976	0.207576007	1772
43241	8	506	1	10000000	cplex	1	0	262	11	1	5	3	1	0.600000024	249	263	0.00778499991	0.0425649993	0.0980440006	0.146917999	0.191306993	3585
43242	8	506	1	10000000	cplex	1	1	262	9	2	5	3	1	0.600000024	249	263	0.00871200021	0.0420660004	0.091554001	0.158230007	0.225492999	3278
43243	8	506	1	10000000	cplex	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0416469984	0.208342999	0.505823016	0.555710018	0.201432005	2010
43244	8	506	1	10000000	cplex	1	1	262	1	4	5	5	0	0	249		0.0165519994	0.146691993	0.237106994	3.57548499	0.0296090003	296
43245	8	507	1	10000000	cplex	0	1	300	8	0	5	3	1	0.600000024	249	263	0.0435179994	0.192910001	0.436343998	0.518751979	0.187803	1772
43246	8	507	1	10000000	cplex	1	0	262	11	1	5	3	1	0.600000024	249	263	0.00800800044	0.0380310006	0.0968950018	0.146060005	0.195877999	3585
43247	8	507	1	10000000	cplex	1	1	262	9	2	5	3	1	0.600000024	249	263	0.0085359998	0.0392820016	0.093069002	0.157167003	0.247566	3278
43248	8	507	1	10000000	cplex	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0388699993	0.199884996	0.499738008	0.550036013	0.209330007	2010
43249	8	507	1	10000000	cplex	1	1	262	1	4	5	5	0	0	249		0.0167200007	0.146687001	0.238332003	3.7113471	0.035211999	296
43250	8	508	1	10000000	cplex	0	1	300	8	0	5	3	1	0.600000024	249	263	0.0403180011	0.188639998	0.440225005	0.51217097	0.172859997	1772
43251	8	508	1	10000000	cplex	1	0	262	11	1	5	3	1	0.600000024	249	263	0.0074339998	0.0378349982	0.0970479995	0.145731002	0.195502996	3585
43252	8	508	1	10000000	cplex	1	1	262	9	2	5	3	1	0.600000024	249	263	0.00852499995	0.0403949991	0.091835998	0.155090004	0.186186001	3278
43253	8	508	1	10000000	cplex	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0412329994	0.192734003	0.491825998	0.525086999	0.212002993	2010
43254	8	508	1	10000000	cplex	1	1	262	1	4	5	5	0	0	249		0.0161780007	0.150094002	0.235697001	3.4618361	0.043451	296
43255	8	509	1	10000000	cplex	0	1	300	8	0	5	3	1	0.600000024	249	263	0.0433260016	0.185317993	0.438712001	0.528117001	0.177655995	1772
43256	8	509	1	10000000	cplex	1	0	262	11	1	5	3	1	0.600000024	249	263	0.00761399977	0.0427259989	0.0978690013	0.150354996	0.185185	3585
43257	8	509	1	10000000	cplex	1	1	262	9	2	5	3	1	0.600000024	249	263	0.00850000046	0.0397850014	0.0920469984	0.159425005	0.183387995	3278
43258	8	509	1	10000000	cplex	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0446120016	0.200424001	0.494877011	0.54974699	0.175953001	2010
43259	8	509	1	10000000	cplex	1	1	262	1	4	5	5	0	0	249		0.0154959997	0.148414001	0.243812993	3.46749902	0.0274769999	296
43260	8	510	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.244599	6.04133606	14.7938242	36.5941315	0.318244994	21462
43261	8	510	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.104456998	4.55650282	11.2163267	28.8941822	0.318426013	33149
43262	8	510	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.107412003	4.65422297	11.0120115	32.3359337	0.298345	31472
43263	8	510	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.204721004	6.14976215	15.4789858	33.3177147	0.301961988	22924
43264	8	510	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.503156006	8.81973934	14.7970638	157.504639	0	2306
43265	8	511	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.216695994	6.43070793	14.9290943	36.3865166	0.335958004	21462
43266	8	511	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.114108004	4.49807596	11.1989136	29.2726498	0.324458987	33149
43267	8	511	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.104849003	4.55349016	10.9684982	32.427803	0.344581008	31472
43268	8	511	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.207283005	6.66898584	16.0270138	33.3542519	0.350483	22924
43269	8	511	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.542418003	8.85756397	14.8267689	152.163406	0	2306
43270	8	512	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.670741975	5.93873215	14.8769588	36.6779861	0.253307998	21462
43271	8	512	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.0962179974	5.05860996	11.5132599	29.0967655	0.276502997	33149
43272	8	512	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.0988449976	4.73378086	11.3574543	31.7989979	0.309275001	31472
43273	8	512	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.253327012	6.49037218	16.1597214	33.2494087	0.28588599	22924
43274	8	512	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.478197992	8.77913666	14.9586763	153.642258	0	2306
43275	8	513	1	10000000	cplex	0	1	300	9	0	23	0	1	0	199	199	0.225994006	6.8946929	15.8885651	38.2370377	0.132386997	22438
43276	8	513	1	10000000	cplex	1	0	249	11	1	23	0	1	0	199	199	0.105033003	5.2363081	12.3707037	30.4909325	0.115552999	34656
43277	8	513	1	10000000	cplex	1	1	249	10	2	23	0	1	0	199	199	0.108002998	4.90079308	11.7083578	34.2822342	0.118571997	32902
43278	8	513	1	10000000	cplex	0	0	300	11	3	23	0	1	0	199	199	0.225914001	7.00205708	17.1304932	35.2158508	0.118193001	23966
43279	8	513	1	10000000	cplex	1	1	249	1	4	23	23	0	0	199		0.548322022	9.19215202	15.7231522	157.899994	0	2411
43280	8	514	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.28945601	6.66477203	15.4148426	36.541935	0.30390799	21462
43281	8	514	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.120811	4.88422489	11.7368412	29.2813187	0.312927008	33149
43282	8	514	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.121164002	4.6421051	11.1157417	32.3850594	0.336050987	31472
43283	8	514	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.227782995	6.67316103	16.3503857	33.5389709	0.316826999	22924
43284	8	514	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.536897004	8.66232777	14.7686834	158.01796	0	2306
43285	8	515	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.219963998	6.84806585	15.4334803	37.1583366	0.35324499	21462
43286	8	515	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.107887	4.42139578	11.3145399	29.3614578	0.340728998	33149
43287	8	515	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.115620002	4.7062211	11.2310781	32.7067947	0.352299988	31472
43288	8	515	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.247431993	6.4792552	16.0850525	33.4827919	0.291633993	22924
43289	8	515	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.507861018	8.70680428	14.7117691	151.134506	0	2306
43290	8	516	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.186446995	7.1436348	15.6422586	36.8614883	0.283354998	21462
43291	8	516	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.122080997	4.70352221	11.8183336	29.3093014	0.262109995	33149
43292	8	516	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.106017999	4.80452919	11.3425102	32.4348373	0.302724987	31472
43293	8	516	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.261747986	6.38087177	16.1000118	33.6930199	0.284251988	22924
43294	8	516	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.520129979	8.75382423	14.9082232	157.327606	0	2306
43295	8	517	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.226876006	6.51970911	15.2931213	37.3600922	0.361402988	21462
43296	8	517	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.114348002	4.52329397	11.529953	29.1587811	0.316275001	33149
43297	8	517	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.106348999	4.64527988	11.2857227	31.8638363	0.343914986	31472
43298	8	517	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.193379	6.91157579	16.6125126	34.2313614	0.337942988	22924
43299	8	517	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.560557008	8.74640656	14.9116592	157.505707	0	2306
43300	8	518	1	10000000	cplex	0	1	300	9	0	23	0	1	0	199	199	0.214279994	6.90178013	16.0656719	38.4718437	0.124426998	22438
43301	8	518	1	10000000	cplex	1	0	249	11	1	23	0	1	0	199	199	0.105538003	4.73673487	12.107254	30.600172	0.110647	34656
43302	8	518	1	10000000	cplex	1	1	249	10	2	23	0	1	0	199	199	0.105865002	4.73592281	11.5045042	33.6587944	0.112836003	32902
43303	8	518	1	10000000	cplex	0	0	300	11	3	23	0	1	0	199	199	0.225179002	6.56527281	16.9541817	36.0247574	0.112452	23966
43304	8	518	1	10000000	cplex	1	1	249	1	4	23	23	0	0	199		0.522786021	9.22752762	15.6638412	159.831757	0	2411
43305	8	519	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.206719995	6.7132802	15.9512234	36.5267029	0.353502005	21462
43306	8	519	1	10000000	cplex	1	0	249	11	1	22	0	1	0	199	199	0.089339003	5.37242317	11.8949347	29.3135815	0.301571995	33149
43307	8	519	1	10000000	cplex	1	1	249	10	2	22	0	1	0	199	199	0.115271002	4.38076115	11.1646852	31.6684589	0.330348015	31472
43308	8	519	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.220663995	6.31054783	16.1630116	33.3670845	0.327179015	22924
43309	8	519	1	10000000	cplex	1	1	249	1	4	22	22	0	0	199		0.515012026	8.77441311	14.9836836	158.007278	0	2306
43310	8	520	1	10000000	cplex	0	1	300	10	0	11	0	1	0	99	99	0.297006011	13.8929787	31.6725311	120.683151	0.248628005	21329
43311	8	520	1	10000000	cplex	1	0	249	11	1	11	0	1	0	99	99	0.189330995	12.5465794	29.7045002	101.649017	0.245088995	27906
43312	8	520	1	10000000	cplex	1	1	249	10	2	11	0	1	0	99	99	0.235430002	12.3242178	28.4875774	118.760651	0.243713006	26501
43313	8	520	1	10000000	cplex	0	0	300	11	3	11	0	1	0	99	99	0.224215999	13.1296711	31.2500305	103.745064	0.281410992	22462
43314	8	520	1	10000000	cplex	1	1	249	1	4	11	11	0	0	99		0.174309	1.31196296	2.09057999	33.4147682	0.0300939996	810
43320	8	522	1	10000000	cplex	0	1	300	10	0	3	0	1	0	99	99	0.176787004	3.46279097	7.85665178	28.4082642	0.102612004	5817
43321	8	522	1	10000000	cplex	1	0	249	11	1	3	0	1	0	99	99	0.105740003	3.28039908	7.57271099	26.3974438	0.116861999	7610
43322	8	522	1	10000000	cplex	1	1	249	10	2	3	0	1	0	99	99	0.154700994	3.2369349	7.34949684	28.2198257	0.0943299979	7227
43323	8	522	1	10000000	cplex	0	0	300	11	3	3	0	1	0	99	99	0.165638998	3.71795106	8.43171883	27.2237949	0.0754479989	6126
43324	8	522	1	10000000	cplex	1	1	249	1	4	3	3	0	0	99		0.107786	0.405930996	0.591072023	11.4166803	0.0391439982	227
43325	8	523	1	10000000	cplex	0	1	300	10	0	9	21	1	2.33333302	99	130	0.218042001	7.0517149	16.9592457	61.5986633	0.113605998	14800
43326	8	523	1	10000000	cplex	1	0	249	11	1	9	21	1	2.33333302	99	130	0.157974005	6.61985111	15.947154	55.8375664	0.117017999	20007
43327	8	523	1	10000000	cplex	1	1	249	10	2	9	21	1	2.33333302	99	130	0.168606997	6.2586298	15.1707182	59.6047745	0.113151997	18998
43328	8	523	1	10000000	cplex	0	0	300	11	3	9	21	1	2.33333302	99	130	0.233842999	7.64169979	17.516058	57.581234	0.118928999	15588
43329	8	523	1	10000000	cplex	1	1	249	1	4	9	9	0	0	99		0.156369999	1.22077203	2.03995895	30.1689758	0.0415720008	637
43335	8	525	1	10000000	cplex	0	1	300	10	0	11	0	1	0	99	99	0.297735989	12.1354103	29.6837254	120.388802	0.235754997	21329
43336	8	525	1	10000000	cplex	1	0	249	11	1	11	0	1	0	99	99	0.202634007	11.714921	28.4128056	101.750496	0.235101998	27906
43337	8	525	1	10000000	cplex	1	1	249	10	2	11	0	1	0	99	99	0.228734002	11.3248119	27.152977	118.195305	0.205530003	26501
43338	8	525	1	10000000	cplex	0	0	300	11	3	11	0	1	0	99	99	0.264477015	12.5260811	30.553484	104.032249	0.209779993	22462
43339	8	525	1	10000000	cplex	1	1	249	1	4	11	11	0	0	99		0.162171006	1.18955803	1.99677503	32.8889809	0.0403059982	810
43340	8	526	1	10000000	cplex	0	1	300	10	0	3	0	1	0	99	99	0.201095998	3.46077108	7.7748189	28.4545364	0.103382997	5817
43341	8	526	1	10000000	cplex	1	0	249	11	1	3	0	1	0	99	99	0.094388999	3.24811697	7.56436491	26.4389648	0.0989049971	7610
43342	8	526	1	10000000	cplex	1	1	249	10	2	3	0	1	0	99	99	0.132201001	3.24411011	7.30929518	28.0817757	0.100575998	7227
43343	8	526	1	10000000	cplex	0	0	300	11	3	3	0	1	0	99	99	0.167752996	3.62138009	8.34332466	27.2463512	0.103124999	6126
43344	8	526	1	10000000	cplex	1	1	249	1	4	3	3	0	0	99		0.101351	0.406879991	0.588642001	11.1051502	0.0287839994	227
43345	8	527	1	10000000	cplex	0	1	300	10	0	9	21	1	2.33333302	99	130	0.246111006	7.16964293	17.0752335	61.5564461	0.119657002	14800
43346	8	527	1	10000000	cplex	1	0	249	11	1	9	21	1	2.33333302	99	130	0.146757007	6.50519514	15.9840813	56.084713	0.120274	20007
43347	8	527	1	10000000	cplex	1	1	249	10	2	9	21	1	2.33333302	99	130	0.172037005	6.43203115	15.3391743	59.7116432	0.114715002	18998
43348	8	527	1	10000000	cplex	0	0	300	11	3	9	21	1	2.33333302	99	130	0.233974993	7.55927896	17.8304443	57.2450714	0.119465001	15588
43349	8	527	1	10000000	cplex	1	1	249	1	4	9	9	0	0	99		0.155909002	1.26340497	2.046947	29.4673595	0.044027999	637
43350	8	528	1	10000000	cplex	0	1	300	10	0	15	0	1	0	99	99	0.327035993	17.1924934	39.6857986	163.882675	0.110306002	29085
43351	8	528	1	10000000	cplex	1	0	249	11	1	15	0	1	0	99	99	0.229368001	16.0196152	38.4233742	142.520294	0.105474003	38054
43352	8	528	1	10000000	cplex	1	1	249	10	2	15	0	1	0	99	99	0.290803999	15.3262405	37.2319031	161.71434	0.0893639997	36137
43353	8	528	1	10000000	cplex	0	0	300	11	3	15	0	1	0	99	99	0.312875986	18.0210896	41.8156624	145.000885	0.101066001	30630
43354	8	528	1	10000000	cplex	1	1	249	1	4	15	15	0	0	99		0.396658987	5.40897799	9.43361473	179.939484	0	1618
43355	8	529	1	10000000	cplex	0	1	300	10	0	3	0	1	0	99	99	0.191563994	3.50882602	8.02650833	28.1795692	0.0828289986	5817
43356	8	529	1	10000000	cplex	1	0	249	11	1	3	0	1	0	99	99	0.121725	3.333143	7.79986191	26.001894	0.102609999	7610
43357	8	529	1	10000000	cplex	1	1	249	10	2	3	0	1	0	99	99	0.146700993	3.28548503	7.4661088	27.9067707	0.0974000022	7227
43358	8	529	1	10000000	cplex	0	0	300	11	3	3	0	1	0	99	99	0.168812007	3.63181496	8.30856228	26.5717373	0.0972409993	6126
43359	8	529	1	10000000	cplex	1	1	249	1	4	3	40	0	12.333333	99	19	0.200466007	1.36734796	1.99667799	39.0250549	0.127018005	337
43380	8	534	1	10000000	cplex	0	1	300	10	0	9	0	1	0	49	49	0.313593	15.485487	37.4621658	194.049789	0.152769998	21726
43381	8	534	1	10000000	cplex	1	0	249	11	1	9	0	1	0	49	49	0.228755996	15.7612991	36.9033241	180.247742	0.152034998	27366
43382	8	534	1	10000000	cplex	1	1	249	10	2	9	0	1	0	49	49	0.258946002	15.8867989	35.7605934	193.106964	0.147093996	25989
43383	8	534	1	10000000	cplex	0	0	300	11	3	9	0	1	0	49	49	0.290087998	16.8268642	38.8074379	182.44017	0.142032996	22878
43384	8	534	1	10000000	cplex	1	1	249	1	4	9	9	0	0	49		0.0595580004	0.479158998	0.794964015	13.2892456	0.0314910002	443
43390	8	536	1	10000000	cplex	0	1	300	10	0	9	0	1	0	49	49	0.361938	15.2024679	37.1926384	195.006042	0.158222005	21726
43391	8	536	1	10000000	cplex	1	0	249	11	1	9	0	1	0	49	49	0.232595995	15.6239882	37.1377602	181.105698	0.141497999	27366
43392	8	536	1	10000000	cplex	1	1	249	10	2	9	0	1	0	49	49	0.265197009	14.944293	35.4885101	193.20874	0.140856996	25989
43393	8	536	1	10000000	cplex	0	0	300	11	3	9	0	1	0	49	49	0.268236995	16.5181789	38.9853287	183.025558	0.142663002	22878
43394	8	536	1	10000000	cplex	1	1	249	1	4	9	9	0	0	49		0.0588890016	0.480084985	0.802017987	12.4944868	0.0427689999	443
43409	8	530	1	10000000	cplex	0	1	300	10	0	29	0	1	0	49	49	0.616630018	52.4962349	109.419609	731.064514	0.221766993	70006
43410	8	530	1	10000000	cplex	1	0	249	11	1	29	0	1	0	49	49	0.475665987	50.929409	108.384911	687.351257	0.216998994	88180
43411	8	530	1	10000000	cplex	1	1	249	10	2	29	0	1	0	49	49	0.460424989	50.8848228	106.312859	727.018616	0.226732001	83745
43412	8	530	1	10000000	cplex	0	0	300	11	3	29	0	1	0	49	49	0.586755991	55.8715515	115.435669	695.797546	0.195639998	73718
43413	8	530	1	10000000	cplex	1	1	249	1	4	29	32	0	0.103448004	49	125	0.335987985	3.09048295	4.92661905	78.877182	0.0963039994	2142
42501	8	480	1	10000000	cplex	0	1	300	3	0	13	0	1	0	299	299	0.0142280003	0.0164289996	0.00894100033	0.0500270016	0.116126999	234
42502	8	480	1	10000000	cplex	1	0	282	11	1	13	0	1	0	299	299	0.00701700011	0.00187399995	0.00314599997	0.0135979997	0.115033001	546
42503	8	480	1	10000000	cplex	1	1	282	3	2	13	0	1	0	299	299	0.0052459999	0.00101799995	0.00142700004	0.00791299995	0.138766006	234
42504	8	480	1	10000000	cplex	0	0	300	11	3	13	0	1	0	299	299	0.00283399993	0.00104799995	0.00303900009	0.0176069997	0.116093002	546
42505	8	480	1	10000000	cplex	1	1	282	1	4	13	0	1	0	299	299	0.00562300021	0.000903000007	0.00169099995	0.0400479995	0.127590999	110
42506	8	521	1	10000000	cplex	0	1	300	11	0	45	0	1	0	99	99	0.351316988	19.0343895	52.0788345	157.125763	0.188535005	51050
42507	8	521	1	10000000	cplex	1	0	249	11	1	45	0	1	0	99	99	0.211523995	16.8202991	48.0716705	156.451157	0.156847	63423
42508	8	521	1	10000000	cplex	1	1	249	11	2	45	0	1	0	99	99	0.227118999	17.2186432	48.1999321	154.559006	0.139060006	63423
42509	8	521	1	10000000	cplex	0	0	300	11	3	45	0	1	0	99	99	0.264183998	18.3683796	51.3108635	156.053101	0.163637996	51050
42510	8	521	1	10000000	cplex	1	1	249	1	4	45	45	0	0	99		0.0121919997	0.0933300033	0.225805998	3.17118406	0.0397880003	2765
42520	8	531	1	10000000	cplex	1	1	249	1	4	42	58	0	0.380952001	49	251	0.0152329998	0.0704879984	0.168342993	2.13678193	0.119425997	3208
42521	8	532	1	10000000	cplex	0	1	300	11	0	38	1	0.973684013	0	49	49	0.34927699	29.0701733	80.7506485	369.2677	0.127901003	63550
42522	8	532	1	10000000	cplex	1	0	249	11	1	38	1	0.973684013	0	49	49	0.262959987	25.505188	78.0254593	370.661499	0.121303	76017
42523	8	532	1	10000000	cplex	1	1	249	11	2	38	1	0.973684013	0	49	49	0.283517987	25.7107925	77.0397339	372.098145	0.119388998	76017
42524	8	532	1	10000000	cplex	0	0	300	11	3	38	1	0.973684013	0	49	49	0.349204987	27.8401814	80.9553604	373.703339	0.129932001	63550
42525	8	532	1	10000000	cplex	1	1	249	1	4	38	55	0	0.447367996	49	251	0.0147660002	0.0711290017	0.171360999	1.92612004	0.138708994	3208
42526	8	533	1	10000000	cplex	0	1	300	11	0	41	1	0.975610018	0	49	49	0.385232002	27.4431553	81.4364853	375.890472	0.141292006	63550
42527	8	533	1	10000000	cplex	1	0	249	11	1	41	1	0.975610018	0	49	49	0.233612001	26.0099964	77.8288879	376.343414	0.127373993	76017
42528	8	533	1	10000000	cplex	1	1	249	11	2	41	1	0.975610018	0	49	49	1.25035405	26.5885906	77.4522095	374.233246	0.128775999	76017
42529	8	533	1	10000000	cplex	0	0	300	11	3	41	1	0.975610018	0	49	49	0.352127999	29.5679893	82.1515274	382.841187	0.221656993	63550
42530	8	533	1	10000000	cplex	1	1	249	1	4	41	57	0	0.390244007	49	251	0.0149480002	0.0716290027	0.172301993	3.03812909	0.234236002	3208
42531	8	535	1	10000000	cplex	0	1	300	11	0	37	1	0.972972989	0	49	49	0.422764987	28.3567295	83.2859116	383.418091	0.337500006	63550
42532	8	535	1	10000000	cplex	1	0	249	11	1	37	1	0.972972989	0	49	49	0.235154003	27.0298347	79.8100128	382.336945	0.293924987	76017
42533	8	535	1	10000000	cplex	1	1	249	11	2	37	1	0.972972989	0	49	49	0.284545988	27.7376175	77.2100983	364.687378	0.222122997	76017
42534	8	535	1	10000000	cplex	0	0	300	11	3	37	1	0.972972989	0	49	49	0.342705011	28.2103271	85.5312195	378.734497	0.286226988	63550
42535	8	535	1	10000000	cplex	1	1	249	1	4	37	54	0	0.459459007	49	251	0.0159760006	0.0891050026	0.170369998	1.85896504	0.140120998	3208
42536	8	537	1	10000000	cplex	0	1	300	11	0	41	1	0.975610018	0	49	49	0.364472985	26.9874191	81.6642532	378.181213	0.158608004	63550
42537	8	537	1	10000000	cplex	1	0	249	11	1	41	1	0.975610018	0	49	49	0.26630199	27.1760998	77.9612732	376.297699	0.135454997	76017
42538	8	537	1	10000000	cplex	1	1	249	11	2	41	1	0.975610018	0	49	49	0.301191002	25.7613392	77.6534042	373.213531	0.146307006	76017
42539	8	537	1	10000000	cplex	0	0	300	11	3	41	1	0.975610018	0	49	49	0.34356901	28.2978592	80.6530304	368.606354	0.115304999	63550
42540	8	537	1	10000000	cplex	1	1	249	1	4	41	57	0	0.390244007	49	251	0.0150020001	0.0702800006	0.170794994	2.04209304	0.141835004	3208
42541	8	538	1	10000000	cplex	0	1	300	11	0	9	0	1	0	49	49	0.217491001	9.87200737	28.3618908	115.144302	0.122962996	22878
42542	8	538	1	10000000	cplex	1	0	249	11	1	9	0	1	0	49	49	0.133252993	10.7815304	27.1618614	116.086845	0.124830998	27366
42543	8	538	1	10000000	cplex	1	1	249	11	2	9	0	1	0	49	49	0.183186993	9.46174622	27.1074295	116.394249	0.126930997	27366
42544	8	538	1	10000000	cplex	0	0	300	11	3	9	0	1	0	49	49	0.199825004	9.88619137	28.3195724	115.923515	0.155762002	22878
42545	8	538	1	10000000	cplex	1	1	249	1	4	9	9	0	0	49		0.00662600016	0.0386929996	0.0859140009	2.51842904	0.0393319987	643
42546	8	539	1	10000000	cplex	0	1	300	11	0	38	1	0.973684013	0	49	49	0.366501004	30.442194	81.7197113	376.29422	0.120012	63550
42547	8	539	1	10000000	cplex	1	0	249	11	1	38	1	0.973684013	0	49	49	0.249181002	26.4214382	77.8885956	375.602539	0.109408997	76017
42548	8	539	1	10000000	cplex	1	1	249	11	2	38	1	0.973684013	0	49	49	0.269793004	26.1466751	79.643692	375.657166	0.160206005	76017
42549	8	539	1	10000000	cplex	0	0	300	11	3	38	1	0.973684013	0	49	49	0.343923002	31.1689224	82.4195023	380.570557	0.129730001	63550
42550	8	539	1	10000000	cplex	1	1	249	1	4	38	55	0	0.447367996	49	251	0.0148879997	0.0714140013	0.168184996	1.70031297	0.114376999	3208
42511	8	524	1	10000000	cplex	0	1	300	11	0	45	0	1	0	99	99	0.288313001	17.8589001	52.4564285	157.84314	0.144730002	51050
42512	8	524	1	10000000	cplex	1	0	249	11	1	45	0	1	0	99	99	0.224531993	16.9673557	48.0882568	156.286621	0.159621999	63423
42513	8	524	1	10000000	cplex	1	1	249	11	2	45	0	1	0	99	99	0.211906001	16.3133831	47.9577103	153.957062	0.131862	63423
42514	8	524	1	10000000	cplex	0	0	300	11	3	45	0	1	0	99	99	0.271829993	16.8978043	51.7221031	155.564575	0.129691005	51050
42515	8	524	1	10000000	cplex	1	1	249	1	4	45	45	0	0	99		0.0111689996	0.0794709995	0.17994	3.02220201	0.0400339998	2765
42516	8	531	1	10000000	cplex	0	1	300	11	0	42	1	0.976189971	0	49	49	0.363977998	28.0318699	81.202774	369.74292	0.149669006	63550
42517	8	531	1	10000000	cplex	1	0	249	11	1	42	1	0.976189971	0	49	49	0.251931995	26.8670979	77.3099213	371.099213	0.126270995	76017
42518	8	531	1	10000000	cplex	1	1	249	11	2	42	1	0.976189971	0	49	49	0.295706987	26.620142	77.3770905	366.248901	0.121642999	76017
42519	8	531	1	10000000	cplex	0	0	300	11	3	42	1	0.976189971	0	49	49	0.377315015	27.9199009	81.3462677	369.06427	0.125917003	63550
40035	10	600	1	10000000	cplex	1	1	286	3	2	26	0	1	0	299	299	0.0120959999	0.00250800001	0.00336099998	0.00999599975	1.52408504	468
40036	10	600	1	10000000	cplex	0	0	300	11	3	26	0	1	0	299	299	0.00607800018	0.00285300007	0.00506100012	0.0115019996	1.49857295	1092
40037	10	600	1	10000000	cplex	1	1	286	1	4	26	0	1	0	299	299	0.0115069998	0.00225399993	0.00358400005	0.0211130008	1.50664401	221
40038	10	601	1	10000000	cplex	0	1	300	3	0	27	0	1	0	299	299	0.00487599988	0.00184200006	0.00304299989	0.0105410004	1.89491606	486
40039	10	601	1	10000000	cplex	1	0	286	11	1	27	0	1	0	299	299	0.00833799969	0.00264599989	0.00528299995	0.0109649999	1.54828501	1134
40040	10	601	1	10000000	cplex	1	1	286	3	2	27	0	1	0	299	299	0.0090730004	0.00174099999	0.00302800001	0.00900600012	1.43548799	486
40041	10	601	1	10000000	cplex	0	0	300	11	3	27	0	1	0	299	299	0.00441400008	0.00178100006	0.00486099999	0.0117589999	1.42297494	1134
40042	10	601	1	10000000	cplex	1	1	286	1	4	27	0	1	0	299	299	0.00861699972	0.00156899996	0.00312300003	0.0189040005	1.43001199	229
40043	10	602	1	10000000	cplex	0	1	300	3	0	26	0	1	0	299	299	0.00441800011	0.00115300005	0.00291900011	0.0101739997	1.55168903	468
40044	10	602	1	10000000	cplex	1	0	286	11	1	26	0	1	0	299	299	0.00766200013	0.001773	0.00477299979	0.0113340002	1.50381398	1092
40045	10	602	1	10000000	cplex	1	1	286	3	2	26	0	1	0	299	299	0.00883300044	0.00111700001	0.0025859999	0.00995299965	1.51382804	468
40046	10	602	1	10000000	cplex	0	0	300	11	3	26	0	1	0	299	299	0.00545800012	0.00178499997	0.00474500004	0.0114489999	2.68512702	1092
40047	10	602	1	10000000	cplex	1	1	286	1	4	26	0	1	0	299	299	0.00888300035	0.00136899995	0.0031059999	0.0202789996	1.48916399	221
40048	10	603	1	10000000	cplex	0	1	300	3	0	26	0	1	0	299	299	0.00535799982	0.00110700005	0.00264799991	0.009509	1.62873006	468
40049	10	603	1	10000000	cplex	1	0	286	11	1	26	0	1	0	299	299	0.00749999983	0.00147899997	0.00476300018	0.0121590002	1.491171	1092
40050	10	603	1	10000000	cplex	1	1	286	3	2	26	0	1	0	299	299	0.007766	0.00110999995	0.00265299994	0.00830100011	1.49351704	468
40051	10	603	1	10000000	cplex	0	0	300	11	3	26	0	1	0	299	299	0.00497299992	0.00149900001	0.00475100009	0.0112749999	1.733132	1092
40052	10	603	1	10000000	cplex	1	1	286	1	4	26	0	1	0	299	299	0.00847900007	0.00131199998	0.00404600007	0.0209550001	1.47841299	221
40053	10	604	1	10000000	cplex	0	1	300	3	0	39	0	1	0	299	299	0.00351299997	0.001407	0.00367400004	0.0127320001	1.46930599	702
40054	10	604	1	10000000	cplex	1	0	286	11	1	39	0	1	0	299	299	0.00877500046	0.00193000003	0.0067619998	0.013727	1.45450103	1638
40055	10	604	1	10000000	cplex	1	1	286	3	2	39	0	1	0	299	299	0.00874799956	0.00116099999	0.00367500004	0.011403	1.62113702	702
40056	10	604	1	10000000	cplex	0	0	300	11	3	39	0	1	0	299	299	0.00564699993	0.00196400005	0.0068760002	0.0137360003	1.72524405	1638
40057	10	604	1	10000000	cplex	1	1	286	1	4	39	0	1	0	299	299	0.0101380004	0.00169900001	0.00434400002	0.0241560005	1.47023201	331
40058	10	605	1	10000000	cplex	0	1	300	3	0	39	0	1	0	299	299	0.00678100018	0.00140800001	0.0038399999	0.0106100002	1.46500802	702
40059	10	605	1	10000000	cplex	1	0	286	11	1	39	0	1	0	299	299	0.0108510004	0.00196800008	0.00690799998	0.0151479999	1.47523606	1638
40060	10	605	1	10000000	cplex	1	1	286	3	2	39	0	1	0	299	299	0.00965800043	0.00143900001	0.00381999998	0.0104010003	1.46612203	702
40061	10	605	1	10000000	cplex	0	0	300	11	3	39	0	1	0	299	299	0.0080810003	0.00239100005	0.0069240001	0.013603	2.40402889	1638
40062	10	605	1	10000000	cplex	1	1	286	1	4	39	0	1	0	299	299	0.0100910002	0.00146000006	0.00447600009	0.0246530008	1.57867897	331
40063	10	606	1	10000000	cplex	0	1	300	3	0	28	0	1	0	299	299	0.00424099993	0.000850000011	0.00288000004	0.00998200011	1.47671103	504
40064	10	606	1	10000000	cplex	1	0	286	11	1	28	0	1	0	299	299	0.00874499977	0.00171600003	0.00516099995	0.0120559996	1.48907602	1176
40065	10	606	1	10000000	cplex	1	1	286	3	2	28	0	1	0	299	299	0.00720900018	0.000841000001	0.0028880001	0.00965599995	1.47676694	504
40066	10	606	1	10000000	cplex	0	0	300	11	3	28	0	1	0	299	299	0.00448299991	0.00172499998	0.00521299988	0.0122999996	1.61047304	1176
40067	10	606	1	10000000	cplex	1	1	286	1	4	28	0	1	0	299	299	0.00729299989	0.00107500004	0.00323499995	0.0208330005	1.47726202	238
40068	10	607	1	10000000	cplex	0	1	300	3	0	30	0	1	0	299	299	0.00511399982	0.000967999978	0.00315900007	0.0111560002	1.52086794	540
40069	10	607	1	10000000	cplex	1	0	286	11	1	30	0	1	0	299	299	0.00897299964	0.00186299998	0.00559599977	0.0123359999	1.50073504	1260
40070	10	607	1	10000000	cplex	1	1	286	3	2	30	0	1	0	299	299	0.00814399961	0.00091599999	0.00308699999	0.00978900027	1.59383702	540
40071	10	607	1	10000000	cplex	0	0	300	11	3	30	0	1	0	299	299	0.00496400008	0.00175499998	0.00550199999	0.0108169997	1.48767602	1260
40072	10	607	1	10000000	cplex	1	1	286	1	4	30	0	1	0	299	299	0.00923699979	0.00133100001	0.00342900003	0.0213709995	1.472911	255
40073	10	608	1	10000000	cplex	0	1	300	3	0	23	0	1	0	299	299	0.00371200009	0.000736000016	0.00240999996	0.00896599982	1.53348005	414
40074	10	608	1	10000000	cplex	1	0	286	11	1	23	0	1	0	299	299	0.006635	0.00115999999	0.00439399993	0.0113770002	1.52704597	966
40075	10	608	1	10000000	cplex	1	1	286	3	2	23	0	1	0	299	299	0.00733500021	0.000812000013	0.002355	0.00784400012	1.51620996	414
40076	10	608	1	10000000	cplex	0	0	300	11	3	23	0	1	0	299	299	0.00475900015	0.00141799997	0.0043990002	0.0110090002	1.52264798	966
40077	10	608	1	10000000	cplex	1	1	286	1	4	23	0	1	0	299	299	0.00779499998	0.000852000026	0.00282300008	0.0168730002	1.63730204	195
40078	10	609	1	10000000	cplex	0	1	300	3	0	33	0	1	0	299	299	0.00663200021	0.001208	0.00344299991	0.0105419997	1.46142304	594
40079	10	609	1	10000000	cplex	1	0	286	11	1	33	0	1	0	299	299	0.00563400006	0.001651	0.00600899989	0.0140840001	1.44618499	1386
40080	10	609	1	10000000	cplex	1	1	286	3	2	33	0	1	0	299	299	0.00975899957	0.00119600003	0.00330800004	0.0106859999	1.44864094	594
40081	10	609	1	10000000	cplex	0	0	300	11	3	33	0	1	0	299	299	0.00503000012	0.00203799992	0.00604799995	0.0133819999	1.86091995	1386
40082	10	609	1	10000000	cplex	1	1	286	1	4	33	0	1	0	299	299	0.00833799969	0.00144499994	0.00369899999	0.0230570007	1.45920503	280
40083	10	610	1	10000000	cplex	0	1	300	6	0	32	0	1	0	274	274	0.173668995	0.434305996	0.915553987	0.873426974	1.42724705	6246
40084	10	610	1	10000000	cplex	1	0	265	11	1	32	0	1	0	274	274	0.0161509998	0.0858400017	0.190423995	0.216890007	1.53659296	17024
40085	10	610	1	10000000	cplex	1	1	265	7	2	32	0	1	0	274	274	0.0125040002	0.0660170019	0.140701994	0.189005002	1.44063604	12224
40086	10	610	1	10000000	cplex	0	0	300	11	3	32	0	1	0	274	274	0.123274997	0.604265988	1.349967	1.19876802	1.52985001	9344
40087	10	610	1	10000000	cplex	1	1	265	1	4	32	0	1	0	274	274	0.0126139997	0.0114219999	0.0213440005	0.0749310032	1.43976796	1109
40088	10	611	1	10000000	cplex	0	1	300	5	0	38	0	1	0	274	274	0.205640003	0.549094975	1.11353302	0.991970003	1.43687606	7228
40089	10	611	1	10000000	cplex	1	0	278	11	1	38	0	1	0	274	274	0.0570750013	0.689898014	0.735906005	0.689391017	1.41598594	14853
40090	10	611	1	10000000	cplex	1	1	278	6	2	38	0	1	0	274	274	0.0760800019	0.288789988	0.577542007	0.539025009	1.43304896	10766
40091	10	611	1	10000000	cplex	0	0	300	11	3	38	0	1	0	274	274	0.118438996	0.744700015	1.66176498	1.43305099	1.44073701	11096
40092	10	611	1	10000000	cplex	1	1	278	1	4	38	0	1	0	274	274	0.0630960017	0.0764039978	0.114873998	1.08656502	1.52182305	1205
40093	10	612	1	10000000	cplex	0	1	300	5	0	31	0	1	0	274	274	0.175310999	0.428746998	0.890977025	0.861998975	1.55340004	5897
40094	10	612	1	10000000	cplex	1	0	278	11	1	31	0	1	0	274	274	0.0634979978	0.290080011	0.630448997	0.572040021	1.42402601	12117
40095	10	612	1	10000000	cplex	1	1	278	6	2	31	0	1	0	274	274	0.0533620007	0.238086	0.476489991	0.459879994	1.42744994	8783
40096	10	612	1	10000000	cplex	0	0	300	11	3	31	0	1	0	274	274	0.113287002	0.613925993	1.29993701	1.16613698	1.41947699	9052
40097	10	612	1	10000000	cplex	1	1	278	1	4	31	0	1	0	274	274	0.063019	0.0574209988	0.0934439972	0.886538982	1.99686301	983
40098	10	613	1	10000000	cplex	0	1	300	5	0	35	0	1	0	274	274	0.136147007	0.460979998	0.995312989	0.940585017	1.46347904	6658
40099	10	613	1	10000000	cplex	1	0	278	11	1	35	0	1	0	274	274	0.0526079983	0.296716005	0.683699012	0.641806006	1.43809497	13681
40100	10	613	1	10000000	cplex	1	1	278	6	2	35	0	1	0	274	274	0.0503039993	0.251249999	0.523827016	0.510227978	1.58025897	9916
40101	10	613	1	10000000	cplex	0	0	300	11	3	35	0	1	0	274	274	0.137250006	0.620782018	1.47050703	1.32001495	1.43636596	10220
40102	10	613	1	10000000	cplex	1	1	278	1	4	35	0	1	0	274	274	0.0434379987	0.0620820001	0.106512003	0.993538022	1.42220998	1110
40103	10	614	1	10000000	cplex	0	1	300	5	0	35	0	1	0	274	274	0.124477997	1.01199496	1.03764904	0.887947977	1.45655096	6658
40104	10	614	1	10000000	cplex	1	0	278	11	1	35	0	1	0	274	274	0.0493870005	0.287167996	0.678819001	0.644927979	1.44505703	13681
40105	10	614	1	10000000	cplex	1	1	278	6	2	35	0	1	0	274	274	0.0552680008	0.269722015	0.548892021	0.506453991	1.45688498	9916
40106	10	614	1	10000000	cplex	0	0	300	11	3	35	0	1	0	274	274	0.131960005	0.748763025	1.50386202	1.328776	1.45343196	10220
40107	10	614	1	10000000	cplex	1	1	278	1	4	35	0	1	0	274	274	0.0496359989	0.0609350018	0.105678998	0.980885029	1.46520996	1110
40108	10	615	1	10000000	cplex	0	1	300	5	0	52	0	1	0	274	274	0.231242999	0.703016996	1.52597296	1.33929002	1.41177201	9892
40109	10	615	1	10000000	cplex	1	0	278	11	1	52	0	1	0	274	274	0.0708649978	0.434789985	1.03659403	0.929696023	1.386657	20326
40110	10	615	1	10000000	cplex	1	1	278	6	2	52	0	1	0	274	274	0.0678049996	0.403216004	1.35197496	0.740449011	1.40510702	14733
40111	10	615	1	10000000	cplex	0	0	300	11	3	52	0	1	0	274	274	0.184957996	1.019086	2.26037002	1.88834298	1.39840698	15184
40112	10	615	1	10000000	cplex	1	1	278	1	4	52	52	0	0	274		0.262336999	1.53748906	2.753829	13.3702641	0.400849998	3640
40113	10	616	1	10000000	cplex	0	1	300	5	0	34	0	1	0	274	274	0.190807	0.476594001	0.996810973	0.905083001	2.17440104	6467
40114	10	616	1	10000000	cplex	1	0	278	11	1	34	0	1	0	274	274	0.0597710013	0.302863985	0.694613993	0.629197001	1.695714	13290
40115	10	616	1	10000000	cplex	1	1	278	6	2	34	0	1	0	274	274	0.0654179975	0.229040995	0.504707992	0.488952011	1.47448099	9633
40116	10	616	1	10000000	cplex	0	0	300	11	3	34	0	1	0	274	274	0.106186002	0.643370986	1.58510005	1.29721403	1.48498404	9928
40117	10	616	1	10000000	cplex	1	1	278	1	4	34	0	1	0	274	274	0.0484719984	0.0543240011	0.102150999	0.964694977	1.48793101	1078
40118	10	617	1	10000000	cplex	0	1	300	5	0	32	0	1	0	274	274	0.125465006	0.414146006	0.931937993	0.886403978	1.83803701	6087
40119	10	617	1	10000000	cplex	1	0	278	11	1	32	0	1	0	274	274	0.0574849993	0.268662989	0.644997001	0.584689021	1.46533799	12508
40120	10	617	1	10000000	cplex	1	1	278	6	2	32	0	1	0	274	274	0.0465589985	0.232639998	0.497355998	0.472438008	1.55708396	9066
40121	10	617	1	10000000	cplex	0	0	300	11	3	32	0	1	0	274	274	0.125251994	0.573324025	1.38180494	1.21369898	1.46193099	9344
40122	10	617	1	10000000	cplex	1	1	278	1	4	32	0	1	0	274	274	0.0640269965	0.0593950003	0.0985359997	0.960776985	1.48442805	1014
40123	10	618	1	10000000	cplex	0	1	300	5	0	38	0	1	0	274	274	0.156294003	0.681106985	1.14340198	0.993942022	1.85988498	7228
40124	10	618	1	10000000	cplex	1	0	278	11	1	38	0	1	0	274	274	0.0528020002	0.320939004	0.780030012	0.686762989	1.63535202	14853
40125	10	618	1	10000000	cplex	1	1	278	6	2	38	0	1	0	274	274	0.0532639995	0.263110995	0.582271993	0.542928994	1.44325197	10766
40126	10	618	1	10000000	cplex	0	0	300	11	3	38	0	1	0	274	274	0.131512001	0.804895997	1.69264102	1.43036699	1.44250906	11096
40127	10	618	1	10000000	cplex	1	1	278	1	4	38	0	1	0	274	274	0.065429002	0.0592610016	0.113577001	1.03698504	1.43966103	1205
40128	10	619	1	10000000	cplex	0	1	300	5	0	38	0	1	0	274	274	0.156615004	0.495554	1.10922694	0.985387027	1.93821502	7228
40129	10	619	1	10000000	cplex	1	0	278	11	1	38	0	1	0	274	274	0.0539310016	0.324063987	0.787414014	0.688142002	1.51747298	14853
40130	10	619	1	10000000	cplex	1	1	278	6	2	38	0	1	0	274	274	0.0734160021	0.272877991	0.594062984	0.556774974	1.59567297	10766
40131	10	619	1	10000000	cplex	0	0	300	11	3	38	0	1	0	274	274	0.187381998	0.66811198	1.67242801	1.39809501	1.609815	11096
40132	10	619	1	10000000	cplex	1	1	278	1	4	38	38	0	0	274		0.214734003	1.94565594	3.46751904	38.5841446	0.410746992	2636
40133	10	620	1	10000000	cplex	0	1	300	7	0	28	0	1	0	249	249	0.259301007	1.84264302	3.96390891	3.8443141	1.48719704	12312
40134	10	620	1	10000000	cplex	1	0	259	11	1	28	0	1	0	249	249	0.0561570004	1.07655299	2.40620089	2.55120397	1.49535894	23213
40135	10	620	1	10000000	cplex	1	1	259	9	2	28	0	1	0	249	249	0.059714999	1.03471506	2.25488997	2.43253303	1.49767196	21660
40136	10	620	1	10000000	cplex	0	0	300	11	3	28	0	1	0	249	249	0.155953005	1.97564399	4.71775007	4.48266888	1.52796495	15176
40137	10	620	1	10000000	cplex	1	1	259	1	4	28	63	0	1.25	249	257	0.059427999	0.077753	0.127107993	0.240707994	2.61129594	1467
40138	10	621	1	10000000	cplex	0	1	300	7	0	20	0	1	0	249	249	0.130600005	1.32818902	2.77406096	2.70515299	1.54045403	8794
40139	10	621	1	10000000	cplex	1	0	259	11	1	20	0	1	0	249	249	0.0433349982	0.787387013	1.72657895	1.81306601	1.54862905	16581
40140	10	621	1	10000000	cplex	1	1	259	9	2	20	0	1	0	249	249	0.0635939986	1.29380405	1.62456703	1.72078001	1.54411602	15471
40141	10	621	1	10000000	cplex	0	0	300	11	3	20	0	1	0	249	249	0.154779002	1.46413195	3.33442712	3.19523001	1.56504297	10840
40142	10	621	1	10000000	cplex	1	1	259	1	4	20	0	1	0	249	249	0.0752149969	0.205766007	0.347445995	2.85486388	1.56728005	1597
40143	10	622	1	10000000	cplex	0	1	300	7	0	22	0	1	0	249	249	0.174961001	1.52614403	3.17622089	2.95636702	1.60751796	9674
40144	10	622	1	10000000	cplex	1	0	259	11	1	22	0	1	0	249	249	0.0560600013	0.834168971	1.94354999	1.96162999	3.24679399	18239
40145	10	622	1	10000000	cplex	1	1	259	9	2	22	0	1	0	249	249	0.0387100019	0.864921987	1.82637703	1.86069703	1.49640298	17018
40146	10	622	1	10000000	cplex	0	0	300	11	3	22	0	1	0	249	249	0.175421	1.58953905	3.79278111	3.48703003	1.54799402	11924
40147	10	622	1	10000000	cplex	1	1	259	1	4	22	55	0	1.5	249	257	0.0526500009	0.0607689992	0.100293003	0.185950994	1.71848202	1153
40148	10	623	1	10000000	cplex	0	1	300	7	0	29	0	1	0	249	249	0.302682996	1.81566203	4.15923595	3.90744209	1.44727004	12752
40149	10	623	1	10000000	cplex	1	0	259	11	1	29	0	1	0	249	249	0.110164002	1.10171604	2.5636251	3.23706102	1.43746698	24042
40150	10	623	1	10000000	cplex	1	1	259	9	2	29	0	1	0	249	249	0.109530002	1.07104897	2.42050505	2.52423596	1.44199598	22434
40151	10	623	1	10000000	cplex	0	0	300	11	3	29	0	1	0	249	249	0.215223998	2.1185739	4.94403601	4.579	1.46773803	15718
40152	10	623	1	10000000	cplex	1	1	259	1	4	29	62	0	1.13793099	249	257	0.0716689974	0.0736820027	0.132076994	0.239033997	1.52856302	1520
40153	10	624	1	10000000	cplex	0	1	300	7	0	28	0	1	0	249	249	0.143409997	1.86451399	3.98731709	3.82010388	1.51538098	12312
40154	10	624	1	10000000	cplex	1	0	259	11	1	28	0	1	0	249	249	0.101025	1.10329294	2.46134496	2.57595897	1.50994897	23213
40155	10	624	1	10000000	cplex	1	1	259	9	2	28	0	1	0	249	249	0.103726	1.04024506	2.2917459	2.43861103	1.51205099	21660
40156	10	624	1	10000000	cplex	0	0	300	11	3	28	0	1	0	249	249	0.196957007	2.08810806	4.78060913	4.43748283	2.14648294	15176
40157	10	624	1	10000000	cplex	1	1	259	1	4	28	63	0	1.25	249	257	0.0497349985	0.0711050034	0.124491997	0.229098007	2.69384193	1467
40158	10	625	1	10000000	cplex	0	1	300	7	0	43	0	1	0	249	249	0.249541998	2.82346201	6.1844902	5.79264402	1.49590397	18909
40159	10	625	1	10000000	cplex	1	0	259	11	1	43	0	1	0	249	249	0.0994099975	1.63595498	3.85299611	3.99169111	1.50289094	35649
40160	10	625	1	10000000	cplex	1	1	259	9	2	43	0	1	0	249	249	0.0595999993	1.63590801	3.65073609	3.80939794	1.55582905	33264
40161	10	625	1	10000000	cplex	0	0	300	11	3	43	0	1	0	249	249	0.299131006	3.11136007	7.59836006	6.79737616	1.50601602	23306
40162	10	625	1	10000000	cplex	1	1	259	1	4	43	0	1	0	249	249	0.109982997	0.450843006	0.741555989	6.71461487	1.50113595	3352
40163	10	626	1	10000000	cplex	0	1	300	7	0	26	0	1	0	249	249	0.154018998	2.42150402	3.71835709	3.55264497	1.16708004	11433
40164	10	626	1	10000000	cplex	1	0	259	11	1	26	0	1	0	249	249	0.0686739981	0.975246012	2.268893	2.35573101	1.16733301	21555
40165	10	626	1	10000000	cplex	1	1	259	9	2	26	0	1	0	249	249	0.065181002	0.950397015	2.13647389	2.25858998	1.14564598	20113
40166	10	626	1	10000000	cplex	0	0	300	11	3	26	0	1	0	249	249	0.185190007	1.87866998	4.43186378	4.14694118	1.17691195	14092
40167	10	626	1	10000000	cplex	1	1	259	1	4	26	43	0	0.653846025	249	257	0.0671250001	0.0734549984	0.120929003	0.225458995	2.81888294	1362
40168	10	627	1	10000000	cplex	0	1	300	7	0	25	0	1	0	249	249	0.186427996	1.70367897	3.668221	3.26681995	1.57545197	11164
40169	10	627	1	10000000	cplex	1	0	247	11	1	25	0	1	0	249	249	0.0346329994	0.354245007	0.844605029	0.914083004	1.54093695	22050
40170	10	627	1	10000000	cplex	1	1	247	10	2	25	0	1	0	249	249	0.0266800001	0.313409001	0.899169028	0.871164978	1.56031597	20875
40171	10	627	1	10000000	cplex	0	0	300	11	3	25	0	1	0	249	249	0.220347002	1.89168203	4.34984398	3.89817595	1.60802603	13550
40172	10	627	1	10000000	cplex	1	1	247	1	4	25	25	0	0	249		0.0400529988	0.144167006	0.244117007	1.40749705	0.411514014	1773
40173	10	628	1	10000000	cplex	0	1	300	7	0	28	0	1	0	249	249	0.176962003	1.85558105	4.01567602	4.56832981	1.46399796	12312
40174	10	628	1	10000000	cplex	1	0	259	11	1	28	0	1	0	249	249	0.0751990005	1.07173097	2.46004009	2.5568099	1.48402095	23213
40175	10	628	1	10000000	cplex	1	1	259	9	2	28	0	1	0	249	249	0.0769229978	0.980609	2.34039402	2.48749495	1.43753302	21660
40176	10	628	1	10000000	cplex	0	0	300	11	3	28	0	1	0	249	249	0.187506005	1.98186398	4.75957584	4.5311799	1.47965097	15176
40177	10	628	1	10000000	cplex	1	1	259	1	4	28	50	0	0.785713971	249	257	0.052184999	0.0686810017	0.124779001	0.234391004	2.64774203	1467
40178	10	629	1	10000000	cplex	0	1	300	7	0	20	0	1	0	249	249	0.163112	1.35862601	2.90810704	2.73657107	1.50857496	8794
40179	10	629	1	10000000	cplex	1	0	259	11	1	20	0	1	0	249	249	0.0739450008	0.772258997	1.76783705	1.79746795	1.95318902	16581
40180	10	629	1	10000000	cplex	1	1	259	9	2	20	0	1	0	249	249	0.0777819976	0.766039014	1.66724598	1.71619403	1.51590705	15471
40181	10	629	1	10000000	cplex	0	0	300	11	3	20	0	1	0	249	249	0.183620006	1.506531	3.52571511	3.24241304	1.52156401	10840
40182	10	629	1	10000000	cplex	1	1	259	1	4	20	55	0	1.75	249	257	0.028678	0.0496390015	0.091245003	0.187396005	2.37328291	1048
40183	10	630	1	10000000	cplex	0	1	300	8	0	26	0	1	0	199	199	0.345409989	7.03098392	16.3840714	23.4695168	1.45091903	25274
40184	10	630	1	10000000	cplex	1	0	267	11	1	26	0	1	0	199	199	0.225269005	7.25557089	14.9519682	21.9452057	1.45143795	34456
40185	10	630	1	10000000	cplex	1	1	267	10	2	26	0	1	0	199	199	0.171387002	6.40130901	14.6823044	21.6361885	1.50971699	33462
40186	10	630	1	10000000	cplex	0	0	300	11	3	26	0	1	0	199	199	0.293938994	7.59452581	17.3374386	24.2802963	1.45481801	27092
40187	10	630	1	10000000	cplex	1	1	267	1	4	26	0	1	0	199	199	0.302798003	1.62896001	1.60700798	2.40704608	1.494174	2740
40188	10	631	1	10000000	cplex	0	1	300	8	0	26	0	1	0	199	199	0.339192003	7.27614212	16.3966217	23.1484146	1.46477997	25274
40189	10	631	1	10000000	cplex	1	0	267	11	1	26	0	1	0	199	199	0.171950996	6.48189878	14.9318399	22.3616982	1.48648095	34456
40190	10	631	1	10000000	cplex	1	1	267	10	2	26	0	1	0	199	199	0.16223	6.35149717	14.5698566	22.0139847	1.47011805	33462
40191	10	631	1	10000000	cplex	0	0	300	11	3	26	0	1	0	199	199	0.248826995	7.71398401	17.3486462	24.5028172	1.45080602	27092
40192	10	631	1	10000000	cplex	1	1	267	1	4	26	26	0	0	199		0.240845993	1.48366594	2.50832105	6.56065702	0.381689012	3618
40193	10	632	1	10000000	cplex	0	1	300	8	0	24	0	1	0	199	199	0.327441007	7.65617418	15.0569897	21.5153866	1.47261405	23330
40194	10	632	1	10000000	cplex	1	0	267	11	1	24	0	1	0	199	199	0.193994001	5.93165922	13.6498203	20.3183384	1.50860703	31805
40195	10	632	1	10000000	cplex	1	1	267	10	2	24	0	1	0	199	199	0.153317004	5.92193222	13.4410477	20.0128765	1.51865697	30888
40196	10	632	1	10000000	cplex	0	0	300	11	3	24	0	1	0	199	199	0.330249012	6.81195784	15.9250231	22.2796745	1.48671401	25008
40197	10	632	1	10000000	cplex	1	1	267	1	4	24	0	1	0	199	199	0.345661014	0.79291898	1.44117403	2.31754899	1.46494305	2529
40198	10	633	1	10000000	cplex	0	1	300	9	0	28	0	1	0	199	199	0.303941995	8.63681221	17.6139355	25.8827152	1.47072005	27469
40199	10	633	1	10000000	cplex	1	0	253	11	1	28	0	1	0	199	199	0.127765	5.89847279	13.4219446	21.1947269	1.51800394	39909
40200	10	633	1	10000000	cplex	1	1	253	10	2	28	0	1	0	199	199	0.165127993	5.84728718	13.8037691	21.1917095	1.473225	39623
40201	10	633	1	10000000	cplex	0	0	300	11	3	28	0	1	0	199	199	0.315014005	8.17972088	18.3566322	26.4703732	1.57688606	29176
40202	10	633	1	10000000	cplex	1	1	253	1	4	28	28	0	0	199		0.164023995	0.882351995	1.57394004	6.33671999	0.389019996	2509
40203	10	634	1	10000000	cplex	0	1	300	8	0	27	0	1	0	199	199	0.305936992	7.32618523	16.7510033	24.382082	1.47528899	26246
40204	10	634	1	10000000	cplex	1	0	267	11	1	27	0	1	0	199	199	0.178789005	7.65885687	15.1621103	23.246336	1.48828399	35781
40205	10	634	1	10000000	cplex	1	1	267	10	2	27	0	1	0	199	199	0.160403997	6.49773121	14.9249725	22.9019508	1.47141802	34749
40206	10	634	1	10000000	cplex	0	0	300	11	3	27	0	1	0	199	199	0.323015004	7.73355579	17.7045612	25.2036591	1.47071004	28134
40207	10	634	1	10000000	cplex	1	1	267	1	4	27	0	1	0	199	199	0.300036013	0.882462025	1.61525905	2.65551805	1.47068596	2845
40208	10	635	1	10000000	cplex	0	1	300	9	0	22	0	1	0	199	199	0.285086989	6.38387108	13.7124062	19.36726	1.52285802	21583
40209	10	635	1	10000000	cplex	1	0	253	11	1	22	0	1	0	199	199	0.103834003	4.73831987	10.527914	15.9343138	1.56746101	31357
40210	10	635	1	10000000	cplex	1	1	253	10	2	22	0	1	0	199	199	0.128543004	4.50368786	10.5834923	15.7979803	1.52264905	31132
40211	10	635	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.26168099	6.132936	15.426981	19.9314041	1.54707503	22924
40212	10	635	1	10000000	cplex	1	1	253	1	4	22	22	0	0	199		0.171076998	0.684067011	1.19908094	4.39167404	0.392562985	1984
40213	10	636	1	10000000	cplex	0	1	300	9	0	25	0	1	0	199	199	0.338775009	6.88989019	15.6367998	22.2212601	1.49252999	24431
40214	10	636	1	10000000	cplex	1	0	267	11	1	25	0	1	0	199	199	0.141597003	6.1584568	14.0234127	20.9163322	1.51701701	33130
40215	10	636	1	10000000	cplex	1	1	267	10	2	25	0	1	0	199	199	0.188999996	6.06869411	13.7088709	20.4706841	1.53093505	32175
40216	10	636	1	10000000	cplex	0	0	300	11	3	25	0	1	0	199	199	0.287346989	7.39127111	16.4330444	23.0015163	1.60559797	26050
40217	10	636	1	10000000	cplex	1	1	267	1	4	25	25	0	0	199		0.263220012	1.89881396	3.2608521	12.6484642	0.405811012	2805
40218	10	637	1	10000000	cplex	0	1	300	9	0	28	0	1	0	199	199	0.34868899	8.71979713	17.5174599	25.3272953	1.475124	27469
40219	10	637	1	10000000	cplex	1	0	253	11	1	28	0	1	0	199	199	0.128498003	5.53566694	13.2619123	20.689045	1.475335	39909
40220	10	637	1	10000000	cplex	1	1	253	10	2	28	0	1	0	199	199	0.205319002	5.46094513	13.1657925	20.7329636	1.47879004	39623
40221	10	637	1	10000000	cplex	0	0	300	11	3	28	0	1	0	199	199	0.245367005	7.57448101	17.9618053	25.7687168	1.47178304	29176
40222	10	637	1	10000000	cplex	1	1	253	1	4	28	28	0	0	199		0.125609994	0.761982977	1.42633295	5.76811409	0.388879001	2612
40223	10	638	1	10000000	cplex	0	1	300	8	0	22	0	1	0	199	199	0.274562001	5.86360312	13.650445	19.4363384	1.53795397	21386
40224	10	638	1	10000000	cplex	1	0	267	11	1	22	0	1	0	199	199	0.181431994	5.50590992	12.5489044	18.6050453	1.54033399	29155
40225	10	638	1	10000000	cplex	1	1	267	10	2	22	0	1	0	199	199	0.137551993	5.27019978	12.1886578	18.2121792	1.535339	28314
40226	10	638	1	10000000	cplex	0	0	300	11	3	22	0	1	0	199	199	0.216987997	7.28683901	14.3313761	20.2390881	1.51203799	22924
40227	10	638	1	10000000	cplex	1	1	267	1	4	22	0	1	0	199	199	0.257348001	0.719784021	1.30987406	2.04700208	1.52985406	2318
40228	10	639	1	10000000	cplex	0	1	300	8	0	30	0	1	0	199	199	0.275124997	7.95011282	18.6257439	28.1004353	1.52153802	29163
40229	10	639	1	10000000	cplex	1	0	267	11	1	30	0	1	0	199	199	0.191805005	7.02286911	16.7544422	26.2410374	1.49845505	39757
40230	10	639	1	10000000	cplex	1	1	267	10	2	30	0	1	0	199	199	0.200580999	6.90646696	16.1871891	25.6182117	1.45647204	38610
40231	10	639	1	10000000	cplex	0	0	300	11	3	30	0	1	0	199	199	0.239692003	8.35402679	19.7128754	28.6920338	1.45100904	31260
40232	10	639	1	10000000	cplex	1	1	267	1	4	30	0	1	0	199	199	0.418078989	0.976200998	1.80931103	2.71887207	2.71016598	3162
40233	10	640	1	10000000	cplex	0	1	300	10	0	33	0	1	0	99	99	0.614766002	36.3855782	84.250473	174.277512	1.40989399	66501
40234	10	640	1	10000000	cplex	1	0	251	11	1	33	0	1	0	99	99	0.420132995	35.8533058	79.2532196	165.797028	1.41098499	82765
40235	10	640	1	10000000	cplex	1	1	251	10	2	33	0	1	0	99	99	0.396869004	35.2938042	81.1756973	166.868164	1.47232103	82570
40236	10	640	1	10000000	cplex	0	0	300	11	3	33	0	1	0	99	99	0.647101998	37.9101715	85.9627457	172.745911	1.59285402	67386
40237	10	640	1	10000000	cplex	1	1	251	1	4	33	33	0	0	99		0.256448001	0.604049027	1.12049699	6.58622599	0.394434988	2613
40238	10	641	1	10000000	cplex	0	1	300	10	0	26	0	1	0	99	99	0.50089699	29.0557022	66.843071	124.77684	0.984573007	52322
40239	10	641	1	10000000	cplex	1	0	251	11	1	26	0	1	0	99	99	0.326063007	28.6194744	63.4917221	122.740768	1.05654097	65209
40240	10	641	1	10000000	cplex	1	1	251	10	2	26	0	1	0	99	99	0.344114989	27.219326	62.4217148	122.448341	0.920975983	65055
40241	10	641	1	10000000	cplex	0	0	300	11	3	26	0	1	0	99	99	0.492464006	30.5632858	67.8504028	127.000954	0.940878987	53092
40242	10	641	1	10000000	cplex	1	1	251	1	4	26	26	0	0	99		0.0290109999	0.0512979999	0.0835319981	0.36323899	0.407054007	1222
40243	10	642	1	10000000	cplex	0	1	300	10	0	39	0	1	0	99	99	0.66782099	43.6637802	104.045998	220.213898	1.62792802	78483
40244	10	642	1	10000000	cplex	1	0	251	11	1	39	0	1	0	99	99	0.445443988	40.6607704	97.2670975	212.001114	1.38293505	97814
40245	10	642	1	10000000	cplex	1	1	251	10	2	39	0	1	0	99	99	0.434347004	40.8641586	97.255806	206.553452	1.37157202	97582
40246	10	642	1	10000000	cplex	0	0	300	11	3	39	0	1	0	99	99	0.553547025	43.5204964	102.305611	214.749832	1.589481	79638
40247	10	642	1	10000000	cplex	1	1	251	1	4	39	39	0	0	99		0.0380060002	0.0712350011	0.130400002	0.558520973	0.397691995	1833
40248	10	643	1	10000000	cplex	0	1	300	10	0	26	0	1	0	99	99	0.589362979	28.6364098	67.2915955	126.887268	1.03478897	52322
40249	10	643	1	10000000	cplex	1	0	251	11	1	26	0	1	0	99	99	0.324461997	27.6479645	63.5445557	121.331245	0.933624029	65209
40250	10	643	1	10000000	cplex	1	1	251	10	2	26	0	1	0	99	99	0.377471	28.3737507	62.8467064	119.652016	1.06516194	65055
40251	10	643	1	10000000	cplex	0	0	300	11	3	26	0	1	0	99	99	0.495793015	28.5144653	67.4032135	125.115013	1.00740397	53092
40252	10	643	1	10000000	cplex	1	1	251	1	4	26	26	0	0	99		0.0232330002	0.0464299992	0.0830430016	0.369084001	0.402819991	1222
40253	10	644	1	10000000	cplex	0	1	300	10	0	34	0	1	0	99	99	0.624130011	38.3886948	87.9458694	180.597198	1.46430504	68421
40254	10	644	1	10000000	cplex	1	0	251	11	1	34	0	1	0	99	99	0.417174011	37.1347237	84.4029999	175.972198	1.42465794	85273
40255	10	644	1	10000000	cplex	1	1	251	10	2	34	0	1	0	99	99	0.467361003	37.3771439	83.8487396	175.608475	1.43047094	85072
40256	10	644	1	10000000	cplex	0	0	300	11	3	34	0	1	0	99	99	0.619306028	41.3665924	90.1998291	183.402817	1.46120703	69428
40257	10	644	1	10000000	cplex	1	1	251	1	4	34	34	0	0	99		0.0332649983	0.0642459989	0.113072	0.497316003	0.503823996	1598
40258	10	645	1	10000000	cplex	0	1	300	10	0	31	0	1	0	99	99	0.593378007	33.9660187	81.2422409	160.797638	1.45943999	62384
40259	10	645	1	10000000	cplex	1	0	251	11	1	31	0	1	0	99	99	0.361476004	31.692318	75.4094315	158.446228	1.56014001	77749
40260	10	645	1	10000000	cplex	1	1	251	10	2	31	0	1	0	99	99	0.426504999	32.1796799	75.9106979	155.395782	1.45181	77565
40261	10	645	1	10000000	cplex	0	0	300	11	3	31	0	1	0	99	99	2.32649302	35.0312538	82.7454224	161.253845	1.53167903	63302
40262	10	645	1	10000000	cplex	1	1	251	1	4	31	31	0	0	99		0.0294419993	0.0551289991	0.101287	0.489196986	0.405155987	1457
40263	10	646	1	10000000	cplex	0	1	300	10	0	31	0	1	0	99	99	0.572480977	36.3259621	80.8969116	158.235718	1.51604903	62504
40264	10	646	1	10000000	cplex	1	0	250	11	1	31	0	1	0	99	99	0.348316997	32.5931549	77.0805054	155.652725	1.48706901	78112
40265	10	646	1	10000000	cplex	1	1	250	10	2	31	0	1	0	99	99	0.428398997	32.8400688	77.2833405	154.369553	1.494398	77952
40266	10	646	1	10000000	cplex	0	0	300	11	3	31	0	1	0	99	99	0.532841027	34.4068527	81.3503952	161.00798	1.50292504	63302
40267	10	646	1	10000000	cplex	1	1	250	1	4	31	31	0	0	99		0.0292830002	0.0592200011	0.0994800031	0.568768978	0.402211994	1231
40268	10	647	1	10000000	cplex	0	1	300	10	0	29	0	1	0	99	99	0.511169016	32.7182922	76.020546	145.778107	0.976173997	58359
40269	10	647	1	10000000	cplex	1	0	251	11	1	29	0	1	0	99	99	0.354315013	31.5759468	71.841713	142.763504	1.14592898	72733
40270	10	647	1	10000000	cplex	1	1	251	10	2	29	0	1	0	99	99	0.424540997	40.3563232	72.0645981	141.082718	0.912420988	72561
40271	10	647	1	10000000	cplex	0	0	300	11	3	29	0	1	0	99	99	0.531165004	32.0199928	75.5589218	146.780777	0.996215999	59218
40272	10	647	1	10000000	cplex	1	1	251	1	4	29	29	0	0	99		0.0323860012	0.0575730018	0.0948899984	0.402812988	0.403149992	1363
40273	10	648	1	10000000	cplex	0	1	300	10	0	36	0	1	0	99	99	0.637938976	41.9358826	98.9213562	199.088318	2.44668794	72446
40274	10	648	1	10000000	cplex	1	0	251	11	1	36	0	1	0	99	99	0.468448013	38.5435715	88.7666931	193.04422	1.51740003	90289
40275	10	648	1	10000000	cplex	1	1	251	10	2	36	0	1	0	99	99	0.498885989	38.3210449	88.6781921	191.583588	1.73552406	90076
40276	10	648	1	10000000	cplex	0	0	300	11	3	36	0	1	0	99	99	0.608717978	43.4453812	95.6996689	201.379074	1.63789296	73512
40277	10	648	1	10000000	cplex	1	1	251	1	4	36	36	0	0	99		0.0294250008	0.0619090013	0.117574997	0.623776019	0.450424999	1692
40278	10	649	1	10000000	cplex	0	1	300	10	0	37	0	1	0	99	99	1.20270598	101.886703	102.378624	213.973953	2.16658497	74458
40279	10	649	1	10000000	cplex	1	0	251	11	1	37	0	1	0	99	99	0.438383996	38.500576	93.0547333	202.338257	1.48111701	92797
40280	10	649	1	10000000	cplex	1	1	251	10	2	37	0	1	0	99	99	0.488247991	39.2588501	93.1903534	201.877625	1.54342902	92578
40281	10	649	1	10000000	cplex	0	0	300	11	3	37	0	1	0	99	99	0.632865012	42.4052086	101.179298	210.45842	1.44734704	75554
40282	10	649	1	10000000	cplex	1	1	251	1	4	37	37	0	0	99		0.0338080004	0.0696419999	0.124605	0.760533988	0.487783015	1739
40284	10	650	1	10000000	cplex	0	1	300	10	0	25	0	1	0	49	49	0.614759028	43.8776016	93.3698196	210.521088	1.80076396	62901
40285	10	650	1	10000000	cplex	1	0	259	11	1	25	0	1	0	49	49	0.437736005	39.4578857	88.2521133	208.531982	1.47877502	73204
40286	10	650	1	10000000	cplex	1	1	259	10	2	25	0	1	0	49	49	0.514490008	38.2806435	86.8603821	207.921982	1.49722195	73063
40287	10	650	1	10000000	cplex	0	0	300	11	3	25	0	1	0	49	49	0.598417997	38.6567192	90.1615829	210.713562	1.50630701	63550
40288	10	650	1	10000000	cplex	1	1	259	1	4	25	25	0	0	49		0.522602022	5.2753849	8.5200367	35.8581505	0.418197006	5432
40289	10	651	1	10000000	cplex	0	1	300	10	0	28	0	1	0	49	49	0.626635015	51.0060768	106.242676	244.656387	1.28383505	70450
40290	10	651	1	10000000	cplex	1	0	259	11	1	28	0	1	0	49	49	0.503593981	51.0417557	103.092583	238.95018	1.16596997	81989
40291	10	651	1	10000000	cplex	1	1	259	10	2	28	0	1	0	49	49	0.521642983	49.7096558	101.670815	240.286545	1.16453803	81830
40292	10	651	1	10000000	cplex	0	0	300	11	3	28	0	1	0	49	49	0.522947013	52.2197914	105.555359	245.975906	1.16870701	71176
40293	10	651	1	10000000	cplex	1	1	259	1	4	28	28	0	0	49		0.580895007	6.53019524	9.85980034	26.392849	0.393391997	6101
40294	10	652	1	10000000	cplex	0	1	300	10	0	32	0	1	0	49	49	0.684906006	58.9133492	120.977478	296.875732	1.52971005	80514
40295	10	652	1	10000000	cplex	1	0	259	11	1	32	0	1	0	49	49	0.504073977	56.7942543	118.148918	290.281525	1.45909905	93702
40296	10	652	1	10000000	cplex	1	1	259	10	2	32	0	1	0	49	49	0.534770012	55.4657669	116.675453	285.667419	1.56190503	93520
40297	10	652	1	10000000	cplex	0	0	300	11	3	32	0	1	0	49	49	0.696210027	56.4559746	119.662895	295.73468	1.44529998	81344
40298	10	652	1	10000000	cplex	1	1	259	1	4	32	32	0	0	49		0.63490802	9.93550873	16.8218975	74.8879852	0.396405011	8923
40299	10	653	1	10000000	cplex	0	1	300	10	0	33	0	1	0	49	49	0.697504997	58.4246254	124.385017	306.950378	1.51012695	83170
40300	10	653	1	10000000	cplex	1	0	251	11	1	33	0	1	0	49	49	0.509124994	53.4991455	117.184196	295.403687	1.41648102	99461
40301	10	653	1	10000000	cplex	1	1	251	10	2	33	0	1	0	49	49	0.601235986	57.6574211	119.698631	302.027069	1.43269801	99314
40302	10	653	1	10000000	cplex	0	0	300	11	3	33	0	1	0	49	49	0.676011026	56.5143547	123.899055	309.651794	1.42332995	83886
40303	10	653	1	10000000	cplex	1	1	251	1	4	33	45	0	0.363635987	49	46	0.603654981	10.1869965	17.4414158	107.02459	0.944966018	5597
40304	10	654	1	10000000	cplex	0	1	300	10	0	25	0	1	0	49	49	0.550897002	41.1750717	91.4396896	205.692947	1.48782396	62901
40305	10	654	1	10000000	cplex	1	0	259	11	1	25	0	1	0	49	49	0.407422006	40.5706177	88.484993	205.153564	1.50662804	73204
40306	10	654	1	10000000	cplex	1	1	259	10	2	25	0	1	0	49	49	0.457076013	40.6694298	89.3303833	206.196457	1.51644695	73063
40307	10	654	1	10000000	cplex	0	0	300	11	3	25	0	1	0	49	49	0.60769999	42.5650139	92.13414	213.141937	1.52328706	63550
40308	10	654	1	10000000	cplex	1	1	259	1	4	25	25	0	0	49		0.524375975	5.24125195	8.91794586	39.8248978	0.401818991	5432
40309	10	655	1	10000000	cplex	0	1	300	10	0	35	0	1	0	49	49	0.678974986	58.9514389	129.148407	337.856659	1.51320505	88062
40310	10	655	1	10000000	cplex	1	0	259	11	1	35	0	1	0	49	49	0.604970992	57.0669632	125.161674	333.298035	1.45912194	102486
40311	10	655	1	10000000	cplex	1	1	259	10	2	35	0	1	0	49	49	0.608458996	57.7429276	125.565544	333.644226	1.41475499	102288
40312	10	655	1	10000000	cplex	0	0	300	11	3	35	0	1	0	49	49	0.73190701	58.5540695	129.836273	334.628754	1.41839099	88970
40313	10	655	1	10000000	cplex	1	1	259	1	4	35	35	0	0	49		0.72695601	8.07936382	12.3967466	59.3711815	0.391254008	7590
40314	10	656	1	10000000	cplex	0	1	300	10	0	35	0	1	0	49	49	0.684485972	66.3781357	137.122299	334.744446	1.56601	88111
40315	10	656	1	10000000	cplex	1	0	253	11	1	35	0	1	0	49	49	0.510159016	62.1882362	131.508514	326.927887	1.57429004	104617
40316	10	656	1	10000000	cplex	1	1	253	10	2	35	0	1	0	49	49	0.591485977	62.7357368	131.922485	328.837372	1.49478996	104522
40317	10	656	1	10000000	cplex	0	0	300	11	3	35	0	1	0	49	49	0.769867003	63.8307457	137.934906	333.721161	1.630041	88970
40318	10	656	1	10000000	cplex	1	1	253	1	4	35	0	1	0	49	49	0.875977993	7.94539309	12.147151	20.2217464	1.502141	7579
40319	10	657	1	10000000	cplex	0	1	300	10	0	27	0	1	0	49	49	0.690230012	49.1206322	106.168159	236.015106	1.55733597	67933
40320	10	657	1	10000000	cplex	1	0	259	11	1	27	0	1	0	49	49	0.502068996	46.2943039	102.53215	232.112839	1.53088403	79061
40321	10	657	1	10000000	cplex	1	1	259	10	2	27	0	1	0	49	49	0.588288009	47.2206688	99.9782104	229.691162	1.58800805	78908
40322	10	657	1	10000000	cplex	0	0	300	11	3	27	0	1	0	49	49	0.568713009	46.6254845	106.088203	235.684616	1.547755	68634
40323	10	657	1	10000000	cplex	1	1	259	1	4	27	27	0	0	49		0.715543985	14.4511557	25.2509804	153.625412	0	10595
40324	10	658	1	10000000	cplex	0	1	300	10	0	27	0	1	0	49	49	0.608246982	50.34412	109.250534	236.710648	1.70095205	67933
40325	10	658	1	10000000	cplex	1	0	259	11	1	27	0	1	0	49	49	0.517075002	47.4568024	105.470039	231.213364	1.45884001	79061
40326	10	658	1	10000000	cplex	1	1	259	10	2	27	0	1	0	49	49	0.523883998	45.9335709	104.467918	229.237946	1.52833903	78908
40327	10	658	1	10000000	cplex	0	0	300	11	3	27	0	1	0	49	49	0.691362023	48.4481926	110.680054	237.591721	1.46121097	68634
40328	10	658	1	10000000	cplex	1	1	259	1	4	27	27	0	0	49		0.896888971	6.03420401	10.3982372	40.7819214	0.39506799	5867
40329	10	659	1	10000000	cplex	0	1	300	10	0	30	0	1	0	49	49	0.752846003	54.7627907	120.041145	269.91507	1.52780104	75482
40330	10	659	1	10000000	cplex	1	0	259	11	1	30	0	1	0	49	49	0.514710009	53.3564491	117.970108	268.85144	1.537112	87845
40331	10	659	1	10000000	cplex	1	1	259	10	2	30	0	1	0	49	49	0.60136497	50.7196236	116.303474	267.842743	1.54091501	87675
40332	10	659	1	10000000	cplex	0	0	300	11	3	30	0	1	0	49	49	0.611400008	50.468914	119.287445	266.404907	1.50785005	76260
40333	10	659	1	10000000	cplex	1	1	259	1	4	30	30	0	0	49		0.624059975	7.59064484	11.6457338	51.4657593	0.431688011	6519
42040	9	589	1	10000000	cplex	0	0	300	11	3	15	0	1	0	99	99	0.279285014	17.4996128	39.6892242	60.1828423	0.921796978	30630
42041	9	589	1	10000000	cplex	1	1	254	1	4	15	15	0	0	99		0.147529006	0.471132994	0.635349989	3.443856	0.0795100033	661
42130	9	591	1	10000000	cplex	0	1	300	9	0	34	0	1	0	49	49	0.328752011	20.0662708	61.495285	87.4205399	0.240424007	48149
42131	9	591	1	10000000	cplex	1	0	245	11	1	34	0	1	0	49	49	0.205642	19.8441181	60.3904037	68.7492065	0.23556	61546
42132	9	591	1	10000000	cplex	1	1	245	10	2	34	0	1	0	49	49	0.216386005	19.5453701	57.2755852	83.558548	0.225161999	58450
42133	9	591	1	10000000	cplex	0	0	300	11	3	34	0	1	0	49	49	0.314749986	20.6557693	63.3563576	69.4368515	0.225170001	50840
42134	9	591	1	10000000	cplex	1	1	245	1	4	34	0	1	0	49	49	0.211263001	5.98951292	13.8157244	122.430237	0.219914004	12146
42135	9	592	1	10000000	cplex	0	1	300	9	0	35	0	1	0	49	49	0.335197002	20.9254379	61.5901451	82.7396469	0.583527982	48149
42136	9	592	1	10000000	cplex	1	0	245	11	1	35	0	1	0	49	49	0.202782005	19.4466705	60.9945946	68.1760941	0.637802005	61546
42137	9	592	1	10000000	cplex	1	1	245	10	2	35	0	1	0	49	49	0.26561299	18.8169117	58.502697	81.9159698	0.58078599	58450
42138	9	592	1	10000000	cplex	0	0	300	11	3	35	0	1	0	49	49	0.228707001	20.2962246	64.3488312	69.0852966	0.571864009	50840
42139	9	592	1	10000000	cplex	1	1	245	1	4	35	0	1	0	49	49	0.211440995	6.3701148	13.5191631	121.18103	0.584415972	12146
42140	9	593	1	10000000	cplex	0	1	300	9	0	48	0	1	0	49	49	0.377591014	26.6188393	77.2087173	121.687057	0.288058996	60197
42141	9	593	1	10000000	cplex	1	0	245	11	1	48	0	1	0	49	49	0.230283007	25.1096077	76.4285965	97.4703293	0.269116998	76932
42142	9	593	1	10000000	cplex	1	1	245	10	2	48	0	1	0	49	49	0.261142999	24.6196823	72.8545074	120.051094	0.28232801	73063
42143	9	593	1	10000000	cplex	0	0	300	11	3	48	0	1	0	49	49	0.844136	26.896244	80.5716324	97.0211334	0.263184994	63550
42144	9	593	1	10000000	cplex	1	1	245	1	4	48	57	0.958333015	1.14583302	49	49	0.25090301	7.77024221	17.3125477	133.992416	0.204337001	15183
42145	9	594	1	10000000	cplex	0	1	300	9	0	38	0	1	0	49	49	0.353103995	26.0051918	76.5362701	119.348701	0.600655973	60187
42146	9	594	1	10000000	cplex	1	0	245	11	1	38	0	1	0	49	49	0.232673004	24.0425587	76.6575699	95.2630157	0.610930026	76932
42147	9	594	1	10000000	cplex	1	1	245	10	2	38	0	1	0	49	49	0.286356986	25.9067364	72.9883728	118.867912	0.610566974	73063
42148	9	594	1	10000000	cplex	0	0	300	11	3	38	0	1	0	49	49	0.318679988	26.4939003	80.8835983	97.415123	0.589874983	63550
42149	9	594	1	10000000	cplex	1	1	245	1	4	38	0	1	0	49	49	0.235825002	8.02897644	17.4329395	163.949936	0.601274014	15183
42150	9	595	1	10000000	cplex	0	1	300	9	0	37	0	1	0	49	49	0.375508994	27.5934582	77.9477615	124.236214	0.459387004	60197
42151	9	595	1	10000000	cplex	1	0	245	11	1	37	0	1	0	49	49	0.225143999	24.8313065	77.0583878	95.2451706	0.475814015	76932
44001	9	549	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	21	0	1	0	299	299	0.00301599992	0.00163099996	0.00478099985	0.0379000008	0.097773999	882
44002	9	550	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	35	0	1	0	274	274	0.0776010007	0.831214011	1.64307702	1.29321694	0.154171005	10220
44003	9	551	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	57	0	1	0	274	274	0.196740001	1.04521799	2.68078899	2.06551003	0.130263001	16644
44004	9	552	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	68	0	1	0	274	274	0.174107	1.28478897	3.24681306	2.69942689	0.125028998	19856
44005	9	553	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	68	0	1	0	274	274	0.211438999	1.59584296	3.24185395	2.47258496	0.122838996	19856
44006	9	554	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	35	0	1	0	274	274	0.125650004	0.832409978	1.74692297	1.30274701	0.146698996	10220
44007	9	555	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	33	0	1	0	274	274	0.112641998	0.684423983	1.66292298	1.23297	0.120976999	9636
44008	9	556	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	33	0	1	0	274	274	0.144722998	0.695804	1.719769	1.25609899	0.152025998	9636
44009	9	557	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	53	0	1	0	274	274	0.226129994	1.07115805	2.6755681	1.92993999	0.0962150022	15476
44010	9	588	1	10000000	cplex_searchall_1iter	0	0	300	11	5	15	2	1	0.133332998	99	99	0.450296015	37.8565254	76.5196533	507.70459	0.000638000027	45480
44011	9	589	1	10000000	cplex_searchall_1iter	0	0	300	11	5	3	0	1	0	99	99	0.183568001	6.90287113	14.260376	80.8899841	0.000446999999	9096
44012	9	590	1	10000000	cplex_searchall_1iter	0	0	300	11	5	29	0	1	0	49	49	0.742537022	74.8631592	147.606461	1262.23804	0.00151900004	87928
44013	9	591	1	10000000	cplex_searchall_1iter	0	0	300	11	5	42	0	1	0	49	49	0.912151992	103.174538	211.874924	2193.11401	0.000599000021	127344
44014	9	592	1	10000000	cplex_searchall_1iter	0	0	300	11	5	38	0	1	0	49	49	0.826713026	96.2435608	193.086197	1892.32837	0.000529000012	115216
44015	9	593	1	10000000	cplex_searchall_1iter	0	0	300	11	5	41	41	0	0	49		0.914274991	103.739296	207.66745	2127.38745	0	124312
44016	9	594	1	10000000	cplex_searchall_1iter	0	0	300	11	5	9	0	1	0	49	49	0.35720101	23.4504833	45.7441063	294.992065	0.000501999981	27288
44017	9	595	1	10000000	cplex_searchall_1iter	0	0	300	11	5	37	0	1	0	49	49	0.768368006	93.0407639	187.043961	1820.4762	0.000570999982	112184
44018	9	596	1	10000000	cplex_searchall_1iter	0	0	300	11	5	9	0	1	0	49	49	0.312144011	23.3038921	46.1276131	301.196503	0.000475000008	27288
44019	9	597	1	10000000	cplex_searchall_1iter	0	0	300	11	5	41	0	1	0	49	49	0.931605995	105.99382	211.688141	2125.37866	0.000598000013	124312
44020	9	598	1	10000000	cplex_searchall_1iter	0	0	300	11	5	9	0	1	0	49	49	0.315342993	22.1886044	44.2507172	300.653961	0.000453999994	27288
44021	9	599	1	10000000	cplex_searchall_1iter	0	0	300	11	5	38	0	1	0	49	49	0.909286022	99.4060974	199.335602	1904.38562	0.000491000013	115216
44022	9	540	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	13	0	1	0	299	299	0.0201370008	0.0191530008	0.0136169996	0.135441005	0.00434899982	546
44023	9	541	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	9	0	1	0	299	299	0.00537100015	0.00462700007	0.00709699979	0.132531002	0.00144000002	378
44024	9	542	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	13	0	1	0	299	299	0.00618600007	0.00679400004	0.0103270002	0.621361971	0.00118599995	546
44025	9	543	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	42	0	1	0	299	299	0.00689900015	0.0367260017	0.0279019997	0.0507609993	0.000788000005	1764
44026	9	544	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	24	0	1	0	299	299	0.00503099989	0.0102939997	0.013855	0.175953999	0.000870999997	1008
44027	9	545	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	24	0	1	0	299	299	0.0051810001	0.0105569996	0.0159000009	0.0717319995	0.000878999999	1008
44028	9	546	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	13	0	1	0	299	299	0.0033499999	0.00492399978	0.00603599986	0.130064994	0.000812000013	546
44029	9	547	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	24	0	1	0	299	299	0.00416200003	0.00843499973	0.0110879997	0.0438090004	0.000867999974	1008
44030	9	548	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	21	0	1	0	299	299	0.00413799984	0.0059890002	0.00953800045	0.058929	0.00192900002	882
44031	9	549	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	21	0	1	0	299	299	0.00500399992	0.00594200008	0.00917700026	0.0444049984	0.000732999993	882
44032	9	550	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	35	35	1	1	274	274	0.102718003	0.911925972	1.57743204	1.34071302	0.000798999972	10220
44033	9	551	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	57	11	1	0.192982003	274	274	0.0967689976	1.17839897	2.3907001	2.12554097	0.000818	16644
44034	9	552	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	68	0	1	0	274	274	0.170039997	1.39361501	2.81456494	2.53351402	0.000658000004	19856
44035	9	553	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	68	0	1	0	274	274	0.222716004	1.356655	2.80105495	2.5370059	0.000510999991	19856
44036	9	554	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	35	35	1	1	274	274	0.131061003	0.656795025	1.43756604	1.32799304	0.000541999994	10220
44037	9	555	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	33	35	1	1.060606	274	274	0.103761002	0.562120974	1.44900596	1.27614295	0.000475999987	9636
44038	9	556	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	33	35	1	1.060606	274	274	0.182281002	0.546124995	1.36372399	1.27007902	0.000633999996	9636
44039	9	557	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	53	0	1	0	274	274	0.245161995	1.03691399	2.36196995	1.97269106	0.00057600002	15476
44040	9	558	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	53	0	1	0	274	274	0.258709997	1.02468896	2.314183	1.99005604	0.000546000025	15476
44041	9	559	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	33	35	1	1.060606	274	274	0.191485003	0.753040016	1.44875896	1.27039695	0.000554999977	9636
44042	9	560	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	5	64	1	12.8000002	249	264	0.0521150008	0.195359007	0.391855001	0.482625008	0.000606000016	1960
44043	9	561	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	5	64	1	12.8000002	249	264	0.0615249984	0.199717999	0.400281996	0.484113991	0.000717999996	1960
44044	9	562	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	11	0	1	0	249	249	0.0887309983	0.863005996	1.71624899	2.50484896	0.000483000011	5962
44045	9	563	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	4	77	1	19.25	249	274	0.0293010008	0.0806329995	0.156510994	0.244754001	0.000607999973	1168
44046	9	564	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	4	77	1	19.25	249	274	0.0366250016	0.0872839987	0.157585993	0.249479994	0.000727000006	1168
44047	9	565	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	5	64	1	12.8000002	249	264	0.0463639982	0.170041993	0.377443999	0.489731997	0.000564999995	1960
44048	9	566	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	4	77	1	19.25	249	274	0.0368969999	0.0848399997	0.163367003	0.258964002	0.000711000001	1168
44049	9	567	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	5	64	1	12.8000002	249	264	0.0613080002	0.188114002	0.393213987	0.492455006	0.000720000011	1960
44050	9	568	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	5	64	1	12.8000002	249	264	0.0547889993	0.189399004	0.395687997	0.477474004	0.000688	1960
44051	9	569	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	5	64	1	12.8000002	249	264	0.0604630001	0.195993006	0.394825011	0.489082992	0.000714999973	1960
44052	9	570	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.236359	4.31427908	9.58897209	17.2364101	0.000490000006	18964
44053	9	571	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.215001002	3.83146	8.91203213	17.4676533	0.000429000007	18964
44054	9	572	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.188295007	4.30949211	9.13467789	17.2339821	0.000525999989	18964
44055	9	573	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	23	0	1	0	199	199	0.244772002	6.93190098	14.3907976	35.6731873	0.00057600002	23966
44056	9	574	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.282673001	4.4417758	9.08150005	17.0716839	0.000538000022	18964
44057	9	575	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.155321002	4.13700819	9.2025423	17.0442924	0.000403999991	18964
44058	9	576	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.195844993	4.18255615	9.18814087	17.5606956	0.000438999996	18964
44059	9	577	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.229210004	3.89328289	9.11427307	17.719202	0.000552000012	18964
44060	9	578	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	23	0	1	0	199	199	0.230680004	6.1377039	13.8290949	34.773243	0.000651000009	23966
44061	9	579	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	22	15	1	0.681818008	199	217	0.157567993	4.03989887	9.13163853	17.3807011	0.000391999987	18964
44062	9	580	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	11	60	1	5.45454502	99	99	0.256819993	13.1541319	26.9895153	102.566422	0.000514000014	22462
44063	9	581	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	45	16	1	0.355556011	99	99	0.653119981	51.8544159	111.05722	595.641235	0.000500999973	91890
44064	9	582	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	3	0	1	0	99	99	0.164542004	4.0409441	7.30049896	26.4873676	0.000579999993	6126
44065	9	583	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	15	2	1	0.133332998	99	99	0.319530994	16.8880177	36.172245	141.690857	0.00043700001	30630
44066	9	584	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	45	16	1	0.355556011	99	99	0.689009011	51.8192635	110.000397	598.507996	0.000418999989	91890
44067	9	585	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	11	60	1	5.45454502	99	99	0.726783991	12.2815332	26.9863758	101.917503	0.000554000027	22462
44068	9	586	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	3	0	1	0	99	99	0.146145999	3.62880397	7.40352678	26.2434196	0.000402000005	6126
44069	9	587	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	1	4	1	4	99	180	0.0609970018	0.525649011	0.831857026	2.48723102	0.000584999972	1232
44070	9	588	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	15	2	1	0.133332998	99	99	0.287245005	16.6539021	35.8985214	143.321747	0.000425000006	30630
44071	9	589	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	3	0	1	0	99	99	0.165956005	3.80481601	7.16262913	25.8605881	0.000423999998	6126
44072	9	590	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	29	1	1	0.0344830006	49	50	0.535477996	51.3023987	110.033401	679.969116	0.000398000004	73428
44073	9	591	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	42	0	1	0	49	49	0.727352023	75.3297424	163.02594	1194.36292	0.000371000002	106764
44074	9	592	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	38	0	1	0	49	49	0.867304027	65.9995956	147.474045	1047.66821	0.000520000001	96596
44075	9	593	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	41	0	1	0	49	49	0.865113974	71.9112778	159.4384	1161.21399	0.000414000009	104222
44076	9	594	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	9	0	1	0	49	49	0.301129997	15.5588303	34.3551254	176.40239	0.000479000009	22878
44077	9	595	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	37	0	1	0	49	49	0.667873025	67.7266998	145.602158	1001.33374	0.000446999999	94054
44078	9	596	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	9	0	1	0	49	49	0.296113014	17.2599411	34.2429352	179.577942	0.000524999981	22878
44079	9	597	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	41	0	1	0	49	49	0.737510979	77.0227051	161.726334	1162.50427	0.000507000019	104222
44080	9	598	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	9	0	1	0	49	49	0.251985997	15.4303885	34.3250504	179.119797	0.00055300002	22878
44081	9	599	1	10000000	cplex_stopearly_1iter	0	0	300	11	6	38	0	1	0	49	49	0.801596999	67.1072388	150.005508	1044.56287	0.000388999993	96596
44082	9	541	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	9	0	1	0	299	299	0.00228199991	0.00486700004	0.00795399956	0.457174003	0.115019999	378
44083	9	542	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	13	0	1	0	299	299	0.00283599994	0.00419599982	0.0154449996	0.294914991	0.115418002	546
44084	9	543	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	42	0	1	0	299	299	0.00640500011	0.00511599984	0.0100260004	0.0513640009	0.127609998	1764
44085	9	544	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	24	0	1	0	299	299	0.0033760001	0.00258399989	0.00545400009	0.274542987	0.136520997	1008
44086	9	545	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	24	0	1	0	299	299	0.00345900003	0.00223300001	0.00559200021	0.0664810017	0.103096999	1008
44087	9	546	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	13	0	1	0	299	299	0.001988	0.00110500003	0.00314199994	0.37510699	0.0907130018	546
44088	9	547	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	24	0	1	0	299	299	0.00321900006	0.00188899995	0.00559900003	0.0430090018	0.114312001	1008
44089	9	548	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	21	0	1	0	299	299	0.00282500009	0.00161599996	0.00475900015	0.129271999	0.0983899981	882
44090	9	558	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	53	0	1	0	274	274	0.175576001	0.989481986	2.60271692	1.97248602	0.0955870003	15476
44091	9	559	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	33	0	1	0	274	274	0.135961995	0.616513014	1.62232006	1.28241503	0.146546006	9636
44092	9	570	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.204721004	6.14976215	15.4789858	33.3177147	0.301961988	22924
44093	9	571	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.207283005	6.66898584	16.0270138	33.3542519	0.350483	22924
44094	9	572	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.253327012	6.49037218	16.1597214	33.2494087	0.28588599	22924
44095	9	573	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	23	0	1	0	199	199	0.225914001	7.00205708	17.1304932	35.2158508	0.118193001	23966
44096	9	574	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.227782995	6.67316103	16.3503857	33.5389709	0.316826999	22924
44097	9	575	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.247431993	6.4792552	16.0850525	33.4827919	0.291633993	22924
44098	9	576	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.261747986	6.38087177	16.1000118	33.6930199	0.284251988	22924
44099	9	577	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.193379	6.91157579	16.6125126	34.2313614	0.337942988	22924
44100	9	578	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	23	0	1	0	199	199	0.225179002	6.56527281	16.9541817	36.0247574	0.112452	23966
44101	9	579	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	22	0	1	0	199	199	0.220663995	6.31054783	16.1630116	33.3670845	0.327179015	22924
44102	9	580	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	11	0	1	0	99	99	0.224215999	13.1296711	31.2500305	103.745064	0.281410992	22462
44103	9	584	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	45	0	1	0	99	99	0.271829993	16.8978043	51.7221031	155.564575	0.129691005	51050
44104	9	591	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	42	1	0.976189971	0	49	49	0.377315015	27.9199009	81.3462677	369.06427	0.125917003	63550
44105	9	592	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	38	1	0.973684013	0	49	49	0.349204987	27.8401814	80.9553604	373.703339	0.129932001	63550
44106	9	593	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	41	1	0.975610018	0	49	49	0.352127999	29.5679893	82.1515274	382.841187	0.221656993	63550
44107	9	595	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	37	1	0.972972989	0	49	49	0.342705011	28.2103271	85.5312195	378.734497	0.286226988	63550
44108	9	597	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	41	1	0.975610018	0	49	49	0.34356901	28.2978592	80.6530304	368.606354	0.115304999	63550
44109	9	598	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	9	0	1	0	49	49	0.199825004	9.88619137	28.3195724	115.923515	0.155762002	22878
44110	9	599	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	38	1	0.973684013	0	49	49	0.343923002	31.1689224	82.4195023	380.570557	0.129730001	63550
44111	9	583	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	15	0	1	0	99	99	0.189866006	10.358098	31.3785038	84.1256714	0.159289002	30630
44112	9	560	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0312060006	0.147089005	0.375335008	0.132667005	0.403490007	2010
44113	9	561	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0302719995	0.118579	0.362917006	0.131148994	0.221373007	2010
44114	9	562	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	11	0	1	0	249	249	0.0566870011	0.564207971	1.583794	0.804692984	0.124719001	5962
44115	9	563	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	4	0	1	0	249	250	0.065824002	0.281295002	0.539327025	0.33930099	0.361622989	2128
44116	9	564	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	4	0	1	0	249	250	0.0389349982	0.159858003	0.510205984	0.339709014	0.350030988	2128
44117	9	565	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0325030014	0.108823001	0.355664998	0.124964997	0.218088001	2010
44118	9	566	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	4	0	1	0	249	250	0.0301699992	0.204870999	0.514168978	0.347155005	0.508427024	2128
44119	9	567	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0259939991	0.143988997	0.363371015	0.129444003	0.240722001	2010
44120	9	568	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0360229984	0.145568997	0.375746012	0.132227004	0.269567996	2010
44121	9	569	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	5	3	1	0.600000024	249	263	0.0224910006	0.128563002	0.359854013	0.135541007	0.240698993	2010
44122	9	587	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	1	5	1	5	99	176	0.0436360016	0.281352997	0.763360977	0.875090003	0.224562004	1272
44123	9	540	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	2.02467108	293.364014	537.890198	364.570526	0.0038660001	303200
44124	9	541	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	1.78875899	297.372162	544.273132	364.490265	0.00273100007	303200
44125	9	542	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	2.221385	274.710663	529.759705	365.403198	0.00161399995	303200
44126	9	543	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	1.85977304	277.132019	530.232788	371.315643	0.00168700004	303200
44127	9	554	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	1.95421302	296.164398	540.539978	7601.88379	0.00116500002	303200
44128	9	555	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	3.08111405	295.409882	535.086487	7628.53467	0.00109200005	303200
44129	9	556	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	1.95875001	279.937775	535.822327	7613.34766	0.00111499999	303200
44130	9	557	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	2.12181997	274.810547	535.204041	6577.81836	0.00121500005	303200
44131	9	558	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	1.93792701	277.609497	539.121704	6593.52051	0.00101200002	303200
44132	9	540	1	10000000	cplex_searchall_1iter	0	0	300	11	5	13	0	1	0	299	299	0.39723599	30.1738205	65.4603577	44.897213	0.0043159998	39416
44133	9	541	1	10000000	cplex_searchall_1iter	0	0	300	11	5	9	0	1	0	299	299	0.293164015	20.3800831	44.6318321	31.3388748	0.00120699999	27288
44134	9	542	1	10000000	cplex_searchall_1iter	0	0	300	11	5	13	0	1	0	299	299	0.346038997	29.0947971	65.2915955	45.4297485	0.000916999998	39416
44135	9	543	1	10000000	cplex_searchall_1iter	0	0	300	11	5	42	0	1	0	299	299	0.808842003	95.9653549	214.431122	146.649033	0.00114800001	127344
44136	9	544	1	10000000	cplex_searchall_1iter	0	0	300	11	5	24	0	1	0	299	299	0.56566	54.7822456	121.521484	84.3295212	0.000734000001	72768
44137	9	545	1	10000000	cplex_searchall_1iter	0	0	300	11	5	24	0	1	0	299	299	0.605382979	64.1820984	131.035004	85.6879883	0.000765000004	72768
44138	9	546	1	10000000	cplex_searchall_1iter	0	0	300	11	5	13	0	1	0	299	299	0.425819993	30.824131	66.8518524	45.5646591	0.000965000014	39416
44139	9	547	1	10000000	cplex_searchall_1iter	0	0	300	11	5	24	0	1	0	299	299	0.537033975	55.2413597	121.046112	83.5811234	0.00118400005	72768
44140	9	548	1	10000000	cplex_searchall_1iter	0	0	300	11	5	21	0	1	0	299	299	0.508325994	47.1148949	106.254906	71.8102875	0.00118200004	63672
44141	9	549	1	10000000	cplex_searchall_1iter	0	0	300	11	5	21	0	1	0	299	299	0.456892014	48.0457573	106.063232	71.8908691	0.000618999999	63672
44142	9	550	1	10000000	cplex_searchall_1iter	0	0	300	11	5	35	35	1	1	274	274	0.93690002	92.0787506	184.989914	1610.45972	0.000912000018	106120
44143	9	551	1	10000000	cplex_searchall_1iter	0	0	300	11	5	57	11	1	0.192982003	274	274	1.20233798	147.930237	301.087921	3254.37646	0.000662999984	172824
44144	9	552	1	10000000	cplex_searchall_1iter	0	0	300	11	5	68	0	1	0	274	274	1.51239705	192.174652	363.008484	4474.23389	0.000640999991	206176
44145	9	553	1	10000000	cplex_searchall_1iter	0	0	300	11	5	68	0	1	0	274	274	1.47752404	193.211075	362.598145	4469.13721	0.00101100001	206176
44146	9	554	1	10000000	cplex_searchall_1iter	0	0	300	11	5	35	35	1	1	274	274	0.816528976	92.4191437	184.573395	1603.3894	0.000572999998	106120
44147	9	555	1	10000000	cplex_searchall_1iter	0	0	300	11	5	33	35	1	1.060606	274	274	0.685904026	84.3211212	169.336044	1457.7937	0.000614000019	100056
44148	9	556	1	10000000	cplex_searchall_1iter	0	0	300	11	5	33	35	1	1.060606	274	274	0.767993987	88.8432617	175.483154	1468.24329	0.000691000023	100056
44149	9	557	1	10000000	cplex_searchall_1iter	0	0	300	11	5	53	0	1	0	274	274	1.24499094	147.057907	284.166229	2392.19531	0.000679999997	160696
44150	9	558	1	10000000	cplex_searchall_1iter	0	0	300	11	5	53	0	1	0	274	274	1.00327802	127.229416	262.484833	2382.85547	0.000523999974	160696
44151	9	559	1	10000000	cplex_searchall_1iter	0	0	300	11	5	33	35	1	1.060606	274	274	0.804458022	82.4803391	167.567947	1464.27197	0.000732999993	100056
44152	9	560	1	10000000	cplex_searchall_1iter	0	0	300	11	5	5	0	1	0	249	249	0.247538999	12.1896868	24.7864285	137.362473	0.00206999993	15160
44153	9	561	1	10000000	cplex_searchall_1iter	0	0	300	11	5	5	0	1	0	249	249	0.223864004	12.8115387	24.9338131	147.657974	0.00251900009	15160
44154	9	562	1	10000000	cplex_searchall_1iter	0	0	300	11	5	11	0	1	0	249	249	0.359975994	26.1765633	54.7268944	305.320709	0.000537000014	33352
44155	9	563	1	10000000	cplex_searchall_1iter	0	0	300	11	5	4	0	1	0	249	249	0.209132001	9.15438271	19.0595303	102.085022	0.001086	12128
44156	9	582	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	3	0	1	0	99	99	0.165638998	3.71795106	8.43171883	27.2237949	0.0754479989	6126
44157	9	585	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	11	0	1	0	99	99	0.264477015	12.5260811	30.553484	104.032249	0.209779993	22462
44158	9	586	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	3	0	1	0	99	99	0.167752996	3.62138009	8.34332466	27.2463512	0.103124999	6126
44159	9	588	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	15	0	1	0	99	99	0.312875986	18.0210896	41.8156624	145.000885	0.101066001	30630
44160	9	589	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	3	0	1	0	99	99	0.168812007	3.63181496	8.30856228	26.5717373	0.0972409993	6126
44161	9	594	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	9	0	1	0	49	49	0.290087998	16.8268642	38.8074379	182.44017	0.142032996	22878
44162	9	596	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	9	0	1	0	49	49	0.268236995	16.5181789	38.9853287	183.025558	0.142663002	22878
44163	9	590	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	29	0	1	0	49	49	0.586755991	55.8715515	115.435669	695.797546	0.195639998	73718
44164	9	540	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	13	0	1	0	299	299	0.00283399993	0.00104799995	0.00303900009	0.0176069997	0.116093002	546
44165	9	581	1	10000000	cplex_stopearly_2iter	0	0	300	11	3	45	0	1	0	99	99	0.264183998	18.3683796	51.3108635	156.053101	0.163637996	51050
44166	9	564	1	10000000	cplex_searchall_1iter	0	0	300	11	5	4	0	1	0	249	249	0.196850002	9.58281708	19.0161648	102.134567	0.00106399995	12128
44167	9	565	1	10000000	cplex_searchall_1iter	0	0	300	11	5	5	0	1	0	249	249	0.216463	12.2488642	24.1643906	137.24704	0.00151099998	15160
44168	9	566	1	10000000	cplex_searchall_1iter	0	0	300	11	5	4	0	1	0	249	249	0.192379996	9.58411694	19.0187302	102.425385	0.00105199998	12128
44169	9	567	1	10000000	cplex_searchall_1iter	0	0	300	11	5	5	0	1	0	249	249	0.204230994	12.2552872	24.2834053	136.415451	0.00155199994	15160
44170	9	568	1	10000000	cplex_searchall_1iter	0	0	300	11	5	5	0	1	0	249	249	0.213078007	11.7863779	23.9591694	136.462814	0.00142600003	15160
44171	9	569	1	10000000	cplex_searchall_1iter	0	0	300	11	5	5	0	1	0	249	249	0.212551996	12.8288631	24.7096252	147.229294	0.00185799995	15160
44172	9	570	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	6	1	0.272727013	199	188	0.582460999	53.7414169	109.78302	896.188782	0.00187000004	66704
44173	9	571	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	6	1	0.272727013	199	188	0.509355009	52.1452293	109.384369	893.913086	0.00149399997	66704
44174	9	572	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	0	1	0	199	199	0.528629005	51.9265633	107.935265	909.094666	0.00117800001	66704
44175	9	573	1	10000000	cplex_searchall_1iter	0	0	300	11	5	23	0	1	0	199	199	0.580650985	56.7232666	115.333191	972.030212	0.000627000001	69736
44176	9	574	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	6	1	0.272727013	199	188	0.547366977	54.6838188	110.755669	896.261414	0.00140499999	66704
44177	9	575	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	6	1	0.272727013	199	188	0.518967986	54.1204681	110.736328	892.627441	0.00135300006	66704
44178	9	576	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	0	1	0	199	199	0.541085005	53.9936028	110.787933	917.272217	0.00115200004	66704
44179	9	577	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	6	1	0.272727013	199	188	0.579415023	53.3702087	109.602135	893.513977	0.00147100003	66704
44180	9	578	1	10000000	cplex_searchall_1iter	0	0	300	11	5	23	0	1	0	199	199	0.566188991	57.065712	117.759232	977.055237	0.000569999975	69736
44181	9	579	1	10000000	cplex_searchall_1iter	0	0	300	11	5	22	6	1	0.272727013	199	188	0.572897971	54.0237656	110.471733	895.312073	0.00208500004	66704
44182	9	580	1	10000000	cplex_searchall_1iter	0	0	300	11	5	11	60	1	5.45454502	99	99	0.360929012	28.5343246	56.3458748	368.349182	0.000592999975	33352
44183	9	581	1	10000000	cplex_searchall_1iter	0	0	300	11	5	45	16	1	0.355556011	99	99	0.956263006	115.044685	228.954132	2441.68774	0.000492000021	136440
44184	9	582	1	10000000	cplex_searchall_1iter	0	0	300	11	5	3	0	1	0	99	99	0.200553	6.72328186	14.2084646	79.151619	0.000493999978	9096
44185	9	583	1	10000000	cplex_searchall_1iter	0	0	300	11	5	15	2	1	0.133332998	99	99	0.443915993	37.5691795	76.1770401	503.973755	0.000556999992	45480
44186	9	584	1	10000000	cplex_searchall_1iter	0	0	300	11	5	45	16	1	0.355556011	99	99	0.929951012	113.329971	227.499649	2435.68408	0.00057199999	136440
44187	9	585	1	10000000	cplex_searchall_1iter	0	0	300	11	5	11	60	1	5.45454502	99	99	0.331907004	25.1759567	54.6478806	368.411896	0.000590000011	33352
44188	9	586	1	10000000	cplex_searchall_1iter	0	0	300	11	5	3	0	1	0	99	99	0.191045001	8.19090462	15.2120619	79.5180054	0.000525999989	9096
44189	9	587	1	10000000	cplex_searchall_1iter	0	0	300	11	5	1	2	1	2	99	130	0.155497998	3.2515471	4.98403788	27.2183456	0.00298899994	3032
44190	9	544	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	1.88571799	283.249268	539.242554	372.562225	0.00199900009	303200
44191	9	545	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	1.85366905	275.167175	535.139893	371.696533	0.001666	303200
44192	9	546	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	2.26838112	285.690277	541.960999	374.923096	0.00141799997	303200
44193	9	547	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	1.81029105	280.69931	540.942871	372.366638	0.00145900005	303200
44194	9	548	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	1.799137	278.342682	529.648254	386.376709	0.00221400009	303200
44195	9	549	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	299	299	2.07784891	273.032654	532.240356	375.990723	0.00209000008	303200
44196	9	550	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	1.76087797	281.514435	544.564148	7595.9751	0.00142999995	303200
44197	9	551	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	1.84945798	274.393524	538.775696	7318.48145	0.00130899996	303200
44198	9	552	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	1.92276394	284.494354	541.518066	7288.08301	0.00144100003	303200
44199	9	553	1	10000000	Naive_cplex	0	0	300	11	4	100	0	1	0	274	274	1.93352199	276.555908	536.790894	7303.61084	0.00109000003	303200
1	1	60	1	10000000	cplex	0	1	300	2	0	24	0	1	0	299	299	0.0235009994	0.0191750005	0.012259	0.0101800002	0.657961011	360
2	1	60	1	10000000	cplex	1	0	275	11	1	24	0	1	0	299	299	0.0110830003	0.00656800019	0.0106349997	0.00853000022	0.522189021	1008
3	1	60	1	10000000	cplex	1	1	275	2	2	24	0	1	0	299	299	0.00826600008	0.00213799998	0.0030100001	0.00698200008	0.487542987	360
4	1	60	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.00544400001	0.00266600004	0.00538699981	0.00921600033	0.534645021	1008
5	1	60	1	10000000	cplex	1	1	275	1	4	24	0	1	0	299	299	0.00752100023	0.002355	0.00337800011	0.0139619997	0.481366009	204
6	1	61	1	10000000	cplex	0	1	300	2	0	25	0	1	0	299	299	0.00320899999	0.00170699996	0.00263700006	0.00736699998	0.872999012	375
7	1	61	1	10000000	cplex	1	0	275	11	1	25	0	1	0	299	299	0.00829300005	0.00244099996	0.00508800009	0.00911100022	0.860000014	1050
8	1	61	1	10000000	cplex	1	1	275	2	2	25	0	1	0	299	299	0.00594499987	0.00149399997	0.00260600005	0.00735499989	0.877757013	375
9	1	61	1	10000000	cplex	0	0	300	11	3	25	0	1	0	299	299	0.00508499984	0.00216599996	0.00496899989	0.00931499992	0.862547994	1050
10	1	61	1	10000000	cplex	1	1	275	1	4	25	0	1	0	299	299	0.00673800008	0.00211800006	0.00402199989	0.105063997	0.912302971	212
11	1	62	1	10000000	cplex	0	1	300	2	0	23	0	1	0	299	299	0.00371400011	0.00100599998	0.0020920001	0.00688599981	0.875717998	345
12	1	62	1	10000000	cplex	1	0	275	11	1	23	0	1	0	299	299	0.0063860002	0.00206699991	0.00426500011	0.00791199971	0.979623973	966
13	1	62	1	10000000	cplex	1	1	275	2	2	23	0	1	0	299	299	0.00694000022	0.000957000011	0.00207099994	0.00632200018	0.862509012	345
14	1	62	1	10000000	cplex	0	0	300	11	3	23	0	1	0	299	299	0.00344599993	0.00122800004	0.0042770002	0.00910000037	0.860207975	966
15	1	62	1	10000000	cplex	1	1	275	1	4	23	0	1	0	299	299	0.00619299989	0.00122700003	0.00265399995	0.0143370004	1.19042206	195
16	1	63	1	10000000	cplex	0	1	300	2	0	25	0	1	0	299	299	0.00406299997	0.000835000013	0.00225899997	0.00725900009	0.202239007	375
17	1	63	1	10000000	cplex	1	0	275	11	1	25	0	1	0	299	299	0.00623399997	0.00135499996	0.00466099987	0.00980000012	0.195837006	1050
18	1	63	1	10000000	cplex	1	1	275	2	2	25	0	1	0	299	299	0.00682399981	0.000724999991	0.00224799989	0.00742800022	0.201404005	375
19	1	63	1	10000000	cplex	0	0	300	11	3	25	0	1	0	299	299	0.00381599995	0.00135799998	0.00475500012	0.00959699973	0.200469002	1050
20	1	63	1	10000000	cplex	1	1	275	1	4	25	0	1	0	299	299	0.00663900003	0.00162700005	0.0029480001	0.0172680002	0.303900003	212
21	1	64	1	10000000	cplex	0	1	300	2	0	28	0	1	0	299	299	0.0054390002	0.00133	0.002691	0.00796500035	0.803579986	420
22	1	64	1	10000000	cplex	1	0	275	11	1	28	0	1	0	299	299	0.00676300004	0.00156500004	0.00521800015	0.00960600004	0.786625028	1176
23	1	64	1	10000000	cplex	1	1	275	2	2	28	0	1	0	299	299	0.00660199998	0.00142600003	0.00259699998	0.00699499995	0.789996982	420
24	1	64	1	10000000	cplex	0	0	300	11	3	28	0	1	0	299	299	0.00472099986	0.00138599996	0.00512599992	0.0101150004	0.806912005	1176
25	1	64	1	10000000	cplex	1	1	275	1	4	28	0	1	0	299	299	0.00633500004	0.00105900003	0.0031020001	0.0171830002	0.797809005	238
26	1	65	1	10000000	cplex	0	1	300	2	0	41	0	1	0	299	299	0.00626499997	0.00122600002	0.00346400007	0.00930900034	0.852805018	615
27	1	65	1	10000000	cplex	1	0	275	11	1	41	0	1	0	299	299	0.00907700043	0.00198299997	0.00739300018	0.0129709998	0.852797985	1722
28	1	65	1	10000000	cplex	1	1	275	2	2	41	0	1	0	299	299	0.0103719998	0.00138699997	0.00362399989	0.00904100016	0.855710983	615
29	1	65	1	10000000	cplex	0	0	300	11	3	41	0	1	0	299	299	0.0081860004	0.00242500007	0.00743999984	0.0124089997	0.834824026	1722
30	1	65	1	10000000	cplex	1	1	275	1	4	41	0	1	0	299	299	0.00785200018	0.00148700003	0.00445700018	0.0220190007	0.835263014	348
31	1	66	1	10000000	cplex	0	1	300	2	0	27	0	1	0	299	299	0.00560300006	0.000976999989	0.00243899995	0.0074339998	0.864480019	405
32	1	66	1	10000000	cplex	1	0	275	11	1	27	0	1	0	299	299	0.00797700044	0.00162	0.005167	0.00959699973	0.886991978	1134
33	1	66	1	10000000	cplex	1	1	275	2	2	27	0	1	0	299	299	0.00782399997	0.000959999976	0.00255999994	0.00735600013	0.88973999	405
34	1	66	1	10000000	cplex	0	0	300	11	3	27	0	1	0	299	299	0.00554999989	0.00162400003	0.00516499998	0.00962200016	0.880721986	1134
35	1	66	1	10000000	cplex	1	1	275	1	4	27	0	1	0	299	299	0.00782399997	0.00123000005	0.003211	0.0155389998	1.21083796	229
36	1	67	1	10000000	cplex	0	1	300	2	0	27	0	1	0	299	299	0.00400900003	0.000754999986	0.0024900001	0.00755099999	0.794017017	405
37	1	67	1	10000000	cplex	1	0	275	11	1	27	0	1	0	299	299	0.00607200013	0.00130400003	0.00513899978	0.00987299997	0.78459698	1134
38	1	67	1	10000000	cplex	1	1	275	2	2	27	0	1	0	299	299	0.00608400023	0.000771999999	0.0024629999	0.00733199995	0.788196981	405
39	1	67	1	10000000	cplex	0	0	300	11	3	27	0	1	0	299	299	0.00447400007	0.00164399995	0.00511199981	0.00947299972	0.790409982	1134
40	1	67	1	10000000	cplex	1	1	275	1	4	27	0	1	0	299	299	0.00608200021	0.000982000027	0.00306900009	0.0160009991	0.793760002	229
41	1	68	1	10000000	cplex	0	1	300	2	0	33	0	1	0	299	299	0.00579999993	0.00111199997	0.00293199997	0.00806399994	0.234796003	495
42	1	68	1	10000000	cplex	1	0	275	11	1	33	0	1	0	299	299	0.00680600014	0.00156999996	0.00604199991	0.0113580003	0.236787006	1386
43	1	68	1	10000000	cplex	1	1	275	2	2	33	0	1	0	299	299	0.00682100002	0.000939999998	0.00289299991	0.00818299968	0.245731995	495
44	1	68	1	10000000	cplex	0	0	300	11	3	33	0	1	0	299	299	0.00459699985	0.00156700006	0.006054	0.0115109999	0.230220005	1386
45	1	68	1	10000000	cplex	1	1	275	1	4	33	0	1	0	299	299	0.00683100009	0.00119099999	0.00365499989	0.0187020004	0.237562001	280
46	1	69	1	10000000	cplex	0	1	300	2	0	22	0	1	0	299	299	0.00423499988	0.000760999974	0.002018	0.00674699992	0.162494004	330
47	1	69	1	10000000	cplex	1	0	275	11	1	22	0	1	0	299	299	0.00541000022	0.00106200005	0.0042539998	0.00885699969	0.164755002	924
48	1	69	1	10000000	cplex	1	1	275	2	2	22	0	1	0	299	299	0.00541999983	0.000625999994	0.0020620001	0.00686400011	0.162047997	330
49	1	69	1	10000000	cplex	0	0	300	11	3	22	0	1	0	299	299	0.00325999991	0.00107200001	0.00427100016	0.00932599977	0.166100994	924
50	1	69	1	10000000	cplex	1	1	275	1	4	22	0	1	0	299	299	0.0054299999	0.00080899999	0.00256399997	0.0155440001	0.164464995	187
51	1	70	1	10000000	cplex	0	1	300	5	0	10	0	1	0	274	274	0.0471879989	0.124649003	0.262073994	0.749099016	0.164515004	1736
52	1	70	1	10000000	cplex	1	0	288	11	1	10	0	1	0	274	274	0.0291600004	0.119672	0.283055007	0.332286	0.153844997	3473
53	1	70	1	10000000	cplex	1	1	288	5	2	10	0	1	0	274	274	0.0291419998	0.0904640034	0.194352001	0.469473004	0.151453003	2318
54	1	70	1	10000000	cplex	0	0	300	11	3	10	0	1	0	274	274	0.0457120016	0.177586004	0.410643011	0.803044021	0.167248994	2920
55	1	70	1	10000000	cplex	1	1	288	1	4	10	0	1	0	274	274	0.0272179991	0.0300670005	0.0425300002	0.470479995	0.163857996	445
56	1	71	1	10000000	cplex	0	1	300	5	0	16	0	1	0	274	274	0.0668540001	0.202904999	0.417156011	0.816464007	0.154567003	2777
57	1	71	1	10000000	cplex	1	0	288	11	1	16	0	1	0	274	274	0.0415150002	0.192848995	0.46024701	0.632790983	0.162542999	5557
58	1	71	1	10000000	cplex	1	1	288	5	2	16	0	1	0	274	274	0.0419690013	0.145033002	0.321548998	0.454546005	0.155799001	3709
59	1	71	1	10000000	cplex	0	0	300	11	3	16	0	1	0	274	274	0.0351429991	0.377191007	0.678210974	0.950986981	0.175990999	4672
60	1	71	1	10000000	cplex	1	1	288	1	4	16	0	1	0	274	274	0.0375699997	0.0364199989	0.0659509972	0.248438999	0.166718006	712
71	1	74	1	10000000	cplex	0	1	300	5	0	14	0	1	0	274	274	0.0580170006	0.167181998	0.369147986	0.569299996	0.159208	2430
72	1	74	1	10000000	cplex	1	0	288	11	1	14	0	1	0	274	274	0.0373100005	0.165787995	0.401086986	0.739965022	0.152309	4862
73	1	74	1	10000000	cplex	1	1	288	5	2	14	0	1	0	274	274	0.122268997	0.138919994	0.294205993	0.358193994	0.150027007	3246
74	1	74	1	10000000	cplex	0	0	300	11	3	14	0	1	0	274	274	0.0589930005	0.237519994	0.576723993	1.01707494	0.190441996	4088
75	1	74	1	10000000	cplex	1	1	288	1	4	14	0	1	0	274	274	0.0532089993	0.0396689996	0.06219	0.249630004	0.190255001	623
76	1	75	1	10000000	cplex	0	1	300	4	0	16	13	1	0.8125	274	282	0.0472779982	0.0840770006	0.185390994	0.233142003	1.00087905	1752
77	1	75	1	10000000	cplex	1	0	288	11	1	16	13	1	0.8125	274	282	0.0283640008	0.0982799977	0.243579999	0.276309997	1.00587404	4384
78	1	75	1	10000000	cplex	1	1	288	5	2	16	13	1	0.8125	274	282	0.0230730008	0.0731619969	0.15546	0.186603993	1.1221	2579
79	1	75	1	10000000	cplex	0	0	300	11	3	16	13	1	0.8125	274	282	0.0470409989	0.133689001	0.333352	0.380403012	0.981181026	3392
80	1	75	1	10000000	cplex	1	1	288	1	4	16	13	1	0.8125	274	282	0.0283690002	0.035606999	0.0648349971	0.512282014	0.930016994	409
81	1	76	1	10000000	cplex	0	1	300	5	0	8	0	1	0	274	274	0.0405940004	0.0990059972	0.210473001	0.452989012	0.156586006	1388
82	1	76	1	10000000	cplex	1	0	288	11	1	8	0	1	0	274	274	0.0254980009	0.0968670025	0.228896007	0.349103004	0.147066996	2778
83	1	76	1	10000000	cplex	1	1	288	5	2	8	0	1	0	274	274	0.0261080004	0.0752800032	0.162135005	0.269360006	0.159493998	1854
84	1	76	1	10000000	cplex	0	0	300	11	3	8	0	1	0	274	274	0.0403820015	0.140653998	0.335303992	1.042557	0.166659996	2336
85	1	76	1	10000000	cplex	1	1	288	1	4	8	0	1	0	274	274	0.024774	0.0194230005	0.0350629985	0.130391002	0.153049007	356
91	1	78	1	10000000	cplex	0	1	300	5	0	3	0	1	0	274	274	0.0215039998	0.0411479995	0.084716998	0.224946007	0.144428	520
92	1	78	1	10000000	cplex	1	0	288	11	1	3	0	1	0	274	274	0.014773	0.0437749997	0.085202001	0.173711002	0.146606997	1042
93	1	78	1	10000000	cplex	1	1	288	5	2	3	0	1	0	274	274	0.0146040004	0.0300229993	0.0614369996	0.156730995	0.151102006	695
94	1	78	1	10000000	cplex	0	0	300	11	3	3	0	1	0	274	274	0.0212430004	0.0563849993	0.124349996	0.240324005	0.153640002	876
95	1	78	1	10000000	cplex	1	1	288	1	4	3	0	1	0	274	274	0.012809	0.00823799986	0.0141700003	0.114886001	0.155260995	133
96	1	79	1	10000000	cplex	0	1	300	5	0	5	0	1	0	274	274	0.0358569995	0.074458003	0.133186996	0.296000004	0.175053	868
97	1	79	1	10000000	cplex	1	0	288	11	1	5	0	1	0	274	274	0.0191050004	0.0630059987	0.144721001	0.220731005	0.185562	1736
98	1	79	1	10000000	cplex	1	1	288	5	2	5	0	1	0	274	274	0.0189299993	0.0481400006	0.0994890034	0.252835006	0.1796	1159
99	1	79	1	10000000	cplex	0	0	300	11	3	5	0	1	0	274	274	0.0286350008	0.0923129991	0.211594999	0.318612009	0.167880997	1460
100	1	79	1	10000000	cplex	1	1	288	1	4	5	17	0.200000003	2.5999999	274	282	0.012023	0.00647900021	0.0117549999	0.118441999	0.248058006	164
101	1	80	1	10000000	cplex	0	1	300	6	0	16	0	1	0	249	249	0.121799998	1.11351395	2.19827008	2.05473399	0.881223023	6866
102	1	80	1	10000000	cplex	1	0	251	11	1	16	0	1	0	249	249	0.0363430008	0.310092986	0.663703978	0.679624021	0.869439006	12014
103	1	80	1	10000000	cplex	1	1	251	8	2	16	0	1	0	249	249	0.0346129984	0.328631997	0.582296014	0.682381988	0.868192017	10563
104	1	80	1	10000000	cplex	0	0	300	11	3	16	0	1	0	249	249	0.19427	1.24898195	2.70231509	2.44426489	0.877116978	8672
105	1	80	1	10000000	cplex	1	1	251	1	4	16	16	0	0	249		0.0554290004	0.381374002	0.631245971	7.78782177	0.0597440004	1103
106	1	81	1	10000000	cplex	0	1	300	7	0	18	0	1	0	249	249	0.132367	1.11356997	2.35216093	2.25763702	0.228186995	7854
107	1	81	1	10000000	cplex	1	0	250	11	1	18	0	1	0	249	249	0.0251950007	0.280054986	0.677456975	0.749240994	0.219218001	14886
108	1	81	1	10000000	cplex	1	1	250	8	2	18	0	1	0	249	249	0.0209960006	0.318695992	0.633446991	0.713666022	0.224760994	13239
109	1	81	1	10000000	cplex	0	0	300	11	3	18	0	1	0	249	249	0.129933998	1.20959997	2.83862805	2.68661594	0.204395995	9756
110	1	81	1	10000000	cplex	1	1	250	1	4	18	18	0	0	249		0.0447460003	0.338694006	0.571838975	5.58089304	0.0679259971	1101
111	1	82	1	10000000	cplex	0	1	300	6	0	15	0	1	0	249	249	0.144972995	0.905300021	1.92216897	1.89527202	0.943154991	6490
112	1	82	1	10000000	cplex	1	0	251	11	1	15	0	1	0	249	249	0.0244759992	0.237439007	0.57051003	0.640576005	0.929844022	11263
113	1	82	1	10000000	cplex	1	1	251	8	2	15	0	1	0	249	249	0.02097	0.280820012	0.532159984	0.619400978	0.928282022	9903
114	1	82	1	10000000	cplex	0	0	300	11	3	15	0	1	0	249	249	0.0669040009	1.30773795	2.37796807	2.3282361	1.00425601	8130
115	1	82	1	10000000	cplex	1	1	251	1	4	15	15	0	0	249		0.0343419984	0.104952	0.173666	1.56522	0.0936829969	1134
116	1	83	1	10000000	cplex	0	1	300	7	0	20	0	1	0	249	249	0.122440003	1.34568596	2.68706989	2.50178504	0.576002002	8905
117	1	83	1	10000000	cplex	1	0	251	11	1	20	0	1	0	249	249	0.030297	0.33653	0.803279996	0.864646018	0.727793992	15017
118	1	83	1	10000000	cplex	1	1	251	8	2	20	0	1	0	249	249	0.0311120003	0.296068996	0.694974005	0.791420996	0.570524991	13204
119	1	83	1	10000000	cplex	0	0	300	11	3	20	0	1	0	249	249	0.134075999	1.45569098	3.22903395	2.90159392	0.575670004	10840
120	1	83	1	10000000	cplex	1	1	251	1	4	20	20	0	0	249		0.457049012	7.64951181	12.484683	99.5167313	0	3030
121	1	84	1	10000000	cplex	0	1	300	6	0	16	0	1	0	249	249	0.0875099972	1.027964	2.10360408	2.02536106	0.411637992	6866
122	1	84	1	10000000	cplex	1	0	251	11	1	16	0	1	0	249	249	0.0159789994	0.278577	0.643351972	0.686662972	0.450015008	12014
123	1	84	1	10000000	cplex	1	1	251	8	2	16	0	1	0	249	249	0.028585	0.249888003	0.564736009	0.646668971	0.442997009	10563
124	1	84	1	10000000	cplex	0	0	300	11	3	16	0	1	0	249	249	0.135461003	1.15462005	2.62862396	2.43390894	0.40081799	8672
125	1	84	1	10000000	cplex	1	1	251	1	4	16	16	0	0	249		0.045074001	0.33724001	0.569207013	6.69436979	0.0768589973	1105
126	1	85	1	10000000	cplex	0	1	300	6	0	12	0	1	0	249	249	0.107992999	0.675572991	1.56524897	1.49927998	0.941928983	5149
127	1	85	1	10000000	cplex	1	0	251	11	1	12	0	1	0	249	249	0.0206860006	0.213779002	0.493503988	0.516166985	0.942991972	9010
128	1	85	1	10000000	cplex	1	1	251	8	2	12	0	1	0	249	249	0.0212309994	0.178938001	0.420655012	0.475226998	0.951843023	7922
129	1	85	1	10000000	cplex	0	0	300	11	3	12	0	1	0	249	249	0.101149	0.842117012	1.942873	1.87979102	0.961189985	6504
130	1	85	1	10000000	cplex	1	1	251	1	4	12	12	0	0	249		0.0471390001	0.343246013	0.537747025	6.70784378	0.0622229986	874
131	1	86	1	10000000	cplex	0	1	300	7	0	21	0	1	0	249	249	0.0943579972	1.61802697	2.86138606	2.60548997	0.244785994	9163
132	1	86	1	10000000	cplex	1	0	250	11	1	21	0	1	0	249	249	0.028655	0.326586008	0.822338998	0.868165016	0.242190003	17367
133	1	86	1	10000000	cplex	1	1	250	8	2	21	0	1	0	249	249	0.0253430009	0.361184001	0.75335902	0.817385972	0.226138994	15445
134	1	86	1	10000000	cplex	0	0	300	11	3	21	0	1	0	249	249	0.145518005	1.42024398	3.42381811	3.03442788	0.231066003	11382
135	1	86	1	10000000	cplex	1	1	250	1	4	21	21	0	0	249		0.050875999	0.398970991	0.688091993	6.82366896	0.073100999	1285
136	1	87	1	10000000	cplex	0	1	300	7	0	18	0	1	0	249	249	0.136224002	1.23011506	2.49943399	2.30018306	0.883356988	7867
137	1	87	1	10000000	cplex	1	0	247	11	1	18	0	1	0	249	249	0.0163339991	0.208624005	0.516004026	0.593347013	0.879703999	17748
138	1	87	1	10000000	cplex	1	1	247	9	2	18	0	1	0	249	249	0.0168149993	0.198961005	0.473078012	0.58048898	0.886777997	15969
139	1	87	1	10000000	cplex	0	0	300	11	3	18	0	1	0	249	249	0.112845004	1.44243801	2.97295403	2.67420101	0.939475	9756
140	1	87	1	10000000	cplex	1	1	247	1	4	18	0	1	0	249	249	0.0168839991	0.0275100004	0.0485239998	0.159964994	0.886866987	1011
141	1	88	1	10000000	cplex	0	1	300	6	0	20	0	1	0	249	249	0.768056989	1.19385505	2.6824441	2.43506694	0.824034989	8582
142	1	88	1	10000000	cplex	1	0	251	11	1	20	0	1	0	249	249	0.0301920008	0.341481	0.811905026	0.841794014	0.815195978	15017
143	1	88	1	10000000	cplex	1	1	251	8	2	20	0	1	0	249	249	0.0286660008	0.38233301	0.742101014	0.797945976	0.803192973	13204
144	1	88	1	10000000	cplex	0	0	300	11	3	20	0	1	0	249	249	0.151224002	1.37815106	3.4279561	2.90793896	0.812367976	10840
145	1	88	1	10000000	cplex	1	1	251	1	4	20	20	0	0	249		0.0679550022	0.294102997	0.50306797	4.22961617	0.0784510002	1355
146	1	89	1	10000000	cplex	0	1	300	6	0	10	0	1	0	249	249	0.0945309997	0.567405999	1.33278406	1.36546803	0.53134203	4291
147	1	89	1	10000000	cplex	1	0	251	11	1	10	0	1	0	249	249	0.0183630008	0.164997995	0.401737005	0.433645993	0.543973029	7508
148	1	89	1	10000000	cplex	1	1	251	8	2	10	0	1	0	249	249	0.0255120005	0.186139002	0.382999986	0.497213006	0.542415977	6602
149	1	89	1	10000000	cplex	0	0	300	11	3	10	0	1	0	249	249	0.0919630006	0.659139991	1.63386905	1.56880605	0.550628006	5420
150	1	89	1	10000000	cplex	1	1	251	1	4	10	10	0	0	249		0.0330770016	0.171232	0.288064986	3.72845292	0.0699739978	673
151	1	90	1	10000000	cplex	0	1	300	8	0	21	4	1	0.190476	199	199	0.261732996	5.37650108	12.5859261	18.6236591	0.940777004	20115
152	1	90	1	10000000	cplex	1	0	241	11	1	21	4	1	0.190476	199	199	0.0805480033	3.70311403	8.73812675	13.1176844	0.940985024	33362
153	1	90	1	10000000	cplex	1	1	241	9	2	21	4	1	0.190476	199	199	0.0995659977	3.59587407	8.20430946	14.6165562	0.923605025	31434
154	1	90	1	10000000	cplex	0	0	300	11	3	21	4	1	0.190476	199	199	0.236739993	5.72947598	13.6111832	17.5141983	0.965174019	21882
155	1	90	1	10000000	cplex	1	1	241	1	4	21	21	0	0	199		0.215219006	0.872107983	1.60667396	15.1082478	0.0613269992	2287
156	1	91	1	10000000	cplex	0	1	300	9	0	34	4	1	0.117647	199	199	0.303162009	8.74411583	20.588974	31.6964226	0.940645993	32711
157	1	91	1	10000000	cplex	1	0	240	11	1	34	4	1	0.117647	199	199	0.108603001	6.69202518	13.9297733	22.5562382	0.916701972	54866
158	1	91	1	10000000	cplex	1	1	240	10	2	34	4	1	0.117647	199	199	0.110377997	5.71109009	13.2174997	24.8824596	0.934984982	52092
159	1	91	1	10000000	cplex	0	0	300	11	3	34	4	1	0.117647	199	199	0.280858994	9.25423717	21.9363518	30.2379322	0.942250013	35428
160	1	91	1	10000000	cplex	1	1	240	1	4	34	34	0	0	199		0.316778004	1.65447998	2.94752789	17.3139496	0.0729380026	3654
161	1	92	1	10000000	cplex	0	1	300	9	0	65	0	1	0	199	199	0.664269984	19.0868759	42.7692261	72.6244507	0.769798994	62908
162	1	92	1	10000000	cplex	1	0	240	11	1	65	0	1	0	199	199	0.207525	13.7590828	28.6025658	50.3786964	0.76128298	104890
163	1	92	1	10000000	cplex	1	1	240	10	2	65	0	1	0	199	199	0.169792995	12.3267078	27.4963093	60.1405792	0.777822018	99587
164	1	92	1	10000000	cplex	0	0	300	11	3	65	0	1	0	199	199	0.619660974	20.4803219	45.5473709	66.6412125	0.769369006	67730
165	1	92	1	10000000	cplex	1	1	240	1	4	65	65	0	0	199		0.477355003	5.64148188	10.2954655	63.4437943	0.0694859996	6589
166	1	93	1	10000000	cplex	0	1	300	8	0	25	0	1	0	199	199	0.230339006	7.45124817	15.1309252	22.1848679	0.980534971	23947
167	1	93	1	10000000	cplex	1	0	241	11	1	25	0	1	0	199	199	0.139129996	4.21926785	10.3269806	15.6483631	0.864282012	39716
168	1	93	1	10000000	cplex	1	1	241	9	2	25	0	1	0	199	199	0.113494001	4.08135509	9.76045418	17.3368778	0.864444971	37421
169	1	93	1	10000000	cplex	0	0	300	11	3	25	0	1	0	199	199	0.230121002	6.53755093	16.1787834	21.0947495	0.853895009	26050
170	1	93	1	10000000	cplex	1	1	241	1	4	25	25	0	0	199		0.193747997	0.984979987	1.85105598	15.9987831	0.075263001	2714
171	1	94	1	10000000	cplex	0	1	300	8	0	38	0	1	0	199	199	0.291202992	12.3187618	24.9950371	36.2736893	0.86748898	36466
172	1	94	1	10000000	cplex	1	0	240	11	1	38	0	1	0	199	199	0.151856005	7.26266003	17.2535057	26.0037174	0.855727017	61320
173	1	94	1	10000000	cplex	1	1	240	10	2	38	0	1	0	199	199	0.145829007	7.11707401	16.370615	28.6420498	0.887153029	58220
174	1	94	1	10000000	cplex	0	0	300	11	3	38	0	1	0	199	199	0.420453012	11.4538298	27.8892422	34.0697708	0.893670976	39596
175	1	94	1	10000000	cplex	1	1	240	1	4	38	38	0	0	199		0.28777501	1.41291106	2.65532589	38.0156364	0.0743390024	4666
176	1	95	1	10000000	cplex	0	1	300	8	0	13	4	1	0.307691991	199	199	0.200619996	3.90908289	8.57885933	10.8761358	0.929458022	12452
177	1	95	1	10000000	cplex	1	0	241	11	1	13	4	1	0.307691991	199	199	0.090150997	2.76260304	5.86004782	7.55038118	0.892390013	20652
178	1	95	1	10000000	cplex	1	1	241	9	2	13	4	1	0.307691991	199	199	0.111469999	3.47922993	5.54856682	8.35617638	0.945210993	19459
179	1	95	1	10000000	cplex	0	0	300	11	3	13	4	1	0.307691991	199	199	0.206938997	4.00250483	9.17749882	10.3497477	0.906051993	13546
180	1	95	1	10000000	cplex	1	1	241	1	4	13	13	0	0	199		0.112007998	0.604785025	1.00238097	7.763834	0.0784590021	1402
181	1	96	1	10000000	cplex	0	1	300	8	0	14	0	1	0	199	199	0.256695986	3.562819	8.4699297	11.5359201	0.924161017	13410
182	1	96	1	10000000	cplex	1	0	241	11	1	14	0	1	0	199	199	0.05528	2.34599495	5.78134918	8.15961742	0.942183971	22241
183	1	96	1	10000000	cplex	1	1	241	9	2	14	0	1	0	199	199	0.0563730001	2.25394511	5.47026682	9.19801521	0.949894011	20956
184	1	96	1	10000000	cplex	0	0	300	11	3	14	0	1	0	199	199	0.166321993	3.70809007	9.03851318	11.3271589	0.954918027	14588
185	1	96	1	10000000	cplex	1	1	241	1	4	14	14	0	0	199		0.126698002	0.567175984	1.02667296	8.42668915	0.06391	1511
186	1	97	1	10000000	cplex	0	1	300	8	0	16	0	1	0	199	199	0.177586004	4.28249884	9.86979771	13.9384375	0.648289979	15326
187	1	97	1	10000000	cplex	1	0	241	11	1	16	0	1	0	199	199	0.0718059987	2.86921191	6.54556513	9.55693245	0.644563019	25418
188	1	97	1	10000000	cplex	1	1	241	9	2	16	0	1	0	199	199	0.0845789984	2.65922809	6.24723291	10.6650009	0.629867971	23949
189	1	97	1	10000000	cplex	0	0	300	11	3	16	0	1	0	199	199	0.211523995	4.17372322	11.3084974	12.9092894	0.642674983	16672
190	1	97	1	10000000	cplex	1	1	241	1	4	16	16	0	0	199		0.0839790031	0.670001984	1.15596104	9.34717941	0.0806170031	1725
191	1	98	1	10000000	cplex	0	1	300	8	0	19	0	1	0	199	199	0.260419011	5.56546402	12.6953287	16.8243332	0.62676698	18199
192	1	98	1	10000000	cplex	1	0	241	11	1	19	0	1	0	199	199	0.0765260011	3.8553319	8.79395008	11.7351542	0.622708976	30184
193	1	98	1	10000000	cplex	1	1	241	9	2	19	0	1	0	199	199	0.0966179967	3.69473004	8.13683987	12.9991875	0.617805004	28440
194	1	98	1	10000000	cplex	0	0	300	11	3	19	0	1	0	199	199	0.256496012	5.91246605	13.8320618	15.5487747	0.617847025	19798
195	1	98	1	10000000	cplex	1	1	241	1	4	19	19	0	0	199		0.184423998	0.941797972	1.49449694	11.2446642	0.081253998	2060
196	1	99	1	10000000	cplex	0	1	300	9	0	21	0	1	0	199	199	0.255461007	6.35808086	13.0147285	18.1354561	0.533257008	20204
197	1	99	1	10000000	cplex	1	0	240	11	1	21	0	1	0	199	199	0.0771000013	3.66670108	8.75753212	12.6227999	0.528940976	33887
198	1	99	1	10000000	cplex	1	1	240	10	2	21	0	1	0	199	199	0.101302996	3.79601693	8.93734837	14.273592	0.558155	32174
199	1	99	1	10000000	cplex	0	0	300	11	3	21	0	1	0	199	199	0.284833997	6.47836018	15.0271721	17.1060276	0.555863976	21882
200	1	99	1	10000000	cplex	1	1	240	1	4	21	21	0	0	199		0.235429004	0.983476996	1.77508795	10.4680624	0.0770360008	2210
201	1	100	1	10000000	cplex	0	1	300	9	0	30	0	1	0	99	99	0.51542598	37.4386864	81.5336914	186.23233	0.774248004	57766
202	1	100	1	10000000	cplex	1	0	252	11	1	30	0	1	0	99	99	0.378096998	35.725132	79.3675003	145.667099	0.761416018	75122
203	1	100	1	10000000	cplex	1	1	252	9	2	30	0	1	0	99	99	0.428588986	33.8716583	75.4524231	181.261993	0.832278013	71201
204	1	100	1	10000000	cplex	0	0	300	11	3	30	0	1	0	99	99	0.488402992	38.0798035	84.2892303	151.115005	0.779902995	61260
205	1	100	1	10000000	cplex	1	1	252	1	4	30	30	0	0	99		0.381702989	2.85211492	4.93899488	25.9882393	0.0812849998	3742
206	1	101	1	10000000	cplex	0	1	300	9	0	27	0	1	0	99	99	0.552057981	31.9328213	70.9274292	157.380051	0.770422995	51989
207	1	101	1	10000000	cplex	1	0	252	11	1	27	0	1	0	99	99	0.32712999	31.9493389	69.6300278	124.546478	0.753377974	67610
208	1	101	1	10000000	cplex	1	1	252	9	2	27	0	1	0	99	99	0.34898001	31.1874237	66.5742722	156.611389	0.77481699	64081
209	1	101	1	10000000	cplex	0	0	300	11	3	27	0	1	0	99	99	0.459812999	33.3045425	75.1568756	127.601448	0.765658975	55134
210	1	101	1	10000000	cplex	1	1	252	1	4	27	27	0	0	99		0.375416994	2.56736994	4.44307518	23.5347137	0.0669789985	3368
211	1	102	1	10000000	cplex	0	1	300	9	0	34	0	1	0	99	99	0.516851008	35.3629951	82.6701431	224.798309	0.709922016	65735
212	1	102	1	10000000	cplex	1	0	238	11	1	34	0	1	0	99	99	0.293011993	33.7204895	78.1596527	171.320343	0.730880976	90312
213	1	102	1	10000000	cplex	1	1	238	10	2	34	0	1	0	99	99	0.358357012	35.6854973	80.3353806	225.807434	0.729170024	85766
214	1	102	1	10000000	cplex	0	0	300	11	3	34	0	1	0	99	99	0.630249977	42.5776596	95.2666168	181.186646	0.722119987	69428
215	1	102	1	10000000	cplex	1	1	238	1	4	34	34	0	0	99		0.317382008	3.77705312	6.92995596	53.9268875	0.0962390006	4437
216	1	103	1	10000000	cplex	0	1	300	9	0	20	0	1	0	99	99	0.383356988	20.2999878	49.6729355	110.130936	1.08009303	38645
217	1	103	1	10000000	cplex	1	0	238	11	1	20	0	1	0	99	99	0.233797997	20.6603146	48.5471077	81.4599533	0.866894007	53124
218	1	103	1	10000000	cplex	1	1	238	10	2	20	0	1	0	99	99	0.287930012	21.8205452	48.6133652	105.984398	0.955313981	50450
219	1	103	1	10000000	cplex	0	0	300	11	3	20	0	1	0	99	99	0.382275999	25.089325	56.4844055	88.0620575	0.904945016	40840
220	1	103	1	10000000	cplex	1	1	238	1	4	20	20	0	0	99		0.218934	2.31975293	3.99742508	35.8987617	0.104621999	2610
221	1	104	1	10000000	cplex	0	1	300	9	0	36	0	1	0	99	99	0.763514996	42.7260895	92.6710358	250.844833	0.376796991	69319
222	1	104	1	10000000	cplex	1	0	252	11	1	36	0	1	0	99	99	0.406057	36.708786	86.3248215	189.399994	0.261312008	90147
223	1	104	1	10000000	cplex	1	1	252	9	2	36	0	1	0	99	99	0.395227998	36.6608124	83.5129395	243.646667	0.483314008	85441
224	1	104	1	10000000	cplex	0	0	300	11	3	36	0	1	0	99	99	0.525379002	45.6998367	92.2442932	196.89537	0.334504008	73512
225	1	104	1	10000000	cplex	1	1	252	1	4	36	36	0	0	99		0.40478	3.26945496	5.94609213	28.0692978	0.100079998	4491
226	1	105	1	10000000	cplex	0	1	300	9	0	20	0	1	0	99	99	0.414871991	20.5477638	49.2365875	110.001808	0.824222028	38667
227	1	105	1	10000000	cplex	1	0	238	11	1	20	0	1	0	99	99	0.244371995	21.1929245	50.4496841	86.3804092	0.782719016	53124
228	1	105	1	10000000	cplex	1	1	238	10	2	20	0	1	0	99	99	0.269748986	18.9699688	45.2510452	106.919243	0.76058501	50450
229	1	105	1	10000000	cplex	0	0	300	11	3	20	0	1	0	99	99	0.410154998	29.3725872	53.7175331	95.2388306	0.785219014	40840
230	1	105	1	10000000	cplex	1	1	238	1	4	20	20	0	0	99		0.217928007	2.40493798	4.21690989	27.7028923	0.0754029974	2610
231	1	106	1	10000000	cplex	0	1	300	9	0	25	0	1	0	99	99	0.533227026	27.3357849	63.7626076	143.214264	0.844658971	48374
232	1	106	1	10000000	cplex	1	0	238	11	1	25	0	1	0	99	99	0.276762992	26.6370029	61.965168	113.237457	0.903472006	66406
233	1	106	1	10000000	cplex	1	1	238	10	2	25	0	1	0	99	99	0.294018	26.9983692	60.6780548	140.611282	0.928987026	63063
234	1	106	1	10000000	cplex	0	0	300	11	3	25	0	1	0	99	99	0.414967	27.3954811	65.9055862	118.77494	1.07989395	51050
235	1	72	1	10000000	cplex	0	1	300	5	0	24	0	1	0	274	274	0.128125995	0.561600983	0.781706989	0.964950979	0.255753011	4166
236	1	72	1	10000000	cplex	1	0	288	11	1	24	0	1	0	274	274	0.0379379988	0.320282996	0.712050021	0.809453011	0.193653002	8336
237	1	72	1	10000000	cplex	1	1	288	5	2	24	0	1	0	274	274	0.0673409998	0.216619998	0.466794014	0.764230013	0.199824005	5564
238	1	72	1	10000000	cplex	0	0	300	11	3	24	0	1	0	274	274	0.0830340013	0.433571994	0.969609022	1.10959995	0.189120993	7008
239	1	72	1	10000000	cplex	1	1	288	1	4	24	0	1	0	274	274	0.0674820021	0.0599890016	0.0947770029	0.392967999	0.187352002	1068
240	1	73	1	10000000	cplex	0	1	300	5	0	17	0	1	0	274	274	0.0800009966	0.199200004	0.431349009	0.559373975	0.161059007	2951
241	1	73	1	10000000	cplex	1	0	288	11	1	17	0	1	0	274	274	0.0493399985	0.196964994	0.465074003	0.882991016	0.176456004	5904
242	1	73	1	10000000	cplex	1	1	288	5	2	17	0	1	0	274	274	0.0466520004	0.163990006	0.325998008	0.475603014	0.224959001	3941
243	1	73	1	10000000	cplex	0	0	300	11	3	17	0	1	0	274	274	0.0750939995	0.283008009	0.673785985	0.758513987	0.391530007	4964
244	1	73	1	10000000	cplex	1	1	288	1	4	17	0	1	0	274	274	0.0454979986	0.0376360007	0.0656360015	0.313003987	0.178010002	757
245	1	77	1	10000000	cplex	0	1	300	5	0	5	0	1	0	274	274	0.0276989993	0.0607349984	0.119502999	0.237560004	0.16279	868
246	1	77	1	10000000	cplex	1	0	288	11	1	5	0	1	0	274	274	0.0212340001	0.070900999	0.133499995	0.222042993	0.150431007	1736
247	1	77	1	10000000	cplex	1	1	288	5	2	5	0	1	0	274	274	0.0204949994	0.0535160005	0.0925699994	0.181382	0.174804002	1159
248	1	77	1	10000000	cplex	0	0	300	11	3	5	0	1	0	274	274	0.029778	0.104162998	0.196003005	0.731746018	0.148923993	1460
249	1	77	1	10000000	cplex	1	1	288	1	4	5	0	1	0	274	274	0.0160029996	0.0135880001	0.0219500009	0.0918420032	0.176635996	222
250	1	107	1	10000000	cplex	0	1	300	9	0	27	0	1	0	99	99	0.524641991	26.5070801	59.0149422	164.742676	0.247299001	51989
251	1	107	1	10000000	cplex	1	0	252	11	1	27	0	1	0	99	99	0.312133998	25.4969044	56.6934013	126.988747	0.249256998	67610
252	1	107	1	10000000	cplex	1	1	252	9	2	27	0	1	0	99	99	0.343941987	25.0864906	54.9884262	161.999298	0.239812002	64081
253	1	107	1	10000000	cplex	0	0	300	11	3	27	0	1	0	99	99	0.457170993	26.6979046	61.7678719	130.115738	0.249587998	55134
254	1	107	1	10000000	cplex	1	1	252	1	4	27	27	0	0	99		0.339242995	2.11436391	3.62003994	21.0507469	0.0700619966	3368
255	1	108	1	10000000	cplex	0	1	300	9	0	25	0	1	0	99	99	0.459787995	25.5972786	55.2550812	147.156525	0.80093497	48138
256	1	108	1	10000000	cplex	1	0	252	11	1	25	0	1	0	99	99	0.286356986	24.3950005	53.9735641	114.869003	0.789600015	62602
257	1	108	1	10000000	cplex	1	1	252	9	2	25	0	1	0	99	99	0.320441991	24.1545124	51.0912247	144.2892	0.809072018	59334
258	1	108	1	10000000	cplex	0	0	300	11	3	25	0	1	0	99	99	0.439182013	26.3552647	57.8098831	118.678314	0.804207027	51050
259	1	108	1	10000000	cplex	1	1	252	1	4	25	25	0	0	99		0.306502998	2.02316999	3.39973092	20.1119061	0.067933999	3119
260	1	109	1	10000000	cplex	0	1	300	9	0	26	0	1	0	99	99	0.500782013	25.6447468	56.1222725	145.483521	0.849861026	50064
261	1	109	1	10000000	cplex	1	0	252	11	1	26	0	1	0	99	99	0.263377011	26.5414143	56.0413055	115.73645	0.859502971	65106
262	1	109	1	10000000	cplex	1	1	252	9	2	26	0	1	0	99	99	0.356950998	24.3038292	53.0083542	142.484558	0.880748987	61707
263	1	109	1	10000000	cplex	0	0	300	11	3	26	0	1	0	99	99	0.482046992	28.4805775	60.0820427	118.928635	0.870977998	53092
264	1	109	1	10000000	cplex	1	1	252	1	4	26	26	0	0	99		0.351918012	2.24784899	3.82128906	22.0434914	0.0836049989	3243
265	1	110	1	10000000	cplex	0	1	300	9	0	15	0	1	0	49	49	0.426183999	23.8922787	51.5100822	149.403809	0.832388997	36032
266	1	110	1	10000000	cplex	1	0	268	11	1	15	0	1	0	49	49	0.334991992	27.5191879	55.5080757	117.305061	0.874188006	42895
267	1	110	1	10000000	cplex	1	1	268	9	2	15	0	1	0	49	49	0.388958007	28.5134068	53.1386833	148.248291	0.830419004	40665
268	1	110	1	10000000	cplex	0	0	300	11	3	15	0	1	0	49	49	0.33939901	25.0916271	55.3642578	117.068405	0.813772023	38130
269	1	110	1	10000000	cplex	1	1	268	1	4	15	15	0	0	49		0.553427994	3.11000204	5.13751984	20.9041595	0.0749669969	3305
270	1	111	1	10000000	cplex	0	1	300	9	0	7	0	1	0	49	49	0.271871001	10.8130169	23.6379261	74.9932938	0.819154024	16792
271	1	111	1	10000000	cplex	1	0	277	11	1	7	0	1	0	49	49	0.204477996	11.3488226	24.6971703	61.5431862	0.824262977	19388
272	1	111	1	10000000	cplex	1	1	277	9	2	7	0	1	0	49	49	0.245242998	11.679616	23.4679108	74.9113159	0.816475987	18361
273	1	111	1	10000000	cplex	0	0	300	11	3	7	0	1	0	49	49	0.232370004	11.3454266	24.8222389	61.9317894	0.806101024	17794
274	1	111	1	10000000	cplex	1	1	277	1	4	7	7	0	0	49		0.156481996	0.607833028	1.03487802	4.76504612	0.0696849972	789
275	1	112	1	10000000	cplex	0	1	300	9	0	14	0	1	0	49	49	0.395790994	25.6060448	50.6799011	190.07634	0.932154	33553
276	1	112	1	10000000	cplex	1	0	279	11	1	14	0	1	0	49	49	0.283436	24.8275375	52.3073807	109.931541	0.902613997	38472
277	1	112	1	10000000	cplex	1	1	279	9	2	14	0	1	0	49	49	0.391736001	23.6590519	49.3033981	188.252808	0.937867999	36424
278	1	112	1	10000000	cplex	0	0	300	11	3	14	0	1	0	49	49	0.387620986	25.5679531	53.3748932	110.5662	0.927035987	35588
279	1	112	1	10000000	cplex	1	1	279	1	4	14	14	0	0	49		0.68097502	2.99964809	4.8814621	17.3078957	0.082268998	2884
280	1	113	1	10000000	cplex	0	1	300	9	0	15	0	1	0	49	49	0.379729986	24.9914722	53.3346062	178.37825	1.00409698	35984
281	1	113	1	10000000	cplex	1	0	268	11	1	15	0	1	0	49	49	0.302980006	27.2998428	55.8877831	128.87999	0.900888979	42895
282	1	113	1	10000000	cplex	1	1	268	9	2	15	0	1	0	49	49	0.354591012	24.6123638	52.472477	177.016571	0.977914989	40665
283	1	113	1	10000000	cplex	0	0	300	11	3	15	0	1	0	49	49	0.376542002	28.8059769	58.5391273	130.630264	0.929790974	38130
284	1	113	1	10000000	cplex	1	1	268	1	4	15	15	0	0	49		0.599596024	3.16182804	5.47291613	22.7763729	0.083672002	3305
285	1	114	1	10000000	cplex	0	1	300	9	0	13	0	1	0	49	49	0.391736001	21.2707577	45.5199509	140.121033	0.997539997	31250
286	1	114	1	10000000	cplex	1	0	238	11	1	13	0	1	0	49	49	0.244568005	21.0937748	45.8012314	106.359589	0.911572993	41050
287	1	114	1	10000000	cplex	1	1	238	10	2	13	0	1	0	49	49	0.289777011	21.8348255	44.754055	135.898773	0.873085022	38986
288	1	114	1	10000000	cplex	0	0	300	11	3	13	0	1	0	49	49	0.306048989	22.3452797	48.8143272	108.93914	0.879777014	33046
289	1	114	1	10000000	cplex	1	1	238	1	4	13	13	0	0	49		0.187996998	0.871740997	1.39383304	5.96581221	0.0616110004	1448
290	1	115	1	10000000	cplex	0	1	300	9	0	17	0	1	0	49	49	0.440979987	29.027092	58.8587608	156.102814	0.899021029	40840
291	1	115	1	10000000	cplex	1	0	240	11	1	17	0	1	0	49	49	0.287669003	27.1236973	59.7692528	116.831009	0.933467984	53310
292	1	115	1	10000000	cplex	1	1	240	10	2	17	0	1	0	49	49	0.341939002	25.2792625	56.6474266	152.179474	0.875349998	50629
293	1	115	1	10000000	cplex	0	0	300	11	3	17	0	1	0	49	49	0.405441999	28.4691792	62.906826	119.381645	0.897873998	43214
294	1	115	1	10000000	cplex	1	1	240	1	4	17	17	0	0	49		0.201652005	1.16254306	1.94797504	12.8813152	0.0676610023	1709
295	1	116	1	10000000	cplex	0	1	300	9	0	15	0	1	0	49	49	0.374628007	25.1151466	53.4947281	177.814423	1.07787895	35984
296	1	116	1	10000000	cplex	1	0	268	11	1	15	0	1	0	49	49	0.367727011	27.0754471	57.8653412	127.981529	0.928897023	42895
297	1	116	1	10000000	cplex	1	1	268	9	2	15	0	1	0	49	49	0.389990002	26.8373146	55.4821854	177.657349	0.921172023	40665
298	1	116	1	10000000	cplex	0	0	300	11	3	15	0	1	0	49	49	0.336205006	29.104105	59.3177376	129.759201	0.932875991	38130
299	1	116	1	10000000	cplex	1	1	268	1	4	15	15	0	0	49		0.598160028	3.13107896	5.53158188	23.6310101	0.0780740008	3305
300	1	117	1	10000000	cplex	0	1	300	9	0	10	0	1	0	49	49	0.328325987	16.8465652	36.3367844	123.559067	0.487679988	23974
301	1	117	1	10000000	cplex	1	0	277	11	1	10	0	1	0	49	49	0.236604005	18.3409767	39.0520439	97.2866135	0.482540011	27697
302	1	117	1	10000000	cplex	1	1	277	9	2	10	0	1	0	49	49	0.327737004	16.7114449	36.2677498	122.687584	0.49751699	26230
303	1	117	1	10000000	cplex	0	0	300	11	3	10	0	1	0	49	49	0.307778001	18.4898453	39.8523712	98.8686905	0.487491012	25420
304	1	117	1	10000000	cplex	1	1	277	1	4	10	10	0	0	49		0.286076009	2.21570706	4.04158592	20.5212383	0.0669159964	2297
305	1	118	1	10000000	cplex	0	1	300	9	0	14	0	1	0	49	49	0.381258011	24.2024498	50.9668503	123.528473	0.877059996	33652
306	1	118	1	10000000	cplex	1	0	245	11	1	14	0	1	0	49	49	0.258520007	22.3938618	51.9965172	98.6511307	0.871652007	43170
307	1	118	1	10000000	cplex	1	1	245	9	2	14	0	1	0	49	49	0.310847014	21.9763908	48.4957657	121.388397	0.928427994	40982
308	1	118	1	10000000	cplex	0	0	300	11	3	14	0	1	0	49	49	0.346949995	24.6417542	54.9503822	100.609421	0.883036971	35588
309	1	118	1	10000000	cplex	1	1	245	1	4	14	14	0	0	49		0.477281004	4.97161102	8.57743645	59.7923813	0	3150
310	1	119	1	10000000	cplex	0	1	300	9	0	14	0	1	0	49	49	0.415010005	23.2420235	51.6022072	152.572784	0.222513005	33621
311	1	119	1	10000000	cplex	1	0	238	11	1	14	0	1	0	49	49	0.229800001	22.0215206	50.3494415	95.1302643	0.199283004	44208
312	1	119	1	10000000	cplex	1	1	238	10	2	14	0	1	0	49	49	0.305866003	24.4630718	52.0412865	149.442215	0.227319002	41985
313	1	119	1	10000000	cplex	0	0	300	11	3	14	0	1	0	49	49	0.343695015	27.0952415	58.3125534	98.0823135	0.263785988	35588
314	1	119	1	10000000	cplex	1	1	238	1	4	14	216	0.0714289993	14.5	49	130	0.393759012	0.682601988	1.16263294	2.05143404	0.472873002	1277
20051	2	130	1	10000000	cplex	0	1	300	6	0	25	0	1	0	274	274	0.117445998	0.394933999	0.827970028	0.817086995	0.803095996	5509
10001	0	0	1	10000000	cplex	0	1	300	2	0	31	0	1	0	299	299	0.0237659998	0.0212529991	0.0145749999	0.0136200003	1.13055897	465
10002	0	0	1	10000000	cplex	1	0	268	11	1	31	0	1	0	299	299	0.010338	0.00618000003	0.0134100001	0.0132910004	0.977463007	1302
10003	0	0	1	10000000	cplex	1	1	268	2	2	31	0	1	0	299	299	0.00767799979	0.00256499997	0.00359699992	0.00896400027	0.912649989	465
10004	0	0	1	10000000	cplex	0	0	300	11	3	31	0	1	0	299	299	0.00537199993	0.00308499997	0.00613200013	0.012317	0.911215007	1302
10005	0	0	1	10000000	cplex	1	1	268	1	4	31	0	1	0	299	299	0.00889199972	0.00266	0.00435499987	0.0207540002	0.912113011	263
10006	0	1	1	10000000	cplex	0	1	300	2	0	18	0	1	0	299	299	0.003669	0.00129100005	0.00352400006	0.00795899983	0.172392994	270
10007	0	1	1	10000000	cplex	1	0	268	11	1	18	0	1	0	299	299	0.00565299997	0.00162800006	0.00367200002	0.00881300028	0.175398007	756
10008	0	1	1	10000000	cplex	1	1	268	2	2	18	0	1	0	299	299	0.00593600003	0.00126199995	0.00197899994	0.00937800016	0.161589995	270
10009	0	1	1	10000000	cplex	0	0	300	11	3	18	0	1	0	299	299	0.00321500003	0.00155199994	0.00375399995	0.0104999999	0.184215993	756
10010	0	1	1	10000000	cplex	1	1	268	1	4	18	0	1	0	299	299	0.00553099997	0.001453	0.00270699989	0.0178459994	0.208263993	153
10011	0	2	1	10000000	cplex	0	1	300	2	0	25	0	1	0	299	299	0.00270500011	0.00168999995	0.00270100008	0.00924600009	0.913442016	375
10012	0	2	1	10000000	cplex	1	0	268	11	1	25	0	1	0	299	299	0.00644899998	0.00231199991	0.00473999977	0.0104839997	0.898325026	1050
10013	0	2	1	10000000	cplex	1	1	268	2	2	25	0	1	0	299	299	0.00619499991	0.001208	0.00227300008	0.00977899972	0.965309024	375
10014	0	2	1	10000000	cplex	0	0	300	11	3	25	0	1	0	299	299	0.00398600008	0.00158000004	0.0046910001	0.0112640001	0.910324991	1050
10015	0	2	1	10000000	cplex	1	1	268	1	4	25	0	1	0	299	299	0.00607600017	0.00142600003	0.0031020001	0.020854	0.910722971	212
10016	0	3	1	10000000	cplex	0	1	300	2	0	38	0	1	0	299	299	0.00613699993	0.00181299995	0.00340200006	0.0102909999	1.06775606	570
10017	0	3	1	10000000	cplex	1	0	268	11	1	38	0	1	0	299	299	0.00799600035	0.00200399989	0.00695100008	0.0148830004	0.781657994	1596
10018	0	3	1	10000000	cplex	1	1	268	2	2	38	0	1	0	299	299	0.00839299988	0.00121400005	0.00338299992	0.0101939999	0.785812974	570
10019	0	3	1	10000000	cplex	0	0	300	11	3	38	0	1	0	299	299	0.00557600008	0.00199800008	0.00696999999	0.0145330001	0.780019999	1596
10020	0	3	1	10000000	cplex	1	1	268	1	4	38	0	1	0	299	299	0.00588899991	0.00196700008	0.00448800018	0.0235569999	0.787927985	323
10021	0	4	1	10000000	cplex	0	1	300	2	0	39	0	1	0	299	299	0.00593699981	0.001238	0.00347699993	0.0116119999	0.454252988	585
10022	0	4	1	10000000	cplex	1	0	268	11	1	39	0	1	0	299	299	0.00803900044	0.00217200001	0.00731700007	0.0145690003	0.356945992	1638
10023	0	4	1	10000000	cplex	1	1	268	2	2	39	0	1	0	299	299	0.00771899987	0.00109200005	0.003363	0.0116459997	0.366696	585
10024	0	4	1	10000000	cplex	0	0	300	11	3	39	0	1	0	299	299	0.00580199994	0.00186600001	0.00705400016	0.0138670001	0.368851006	1638
10025	0	4	1	10000000	cplex	1	1	268	1	4	39	0	1	0	299	299	0.00764699979	0.00163399999	0.00441099983	0.0260499995	0.366524994	331
10026	0	5	1	10000000	cplex	0	1	300	2	0	27	0	1	0	299	299	0.0056090001	0.000944000029	0.00257900008	0.00918999966	0.806182027	405
10027	0	5	1	10000000	cplex	1	0	268	11	1	27	0	1	0	299	299	0.00677599991	0.00167200004	0.00520400004	0.0109310001	0.894954026	1134
10028	0	5	1	10000000	cplex	1	1	268	2	2	27	0	1	0	299	299	0.0075480002	0.000939999998	0.00254300004	0.00872899964	0.806595981	405
10029	0	5	1	10000000	cplex	0	0	300	11	3	27	0	1	0	299	299	0.00537199993	0.00158499996	0.00564699993	0.0108960001	0.800180018	1134
10030	0	5	1	10000000	cplex	1	1	268	1	4	27	0	1	0	299	299	0.00693299994	0.00103599997	0.00327700004	0.0189319998	0.800005972	229
10031	0	6	1	10000000	cplex	0	1	300	2	0	40	0	1	0	299	299	0.0075869998	0.00131900003	0.00362999993	0.0103500001	0.842033982	600
10032	0	6	1	10000000	cplex	1	0	268	11	1	40	0	1	0	299	299	0.00965499971	0.00216699997	0.00752899982	0.014316	0.839631975	1680
10033	0	6	1	10000000	cplex	1	1	268	2	2	40	0	1	0	299	299	0.00766499992	0.00109799998	0.00363199995	0.0102350004	0.940720022	600
10034	0	6	1	10000000	cplex	0	0	300	11	3	40	0	1	0	299	299	0.00735000009	0.00236400007	0.00742699997	0.0145819997	0.850040019	1680
10035	0	6	1	10000000	cplex	1	1	268	1	4	40	0	1	0	299	299	0.00979200006	0.001773	0.00484299986	0.0247510001	0.863894999	340
10036	0	7	1	10000000	cplex	0	1	300	2	0	30	0	1	0	299	299	0.00312200002	0.000927000016	0.00283199991	0.00927000027	0.174235001	450
10037	0	7	1	10000000	cplex	1	0	268	11	1	30	0	1	0	299	299	0.0081120003	0.00161499996	0.00576600013	0.0117969997	0.154768005	1260
10038	0	7	1	10000000	cplex	1	1	268	2	2	30	0	1	0	299	299	0.00809499994	0.000996000017	0.00284299999	0.00915700011	0.162246004	450
10039	0	7	1	10000000	cplex	0	0	300	11	3	30	0	1	0	299	299	0.00570299989	0.00170499994	0.00587400002	0.0110320002	0.193118006	1260
10040	0	7	1	10000000	cplex	1	1	268	1	4	30	0	1	0	299	299	0.00812700018	0.00133600004	0.00373200001	0.0197529998	0.160556003	255
10041	0	8	1	10000000	cplex	0	1	300	2	0	22	0	1	0	299	299	0.00388500001	0.000630999974	0.0021879999	0.00853300001	0.845369995	330
10042	0	8	1	10000000	cplex	1	0	268	11	1	22	0	1	0	299	299	0.00540400017	0.00109300006	0.00433300016	0.0115080001	0.959316015	924
10043	0	8	1	10000000	cplex	1	1	268	2	2	22	0	1	0	299	299	0.00653300015	0.000656999997	0.00214500003	0.00789999962	0.855172992	330
10044	0	8	1	10000000	cplex	0	0	300	11	3	22	0	1	0	299	299	0.00458899979	0.00136600004	0.00436899997	0.0114059998	0.86322403	924
10045	0	8	1	10000000	cplex	1	1	268	1	4	22	0	1	0	299	299	0.00671999995	0.001024	0.00275600003	0.0191879999	0.853128016	187
10046	0	9	1	10000000	cplex	0	1	300	2	0	29	0	1	0	299	299	0.00461999979	0.000980000012	0.0027350001	0.011008	0.842867017	435
10047	0	9	1	10000000	cplex	1	0	268	11	1	29	0	1	0	299	299	0.00701300008	0.00142999995	0.00559799979	0.0113979997	0.849991024	1218
10048	0	9	1	10000000	cplex	1	1	268	2	2	29	0	1	0	299	299	0.00459899986	0.00078599999	0.00271899998	0.0109599996	0.849904001	435
10049	0	9	1	10000000	cplex	0	0	300	11	3	29	0	1	0	299	299	0.00586399995	0.00171600003	0.00569299981	0.0123500004	0.843707025	1218
10050	0	9	1	10000000	cplex	1	1	268	1	4	29	0	1	0	299	299	0.00798300002	0.00136600004	0.00351199997	0.0224259999	0.842525005	246
10051	0	10	1	10000000	cplex	0	1	300	4	0	22	6	1	0.272727013	274	274	0.103589997	0.592786014	0.519198	0.532899022	0.93453598	3313
10052	0	10	1	10000000	cplex	1	0	252	11	1	22	6	1	0.272727013	274	274	0.011713	0.0406260006	0.0931769982	0.100230001	0.928573012	7744
10053	0	10	1	10000000	cplex	1	1	252	4	2	22	6	1	0.272727013	274	274	0.0111269997	0.0235270001	0.0471150018	0.0894299969	0.922028005	3696
10054	0	10	1	10000000	cplex	0	0	300	11	3	22	6	1	0.272727013	274	274	0.121059	0.453125	0.959300995	0.876133978	0.916226983	6424
10055	0	10	1	10000000	cplex	1	1	252	1	4	22	22	0	0	274		0.0901279971	0.955901027	1.38749599	14.4203129	0.0762609988	1808
10056	0	11	1	10000000	cplex	0	1	300	4	0	30	0	1	0	274	274	0.152615994	0.357593	0.734439015	0.658393979	0.962135017	4518
10057	0	11	1	10000000	cplex	1	0	252	11	1	30	0	1	0	274	274	0.0116640003	0.0539189987	0.122374997	0.133973002	0.961166024	10560
10058	0	11	1	10000000	cplex	1	1	252	4	2	30	0	1	0	274	274	0.0130359996	0.0326059982	0.0642250031	0.101118997	0.952561021	5040
10059	0	11	1	10000000	cplex	0	0	300	11	3	30	0	1	0	274	274	0.161102995	0.575116992	1.33782697	1.16951096	0.959648013	8760
10060	0	11	1	10000000	cplex	1	1	252	1	4	30	0	1	0	274	274	0.0122560002	0.0278970003	0.0488580018	0.504042983	0.943831027	1067
10061	0	12	1	10000000	cplex	0	1	300	4	0	15	0	1	0	274	274	0.086544998	0.163829997	0.354472011	0.39190799	0.899688005	2259
10062	0	12	1	10000000	cplex	1	0	252	11	1	15	0	1	0	274	274	0.00730299996	0.0259150006	0.0601460002	0.0695049986	0.886160016	5280
10063	0	12	1	10000000	cplex	1	1	252	4	2	15	0	1	0	274	274	0.00700399978	0.0154510001	0.0318769999	0.0631740019	0.905081987	2520
10064	0	12	1	10000000	cplex	0	0	300	11	3	15	0	1	0	274	274	0.0905169994	0.303608	0.678478003	0.620989978	0.900120974	4380
10065	0	12	1	10000000	cplex	1	1	252	1	4	15	15	0	0	274		0.0778660029	0.590120971	0.915868998	9.25259304	0.0850789994	1227
10066	0	13	1	10000000	cplex	0	1	300	4	0	19	0	1	0	274	274	0.109894	0.218078002	0.463223994	0.453936994	0.928955972	2861
10067	0	13	1	10000000	cplex	1	0	252	11	1	19	0	1	0	274	274	0.00969900005	0.0316979997	0.0765419975	0.0871199965	0.924709022	6688
10068	0	13	1	10000000	cplex	1	1	252	4	2	19	0	1	0	274	274	0.00914399978	0.0190210007	0.0392649993	0.0623230003	0.928335011	3192
10069	0	13	1	10000000	cplex	0	0	300	11	3	19	0	1	0	274	274	0.0569249988	0.445293993	0.856765985	0.770537972	0.928345978	5548
10070	0	13	1	10000000	cplex	1	1	252	1	4	19	19	0	0	274		0.0809819996	0.603461981	0.997546017	7.3829298	0.0773250014	1541
10071	0	14	1	10000000	cplex	0	1	300	5	0	20	0	1	0	274	274	0.113554999	0.244112998	0.527741015	0.538788021	0.184058994	3290
10072	0	14	1	10000000	cplex	1	0	252	11	1	20	0	1	0	274	274	0.00838600006	0.0325740017	0.0809170008	0.0919160023	0.181917995	7040
10073	0	14	1	10000000	cplex	1	1	252	4	2	20	0	1	0	274	274	0.00882599968	0.0206509996	0.0423949994	0.072920002	0.253466994	3360
10074	0	14	1	10000000	cplex	0	0	300	11	3	20	0	1	0	274	274	0.112548001	0.408984005	0.939949989	0.823121011	0.178111002	5840
10075	0	14	1	10000000	cplex	1	1	252	1	4	20	20	0	0	274		0.0222970005	0.0797040015	0.131174996	1.06060898	0.0741899982	1024
10076	0	15	1	10000000	cplex	0	1	300	4	0	18	0	1	0	274	274	0.0979409963	0.204659998	0.442200005	0.444682986	0.847630978	2711
10077	0	15	1	10000000	cplex	1	0	252	11	1	18	0	1	0	274	274	0.00778699992	0.0292199999	0.0718839988	0.083382003	0.873813987	6336
10078	0	15	1	10000000	cplex	1	1	252	4	2	18	0	1	0	274	274	0.00771099981	0.0167779997	0.0367290005	0.0674410015	0.927438974	3024
10079	0	15	1	10000000	cplex	0	0	300	11	3	18	0	1	0	274	274	0.101571999	0.367758989	0.825746	0.74990201	0.857097983	5256
10080	0	15	1	10000000	cplex	1	1	252	1	4	18	18	0	0	274		0.0674770027	0.846000016	0.957647026	7.2296381	0.0797609985	1460
10081	0	16	1	10000000	cplex	0	1	300	5	0	29	0	1	0	274	274	0.140981004	0.504576027	0.808992028	0.71073699	0.191861004	4771
10082	0	16	1	10000000	cplex	1	0	252	11	1	29	0	1	0	274	274	0.0142590003	0.0538970008	0.125643	0.134252995	0.178684995	10208
10083	0	16	1	10000000	cplex	1	1	252	4	2	29	0	1	0	274	274	0.0141639998	0.0317739993	0.0631349981	0.102932997	0.176561996	4872
10084	0	16	1	10000000	cplex	0	0	300	11	3	29	0	1	0	274	274	0.160328999	0.530408025	1.30288601	1.149248	0.188068002	8468
10085	0	16	1	10000000	cplex	1	1	252	1	4	29	0	1	0	274	274	0.0113629997	0.0276950002	0.0492779985	0.501114011	0.181677997	1031
10086	0	17	1	10000000	cplex	0	1	300	5	0	29	0	1	0	274	274	0.129847005	0.533245027	0.798658013	0.701299012	0.191468999	4771
10087	0	17	1	10000000	cplex	1	0	252	11	1	29	0	1	0	274	274	0.0136360005	0.0556720011	0.127002001	0.132743999	0.183722004	10208
10088	0	17	1	10000000	cplex	1	1	252	4	2	29	0	1	0	274	274	0.0138429999	0.0317390002	0.0648489967	0.105734996	0.186848998	4872
10089	0	17	1	10000000	cplex	0	0	300	11	3	29	0	1	0	274	274	0.142756999	0.523899019	1.30190003	1.14833295	0.189006001	8468
10090	0	17	1	10000000	cplex	1	1	252	1	4	29	0	1	0	274	274	0.0127389999	0.029352	0.0494019985	0.501411021	0.191488996	1031
10091	0	18	1	10000000	cplex	0	1	300	4	0	23	6	1	0.26087001	274	274	0.104840003	0.684231997	0.601303995	0.591943979	0.928848982	3464
10092	0	18	1	10000000	cplex	1	0	252	11	1	23	6	1	0.26087001	274	274	0.0114489999	0.0436090007	0.100922003	0.101989001	0.933144987	8096
10093	0	18	1	10000000	cplex	1	1	252	4	2	23	6	1	0.26087001	274	274	0.00916500017	0.0218850002	0.0473540016	0.0934860036	0.919766009	3864
10094	0	18	1	10000000	cplex	0	0	300	11	3	23	6	1	0.26087001	274	274	0.112698004	0.422888994	1.03200996	0.878758013	0.919627011	6716
10095	0	18	1	10000000	cplex	1	1	252	1	4	23	6	1	0.26087001	274	274	0.0119510004	0.0242979992	0.0385209993	0.400828987	0.957240999	818
10096	0	19	1	10000000	cplex	0	1	300	4	0	19	0	1	0	274	274	0.109640002	0.231023997	0.483224988	0.453400999	0.313567013	2861
10097	0	19	1	10000000	cplex	1	0	252	11	1	19	0	1	0	274	274	0.00788499974	0.0310849994	0.0790089965	0.0893990025	0.326555997	6688
10098	0	19	1	10000000	cplex	1	1	252	4	2	19	0	1	0	274	274	0.0091380002	0.0188549999	0.0409529991	0.0722369999	0.322158009	3192
10099	0	19	1	10000000	cplex	0	0	300	11	3	19	0	1	0	274	274	0.0881619975	0.539107025	0.907967985	0.791810989	0.359259993	5548
10100	0	19	1	10000000	cplex	1	1	252	1	4	19	19	0	0	274		0.0703430027	0.682968974	1.16750896	9.80120564	0.0764430016	1552
10101	0	20	1	10000000	cplex	0	1	300	7	0	55	0	1	0	249	249	0.302760988	3.19691491	7.9311161	6.29000998	0.837258995	23079
10102	0	20	1	10000000	cplex	1	0	264	11	1	55	0	1	0	249	249	0.076448001	1.75951505	4.07868099	3.66824603	0.903137028	43743
10103	0	20	1	10000000	cplex	1	1	264	9	2	55	0	1	0	249	249	0.166593	1.73702002	3.78087211	3.38677001	0.866474986	40168
10104	0	20	1	10000000	cplex	0	0	300	11	3	55	0	1	0	249	249	0.383244008	3.956321	9.7644577	8.03860664	0.855687976	29810
10105	0	20	1	10000000	cplex	1	1	264	1	4	55	55	0	0	249		0.190996006	0.778142989	1.36867905	8.96923065	0.0783289969	3543
10106	0	21	1	10000000	cplex	0	1	300	7	0	20	0	1	0	249	249	0.188082993	1.225384	2.7985599	2.37311196	0.743068993	8392
10107	0	21	1	10000000	cplex	1	0	264	11	1	20	0	1	0	249	249	0.0566099994	0.637658	1.52879703	1.30914402	0.680240989	15906
10108	0	21	1	10000000	cplex	1	1	264	9	2	20	0	1	0	249	249	0.0622019991	0.602576017	1.41381598	1.20708597	0.643788993	14606
10109	0	21	1	10000000	cplex	0	0	300	11	3	20	0	1	0	249	249	0.0829659998	1.43724704	3.49787807	2.95893407	0.642880976	10840
10110	0	21	1	10000000	cplex	1	1	264	1	4	20	20	0	0	249		0.0705090016	0.310503006	0.536082983	3.93549895	0.0778999999	1255
10111	0	22	1	10000000	cplex	0	1	300	7	0	42	0	1	0	249	249	0.336210996	2.55292106	5.78595877	4.78175879	1.32819104	17624
10112	0	22	1	10000000	cplex	1	0	264	11	1	42	0	1	0	249	249	0.100947998	1.31454897	3.22498202	2.79477191	0.867416024	33404
10113	0	22	1	10000000	cplex	1	1	264	9	2	42	0	1	0	249	249	0.0991050005	1.24932396	2.94540811	2.53931403	0.850659013	30674
10114	0	22	1	10000000	cplex	0	0	300	11	3	42	0	1	0	249	249	0.245958	2.99428511	7.27776909	5.80654097	0.849624991	22764
10115	0	22	1	10000000	cplex	1	1	264	1	4	42	42	0	0	249		0.144051999	0.603094995	1.070225	7.13341188	0.0600199997	2705
10116	0	23	1	10000000	cplex	0	1	300	7	0	37	0	1	0	249	249	0.227356002	2.23424697	5.56680393	4.20364618	0.734857023	15526
10117	0	23	1	10000000	cplex	1	0	264	11	1	37	0	1	0	249	249	0.0823689997	1.15912998	2.81132507	2.45786691	0.754188001	29427
10118	0	23	1	10000000	cplex	1	1	264	9	2	37	0	1	0	249	249	0.0834299996	1.11390901	2.6179471	2.26521611	0.727365971	27022
10119	0	23	1	10000000	cplex	0	0	300	11	3	37	0	1	0	249	249	0.29658699	2.66786504	6.44110918	5.24885511	0.732555985	20054
10120	0	23	1	10000000	cplex	1	1	264	1	4	37	37	0	0	249		0.142130002	0.540130973	0.945874989	6.18307686	0.0722109973	2383
10121	0	24	1	10000000	cplex	0	1	300	7	0	40	0	1	0	249	249	0.246488005	2.45583105	6.11802483	4.52713919	0.850490987	16785
10122	0	24	1	10000000	cplex	1	0	264	11	1	40	0	1	0	249	249	0.0902910009	1.29647696	3.08769488	2.60997796	0.846589029	31813
10123	0	24	1	10000000	cplex	1	1	264	9	2	40	0	1	0	249	249	0.0965609998	1.20089996	2.88066411	2.45680094	0.863139987	29213
10124	0	24	1	10000000	cplex	0	0	300	11	3	40	0	1	0	249	249	0.224887997	2.9075501	7.05593395	5.59110308	0.841506004	21680
10125	0	24	1	10000000	cplex	1	1	264	1	4	40	40	0	0	249		0.149874002	0.562384009	1.01916897	7.08285379	0.0776109993	2576
10126	0	25	1	10000000	cplex	0	1	300	7	0	26	0	1	0	249	249	0.183783993	1.64199996	3.65584397	2.98632693	0.181722	10910
10127	0	25	1	10000000	cplex	1	0	264	11	1	26	0	1	0	249	249	0.0579049997	0.876561999	2.00412703	1.683514	0.196070001	20678
10128	0	25	1	10000000	cplex	1	1	264	9	2	26	0	1	0	249	249	0.0874319971	0.764348984	1.83994198	1.56259501	0.192723006	18988
10129	0	25	1	10000000	cplex	0	0	300	11	3	26	0	1	0	249	249	0.166106001	1.927302	4.62126923	3.76434588	0.189651996	14092
10130	0	25	1	10000000	cplex	1	1	264	1	4	26	26	0	0	249		0.112227	0.38547501	0.659950972	4.29872608	0.0662610009	1675
10131	0	26	1	10000000	cplex	0	1	300	7	0	51	0	1	0	249	249	0.248612002	3.19216204	7.16053009	5.71106291	0.882508993	21401
10132	0	26	1	10000000	cplex	1	0	264	11	1	51	0	1	0	249	249	0.0649020001	1.63554299	3.93075204	3.43520689	0.868785024	40562
10133	0	26	1	10000000	cplex	1	1	264	9	2	51	0	1	0	249	249	0.113049999	1.52907503	3.66362906	3.1017921	1.49064195	37247
10134	0	26	1	10000000	cplex	0	0	300	11	3	51	0	1	0	249	249	0.380892009	3.73979998	9.01339245	7.13812685	0.859623015	27642
10135	0	26	1	10000000	cplex	1	1	264	1	4	51	51	0	0	249		0.152089	0.740063012	1.32630205	8.53156757	0.0593959987	3285
10136	0	27	1	10000000	cplex	0	1	300	7	0	27	0	1	0	249	249	0.131617993	1.67046797	3.74979401	3.02718997	0.692915976	11329
10137	0	27	1	10000000	cplex	1	0	264	11	1	27	0	1	0	249	249	0.0904849991	0.839150012	2.0491879	1.71520197	0.658855975	21474
10138	0	27	1	10000000	cplex	1	1	264	9	2	27	0	1	0	249	249	0.0516499989	0.903970003	1.95794201	1.655213	0.647778988	19719
10139	0	27	1	10000000	cplex	0	0	300	11	3	27	0	1	0	249	249	0.165803999	2.01016498	4.83941984	3.84717989	0.673421979	14634
10140	0	27	1	10000000	cplex	1	1	264	1	4	27	27	0	0	249		0.0837490037	0.425448	0.691137016	4.41389704	0.0859109983	1739
10141	0	28	1	10000000	cplex	0	1	300	7	0	46	0	1	0	249	249	0.226035997	2.82592797	6.57598305	5.32839489	0.777778983	19302
10142	0	28	1	10000000	cplex	1	0	264	11	1	46	0	1	0	249	249	0.0619440004	1.50748205	3.53970003	3.0557251	1.49737096	36585
10143	0	28	1	10000000	cplex	1	1	264	9	2	46	0	1	0	249	249	0.139927	1.35668802	3.30045104	2.78775191	0.829006016	33595
10144	0	28	1	10000000	cplex	0	0	300	11	3	46	0	1	0	249	249	0.233964995	3.33460903	8.18523407	6.41521311	0.776244998	24932
10145	0	28	1	10000000	cplex	1	1	264	1	4	46	46	0	0	249		0.179492995	0.657254994	1.19175506	7.43688583	0.0659990013	2963
10146	0	29	1	10000000	cplex	0	1	300	7	0	65	0	1	0	249	249	0.489872992	3.98634505	9.10888386	7.40109777	0.880675018	27275
10147	0	29	1	10000000	cplex	1	0	264	11	1	65	0	1	0	249	249	0.0956860036	2.11662889	4.97830296	4.92307091	0.881733	51696
10148	0	29	1	10000000	cplex	1	1	264	9	2	65	0	1	0	249	249	0.165724993	1.97639799	4.6761198	3.912081	0.85323298	47471
10149	0	29	1	10000000	cplex	0	0	300	11	3	65	0	1	0	249	249	0.319635004	4.74725103	11.5776873	9.34634399	0.864377975	35230
10150	0	29	1	10000000	cplex	1	1	264	1	4	65	65	0	0	249		0.220549002	0.945926011	1.71687603	9.9174242	0.0811180025	4187
10151	0	30	1	10000000	cplex	0	1	300	8	0	27	1	1	0.0370370001	199	199	0.287523001	7.15088511	17.0009804	25.1473217	0.88182199	25048
10152	0	30	1	10000000	cplex	1	0	265	11	1	27	1	1	0.0370370001	199	199	0.186240003	6.40176392	15.6689043	21.4302406	0.900570989	35841
10153	0	30	1	10000000	cplex	1	1	265	9	2	27	1	1	0.0370370001	199	199	0.204079002	6.16175985	15.6745176	23.1594734	0.883997977	33804
10154	0	30	1	10000000	cplex	0	0	300	11	3	27	1	1	0.0370370001	199	199	0.251834005	7.7490201	18.8536644	23.9011421	0.862601995	28134
10155	0	30	1	10000000	cplex	1	1	265	1	4	27	27	0	0	199		0.126422003	0.556032002	0.748130977	3.54657102	0.0770839974	2002
10156	0	31	1	10000000	cplex	0	1	300	8	0	21	0	1	0	199	199	0.241631001	5.66288519	13.1160564	19.2855129	0.253271997	19344
10157	0	31	1	10000000	cplex	1	0	287	11	1	21	0	1	0	199	199	0.194096997	5.71981716	14.767251	18.2980614	0.249384999	24192
10158	0	31	1	10000000	cplex	1	1	287	8	2	21	0	1	0	199	199	0.249392003	5.37469912	12.9818392	19.2959347	0.272390008	21682
10159	0	31	1	10000000	cplex	0	0	300	11	3	21	0	1	0	199	199	0.250658989	5.9786582	14.7165861	18.6985683	0.233508006	21882
10160	0	31	1	10000000	cplex	1	1	287	1	4	21	21	0	0	199		0.181559995	0.816644013	1.51173902	4.45910597	0.0800369978	2011
10161	0	32	1	10000000	cplex	0	1	300	8	0	14	0	1	0	199	199	0.141244993	3.84387398	8.7818737	12.7480249	0.203022003	12928
10162	0	32	1	10000000	cplex	1	0	275	11	1	14	0	1	0	199	199	0.138601005	3.62643504	8.70411015	11.4335871	0.205017999	17365
10163	0	32	1	10000000	cplex	1	1	275	9	2	14	0	1	0	199	199	0.117582999	3.45042706	8.14286804	12.0615072	0.196097001	15908
10164	0	32	1	10000000	cplex	0	0	300	11	3	14	0	1	0	199	199	0.188311994	4.01783323	9.83059883	12.5505323	0.222442999	14588
10165	0	32	1	10000000	cplex	1	1	275	1	4	14	14	0	0	199		0.245568007	0.516023993	0.888813019	2.95271897	0.0727180019	1436
10166	0	33	1	10000000	cplex	0	1	300	8	0	23	0	1	0	199	199	0.294297993	7.05383492	14.364666	20.7243748	0.258437991	21240
10167	0	33	1	10000000	cplex	1	0	275	11	1	23	0	1	0	199	199	0.162453994	5.87874222	14.45397	18.5769367	0.236351997	28529
10168	0	33	1	10000000	cplex	1	1	275	9	2	23	0	1	0	199	199	0.195265993	5.65253496	13.2688828	19.8152008	0.244165003	26134
10169	0	33	1	10000000	cplex	0	0	300	11	3	23	0	1	0	199	199	0.229333997	6.68476105	16.0676441	20.2874813	0.245171994	23966
10170	0	33	1	10000000	cplex	1	1	275	1	4	23	23	0	0	199		0.444348991	1.62355304	2.90282989	15.5226746	0.0779870003	2882
10171	0	34	1	10000000	cplex	0	1	300	8	0	18	0	1	0	199	199	0.291514009	4.94302988	11.1538486	16.4703465	0.232059002	16622
10172	0	34	1	10000000	cplex	1	0	275	11	1	18	0	1	0	199	199	0.141082004	4.74315214	11.1456556	14.7202148	0.235383004	22327
10173	0	34	1	10000000	cplex	1	1	275	9	2	18	0	1	0	199	199	0.162331	4.42967415	10.2933044	15.5995207	0.236061007	20453
10174	0	34	1	10000000	cplex	0	0	300	11	3	18	0	1	0	199	199	0.209739	5.92503595	12.3462343	16.0566635	0.246537	18756
10175	0	34	1	10000000	cplex	1	1	275	1	4	18	18	0	0	199		0.329014003	0.638952971	1.14347398	3.16234803	0.0735019967	1835
10176	0	35	1	10000000	cplex	0	1	300	8	0	19	0	1	0	199	199	0.306100011	5.06007099	11.8156586	17.4089241	0.340193003	17546
10177	0	35	1	10000000	cplex	1	0	275	11	1	19	0	1	0	199	199	0.150894001	4.9272151	12.1220207	15.4049597	0.338075012	23568
10178	0	35	1	10000000	cplex	1	1	275	9	2	19	0	1	0	199	199	0.143686995	4.750453	10.9579945	16.5799446	0.339522004	21589
10179	0	35	1	10000000	cplex	0	0	300	11	3	19	0	1	0	199	199	0.164882004	5.44090986	13.2948732	16.7198868	0.327906996	19798
10180	0	35	1	10000000	cplex	1	1	275	1	4	19	19	0	0	199		0.297838002	1.31701899	2.43412709	11.4054632	0.0840990022	2386
10181	0	36	1	10000000	cplex	0	1	300	8	0	44	0	1	0	199	199	0.34455201	12.8379688	28.0547504	45.1052094	0.728366017	40531
10182	0	36	1	10000000	cplex	1	0	287	11	1	44	0	1	0	199	199	0.321579009	12.9704304	30.2236938	42.7423668	0.694543004	50688
10183	0	36	1	10000000	cplex	1	1	287	8	2	44	0	1	0	199	199	0.352007985	11.4158621	26.6844673	44.1460686	0.684056997	45429
10184	0	36	1	10000000	cplex	0	0	300	11	3	44	0	1	0	199	199	0.39221099	13.2101297	30.3760738	43.0889397	0.725090981	45848
10185	0	36	1	10000000	cplex	1	1	287	1	4	44	44	0	0	199		0.652819991	1.65510595	3.08872008	7.73316193	0.0660630018	4218
10186	0	37	1	10000000	cplex	0	1	300	8	0	18	1	1	0.0555559993	199	199	0.241325006	4.79041815	11.1406689	16.7339745	0.865966976	16581
10187	0	37	1	10000000	cplex	1	0	287	11	1	18	1	1	0.0555559993	199	199	0.231764004	4.92595005	11.8319225	15.5690994	0.858039021	20736
10188	0	37	1	10000000	cplex	1	1	287	8	2	18	1	1	0.0555559993	199	199	0.185875997	4.65239382	10.8612766	16.2782459	0.888707995	18584
10189	0	37	1	10000000	cplex	0	0	300	11	3	18	1	1	0.0555559993	199	199	0.227162004	5.2886548	12.4204483	16.0074692	0.855669022	18756
10190	0	37	1	10000000	cplex	1	1	287	1	4	18	18	0	0	199		0.228489995	0.713882029	1.27127302	3.1864059	0.0790039971	1725
10191	0	38	1	10000000	cplex	0	1	300	8	0	17	1	1	0.058823999	199	199	0.211518005	4.7135582	10.55021	15.5286226	0.837419987	15699
10192	0	38	1	10000000	cplex	1	0	275	11	1	17	1	1	0.058823999	199	199	0.107952997	5.70819187	10.8633137	13.763092	0.933911026	21087
10193	0	38	1	10000000	cplex	1	1	275	9	2	17	1	1	0.058823999	199	199	0.178031996	4.22305298	10.0006981	14.5657024	0.88251698	19317
10194	0	38	1	10000000	cplex	0	0	300	11	3	17	1	1	0.058823999	199	199	0.230915993	4.95876312	11.9690151	15.137125	0.870456994	17714
10195	0	38	1	10000000	cplex	1	1	275	1	4	17	17	0	0	199		0.195508003	0.623001993	1.11382496	3.46601391	0.0861139968	1744
10196	0	39	1	10000000	cplex	0	1	300	8	0	10	1	1	0.100000001	199	199	0.213065997	2.69958711	6.2691102	9.22671223	0.90429002	9211
10197	0	39	1	10000000	cplex	1	0	287	11	1	10	1	1	0.100000001	199	199	0.179854006	2.7098031	6.6342659	8.66174126	0.896492004	11520
10198	0	39	1	10000000	cplex	1	1	287	8	2	10	1	1	0.100000001	199	199	0.103762001	2.6460371	6.13561678	8.91190529	0.903241992	10324
10199	0	39	1	10000000	cplex	0	0	300	11	3	10	1	1	0.100000001	199	199	0.104594998	2.87447596	6.9199481	8.99402046	0.92228502	10420
10200	0	39	1	10000000	cplex	1	1	287	1	4	10	10	0	0	199		0.243993998	0.405903012	0.656331003	2.27864695	0.0841569975	958
10201	0	40	1	10000000	cplex	0	1	300	9	0	32	0	1	0	99	99	0.495840013	38.9144669	85.1712799	199.085159	0.832283974	61914
10202	0	40	1	10000000	cplex	1	0	250	11	1	32	0	1	0	99	99	0.403173	35.7787704	81.9508057	155.898743	0.820870996	80928
10203	0	40	1	10000000	cplex	1	1	250	10	2	32	0	1	0	99	99	0.366097003	35.4649239	78.5213013	192.930908	0.871867001	76853
10204	0	40	1	10000000	cplex	0	0	300	11	3	32	0	1	0	99	99	0.60582298	38.208477	87.9500961	161.163101	0.812326014	65344
10205	0	40	1	10000000	cplex	1	1	250	1	4	32	32	0	0	99		0.0698570013	0.402070999	0.672354996	4.90308905	0.0802669972	2679
10206	0	41	1	10000000	cplex	0	1	300	9	0	35	0	1	0	99	99	0.53282702	38.6618729	91.1798706	222.231323	0.380190998	67488
10207	0	41	1	10000000	cplex	1	0	250	11	1	35	0	1	0	99	99	0.363036007	37.6125336	88.5254822	174.18045	0.228240997	88515
10208	0	41	1	10000000	cplex	1	1	250	10	2	35	0	1	0	99	99	0.372346014	39.014843	85.5180283	217.810196	0.305269003	84058
10209	0	41	1	10000000	cplex	0	0	300	11	3	35	0	1	0	99	99	0.55062902	42.2901344	95.9551468	180.439117	0.326656997	71470
10210	0	41	1	10000000	cplex	1	1	250	1	4	35	35	0	0	99		0.146001995	0.394731998	0.7148	3.21291804	0.0649700016	2978
10211	0	42	1	10000000	cplex	0	1	300	9	0	26	0	1	0	99	99	0.440800995	30.3817997	66.4376297	147.679199	0.84848702	50134
10212	0	42	1	10000000	cplex	1	0	250	11	1	26	0	1	0	99	99	0.308173001	27.7925777	64.708992	118.477623	0.824267983	65754
10213	0	42	1	10000000	cplex	1	1	250	10	2	26	0	1	0	99	99	0.318951994	29.8293133	62.1419983	144.517166	0.843316019	62443
10214	0	42	1	10000000	cplex	0	0	300	11	3	26	0	1	0	99	99	0.464410007	28.1176834	69.4683304	122.268188	0.827054024	53092
10215	0	42	1	10000000	cplex	1	1	250	1	4	26	26	0	0	99		0.0781150013	0.423615009	0.677106977	4.165133	0.0830269977	2269
10216	0	43	1	10000000	cplex	0	1	300	9	0	21	0	1	0	99	99	0.384153008	22.0582943	52.6143761	110.623062	0.382634014	40493
10217	0	43	1	10000000	cplex	1	0	250	11	1	21	0	1	0	99	99	0.259680986	20.8712883	51.0445671	88.582283	0.355269015	53109
10218	0	43	1	10000000	cplex	1	1	250	10	2	21	0	1	0	99	99	0.274506003	23.0585651	50.2906876	107.734886	0.382441998	50435
10219	0	43	1	10000000	cplex	0	0	300	11	3	21	0	1	0	99	99	0.405180007	23.9804287	57.0085335	93.2282562	0.424787015	42882
10220	0	43	1	10000000	cplex	1	1	250	1	4	21	21	0	0	99		0.0651910007	0.249598995	0.430932999	2.43983412	0.081840001	1787
10221	0	44	1	10000000	cplex	0	1	300	10	0	45	0	1	0	99	99	0.638194025	53.5161858	115.808128	311.857727	0.704850018	87255
10222	0	44	1	10000000	cplex	1	0	250	11	1	45	0	1	0	99	99	0.459170997	49.2217178	113.381622	238.923981	0.777337015	113805
10223	0	44	1	10000000	cplex	1	1	250	10	2	45	0	1	0	99	99	0.542641997	49.679287	109.135132	305.975037	0.768531024	108075
10224	0	44	1	10000000	cplex	0	0	300	11	3	45	0	1	0	99	99	0.762178004	52.5321693	121.362762	238.421814	0.702957988	91890
10225	0	44	1	10000000	cplex	1	1	250	1	4	45	169	0	2.75555611	99	231	0.0984620005	0.355937004	0.754435003	0.811296999	0.198250994	4087
10226	0	45	1	10000000	cplex	0	1	300	9	0	29	0	1	0	99	99	0.561194003	32.3455582	73.6595001	169.136414	0.808833003	55661
10227	0	45	1	10000000	cplex	1	0	261	11	1	29	0	1	0	99	99	0.37768501	31.8358459	73.5936432	138.957428	0.822305024	70030
10228	0	45	1	10000000	cplex	1	1	261	9	2	29	0	1	0	99	99	0.351808012	29.3441181	69.5231628	166.228333	0.924673975	66489
10229	0	45	1	10000000	cplex	0	0	300	11	3	29	0	1	0	99	99	0.47073999	32.1555443	77.2183151	143.612686	0.825756013	59218
10230	0	45	1	10000000	cplex	1	1	261	1	4	29	450	0	14.5172405	99	270	0.0159479994	0.0173330009	0.0328320004	0.128720999	1.86843395	1392
10231	0	46	1	10000000	cplex	0	1	300	9	0	22	0	1	0	99	99	0.440540999	22.9307404	54.9669189	117.509552	0.868537009	42421
10232	0	46	1	10000000	cplex	1	0	250	11	1	22	0	1	0	99	99	0.244284004	21.7606926	54.2892418	96.9449692	0.793793023	55638
10233	0	46	1	10000000	cplex	1	1	250	10	2	22	0	1	0	99	99	0.295940995	23.7779026	53.1343384	115.354576	0.885532975	52836
10234	0	46	1	10000000	cplex	0	0	300	11	3	22	0	1	0	99	99	0.438463002	26.354393	61.0624123	101.469543	0.92720902	44924
10235	0	46	1	10000000	cplex	1	1	250	1	4	22	22	0	0	99		0.0683149993	0.264524013	0.456761986	4.19266319	0.0949229971	1873
10236	0	47	1	10000000	cplex	0	1	300	9	0	54	0	1	0	99	99	0.784862995	63.0461426	138.700089	419.529114	0.399255008	104124
10237	0	47	1	10000000	cplex	1	0	250	11	1	54	0	1	0	99	99	0.519460022	57.9490128	137.852142	328.242493	0.207702994	136567
10238	0	47	1	10000000	cplex	1	1	250	10	2	54	0	1	0	99	99	0.559170008	54.8464622	128.997467	407.806854	11.1435738	129690
10239	0	47	1	10000000	cplex	0	0	300	11	3	54	0	1	0	99	99	0.713137984	62.8182907	147.389679	329.502869	0.229754001	110268
10240	0	47	1	10000000	cplex	1	1	250	1	4	54	54	0	0	99		0.384456009	0.602087975	1.13807905	6.97184992	0.0796810016	4597
10241	0	48	1	10000000	cplex	0	1	300	9	0	25	0	1	0	99	99	0.491719991	28.2287083	66.0159454	146.66954	0.885433018	48370
10242	0	48	1	10000000	cplex	1	0	250	11	1	25	0	1	0	99	99	0.286457002	28.5351124	63.8214836	113.91983	0.832165003	63225
10243	0	48	1	10000000	cplex	1	1	250	10	2	25	0	1	0	99	99	0.335586011	28.6957417	59.8685417	137.345184	0.838716984	60041
10244	0	48	1	10000000	cplex	0	0	300	11	3	25	0	1	0	99	99	0.400424004	28.0344448	66.9955368	120.283966	0.90774101	51050
10245	0	48	1	10000000	cplex	1	1	250	1	4	25	25	0	0	99		0.0608780012	0.269010007	0.501325011	3.16259408	0.0673639998	2093
10246	0	49	1	10000000	cplex	0	1	300	9	0	24	0	1	0	99	99	0.442672014	26.6618824	62.3068008	133.292877	0.917289972	46277
10247	0	49	1	10000000	cplex	1	0	250	11	1	24	0	1	0	99	99	0.295103014	27.5417709	60.6550827	109.321503	0.946469009	60696
10248	0	49	1	10000000	cplex	1	1	250	10	2	24	0	1	0	99	99	0.354057997	26.0934124	57.9949493	131.861572	0.905768991	57640
10249	0	49	1	10000000	cplex	0	0	300	11	3	24	0	1	0	99	99	0.436430007	40.7159805	65.0495682	113.171799	0.913164973	49008
10250	0	49	1	10000000	cplex	1	1	250	1	4	24	24	0	0	99		0.0709849969	0.370335013	0.643091977	6.34117413	0.0620590001	2094
10251	0	50	1	10000000	cplex	0	1	300	9	0	24	0	1	0	49	49	0.603879988	42.0443382	97.847435	255.762909	0.976639986	57787
10252	0	50	1	10000000	cplex	1	0	250	11	1	24	0	1	0	49	49	0.413985997	40.2589264	97.2752609	189.480118	1.18785298	72773
10253	0	50	1	10000000	cplex	1	1	250	10	2	24	0	1	0	49	49	0.420096993	38.9318123	93.1052551	244.711868	0.972836018	69113
10254	0	50	1	10000000	cplex	0	0	300	11	3	24	0	1	0	49	49	0.518751025	136.318939	101.649696	192.723267	1.35309803	61008
10255	0	50	1	10000000	cplex	1	1	250	1	4	24	24	0	0	49		0.601276994	7.61740208	14.2729826	70.3784714	0	5627
10259	0	51	1	10000000	cplex	0	1	300	9	0	18	0	1	0	49	49	0.514741004	29.4651527	60.7563477	165.456802	0.470275015	43340
10260	0	51	1	10000000	cplex	1	0	250	11	1	18	0	1	0	49	49	0.315023988	30.6198673	63.034935	128.519592	0.433268011	54580
10261	0	51	1	10000000	cplex	1	1	250	10	2	18	0	1	0	49	49	0.341042995	27.2709255	58.0528564	161.393524	0.427688986	51835
10262	0	51	1	10000000	cplex	0	0	300	11	3	18	0	1	0	49	49	0.36264801	30.5814476	64.8557205	131.231705	0.499251992	45756
10263	0	51	1	10000000	cplex	1	1	250	1	4	18	18	0	0	49		0.666127026	6.77392721	10.5792093	74.9471512	0	4396
10264	0	52	1	10000000	cplex	0	1	300	9	0	21	0	1	0	49	49	0.514150023	35.7962341	73.3108749	200.559204	0.895271003	50564
10265	0	52	1	10000000	cplex	1	0	250	11	1	21	0	1	0	49	49	0.379936993	32.9806595	73.3900757	154.122711	0.932199001	63677
10266	0	52	1	10000000	cplex	1	1	250	10	2	21	0	1	0	49	49	0.407595009	33.2006378	69.2505035	196.173538	0.884902	60474
10267	0	52	1	10000000	cplex	0	0	300	11	3	21	0	1	0	49	49	0.444573998	34.887825	76.409874	157.4142	0.891918004	53382
10268	0	52	1	10000000	cplex	1	1	250	1	4	21	21	0	0	49		0.610525012	7.63533592	12.5172596	91.6093597	0	5123
10269	0	53	1	10000000	cplex	0	1	300	9	0	21	0	1	0	49	49	0.491064012	36.6995926	74.8577271	196.338943	0.986903012	50584
10270	0	53	1	10000000	cplex	1	0	250	11	1	21	0	1	0	49	49	0.377620995	35.2653465	74.469101	158.323578	0.924564004	63677
10271	0	53	1	10000000	cplex	1	1	250	10	2	21	0	1	0	49	49	0.384970993	35.2788086	71.4745407	192.00238	0.901872993	60474
10272	0	53	1	10000000	cplex	0	0	300	11	3	21	0	1	0	49	49	0.469276011	36.6513596	78.0488129	159.97963	0.890362978	53382
10273	0	53	1	10000000	cplex	1	1	250	1	4	21	21	0	0	49		0.655663013	7.81051683	12.776165	95.1508408	0	5138
10274	0	54	1	10000000	cplex	0	1	300	9	0	12	2	1	0.166666999	49	49	0.349148989	20.6842766	41.571804	156.172256	0.92752701	28893
10275	0	54	1	10000000	cplex	1	0	250	11	1	12	2	1	0.166666999	49	49	0.218889996	19.7418861	41.526207	116.736031	0.933399022	36386
10276	0	54	1	10000000	cplex	1	1	250	10	2	12	2	1	0.166666999	49	49	0.287025988	19.6168118	39.9489708	157.674667	0.989112973	34556
10277	0	54	1	10000000	cplex	0	0	300	11	3	12	2	1	0.166666999	49	49	0.333348006	20.8082981	44.1825409	120.007843	0.968033016	30504
10278	0	54	1	10000000	cplex	1	1	250	1	4	12	12	0	0	49		0.513983011	4.46315622	7.2208972	54.9895592	0	2930
10279	0	55	1	10000000	cplex	0	1	300	9	0	26	2	1	0.0769229978	49	49	0.610922992	44.8698997	92.7786179	260.739288	0.894895017	62603
10280	0	55	1	10000000	cplex	1	0	250	11	1	26	2	1	0.0769229978	49	49	0.373365998	43.3226242	91.5381012	209.233948	0.902203977	78838
10281	0	55	1	10000000	cplex	1	1	250	10	2	26	2	1	0.0769229978	49	49	0.453628987	42.8049622	88.5140076	261.617249	0.906029999	74873
10282	0	55	1	10000000	cplex	0	0	300	11	3	26	2	1	0.0769229978	49	49	0.563567996	45.3589211	97.235878	212.361801	0.916499019	66092
10283	0	55	1	10000000	cplex	1	1	250	1	4	26	26	0	0	49		0.63082701	8.11969757	13.5741186	75.5847473	0	6071
10284	0	56	1	10000000	cplex	0	1	300	9	0	19	2	1	0.105263002	49	49	0.455119014	33.5358582	66.4426956	173.97612	0.909308016	45748
10285	0	56	1	10000000	cplex	1	0	250	11	1	19	2	1	0.105263002	49	49	0.337085992	31.1909981	68.7632675	137.182709	0.900201023	57612
10286	0	56	1	10000000	cplex	1	1	250	10	2	19	2	1	0.105263002	49	49	0.364553005	30.791069	63.5011673	169.718277	0.910548985	54714
10287	0	56	1	10000000	cplex	0	0	300	11	3	19	2	1	0.105263002	49	49	0.389975995	32.9151115	71.5331421	141.190933	0.918551981	48298
10288	0	56	1	10000000	cplex	1	1	250	1	4	19	19	0	0	49		0.662818015	7.72034693	11.5348473	80.0953445	0	4624
10289	0	57	1	10000000	cplex	0	1	300	9	0	29	2	1	0.0689660013	49	49	0.575628996	49.714222	101.899933	310.337494	0.901235998	69977
10290	0	57	1	10000000	cplex	1	0	250	11	1	29	2	1	0.0689660013	49	49	0.428481996	49.1146812	102.785934	242.79155	0.870491028	87935
10291	0	57	1	10000000	cplex	1	1	250	10	2	29	2	1	0.0689660013	49	49	0.50138998	47.5838089	97.8758926	299.885132	0.881801009	83512
10292	0	57	1	10000000	cplex	0	0	300	11	3	29	2	1	0.0689660013	49	49	0.574404001	50.8205223	107.460258	244.969437	0.889900982	73718
10293	0	57	1	10000000	cplex	1	1	250	1	4	29	29	0	0	49		0.741361022	10.1405678	16.1437435	91.002182	0	6842
10294	0	58	1	10000000	cplex	0	1	300	9	0	23	2	1	0.0869570002	49	49	0.466123998	39.8364182	83.5470581	228.88327	0.940756023	55402
10295	0	58	1	10000000	cplex	1	0	250	11	1	23	2	1	0.0869570002	49	49	0.368070006	38.6504021	83.1971741	176.603058	0.944249988	69741
10296	0	58	1	10000000	cplex	1	1	250	10	2	23	2	1	0.0869570002	49	49	0.43591401	37.9207611	78.2029724	220.841705	0.950452983	66233
10297	0	58	1	10000000	cplex	0	0	300	11	3	23	2	1	0.0869570002	49	49	0.497447014	40.5422096	85.5806046	178.106232	0.997952998	58466
10298	0	58	1	10000000	cplex	1	1	250	1	4	23	23	0	0	49		0.772625983	7.8637352	12.1610832	58.6230965	0	5378
10299	0	59	1	10000000	cplex	0	1	300	9	0	20	0	1	0	49	49	0.480064005	35.0082741	72.6101379	231.028397	0.833351016	48156
10300	0	59	1	10000000	cplex	1	0	250	11	1	20	0	1	0	49	49	0.295385003	33.3622818	72.7735519	153.839615	0.842083991	60644
10301	0	59	1	10000000	cplex	1	1	250	10	2	20	0	1	0	49	49	0.39309299	32.6327248	70.3498917	230.499527	0.976585984	57594
10302	0	59	1	10000000	cplex	0	0	300	11	3	20	0	1	0	49	49	0.473924994	34.5909042	75.4459686	154.218399	0.85551399	50840
10303	0	59	1	10000000	cplex	1	1	250	1	4	20	20	0	0	49		0.554328978	7.29979181	12.2845221	95.7393723	0	4840
20001	2	120	1	10000000	cplex	0	1	300	2	0	14	2	1	0.142857	299	299	0.0387180001	0.0173160005	0.00890399981	0.00912099984	1.08616102	210
20002	2	120	1	10000000	cplex	1	0	286	11	1	14	2	1	0.142857	299	299	0.0141789997	0.0041410001	0.00676500006	0.00793800037	0.923529983	588
20003	2	120	1	10000000	cplex	1	1	286	2	2	14	2	1	0.142857	299	299	0.00809099991	0.00132100005	0.00200999994	0.00655000005	0.882978976	210
20004	2	120	1	10000000	cplex	0	0	300	11	3	14	2	1	0.142857	299	299	0.00376500003	0.00171800004	0.00295099989	0.00861699972	0.887041986	588
20005	2	120	1	10000000	cplex	1	1	286	1	4	14	2	1	0.142857	299	299	0.0106149996	0.00173300004	0.00227700011	0.0153470002	0.876452029	119
20006	2	121	1	10000000	cplex	0	1	300	2	0	11	0	1	0	299	299	0.0030100001	0.000768000027	0.00131900003	0.00708500016	0.328240991	165
20007	2	121	1	10000000	cplex	1	0	286	11	1	11	0	1	0	299	299	0.00598999998	0.00108900003	0.00233000005	0.00910800043	0.267787993	462
20008	2	121	1	10000000	cplex	1	1	286	2	2	11	0	1	0	299	299	0.00532	0.000707999978	0.00132499996	0.00770300021	0.307009995	165
20009	2	121	1	10000000	cplex	0	0	300	11	3	11	0	1	0	299	299	0.00243599992	0.00129000004	0.00233300007	0.00756799988	0.267535001	462
20010	2	121	1	10000000	cplex	1	1	286	1	4	11	0	1	0	299	299	0.00525799999	0.00133	0.00180199998	0.0154879997	0.29193899	93
20011	2	122	1	10000000	cplex	0	1	300	2	0	21	0	1	0	299	299	0.00487700012	0.00107500004	0.00234499993	0.00803000014	0.280445993	315
20012	2	122	1	10000000	cplex	1	0	286	11	1	21	0	1	0	299	299	0.0067230002	0.001865	0.00425100001	0.00904399995	0.215531006	882
20013	2	122	1	10000000	cplex	1	1	286	2	2	21	0	1	0	299	299	0.0074740001	0.00125199999	0.00199500006	0.00740099978	0.210076004	315
20014	2	122	1	10000000	cplex	0	0	300	11	3	21	0	1	0	299	299	0.00356100011	0.001727	0.00390599994	0.0105600003	0.275189012	882
20015	2	122	1	10000000	cplex	1	1	286	1	4	21	0	1	0	299	299	0.00679200003	0.00138300005	0.00260900008	0.0176490005	0.223951995	178
20016	2	123	1	10000000	cplex	0	1	300	2	0	2	0	1	0	299	299	0.000953999988	0.000140999997	0.000410000008	0.00590300001	0.153322995	30
20017	2	123	1	10000000	cplex	1	0	286	11	1	2	0	1	0	299	299	0.00388900004	0.000220000002	0.000629000016	0.00570400013	0.156158999	84
20018	2	123	1	10000000	cplex	1	1	286	2	2	2	0	1	0	299	299	0.00384599995	0.000176999994	0.00039999999	0.00546800019	0.155191004	30
20019	2	123	1	10000000	cplex	0	0	300	11	3	2	0	1	0	299	299	0.00121699995	0.000254000013	0.000837000029	0.00560799986	0.158463001	84
20020	2	123	1	10000000	cplex	1	1	286	1	4	2	0	1	0	299	299	0.00451300014	0.000239999994	0.000515999971	0.0101589998	0.163827002	17
20021	2	124	1	10000000	cplex	0	1	300	2	0	14	0	1	0	299	299	0.00302099995	0.000780000002	0.00142300001	0.00729800016	0.728047013	210
20022	2	124	1	10000000	cplex	1	0	286	11	1	14	0	1	0	299	299	0.00560399983	0.000962999999	0.00271499995	0.00910899974	0.722995996	588
20023	2	124	1	10000000	cplex	1	1	286	2	2	14	0	1	0	299	299	0.00615999987	0.000667000015	0.00141300005	0.00867400039	0.730534971	210
20024	2	124	1	10000000	cplex	0	0	300	11	3	14	0	1	0	299	299	0.00311699999	0.00104999996	0.00276300008	0.00935200043	0.800255001	588
20025	2	124	1	10000000	cplex	1	1	286	1	4	14	0	1	0	299	299	0.0061639999	0.000708999985	0.00181599997	0.0136240004	0.715933979	119
20026	2	125	1	10000000	cplex	0	1	300	2	0	16	0	1	0	299	299	0.00369899999	0.000776999979	0.001636	0.00846500043	0.412726015	240
20027	2	125	1	10000000	cplex	1	0	286	11	1	16	0	1	0	299	299	0.00604999997	0.00103000004	0.0031059999	0.00992400013	0.415544987	672
20028	2	125	1	10000000	cplex	1	1	286	2	2	16	0	1	0	299	299	0.00622300012	0.000667000015	0.00163499999	0.00867199991	0.400736988	240
20029	2	125	1	10000000	cplex	0	0	300	11	3	16	0	1	0	299	299	0.00331799989	0.00110800005	0.00311799999	0.00949999969	0.404073	672
20030	2	125	1	10000000	cplex	1	1	286	1	4	16	0	1	0	299	299	0.00543999998	0.000789000012	0.00210199994	0.0175669994	0.401133001	136
20031	2	126	1	10000000	cplex	0	1	300	2	0	34	0	1	0	299	299	0.00573700015	0.00120699999	0.0031010001	0.0110299997	0.190438002	510
20032	2	126	1	10000000	cplex	1	0	286	11	1	34	0	1	0	299	299	0.00857399963	0.00185600005	0.00624800008	0.0133689996	0.200573996	1428
20033	2	126	1	10000000	cplex	1	1	286	2	2	34	0	1	0	299	299	0.00919499993	0.00110400002	0.00311299996	0.0104809999	0.202101007	510
20034	2	126	1	10000000	cplex	0	0	300	11	3	34	0	1	0	299	299	0.00486500002	0.00184399995	0.00636099977	0.0131620001	0.195944995	1428
20035	2	126	1	10000000	cplex	1	1	286	1	4	34	0	1	0	299	299	0.00975899957	0.00182300003	0.00409599999	0.0246750005	0.200379997	289
20036	2	127	1	10000000	cplex	0	1	300	2	0	18	0	1	0	299	299	0.00390299992	0.000668999972	0.001881	0.0091380002	0.184462994	270
20037	2	127	1	10000000	cplex	1	0	286	11	1	18	0	1	0	299	299	0.00612499984	0.00091100001	0.00347599993	0.0106319999	0.181369007	756
20038	2	127	1	10000000	cplex	1	1	286	2	2	18	0	1	0	299	299	0.00576400012	0.000547999982	0.00179200002	0.00807799958	0.172897995	270
20039	2	127	1	10000000	cplex	0	0	300	11	3	18	0	1	0	299	299	0.00279000006	0.00091100001	0.00347999996	0.0100819999	0.167659	756
20040	2	127	1	10000000	cplex	1	1	286	1	4	18	0	1	0	299	299	0.0065609999	0.000864000001	0.00223800004	0.0166059993	0.179260001	153
20041	2	128	1	10000000	cplex	0	1	300	2	0	12	0	1	0	299	299	0.00218999991	0.000436000002	0.00127899996	0.00875900034	0.174180001	180
20042	2	128	1	10000000	cplex	1	0	286	11	1	12	0	1	0	299	299	0.00484800013	0.000713000016	0.00244199997	0.00963899959	0.198530003	504
20043	2	128	1	10000000	cplex	1	1	286	2	2	12	0	1	0	299	299	0.0048750001	0.000384999992	0.00121999998	0.0079979999	0.19269	180
20044	2	128	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.00199700007	0.000607000024	0.0024590001	0.00985999964	0.193347007	504
20045	2	128	1	10000000	cplex	1	1	286	1	4	12	0	1	0	299	299	0.00491400016	0.000586999988	0.00159700005	0.0162540004	0.188559994	102
20046	2	129	1	10000000	cplex	0	1	300	2	0	14	2	1	0.142857	299	299	0.00267000007	0.00042299999	0.00141799997	0.00808999967	0.845682025	210
20047	2	129	1	10000000	cplex	1	0	286	11	1	14	2	1	0.142857	299	299	0.00576899992	0.000713000016	0.00276700011	0.00821899995	0.841946006	588
20048	2	129	1	10000000	cplex	1	1	286	2	2	14	2	1	0.142857	299	299	0.00525900023	0.000445000012	0.00138300005	0.00789800007	0.864253998	210
20049	2	129	1	10000000	cplex	0	0	300	11	3	14	2	1	0.142857	299	299	0.00234599994	0.000717999996	0.00279799988	0.00894500036	0.874035001	588
20050	2	129	1	10000000	cplex	1	1	286	1	4	14	2	1	0.142857	299	299	0.00531700021	0.000637000019	0.00182200002	0.0165519994	0.867720008	119
20052	2	130	1	10000000	cplex	1	0	289	11	1	25	0	1	0	274	274	0.116806	0.405095011	0.897086024	0.830812991	0.812251985	8855
20053	2	130	1	10000000	cplex	1	1	289	6	2	25	0	1	0	274	274	0.074819997	0.336080998	0.702265978	0.934045017	0.821431994	6879
20054	2	130	1	10000000	cplex	0	0	300	11	3	25	0	1	0	274	274	0.141791001	0.446301013	1.03794801	1.00872803	0.813229978	7300
20055	2	130	1	10000000	cplex	1	1	289	1	4	25	25	0	0	274		0.105974004	0.527374983	0.796450019	7.20845795	0.0754849985	1205
20056	2	131	1	10000000	cplex	0	1	300	6	0	27	0	1	0	274	274	0.063414	0.460795999	0.912328005	0.873197973	0.555101991	5950
20057	2	131	1	10000000	cplex	1	0	289	11	1	27	0	1	0	274	274	0.0531920008	0.463761002	0.962219	0.90416801	0.558498979	9564
20058	2	131	1	10000000	cplex	1	1	289	6	2	27	0	1	0	274	274	0.0663739964	0.366475999	0.815887988	0.747268975	0.544026971	7429
20059	2	131	1	10000000	cplex	0	0	300	11	3	27	0	1	0	274	274	0.0922460034	0.529431999	1.14229298	1.076545	0.546330988	7884
20060	2	131	1	10000000	cplex	1	1	289	1	4	27	27	0	0	274		0.118683003	0.550442994	0.912002981	12.4363689	0.0754579976	1264
20061	2	132	1	10000000	cplex	0	1	300	6	0	29	0	1	0	274	274	0.121248998	0.464347005	0.983619988	0.93532902	0.903221011	6391
20062	2	132	1	10000000	cplex	1	0	289	11	1	29	0	1	0	274	274	0.0910189971	0.495860994	1.03336298	0.952274024	0.862554014	10272
20063	2	132	1	10000000	cplex	1	1	289	6	2	29	0	1	0	274	274	0.113147996	0.401138991	0.836178005	0.812308013	0.886115015	7979
20064	2	132	1	10000000	cplex	0	0	300	11	3	29	0	1	0	274	274	0.120315999	0.569878995	1.23056901	1.14378798	0.851550996	8468
20065	2	132	1	10000000	cplex	1	1	289	1	4	29	29	0	0	274		0.124710001	0.215458006	0.370144993	4.77975512	0.070024997	1103
20066	2	133	1	10000000	cplex	0	1	300	6	0	21	0	1	0	274	274	0.0755349994	0.399996996	0.700187981	0.682973027	0.183799997	4628
20067	2	133	1	10000000	cplex	1	0	289	11	1	21	0	1	0	274	274	0.0714790002	0.317535996	0.745536029	0.716419995	0.182891995	7438
20068	2	133	1	10000000	cplex	1	1	289	6	2	21	0	1	0	274	274	0.0561319999	0.292079985	0.64389801	0.62036401	0.201201007	5778
20069	2	133	1	10000000	cplex	0	0	300	11	3	21	0	1	0	274	274	0.0913330019	0.376244009	0.900138021	0.85820502	0.186425	6132
20070	2	133	1	10000000	cplex	1	1	289	1	4	21	21	0	0	274		0.0905530006	0.144387007	0.245754004	3.07936001	0.0817750022	832
20071	2	134	1	10000000	cplex	0	1	300	6	0	50	0	1	0	274	274	0.201049998	1.17470205	1.74354196	1.50276005	0.263664991	11019
20072	2	134	1	10000000	cplex	1	0	289	11	1	50	0	1	0	274	274	0.152067006	0.87806797	1.82846606	1.59498703	0.257322997	17711
20073	2	134	1	10000000	cplex	1	1	289	6	2	50	0	1	0	274	274	0.178290993	0.800203979	1.50627303	1.33117998	0.261931002	13758
20074	2	134	1	10000000	cplex	0	0	300	11	3	50	0	1	0	274	274	0.207845002	0.97053802	2.18495202	1.87614405	0.373158991	14600
20075	2	134	1	10000000	cplex	1	1	289	1	4	50	50	0	0	274		0.145172	0.272080004	0.474411994	4.58244801	0.0675970018	1919
20076	2	135	1	10000000	cplex	0	1	300	6	0	42	0	1	0	274	274	0.110428996	0.816926003	1.44970798	1.32200694	0.820542991	9256
20077	2	135	1	10000000	cplex	1	0	289	11	1	42	0	1	0	274	274	0.158200994	0.987300992	1.52148604	1.36188996	0.825250983	14877
20078	2	135	1	10000000	cplex	1	1	289	6	2	42	0	1	0	274	274	0.133941993	0.625844002	1.27452803	1.14268196	0.825900018	11557
20079	2	135	1	10000000	cplex	0	0	300	11	3	42	0	1	0	274	274	0.119703002	0.884971976	1.85079098	1.61556602	0.828918993	12264
20080	2	135	1	10000000	cplex	1	1	289	1	4	42	42	0	0	274		0.141341999	0.311306	0.557578981	5.82844114	0.0730210021	1730
20081	2	136	1	10000000	cplex	0	1	300	6	0	18	0	1	0	274	274	0.108742997	0.318955004	0.634020984	0.61331898	0.830582976	3966
20082	2	136	1	10000000	cplex	1	0	289	11	1	18	0	1	0	274	274	0.0549950004	0.271257997	0.63804698	0.608379006	0.828230023	6376
20083	2	136	1	10000000	cplex	1	1	289	6	2	18	0	1	0	274	274	0.0392320007	0.329948008	0.526144981	0.527728975	0.842446983	4953
20084	2	136	1	10000000	cplex	0	0	300	11	3	18	0	1	0	274	274	0.106978998	0.364160001	0.801500976	0.738875985	0.851005018	5256
20085	2	136	1	10000000	cplex	1	1	289	1	4	18	18	0	0	274		0.0588040017	0.157378003	0.168252006	1.47257602	0.0776380002	690
20086	2	137	1	10000000	cplex	0	1	300	6	0	20	0	1	0	274	274	0.0770289972	0.704367995	0.674968004	0.682936013	0.156417996	4407
20087	2	137	1	10000000	cplex	1	0	289	11	1	20	0	1	0	274	274	0.058995001	0.335079998	0.770707011	0.683501005	0.157079995	7084
20088	2	137	1	10000000	cplex	1	1	289	6	2	20	0	1	0	274	274	0.0814170018	0.309666991	0.615382016	0.58357501	0.156865001	5503
20089	2	137	1	10000000	cplex	0	0	300	11	3	20	0	1	0	274	274	0.117885001	0.359129012	0.872645974	0.818242013	0.158502996	5840
20090	2	137	1	10000000	cplex	1	1	289	1	4	20	0	1	0	274	274	0.0586699992	0.0620089993	0.113824002	0.93907702	0.153519005	627
20091	2	138	1	10000000	cplex	0	1	300	6	0	27	0	1	0	274	274	0.118809	0.473517001	0.980314016	0.885016024	0.544336975	5950
20092	2	138	1	10000000	cplex	1	0	289	11	1	27	0	1	0	274	274	0.0753810033	0.401457012	0.976311982	0.901274025	0.530294001	9564
20093	2	138	1	10000000	cplex	1	1	289	6	2	27	0	1	0	274	274	0.0754610002	0.384420991	0.812146008	0.765105009	0.547776997	7429
20094	2	138	1	10000000	cplex	0	0	300	11	3	27	0	1	0	274	274	0.152042001	0.518612981	1.20157099	1.06893599	0.536354005	7884
20095	2	138	1	10000000	cplex	1	1	289	1	4	27	27	0	0	274		0.111349002	0.576370001	0.980063021	12.0367594	0.0707509965	1264
20096	2	139	1	10000000	cplex	0	1	300	6	0	19	0	1	0	274	274	0.0776939988	0.290986001	0.640940011	0.667174995	0.518733025	4187
20097	2	139	1	10000000	cplex	1	0	289	11	1	19	0	1	0	274	274	0.0367159992	0.354633003	0.700896025	0.645326972	0.52828598	6730
20098	2	139	1	10000000	cplex	1	1	289	6	2	19	0	1	0	274	274	0.0570169985	0.293738008	0.593006015	0.564426005	0.513055027	5228
20099	2	139	1	10000000	cplex	0	0	300	11	3	19	0	1	0	274	274	0.109499998	0.354422003	0.829892993	0.777665019	0.529905975	5548
20100	2	139	1	10000000	cplex	1	1	289	1	4	19	0	1	0	274	274	0.058242999	0.0601270013	0.111928001	0.878337026	0.521544993	595
20101	2	140	1	10000000	cplex	0	1	300	7	0	39	0	1	0	249	249	0.308032006	2.98378992	5.44726801	4.97261	0.195218995	17723
20102	2	140	1	10000000	cplex	1	0	270	11	1	39	0	1	0	249	249	0.0861380026	1.71831405	3.89419794	3.45957899	0.231022	29505
20103	2	140	1	10000000	cplex	1	1	270	9	2	39	0	1	0	249	249	0.151813999	1.63926804	3.53271389	3.4356029	0.195734993	26727
20104	2	140	1	10000000	cplex	0	0	300	11	3	39	0	1	0	249	249	0.163098007	2.87051511	6.48822498	5.54283094	0.275195003	21138
20105	2	140	1	10000000	cplex	1	1	270	1	4	39	39	0	0	249		0.240000993	0.629278004	1.07918096	5.94421291	0.0690080002	3280
20106	2	141	1	10000000	cplex	0	1	300	7	0	26	0	1	0	249	249	0.267917007	1.70850301	3.59844899	3.3227191	0.948913991	11680
20107	2	141	1	10000000	cplex	1	0	271	11	1	26	0	1	0	249	249	0.104969002	1.54163504	2.59137988	2.38414001	0.956115007	19065
20108	2	141	1	10000000	cplex	1	1	271	8	2	26	0	1	0	249	249	0.135839	1.08777404	2.42737603	2.30179596	1.28332698	17179
20109	2	141	1	10000000	cplex	0	0	300	11	3	26	0	1	0	249	249	0.243630007	1.91173506	4.29815102	3.81853104	0.957702994	14092
20110	2	141	1	10000000	cplex	1	1	271	1	4	26	26	0	0	249		0.120848	0.177568004	0.289323002	2.62565207	0.081987001	1307
20111	2	142	1	10000000	cplex	0	1	300	7	0	22	0	1	0	249	249	0.199153006	1.48673999	3.09645796	2.89205909	0.888902009	9883
20112	2	142	1	10000000	cplex	1	0	271	11	1	22	0	1	0	249	249	0.0562830009	1.01454902	2.26394701	2.02514505	0.889347017	16132
20113	2	142	1	10000000	cplex	1	1	271	8	2	22	0	1	0	249	249	0.0761739984	0.899088025	2.01442003	1.99859297	0.894447029	14536
20114	2	142	1	10000000	cplex	0	0	300	11	3	22	0	1	0	249	249	0.0814220011	1.59705901	3.68481588	3.18390894	0.932808995	11924
20115	2	142	1	10000000	cplex	1	1	271	1	4	22	22	0	0	249		0.346697986	9.60836124	15.1557407	113.542709	0.071676001	6768
20116	2	143	1	10000000	cplex	0	1	300	7	0	24	0	1	0	249	249	0.172913	1.63136601	3.45236492	2.99148011	0.876564026	10906
20117	2	143	1	10000000	cplex	1	0	270	11	1	24	0	1	0	249	249	0.0421259999	1.10029399	2.44763994	2.07287002	0.902522981	18157
20118	2	143	1	10000000	cplex	1	1	270	9	2	24	0	1	0	249	249	0.0689930022	1.38221502	2.2190721	2.06050801	0.873763025	16447
20119	2	143	1	10000000	cplex	0	0	300	11	3	24	0	1	0	249	249	0.142075002	1.7098	3.990206	3.38853312	0.898214996	13008
20120	2	143	1	10000000	cplex	1	1	270	1	4	24	24	0	0	249		0.0982770026	0.391532004	0.668482006	4.13116503	0.0654079989	2018
20121	2	144	1	10000000	cplex	0	1	300	7	0	25	0	1	0	249	249	0.166136995	1.69058597	3.60065794	3.2129631	0.861190021	11230
20122	2	144	1	10000000	cplex	1	0	271	11	1	25	0	1	0	249	249	0.0568379983	1.15477598	2.61545992	2.28161907	0.848246992	18332
20123	2	144	1	10000000	cplex	1	1	271	8	2	25	0	1	0	249	249	0.0743990019	1.04933405	2.34714699	2.23921108	0.858627975	16518
20124	2	144	1	10000000	cplex	0	0	300	11	3	25	0	1	0	249	249	0.219054997	1.75797796	4.25469303	3.61425591	0.864975989	13550
20125	2	144	1	10000000	cplex	1	1	271	1	4	25	25	0	0	249		0.391030997	10.3155622	17.6596127	131.320328	0.083792001	7690
20126	2	145	1	10000000	cplex	0	1	300	7	0	134	0	1	0	249	249	0.659941018	9.2751236	19.6837254	19.3663521	0.808265984	60623
20127	2	145	1	10000000	cplex	1	0	271	11	1	134	0	1	0	249	249	0.290493011	6.74243307	13.9876661	14.2938948	0.791154027	98262
20128	2	145	1	10000000	cplex	1	1	271	8	2	134	0	1	0	249	249	0.320618004	5.76560211	12.9048786	14.1513119	0.799125016	88539
20129	2	145	1	10000000	cplex	0	0	300	11	3	134	0	1	0	249	249	0.57585597	9.74287415	22.8479137	21.5363731	0.812997997	72628
20130	2	145	1	10000000	cplex	1	1	271	1	4	134	134	0	0	249		1.55626905	53.5992699	97.1698303	1353.03308	0.0625350028	41223
20131	2	146	1	10000000	cplex	0	1	300	7	0	42	0	1	0	249	249	0.202154994	2.76577091	6.05268002	5.21538115	0.250355989	18867
20132	2	146	1	10000000	cplex	1	0	271	11	1	42	0	1	0	249	249	0.164821997	1.92114794	4.56981516	3.83804011	0.241270006	30798
20133	2	146	1	10000000	cplex	1	1	271	8	2	42	0	1	0	249	249	0.128964007	1.79306304	4.2374692	3.77215195	0.25405699	27751
20134	2	146	1	10000000	cplex	0	0	300	11	3	42	0	1	0	249	249	0.335707992	3.11415911	7.42757893	5.98591614	0.234669998	22764
20135	2	146	1	10000000	cplex	1	1	271	1	4	42	42	0	0	249		0.501349986	17.0170479	30.0823841	228.806625	0.0817100033	12920
20136	2	147	1	10000000	cplex	0	1	300	7	0	25	0	1	0	249	249	0.143969998	1.68386102	3.66722107	3.19127202	0.654760003	11230
20137	2	147	1	10000000	cplex	1	0	271	11	1	25	0	1	0	249	249	0.0591740012	1.19794202	2.66395903	2.27805996	0.643940985	18332
20138	2	147	1	10000000	cplex	1	1	271	8	2	25	0	1	0	249	249	0.0783469975	1.07406902	2.39360309	2.20709896	0.648684978	16518
20139	2	147	1	10000000	cplex	0	0	300	11	3	25	0	1	0	249	249	0.215964004	1.85643804	4.30640221	3.6193471	0.648823977	13550
20140	2	147	1	10000000	cplex	1	1	271	1	4	25	25	0	0	249		0.0930579975	0.154358998	0.278382987	2.37629604	0.0765540004	1280
20141	2	148	1	10000000	cplex	0	1	300	7	0	134	0	1	0	249	249	0.52335	10.1066437	20.4632912	19.1499729	0.821422994	60623
20142	2	148	1	10000000	cplex	1	0	271	11	1	134	0	1	0	249	249	0.227688	6.26599979	14.4429693	14.0182133	0.794941008	98262
20143	2	148	1	10000000	cplex	1	1	271	8	2	134	0	1	0	249	249	0.228921995	6.7719512	13.1571207	13.7488041	0.802021027	88539
20144	2	148	1	10000000	cplex	0	0	300	11	3	134	0	1	0	249	249	0.506592989	9.87032509	23.5741215	21.100399	0.812551975	72628
20145	2	148	1	10000000	cplex	1	1	271	1	4	134	134	0	0	249		1.54091704	54.0425453	97.3291245	1350.29944	0.0983479992	41223
20146	2	149	1	10000000	cplex	0	1	300	7	0	26	0	1	0	249	249	0.225363001	1.72507906	3.71870995	3.22672296	0.908789992	11680
20147	2	149	1	10000000	cplex	1	0	271	11	1	26	0	1	0	249	249	0.0727159977	1.09810305	2.68041897	2.34907889	0.932603002	19065
20148	2	149	1	10000000	cplex	1	1	271	8	2	26	0	1	0	249	249	0.0870800018	1.17530298	2.55573201	2.30550909	1.03487396	17179
20149	2	149	1	10000000	cplex	0	0	300	11	3	26	0	1	0	249	249	0.116976	1.94514894	4.47782183	3.708987	0.936447024	14092
20150	2	149	1	10000000	cplex	1	1	271	1	4	26	26	0	0	249		0.389766008	10.739646	18.2973747	130.901764	0.076801002	7998
20151	2	150	1	10000000	cplex	0	1	300	8	0	72	0	1	0	199	199	0.679866016	20.719408	44.1315079	73.1427536	0.702822983	68459
20152	2	150	1	10000000	cplex	1	0	284	11	1	72	0	1	0	199	199	0.494715989	19.9724445	46.0483551	75.9402771	0.628003001	85256
20153	2	150	1	10000000	cplex	1	1	284	9	2	72	0	1	0	199	199	0.405559003	19.6102505	43.1363907	72.4979706	0.621792018	78853
20154	2	150	1	10000000	cplex	0	0	300	11	3	72	0	1	0	199	199	0.519244015	20.9055843	47.6362915	77.5194702	0.629239023	75024
20155	2	150	1	10000000	cplex	1	1	284	1	4	72	72	0	0	199		0.502196014	0.977123022	1.84195101	8.62989616	0.0798709989	4813
20156	2	151	1	10000000	cplex	0	1	300	8	0	52	0	1	0	199	199	0.394576997	15.7699738	31.9817505	45.7414894	0.316148996	49442
20157	2	151	1	10000000	cplex	1	0	284	11	1	52	0	1	0	199	199	0.335601985	14.2061291	32.9669075	47.3781929	0.358121008	61574
20158	2	151	1	10000000	cplex	1	1	284	9	2	52	0	1	0	199	199	0.410337001	14.0136957	30.7307072	44.8713226	0.320347995	56949
20159	2	151	1	10000000	cplex	0	0	300	11	3	52	0	1	0	199	199	0.349316001	14.7448568	34.5453987	48.7483826	0.308025002	54184
20160	2	151	1	10000000	cplex	1	1	284	1	4	52	52	0	0	199		0.345925003	0.692358017	1.30399406	6.59931421	0.0811360031	3476
20161	2	152	1	10000000	cplex	0	1	300	8	0	49	0	1	0	199	199	0.487560004	13.1764135	30.0261326	43.6527405	0.842356026	46590
20162	2	152	1	10000000	cplex	1	0	284	11	1	49	0	1	0	199	199	0.277406007	12.9643059	30.6386662	44.8233261	0.861901999	58021
20163	2	152	1	10000000	cplex	1	1	284	9	2	49	0	1	0	199	199	0.363453001	12.6274214	30.2687511	43.030426	0.85214901	53664
20164	2	152	1	10000000	cplex	0	0	300	11	3	49	0	1	0	199	199	0.405606002	13.5593443	32.2429962	45.8344765	0.854503989	51058
20165	2	152	1	10000000	cplex	1	1	284	1	4	49	49	0	0	199		0.224285007	0.706276	1.23956704	5.81478786	0.0611810014	3275
20166	2	153	1	10000000	cplex	0	1	300	8	0	60	0	1	0	199	199	0.551272988	16.1365929	36.3755493	57.7940063	0.451698005	57049
20167	2	153	1	10000000	cplex	1	0	284	11	1	60	0	1	0	199	199	0.331322998	15.9673252	37.4087257	59.0913734	0.464489996	71047
20168	2	153	1	10000000	cplex	1	1	284	9	2	60	0	1	0	199	199	0.398764998	15.5219927	35.2092171	56.5033722	0.453530997	65711
20169	2	153	1	10000000	cplex	0	0	300	11	3	60	0	1	0	199	199	0.501734972	18.1500816	39.1910706	61.0684166	0.458274007	62520
20170	2	153	1	10000000	cplex	1	1	284	1	4	60	60	0	0	199		0.199958995	0.99425	1.80976403	6.84017611	0.0846230015	4448
20171	2	154	1	10000000	cplex	0	1	300	8	0	54	0	1	0	199	199	0.476601988	14.4341707	33.6867065	48.9618835	0.182833001	51411
20172	2	154	1	10000000	cplex	1	0	269	11	1	54	0	1	0	199	199	0.287645012	13.3862467	31.8057327	48.4095879	0.180405006	71357
20173	2	154	1	10000000	cplex	1	1	269	9	2	54	0	1	0	199	199	0.286606014	13.2069912	30.1945992	46.1192436	0.178453997	66907
20174	2	154	1	10000000	cplex	0	0	300	11	3	54	0	1	0	199	199	0.482636005	15.102788	36.0697098	51.6056404	0.198668003	56268
20175	2	154	1	10000000	cplex	1	1	269	1	4	54	54	0	0	199		0.419120014	3.50855494	6.30159712	39.3894844	0.0806759968	5408
20176	2	155	1	10000000	cplex	0	1	300	8	0	46	0	1	0	199	199	0.425595999	12.3965006	28.5854721	39.9556274	0.753660977	43737
20177	2	155	1	10000000	cplex	1	0	284	11	1	46	0	1	0	199	199	0.29549399	13.7854061	29.1173153	40.9738655	0.767399013	54469
20178	2	155	1	10000000	cplex	1	1	284	9	2	46	0	1	0	199	199	0.290022999	11.699111	27.4341316	39.1135025	0.755688012	50378
20179	2	155	1	10000000	cplex	0	0	300	11	3	46	0	1	0	199	199	0.357039988	13.155304	30.8078365	42.4786148	0.835438013	47932
20180	2	155	1	10000000	cplex	1	1	284	1	4	46	46	0	0	199		0.223236993	0.789066017	1.49657595	10.3834438	0.0757289976	3329
20181	2	156	1	10000000	cplex	0	1	300	8	0	63	0	1	0	199	199	0.584151983	16.8108082	39.4379921	61.7572517	0.681261003	59901
20182	2	156	1	10000000	cplex	1	0	284	11	1	63	0	1	0	199	199	0.367082	16.9615402	40.2424774	62.6173248	0.681396008	74599
20183	2	156	1	10000000	cplex	1	1	284	9	2	63	0	1	0	199	199	0.40100199	18.2450695	37.7460899	60.2765846	0.688444972	68996
20184	2	156	1	10000000	cplex	0	0	300	11	3	63	0	1	0	199	199	0.431483001	17.5629578	41.7752647	64.7109222	0.679148018	65646
20185	2	156	1	10000000	cplex	1	1	284	1	4	63	63	0	0	199		0.331537008	1.00443804	1.94716895	10.3266287	0.0686350018	4563
20186	2	157	1	10000000	cplex	0	1	300	8	0	50	0	1	0	199	199	0.558625996	13.859252	30.9016628	44.5627861	0.298588008	47541
20187	2	157	1	10000000	cplex	1	0	284	11	1	50	0	1	0	199	199	0.337994993	13.6427374	31.9949856	46.4488678	0.294322997	59205
20188	2	157	1	10000000	cplex	1	1	284	9	2	50	0	1	0	199	199	0.400260001	12.8188791	29.7944431	44.286869	0.355609	54759
20189	2	157	1	10000000	cplex	0	0	300	11	3	50	0	1	0	199	199	0.467429012	14.2147732	33.5196037	47.7128983	0.304242998	52100
20190	2	157	1	10000000	cplex	1	1	284	1	4	50	50	0	0	199		0.239251003	0.798146009	1.49887204	10.9319458	0.068415001	3469
20191	2	158	1	10000000	cplex	0	1	300	8	0	43	0	1	0	199	199	0.392203987	11.6536856	26.6408329	37.3011742	0.516557992	40885
20192	2	158	1	10000000	cplex	1	0	284	11	1	43	0	1	0	199	199	0.305290014	11.6587219	27.7201252	38.7610397	0.511048019	50917
20193	2	158	1	10000000	cplex	1	1	284	9	2	43	0	1	0	199	199	0.30469501	11.0552292	25.6147766	36.6502686	0.542437971	47093
20194	2	158	1	10000000	cplex	0	0	300	11	3	43	0	1	0	199	199	0.320226014	12.2866793	28.7301998	39.6967163	0.536854982	44806
20195	2	158	1	10000000	cplex	1	1	284	1	4	43	43	0	0	199		0.242512003	0.761542022	1.41947806	9.49984264	0.0749389976	3112
20196	2	159	1	10000000	cplex	0	1	300	8	0	63	0	1	0	199	199	0.536378026	17.346365	38.9707756	63.2361336	0.684116006	59901
20197	2	159	1	10000000	cplex	1	0	284	11	1	63	0	1	0	199	199	2.24212503	16.9203644	40.5841866	66.0077133	0.701690972	74599
20198	2	159	1	10000000	cplex	1	1	284	9	2	63	0	1	0	199	199	0.367345005	16.1675663	37.5242424	60.6911354	0.677286029	68996
20199	2	159	1	10000000	cplex	0	0	300	11	3	63	0	1	0	199	199	0.475930005	18.0806866	42.6064911	66.5297394	0.672850013	65646
20200	2	159	1	10000000	cplex	1	1	284	1	4	63	63	0	0	199		0.270316988	1.05039501	1.99204695	10.6179323	0.0784659982	4563
20201	2	160	1	10000000	cplex	0	1	300	9	0	13	1	1	0.0769229978	99	99	0.281524986	14.4803638	32.6617165	55.0512619	0.918558002	24956
20202	2	160	1	10000000	cplex	1	0	284	11	1	13	1	1	0.0769229978	99	99	0.263325006	14.7732868	33.8320808	52.8171387	0.913989007	28519
20203	2	160	1	10000000	cplex	1	1	284	9	2	13	1	1	0.0769229978	99	99	0.315699011	13.9175081	31.8850231	54.0094986	0.909649014	26909
20204	2	160	1	10000000	cplex	0	0	300	11	3	13	1	1	0.0769229978	99	99	0.283829987	14.4768572	34.0825272	52.648098	0.906946003	26546
20205	2	160	1	10000000	cplex	1	1	284	1	4	13	13	0	0	99		0.120660998	0.168606997	0.287142992	2.67832088	0.0682889968	727
20206	2	161	1	10000000	cplex	0	1	300	9	0	18	0	1	0	99	99	0.373598009	19.7355595	44.7119675	79.6690521	0.261449993	34567
20207	2	161	1	10000000	cplex	1	0	269	11	1	18	0	1	0	99	99	0.276704997	19.4976635	45.1412277	75.3541794	0.30588299	42109
20208	2	161	1	10000000	cplex	1	1	269	9	2	18	0	1	0	99	99	0.359338999	19.9665928	44.4110222	79.9783096	0.240556002	39873
20209	2	161	1	10000000	cplex	0	0	300	11	3	18	0	1	0	99	99	0.364811987	20.3472919	47.2794266	77.4218063	0.252674013	36756
20210	2	161	1	10000000	cplex	1	1	269	1	4	18	18	0	0	99		0.293274999	2.52395892	4.43741989	29.9314499	0.0827869996	2931
20211	2	162	1	10000000	cplex	0	1	300	9	0	16	0	1	0	99	99	0.339643002	18.0447159	40.0140381	68.6310654	0.360707998	30800
20212	2	162	1	10000000	cplex	1	0	261	11	1	16	0	1	0	99	99	0.280591011	18.2847672	40.5258942	66.4049149	0.359645009	38657
20213	2	162	1	10000000	cplex	1	1	261	9	2	16	0	1	0	99	99	0.299888998	16.7109585	38.0997467	68.9760971	0.358581007	36668
20214	2	162	1	10000000	cplex	0	0	300	11	3	16	0	1	0	99	99	0.313818008	17.6504593	42.0670395	66.8923416	0.354696989	32672
20215	2	162	1	10000000	cplex	1	1	261	1	4	16	29	0	0.8125	99	213	0.108719997	0.201058999	0.346597999	1.50715005	0.209726006	855
20216	2	163	1	10000000	cplex	0	1	300	9	0	30	1	1	0.0333329998	99	99	0.564770997	33.816452	75.1872559	158.92984	0.910112023	57594
20217	2	163	1	10000000	cplex	1	0	284	11	1	30	1	1	0.0333329998	99	99	0.43986401	40.2110481	78.6097641	153.675964	0.864515007	65813
20218	2	163	1	10000000	cplex	1	1	284	9	2	30	1	1	0.0333329998	99	99	0.572000027	32.8898239	75.2751007	159.034576	0.900270998	62098
20219	2	163	1	10000000	cplex	0	0	300	11	3	30	1	1	0.0333329998	99	99	0.454948992	33.9474106	79.533989	153.227631	0.882152021	61260
20220	2	163	1	10000000	cplex	1	1	284	1	4	30	30	0	0	99		0.124555998	0.59907198	0.993673027	5.23513603	0.070295997	2171
20221	2	164	1	10000000	cplex	0	1	300	9	0	30	1	1	0.0333329998	99	99	0.536369979	32.7541313	75.6437607	160.811157	0.897101998	57594
20222	2	164	1	10000000	cplex	1	0	284	11	1	30	1	1	0.0333329998	99	99	0.46311599	35.2032585	78.980217	151.027649	0.872622013	65813
20223	2	164	1	10000000	cplex	1	1	284	9	2	30	1	1	0.0333329998	99	99	0.548444986	32.138031	75.9333191	158.283737	0.886246026	62098
20224	2	164	1	10000000	cplex	0	0	300	11	3	30	1	1	0.0333329998	99	99	0.531404972	43.3489494	80.5790176	152.361008	0.891277015	61260
20225	2	164	1	10000000	cplex	1	1	284	1	4	30	30	0	0	99		0.135305002	0.589456022	0.997888982	5.12327003	0.0728629977	2171
20226	2	165	1	10000000	cplex	0	1	300	9	0	14	0	1	0	99	99	0.333606005	17.0842285	35.2705345	59.4426537	0.922559023	26886
20227	2	165	1	10000000	cplex	1	0	269	11	1	14	0	1	0	99	99	0.202141002	15.388195	36.1912231	62.3621063	0.880025029	32751
20228	2	165	1	10000000	cplex	1	1	269	9	2	14	0	1	0	99	99	0.278712004	14.911706	33.705452	59.1270638	0.846704006	31012
20229	2	165	1	10000000	cplex	0	0	300	11	3	14	0	1	0	99	99	0.278223991	15.5110588	36.4757462	57.6996613	0.852138996	28588
20230	2	165	1	10000000	cplex	1	1	269	1	4	14	14	0	0	99	236	0.114596002	0.179702997	0.304313987	1.747262	0.337408006	918
20231	2	166	1	10000000	cplex	0	1	300	9	0	11	1	1	0.0909089968	99	99	0.309650987	12.6435061	27.6510715	44.9061203	0.957311988	21174
20232	2	166	1	10000000	cplex	1	0	261	11	1	11	1	1	0.0909089968	99	99	0.241261005	11.8735151	27.8989296	43.5246582	0.939423025	26576
20233	2	166	1	10000000	cplex	1	1	261	9	2	11	1	1	0.0909089968	99	99	0.262706012	11.687212	26.7647781	45.0490036	0.971763015	25209
20234	2	166	1	10000000	cplex	0	0	300	11	3	11	1	1	0.0909089968	99	99	0.318430007	12.5582609	29.4427776	43.5067787	0.929363012	22462
20235	2	166	1	10000000	cplex	1	1	261	1	4	11	58	0.0909089968	4.36363602	99	213	0.124274001	0.121224001	0.208896995	0.675212979	0.210051	498
20236	2	167	1	10000000	cplex	0	1	300	9	0	12	0	1	0	99	99	0.277662009	13.3119297	29.9924202	50.5414467	0.657006025	23037
20237	2	167	1	10000000	cplex	1	0	284	11	1	12	0	1	0	99	99	0.231142998	13.9262581	31.9444962	49.1085777	0.639572024	26325
20238	2	167	1	10000000	cplex	1	1	284	9	2	12	0	1	0	99	99	0.300080001	23.7101841	38.5039177	52.1765594	0.662815988	24839
20239	2	167	1	10000000	cplex	0	0	300	11	3	12	0	1	0	99	99	0.565123975	125.446243	36.5525055	58.3091049	1.12429094	24504
20240	2	167	1	10000000	cplex	1	1	284	1	4	12	12	0	0	99		0.110311002	0.165904	0.284494996	3.57811093	0.0891949981	674
20241	2	168	1	10000000	cplex	0	1	300	9	0	17	0	1	0	99	99	0.349790007	16.9508362	36.6226082	67.8648071	0.745275974	32804
20242	2	168	1	10000000	cplex	1	0	170	11	1	17	0	1	0	99	99	0.120638996	11.4792395	23.8544846	47.0571136	0.774496973	56483
20243	2	168	1	10000000	cplex	1	1	170	10	2	17	0	1	0	99	99	0.142396003	11.3723431	22.8396873	50.2835808	0.76621902	53644
20244	2	168	1	10000000	cplex	0	0	300	11	3	17	0	1	0	99	99	0.329647005	19.4413376	40.6662788	64.9169388	0.775470018	34714
20245	2	168	1	10000000	cplex	1	1	170	1	4	17	17	0	0	99		0.178605005	3.60344791	5.71565294	58.5794334	0.0827789977	4116
20246	2	169	1	10000000	cplex	0	1	300	9	0	16	0	1	0	99	99	0.350044996	16.0470352	34.9118042	62.9829445	0.856666028	30790
20247	2	169	1	10000000	cplex	1	0	170	11	1	16	0	1	0	99	99	0.107153997	9.77572346	20.8821239	43.7216873	0.855039001	53161
20248	2	169	1	10000000	cplex	1	1	170	10	2	16	0	1	0	99	99	0.124077998	9.86630535	20.0275917	46.4912605	0.852528989	50488
20249	2	169	1	10000000	cplex	0	0	300	11	3	16	0	1	0	99	99	0.331019998	15.760087	35.9990692	59.4771919	0.838298023	32672
20250	2	169	1	10000000	cplex	1	1	170	1	4	16	16	0	0	99		0.0441090018	0.335990995	0.54994899	5.7141118	0.0767759979	1879
20251	2	170	1	10000000	cplex	0	1	300	9	0	30	0	1	0	49	49	0.621694982	54.8604546	110.202988	266.58493	0.350371003	72182
20252	2	170	1	10000000	cplex	1	0	170	11	1	30	0	1	0	49	49	0.284193009	41.1946945	83.712883	212.508163	0.333330989	114917
20253	2	170	1	10000000	cplex	1	1	170	10	2	30	0	1	0	49	49	0.312575012	36.3665237	75.1308136	232.489609	0.364203006	109144
20254	2	170	1	10000000	cplex	0	0	300	11	3	30	0	1	0	49	49	0.603713989	49.1278572	108.34977	246.010818	0.299998999	76260
20255	2	170	1	10000000	cplex	1	1	170	1	4	30	30	0	0	49		0.438048005	6.03014421	9.77924728	75.9585266	0	5000
20256	2	171	1	10000000	cplex	0	1	300	9	0	21	0	1	0	49	49	0.50987798	33.3892174	71.7157822	176.487228	0.299365014	50473
20257	2	171	1	10000000	cplex	1	0	170	11	1	21	0	1	0	49	49	0.200329006	26.0252876	56.2713165	142.048325	0.301903009	80442
20258	2	171	1	10000000	cplex	1	1	170	10	2	21	0	1	0	49	49	0.228121996	24.3515835	53.0883141	155.84549	0.302801996	76401
20259	2	171	1	10000000	cplex	0	0	300	11	3	21	0	1	0	49	49	0.470919013	35.0801125	77.549614	165.493713	0.328171015	53382
20260	2	171	1	10000000	cplex	1	1	170	1	4	21	21	0	0	49		0.310725003	1.286147	1.90961599	5.36306906	0.0778980032	2108
20261	2	172	1	10000000	cplex	0	1	300	9	0	38	0	1	0	49	49	0.748745024	63.3766899	132.638535	389.324982	0.764828026	91433
20262	2	172	1	10000000	cplex	1	0	170	11	1	38	0	1	0	49	49	0.294059992	52.043541	108.810249	311.215485	0.802377999	145562
20263	2	172	1	10000000	cplex	1	1	170	10	2	38	0	1	0	49	49	0.330433995	52.6273308	102.157005	341.939362	0.795715988	138250
20264	2	172	1	10000000	cplex	0	0	300	11	3	38	0	1	0	49	49	0.676088989	71.4750671	148.678253	356.257172	0.79095602	96596
20265	2	172	1	10000000	cplex	1	1	170	1	4	38	38	0	0	49		0.506434023	7.21742201	10.4960146	54.5507469	0	3912
20266	2	173	1	10000000	cplex	0	1	300	9	0	28	0	1	0	49	49	0.529825985	49.4671402	100.946182	235.702286	0.446478993	67297
20267	2	173	1	10000000	cplex	1	0	170	11	1	28	0	1	0	49	49	0.263498008	36.3278008	78.5771637	199.105301	0.456939995	107256
20268	2	173	1	10000000	cplex	1	1	170	10	2	28	0	1	0	49	49	0.313167006	35.2128754	75.1859512	213.625031	0.446554989	101868
20269	2	173	1	10000000	cplex	0	0	300	11	3	28	0	1	0	49	49	0.545307994	48.8358116	105.753922	227.852493	0.50326699	71176
20270	2	173	1	10000000	cplex	1	1	170	1	4	28	28	0	0	49		0.378104001	2.11862111	2.39788699	5.3806982	0.0817869976	2786
20271	2	174	1	10000000	cplex	0	1	300	9	0	29	0	1	0	49	49	0.642257988	47.9066811	103.022682	257.445099	0.187309995	69778
20272	2	174	1	10000000	cplex	1	0	170	11	1	29	0	1	0	49	49	0.259544998	35.7959709	80.3084869	211.734589	0.168628007	111087
20273	2	174	1	10000000	cplex	1	1	170	10	2	29	0	1	0	49	49	0.258991003	37.7191734	78.1882935	230.694611	0.17757	105506
20274	2	174	1	10000000	cplex	0	0	300	11	3	29	0	1	0	49	49	0.603097022	51.6453323	110.808388	239.674179	0.180555999	73718
20275	2	174	1	10000000	cplex	1	1	170	1	4	29	29	0	0	49		0.428184986	6.72909307	11.0157328	86.4454727	0	4295
20276	2	175	1	10000000	cplex	0	1	300	9	0	25	0	1	0	49	49	0.54401499	43.0955544	91.6486053	211.062592	0.904578984	60048
20277	2	175	1	10000000	cplex	1	0	170	11	1	25	0	1	0	49	49	0.245471001	32.0911331	69.8345184	171.207611	0.833769023	95764
20278	2	175	1	10000000	cplex	1	1	170	10	2	25	0	1	0	49	49	0.256669998	31.097084	66.7749329	185.95578	0.997902989	90954
20279	2	175	1	10000000	cplex	0	0	300	11	3	25	0	1	0	49	49	0.569908023	44.2046013	96.346817	197.770859	0.848151028	63550
20280	2	175	1	10000000	cplex	1	1	170	1	4	25	25	0	0	49		0.425467998	1.34742606	2.28993201	7.07684612	0.0710169971	2510
20281	2	176	1	10000000	cplex	0	1	300	9	0	28	0	1	0	49	49	0.542661011	48.0723343	101.816254	244.852905	0.774586022	67414
20282	2	176	1	10000000	cplex	1	0	170	11	1	28	0	1	0	49	49	0.25424701	35.6821861	79.5992432	196.386734	0.791190028	107256
20283	2	176	1	10000000	cplex	1	1	170	10	2	28	0	1	0	49	49	0.307844013	35.0415459	75.1743088	218.166763	0.779394984	101868
20284	2	176	1	10000000	cplex	0	0	300	11	3	28	0	1	0	49	49	0.526988029	49.8848648	110.055397	228.306366	0.80368799	71176
20285	2	176	1	10000000	cplex	1	1	170	1	4	28	28	0	0	49		0.427982002	5.82292986	9.85084724	72.5683212	0	4671
20286	2	177	1	10000000	cplex	0	1	300	9	0	28	0	1	0	49	49	0.559507012	51.2125359	104.667747	247.262802	0.817162991	67370
20287	2	177	1	10000000	cplex	1	0	170	11	1	28	0	1	0	49	49	0.250845999	36.2829323	79.6737595	197.935089	0.891012013	107256
20288	2	177	1	10000000	cplex	1	1	170	10	2	28	0	1	0	49	49	0.304201007	36.7726555	76.9443359	216.498413	0.832041025	101868
20289	2	177	1	10000000	cplex	0	0	300	11	3	28	0	1	0	49	49	0.591418982	50.1663551	111.459984	233.537155	0.838930011	71176
20290	2	177	1	10000000	cplex	1	1	170	1	4	28	28	0	0	49		0.384065986	5.81251001	9.92530346	75.282753	0	4659
20291	2	178	1	10000000	cplex	0	1	300	9	0	25	0	1	0	49	49	0.666988015	44.7439156	94.6194	208.009293	0.774165988	60190
20292	2	178	1	10000000	cplex	1	0	170	11	1	25	0	1	0	49	49	0.237571001	32.7482567	72.2472305	166.01593	0.784870982	95764
20293	2	178	1	10000000	cplex	1	1	170	10	2	25	0	1	0	49	49	0.279181987	32.212574	70.656929	182.747284	0.781427979	90954
20294	2	178	1	10000000	cplex	0	0	300	11	3	25	0	1	0	49	49	0.550032973	45.3515549	100.570137	198.093643	0.770250976	63550
20295	2	178	1	10000000	cplex	1	1	170	1	4	25	25	0	0	49		0.384036005	5.13753891	8.77831364	62.7325516	0	4137
20296	2	179	1	10000000	cplex	0	1	300	9	0	37	0	1	0	49	49	0.822624028	68.3471146	140.68927	372.44043	0.821555018	88989
20297	2	179	1	10000000	cplex	1	0	170	11	1	37	0	1	0	49	49	0.302976996	49.2699356	111.421608	300.934448	0.813317001	141732
20298	2	179	1	10000000	cplex	1	1	170	10	2	37	0	1	0	49	49	0.341464013	50.3764496	104.551369	329.857941	0.79538101	134612
20299	2	179	1	10000000	cplex	0	0	300	11	3	37	0	1	0	49	49	0.75997299	68.4823761	153.493149	346.535889	0.796720028	94054
20300	2	179	1	10000000	cplex	1	1	170	1	4	37	37	0	0	49		0.305298001	3.56979394	3.73462391	9.26491642	0.0739390031	3712
20301	4	240	1	10000000	cplex	0	1	300	1	0	160	0	1	0	299	299	0.0524940006	0.0545209982	0.0514540002	0.0591300018	0.599241018	1920
20302	4	240	1	10000000	cplex	1	0	296	11	1	160	0	1	0	299	299	0.0402190015	0.0205199998	0.036187999	0.0742039979	0.545394003	6720
20303	4	240	1	10000000	cplex	1	1	296	1	2	160	0	1	0	299	299	0.0323509984	0.00987400021	0.014157	0.0532409996	0.461562991	1920
20304	4	240	1	10000000	cplex	0	0	300	11	3	160	0	1	0	299	299	0.0293010008	0.0117239999	0.0344729982	0.0709180012	0.455448985	6720
20305	4	240	1	10000000	cplex	1	1	296	1	4	160	0	1	0	299	299	0.0308270007	0.00841199979	0.0141369998	0.0545869991	0.533070028	1920
20306	4	241	1	10000000	cplex	0	1	300	1	0	160	0	1	0	299	299	0.0236569997	0.00655200006	0.01193	0.0552689992	1.01708996	1920
20307	4	241	1	10000000	cplex	1	0	296	11	1	160	0	1	0	299	299	0.0325380005	0.00895399973	0.0304029994	0.071457997	0.613189995	6720
20308	4	241	1	10000000	cplex	1	1	296	1	2	160	0	1	0	299	299	0.0277989991	0.00498200022	0.011442	0.0529050007	0.631142974	1920
20309	4	241	1	10000000	cplex	0	0	300	11	3	160	0	1	0	299	299	0.0103529999	0.00989199989	0.0321060009	0.0723759979	0.608159006	6720
20310	4	241	1	10000000	cplex	1	1	296	1	4	160	0	1	0	299	299	0.0275560003	0.00448899996	0.0113040004	0.0522890016	0.63301003	1920
20311	4	242	1	10000000	cplex	0	1	300	1	0	190	0	1	0	299	299	0.0253759995	0.00497899996	0.0136780003	0.0643180013	0.63310498	2280
20312	4	242	1	10000000	cplex	1	0	296	11	1	190	0	1	0	299	299	0.0340219997	0.0113779996	0.0372469984	0.085473001	0.637908995	7980
20313	4	242	1	10000000	cplex	1	1	296	1	2	190	0	1	0	299	299	0.0307439994	0.0044069998	0.0133480001	0.0661000013	0.641259015	2280
20314	4	242	1	10000000	cplex	0	0	300	11	3	190	0	1	0	299	299	0.0251770001	0.0087580001	0.0355399996	0.0851470008	0.645776987	7980
20315	4	242	1	10000000	cplex	1	1	296	1	4	190	0	1	0	299	299	0.0192709994	0.00474199979	0.0137480004	0.0627679974	0.647029996	2280
20316	4	243	1	10000000	cplex	0	1	300	1	0	160	0	1	0	299	299	0.0162349995	0.00448800018	0.0113700004	0.052104	0.57625699	1920
20317	4	243	1	10000000	cplex	1	0	296	11	1	160	0	1	0	299	299	0.026997	0.00729899993	0.0301419999	0.0703789964	0.573126018	6720
20318	4	243	1	10000000	cplex	1	1	296	1	2	160	0	1	0	299	299	0.0269590002	0.00448499992	0.0113899997	0.0523630008	0.585637987	1920
20319	4	243	1	10000000	cplex	0	0	300	11	3	160	0	1	0	299	299	0.0285700001	0.00731300004	0.0301610008	0.0727590024	0.594878972	6720
20320	4	243	1	10000000	cplex	1	1	296	1	4	160	0	1	0	299	299	0.0273010004	0.00365100009	0.0110600004	0.0528549999	0.601364017	1920
20321	4	244	1	10000000	cplex	0	1	300	1	0	160	0	1	0	299	299	0.0211900007	0.0036830001	0.011101	0.0538869984	0.600772023	1920
20322	4	244	1	10000000	cplex	1	0	296	11	1	160	0	1	0	299	299	0.0358680002	0.0091599999	0.0323529989	0.181705996	0.626802981	6720
20323	4	244	1	10000000	cplex	1	1	296	1	2	160	0	1	0	299	299	0.0359899998	0.00404299982	0.0111999996	0.0539439991	0.638237	1920
20324	4	244	1	10000000	cplex	0	0	300	11	3	160	0	1	0	299	299	0.0306579992	0.0088320002	0.0320239998	0.071262002	0.623570025	6720
20325	4	244	1	10000000	cplex	1	1	296	1	4	160	0	1	0	299	299	0.0327019989	0.00367500004	0.0110069998	0.0522110015	0.619961023	1920
20326	4	245	1	10000000	cplex	0	1	300	1	0	282	0	1	0	299	299	0.0526829995	0.00649699988	0.0200820006	0.106560998	0.27046901	3384
20327	4	245	1	10000000	cplex	1	0	296	11	1	282	0	1	0	299	299	0.0212619994	0.0135260001	0.0543840006	0.140029997	0.92058301	11844
20328	4	245	1	10000000	cplex	1	1	296	1	2	282	0	1	0	299	299	0.0555749983	0.00771600008	0.021582	0.105315998	0.300363004	3384
20329	4	245	1	10000000	cplex	0	0	300	11	3	282	0	1	0	299	299	0.0527819991	0.0158779994	0.0571630001	0.137844995	0.292212993	11844
20330	4	245	1	10000000	cplex	1	1	296	1	4	282	0	1	0	299	299	0.0570759997	0.00632600021	0.0203600004	0.105962999	0.286258012	3384
20331	4	246	1	10000000	cplex	0	1	300	1	0	160	0	1	0	299	299	0.0214489996	0.00368499989	0.0111790001	0.0556199998	0.626954019	1920
20332	4	246	1	10000000	cplex	1	0	296	11	1	160	0	1	0	299	299	0.0264979992	0.00794100016	0.0311980005	0.074533999	0.619495988	6720
20333	4	246	1	10000000	cplex	1	1	296	1	2	160	0	1	0	299	299	0.0269200001	0.00382800004	0.0110759996	0.0537800007	0.633309007	1920
20334	4	246	1	10000000	cplex	0	0	300	11	3	160	0	1	0	299	299	0.0230579991	0.00921900012	0.0324999988	0.0732029974	1.03575397	6720
20335	4	246	1	10000000	cplex	1	1	296	1	4	160	0	1	0	299	299	0.0323100016	0.00367700006	0.0111819999	0.0532820001	0.623746991	1920
20336	4	247	1	10000000	cplex	0	1	300	1	0	160	0	1	0	299	299	0.0215600003	0.00364600006	0.0111090001	0.0545100011	0.741765976	1920
20337	4	247	1	10000000	cplex	1	0	296	11	1	160	0	1	0	299	299	0.0274390001	0.00735099986	0.030243	0.0720150024	0.741056979	6720
20338	4	247	1	10000000	cplex	1	1	296	1	2	160	0	1	0	299	299	0.110752001	0.004189	0.0136219999	0.0557879992	0.745242	1920
20339	4	247	1	10000000	cplex	0	0	300	11	3	160	0	1	0	299	299	0.0210270006	0.00728800008	0.0303320009	0.0712300017	0.73703301	6720
20340	4	247	1	10000000	cplex	1	1	296	1	4	160	0	1	0	299	299	0.0271240007	0.00366099994	0.0111140003	0.0522289984	0.749337018	1920
20341	4	248	1	10000000	cplex	0	1	300	1	0	160	0	1	0	299	299	0.0282150004	0.00455299998	0.0115949996	0.0525400005	0.506399989	1920
20342	4	248	1	10000000	cplex	1	0	296	11	1	160	0	1	0	299	299	0.0284989998	0.00723299989	0.0304540005	0.0719870031	0.354517013	6720
20343	4	248	1	10000000	cplex	1	1	296	1	2	160	0	1	0	299	299	0.0270990003	0.00363799999	0.0111509999	0.0542719997	0.357306987	1920
20344	4	248	1	10000000	cplex	0	0	300	11	3	160	0	1	0	299	299	0.0213360004	0.00726500014	0.0304049999	0.0715230033	0.368191004	6720
20345	4	248	1	10000000	cplex	1	1	296	1	4	160	0	1	0	299	299	0.0367650017	0.00452500023	0.0116649996	0.501514018	0.378441989	1920
20346	4	249	1	10000000	cplex	0	1	300	1	0	205	0	1	0	299	299	0.0267479997	0.00480599981	0.0149670001	0.0716779977	0.618555009	2460
20347	4	249	1	10000000	cplex	1	0	296	11	1	205	0	1	0	299	299	0.0330450013	0.00936600007	0.0387100019	0.0920630023	0.616322994	8610
20348	4	249	1	10000000	cplex	1	1	296	1	2	205	0	1	0	299	299	0.0247760005	0.0058840001	0.0158280004	0.070077002	0.625602007	2460
20349	4	249	1	10000000	cplex	0	0	300	11	3	205	0	1	0	299	299	0.0268949997	0.0093790004	0.038883999	0.0920860022	0.618884027	8610
20350	4	249	1	10000000	cplex	1	1	296	1	4	205	0	1	0	299	299	0.0330719985	0.00466099987	0.0152129997	0.0713829994	0.62053299	2460
20351	4	250	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.232089996	0.626969993	1.15387404	0.899271011	0.297008008	7177
20352	4	250	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0128140002	0.0761879981	0.139878005	0.216157004	0.301687002	24390
20353	4	250	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.014951	0.0522949994	0.0879649967	0.148907006	0.287248999	12780
20354	4	250	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.118855	0.768249989	1.91733694	1.53654206	0.290389001	13140
20355	4	250	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0121409995	0.0543989986	0.0762699991	0.366490006	0.294928998	5872
20356	4	251	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.183780998	0.730827987	1.26060104	0.894038975	0.336995989	7177
20357	4	251	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0143940002	0.0671550035	0.151651993	0.215823993	0.319204003	24390
20358	4	251	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0122499997	0.044032	0.0820820034	0.148820996	0.313744009	12780
20359	4	251	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.0976879969	0.875459015	2.06933308	1.54279196	0.315322012	13140
20360	4	251	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0149119999	0.051456999	0.0839079991	0.367031008	0.312415004	5872
20361	4	252	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.183194995	0.716548979	1.27493203	0.905180991	0.843125999	7177
20362	4	252	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0142489998	0.0671209991	0.151730999	0.217326999	0.839190006	24390
20363	4	252	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0122419996	0.0439070016	0.082611002	0.147467002	0.821232021	12780
20364	4	252	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.113264002	0.884796023	2.08156204	1.533571	0.83750701	13140
20365	4	252	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0148820002	0.0515770018	0.0838079974	0.367145985	0.825654984	5872
20366	4	253	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.173017994	0.716372013	1.27252805	0.898263991	0.908897996	7177
20367	4	253	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0144149996	0.0668589994	0.153321996	0.216502994	1.06524897	24390
20368	4	253	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0121999998	0.0470359996	0.0850730017	0.148733005	0.900942028	12780
20369	4	253	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.142205998	0.878309011	2.08419991	1.55065703	0.904120982	13140
20370	4	253	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0149269998	0.0511879995	0.0834029987	0.366156995	0.889230013	5872
20371	4	254	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.192001998	0.670126975	1.237239	0.912015021	0.861048996	7177
20372	4	254	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0124249998	0.0549699999	0.142039001	0.216286004	0.846373022	24390
20373	4	254	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0148179997	0.0489830002	0.0866030008	0.147397995	0.887309015	12780
20374	4	254	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.171195999	0.768541992	1.98221302	1.53368497	0.873183012	13140
20375	4	254	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0149039999	0.0514479987	0.0861079991	0.370092005	0.830715001	5872
20376	4	255	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.239841998	0.616527975	1.20134199	0.905403972	0.829782009	7177
20377	4	255	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0123960003	0.0547370017	0.142660007	0.214288995	0.836117983	24390
20378	4	255	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.014831	0.0491530001	0.0886040032	0.149279997	0.850104988	12780
20379	4	255	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.139988005	0.770582974	2.01163602	1.56297398	0.847047985	13140
20380	4	255	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0120780002	0.0440689996	0.0792429969	0.368968993	0.842821002	5872
20381	4	256	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.228048995	0.614979982	1.20104802	0.920346975	0.918190002	7177
20382	4	256	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0125510003	0.0549190007	0.143555	0.216345996	0.908967018	24390
20383	4	256	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0147219999	0.0514409989	0.0886289999	0.148020998	0.925756991	12780
20384	4	256	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.0928269997	0.778530002	2.0139029	1.54687703	0.934388995	13140
20385	4	256	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0121099995	0.0434349999	0.0794200003	0.367709011	0.931263983	5872
20386	4	257	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.230061993	0.618830979	1.21095502	0.917787015	0.371573001	7177
20387	4	257	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0124970004	0.0548940003	0.143916994	0.216802999	0.374489009	24390
20388	4	257	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0147740003	0.0527860001	0.0912280008	0.147970006	0.388893008	12780
20389	4	257	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.105373003	0.885998011	2.03749204	1.55557203	0.392903	13140
20390	4	257	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0119669996	0.0429719985	0.0804949999	0.367585987	0.378800005	5872
20391	4	258	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.227467	0.627622008	1.22674704	0.913690984	0.592696011	7177
20392	4	258	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0121759996	0.0564180017	0.148325995	0.216075003	0.591764987	24390
20393	4	258	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0138990004	0.0527359992	0.0929440036	0.148623005	0.597681999	12780
20394	4	258	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.127168	0.83208698	2.05831194	1.56226397	0.59454602	13140
20395	4	258	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0124009997	0.0435659997	0.0797069967	0.364257008	0.586376011	5872
20396	4	259	1	10000000	cplex	0	1	300	2	0	45	0	1	0	274	274	0.162799999	0.635846972	1.24199295	0.927860975	0.842707992	7177
20397	4	259	1	10000000	cplex	1	0	274	11	1	45	0	1	0	274	274	0.0121940002	0.0551269986	0.147370994	0.218163997	0.821206987	24390
20398	4	259	1	10000000	cplex	1	1	274	2	2	45	0	1	0	274	274	0.0120949997	0.0512459986	0.0927039981	0.148711994	0.828913987	12780
20399	4	259	1	10000000	cplex	0	0	300	11	3	45	0	1	0	274	274	0.138473004	0.907986999	2.06430101	1.55525601	0.840807974	13140
20400	4	259	1	10000000	cplex	1	1	274	1	4	45	0	1	0	274	274	0.0126139997	0.0433529988	0.0806569979	0.367626995	0.823791027	5872
20401	4	260	1	10000000	cplex	0	1	300	1	0	71	0	1	0	249	295	0.0653420016	0.0362339988	0.0756810009	1.43958104	0.928213	2272
20402	4	260	1	10000000	cplex	1	0	296	11	1	71	0	1	0	249	295	0.0555969998	0.0575769991	0.165423006	1.51666903	1.54901397	5822
20403	4	260	1	10000000	cplex	1	1	296	1	2	71	0	1	0	249	295	0.0546839982	0.0384190008	0.077486001	1.43068099	0.946286023	2272
20404	4	260	1	10000000	cplex	0	0	300	11	3	71	0	1	0	249	295	0.0497980006	0.0512260012	0.159729004	1.522879	0.857532024	5822
20405	4	260	1	10000000	cplex	1	1	296	1	4	71	0	1	0	249	295	0.0543959998	0.0403920002	0.0784320012	1.48114502	0.935256004	2272
20406	4	261	1	10000000	cplex	0	1	300	1	0	71	0	1	0	249	295	0.0480090007	0.0417589992	0.0800649971	1.44161797	1.26635396	2272
20407	4	261	1	10000000	cplex	1	0	296	11	1	71	0	1	0	249	295	0.0711510032	0.0511749983	0.160534993	1.52042401	0.876079977	5822
20408	4	261	1	10000000	cplex	1	1	296	1	2	71	0	1	0	249	295	0.0550080016	0.0383130014	0.077895999	1.43081295	0.884826005	2272
20409	4	261	1	10000000	cplex	0	0	300	11	3	71	0	1	0	249	295	0.0308090001	0.0521330014	0.160471007	1.51517105	0.994333029	5822
20410	4	261	1	10000000	cplex	1	1	296	1	4	71	0	1	0	249	295	0.0486980006	0.041170001	0.0798619986	1.43384802	0.904439986	2272
20411	4	262	1	10000000	cplex	0	1	300	1	0	71	0	1	0	249	295	0.0488790013	0.133199006	0.0818890035	1.43910599	0.892072976	2272
20412	4	262	1	10000000	cplex	1	0	296	11	1	71	0	1	0	249	295	0.054428	0.0510590002	0.160688996	1.51350796	0.889805973	5822
20413	4	262	1	10000000	cplex	1	1	296	1	2	71	0	1	0	249	295	0.0709149987	0.0378109999	0.0768029988	1.44121206	0.85927999	2272
20414	4	262	1	10000000	cplex	0	0	300	11	3	71	0	1	0	249	295	0.0424249992	0.0613799989	0.170941994	1.60702395	0.857394993	5822
20415	4	262	1	10000000	cplex	1	1	296	1	4	71	0	1	0	249	295	0.0560140014	0.0385949984	0.0775900036	1.44254506	0.924498022	2272
20416	4	263	1	10000000	cplex	0	1	300	2	0	110	0	1	0	249	249	0.379020005	6.2163682	11.7318716	224.922928	0.800204992	33588
20417	4	263	1	10000000	cplex	1	0	296	11	1	110	0	1	0	249	249	0.453880012	8.5244112	18.2847939	232.355392	0.903596997	59299
20418	4	263	1	10000000	cplex	1	1	296	3	2	110	110	0	0	249		2.08688498	264.95575	433.697662	4545.06689	0	210498
20419	4	263	1	10000000	cplex	0	0	300	11	3	110	0	1	0	249	249	0.414732009	7.8720808	19.3293381	237.109436	0.795488	59620
20420	4	263	1	10000000	cplex	1	1	296	1	4	110	110	0	0	249		2.15604305	213.401901	360.654633	4281.68945	0	163749
20421	4	264	1	10000000	cplex	0	1	300	1	0	71	0	1	0	249	295	0.0529120006	0.0366990007	0.0748919994	1.39089406	0.890788019	2272
20422	4	264	1	10000000	cplex	1	0	296	11	1	71	0	1	0	249	295	0.0435849987	0.157692999	0.163868994	1.46580195	0.87381798	5822
20423	4	264	1	10000000	cplex	1	1	296	1	2	71	0	1	0	249	295	0.0430979989	0.0400409997	0.0769599974	1.38318503	0.940801978	2272
20424	4	264	1	10000000	cplex	0	0	300	11	3	71	0	1	0	249	295	0.0383000001	0.0601430014	0.166874006	1.46281004	0.920149028	5822
20425	4	264	1	10000000	cplex	1	1	296	1	4	71	0	1	0	249	295	0.0493309982	0.0389579982	0.0772380009	1.42073905	0.846157014	2272
20426	4	265	1	10000000	cplex	0	1	300	3	0	139	139	0	0	249		2.43822408	334.552521	561.464722	5486.31934	0	263628
20427	4	265	1	10000000	cplex	1	0	272	11	1	139	139	0	0	249		2.21567607	443.293762	815.144409	6980.80664	0	459458
20428	4	265	1	10000000	cplex	1	1	272	3	2	139	139	0	0	249		2.20128202	332.763672	555.553833	5486.36279	0	287783
20429	4	265	1	10000000	cplex	0	0	300	11	3	139	139	0	0	249		2.55693793	426.184387	843.971863	6973.71973	0	421448
20430	4	265	1	10000000	cplex	1	1	272	1	4	139	139	0	0	249		2.249125	326.886932	475.97641	8437.87402	0	115201
20431	4	266	1	10000000	cplex	0	1	300	2	0	96	0	1	0	249	249	0.376825005	5.40269423	10.207305	145.813354	0.848412991	29313
20432	4	266	1	10000000	cplex	1	0	296	11	1	96	0	1	0	249	249	0.355888009	6.29271507	15.7530527	156.138809	0.824728012	51752
20433	4	266	1	10000000	cplex	1	1	296	2	2	96	0	1	0	249	249	0.36470899	5.25209904	9.88335896	144.481949	0.836587012	29276
20434	4	266	1	10000000	cplex	0	0	300	11	3	96	0	1	0	249	249	0.396225989	6.67932177	16.1409473	156.666168	0.845977008	52032
20435	4	266	1	10000000	cplex	1	1	296	1	4	96	0	1	0	249	249	0.347984999	4.76670408	8.25426865	138.254761	0.826223016	24212
30001	3	180	1	10000000	cplex	0	1	300	1	0	77	0	1	0	299	299	0.0314619988	0.0328859985	0.0287989993	0.168428004	0.370804012	924
30002	3	180	1	10000000	cplex	1	0	285	11	1	77	0	1	0	299	299	0.0277110003	0.0309369992	0.0702150017	0.212142006	0.321835011	3234
30003	3	180	1	10000000	cplex	1	1	285	1	2	77	0	1	0	299	299	0.0191309992	0.00973800011	0.0263020005	0.201306	0.281488001	924
30004	3	180	1	10000000	cplex	0	0	300	11	3	77	0	1	0	299	299	0.0100299995	0.0084739998	0.0220899992	0.184974998	0.296728998	3234
30005	3	180	1	10000000	cplex	1	1	285	1	4	77	0	1	0	299	299	0.0187049992	0.00561399991	0.00793499965	0.198863	0.284550995	924
30006	3	181	1	10000000	cplex	0	1	300	1	0	12	0	1	0	299	299	0.00253499998	0.000928999973	0.00131900003	0.0304509997	0.185523003	144
30007	3	181	1	10000000	cplex	1	0	285	11	1	12	0	1	0	299	299	0.0101030003	0.00149499997	0.00277799997	0.0919250026	0.178085998	504
30008	3	181	1	10000000	cplex	1	1	285	1	2	12	0	1	0	299	299	0.00979200006	0.000943000021	0.00153400004	0.0285010003	0.157455996	144
30009	3	181	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.002263	0.00111399998	0.00262399996	0.0327819996	0.157334998	504
30010	3	181	1	10000000	cplex	1	1	285	1	4	12	0	1	0	299	299	0.0097719999	0.000738999981	0.00131199998	0.0304990001	0.179954007	144
30011	3	182	1	10000000	cplex	0	1	300	1	0	9	0	1	0	299	299	0.00169599999	0.00056700001	0.00103000004	0.325572997	0.156849995	108
30012	3	182	1	10000000	cplex	1	0	285	11	1	9	0	1	0	299	299	0.00918999966	0.000814999978	0.00200299989	0.424879998	0.161657006	378
30013	3	182	1	10000000	cplex	1	1	285	1	2	9	0	1	0	299	299	0.00913999975	0.000545000017	0.00101799995	0.459867001	0.230097994	108
30014	3	182	1	10000000	cplex	0	0	300	11	3	9	0	1	0	299	299	0.00158200006	0.000791999977	0.00204599998	0.496484995	0.155987993	378
30015	3	182	1	10000000	cplex	1	1	285	1	4	9	0	1	0	299	299	0.00918500032	0.000547999982	0.00103699998	0.130136997	0.171032995	108
30016	3	183	1	10000000	cplex	0	1	300	1	0	1	0	1	0	299	299	0.000948000001	0.00013	0.000311999989	0.0898289979	0.172620997	12
30017	3	183	1	10000000	cplex	1	0	285	11	1	1	0	1	0	299	299	0.0117650004	0.000207000005	0.000456000009	0.0212270003	0.157801002	42
30018	3	183	1	10000000	cplex	1	1	285	1	2	1	0	1	0	299	299	0.0123340003	0.000142999997	0.000326000008	0.0215460006	0.173279002	12
30019	3	183	1	10000000	cplex	0	0	300	11	3	1	0	1	0	299	299	0.00143599999	0.000254000013	0.000740999996	0.0242250003	0.166613996	42
30020	3	183	1	10000000	cplex	1	1	285	1	4	1	0	1	0	299	299	0.013359	0.000146000006	0.000318000006	0.0199040007	0.170658007	12
30021	3	184	1	10000000	cplex	0	1	300	1	0	137	0	1	0	299	299	0.0204850007	0.00846199971	0.0124469995	0.498322994	0.599164009	1644
30022	3	184	1	10000000	cplex	1	0	285	11	1	137	0	1	0	299	299	0.0251749996	0.0100729996	0.0291200001	0.758845985	0.850624025	5754
30023	3	184	1	10000000	cplex	1	1	285	1	2	137	0	1	0	299	299	0.0276050009	0.00709899981	0.0121759996	0.508744001	0.590983987	1644
30024	3	184	1	10000000	cplex	0	0	300	11	3	137	0	1	0	299	299	0.017515	0.00984199997	0.0289660003	0.678388	0.591174006	5754
30025	3	184	1	10000000	cplex	1	1	285	1	4	137	0	1	0	299	299	0.0277290009	0.00576499989	0.0112570003	0.541383982	0.576049984	1644
30026	3	185	1	10000000	cplex	0	1	300	1	0	12	0	1	0	299	299	0.00233100005	0.000572999998	0.00125800003	0.0839210004	0.156454995	144
30027	3	185	1	10000000	cplex	1	0	285	11	1	12	0	1	0	299	299	0.00922400039	0.00078100001	0.002568	0.0295550004	0.165087998	504
30028	3	185	1	10000000	cplex	1	1	285	1	2	12	0	1	0	299	299	0.00923999958	0.000483000011	0.00126499997	0.0323840007	0.160918996	144
30029	3	185	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.00225899997	0.000979000004	0.00257200003	0.0266689993	0.168981999	504
30030	3	185	1	10000000	cplex	1	1	285	1	4	12	0	1	0	299	299	0.00961500034	0.000554000027	0.00121400005	0.0295919999	0.164079994	144
30031	3	186	1	10000000	cplex	0	1	300	1	0	23	0	1	0	299	299	0.00341599993	0.000927000016	0.00197899994	0.116478004	0.147324994	276
30032	3	186	1	10000000	cplex	1	0	285	11	1	23	0	1	0	299	299	0.0107960002	0.00129199994	0.0045520002	0.0350160003	0.174538001	966
30033	3	186	1	10000000	cplex	1	1	285	1	2	23	0	1	0	299	299	0.0105130002	0.000748999999	0.00198199996	0.0366210006	0.172525004	276
30034	3	186	1	10000000	cplex	0	0	300	11	3	23	0	1	0	299	299	0.00386300008	0.00159700005	0.00451599993	0.0449669994	0.167864993	966
30035	3	186	1	10000000	cplex	1	1	285	1	4	23	0	1	0	299	299	0.0114099998	0.000905000023	0.00202600006	0.0316760018	0.170077994	276
30036	3	187	1	10000000	cplex	0	1	300	1	0	39	0	1	0	299	299	0.00493599987	0.00122400001	0.00323299994	0.112774998	0.203988001	468
30037	3	187	1	10000000	cplex	1	0	285	11	1	39	0	1	0	299	299	0.0136179999	0.00266700005	0.00747099984	0.423597991	0.210244998	1638
30038	3	187	1	10000000	cplex	1	1	285	1	2	39	0	1	0	299	299	0.0120999999	0.00123000005	0.00314199994	0.329531997	0.202274993	468
30039	3	187	1	10000000	cplex	0	0	300	11	3	39	0	1	0	299	299	0.00505700009	0.00260100001	0.025626	0.51235801	0.203647003	1638
30040	3	187	1	10000000	cplex	1	1	285	1	4	39	0	1	0	299	299	0.0121929999	0.00126399996	0.00316000008	0.329575002	0.193792	468
30041	3	188	1	10000000	cplex	0	1	300	1	0	4	0	1	0	299	299	0.00103199994	0.000222999995	0.000513000006	0.0210999995	0.171296	48
30131	3	206	1	10000000	cplex	0	1	300	2	0	21	0	1	0	249	295	0.0173710007	0.0140589997	0.0270690005	0.0335099995	1.05070901	852
30132	3	206	1	10000000	cplex	1	0	284	11	1	21	0	1	0	249	295	0.0148139996	0.0113399997	0.0274730008	0.0295209996	1.03893399	2352
30042	3	188	1	10000000	cplex	1	0	285	11	1	4	0	1	0	299	299	0.00825900026	0.000293999998	0.00104799995	0.023604	0.179171994	168
30043	3	188	1	10000000	cplex	1	1	285	1	2	4	0	1	0	299	299	0.00862300023	0.000155000002	0.000510999991	0.0966140032	0.182282999	48
30044	3	188	1	10000000	cplex	0	0	300	11	3	4	0	1	0	299	299	0.000991999987	0.000338000013	0.00107100001	0.0281649996	0.183130994	168
30045	3	188	1	10000000	cplex	1	1	285	1	4	4	0	1	0	299	299	0.00835900009	0.000211999999	0.000513000006	0.0323880017	0.159048006	48
30046	3	189	1	10000000	cplex	0	1	300	1	0	29	0	1	0	299	299	0.00493500009	0.00112799997	0.00253299996	0.0409980007	0.171846002	348
30047	3	189	1	10000000	cplex	1	0	285	11	1	29	0	1	0	299	299	0.0110459998	0.00164200005	0.0056739999	0.0340460017	0.167120993	1218
30048	3	189	1	10000000	cplex	1	1	285	1	2	29	0	1	0	299	299	0.0111029996	0.00113800005	0.00248700008	0.0326329991	0.177641004	348
30049	3	189	1	10000000	cplex	0	0	300	11	3	29	0	1	0	299	299	0.00255000009	0.00161399995	0.0057310001	0.037388999	0.190502003	1218
30050	3	189	1	10000000	cplex	1	1	285	1	4	29	0	1	0	299	299	0.0114019997	0.00104700006	0.00250299997	0.0319680013	0.183686003	348
30051	3	190	1	10000000	cplex	0	1	300	3	0	4	0	1	0	274	282	0.0148329996	0.047665	0.0610340014	0.128719002	1.28698206	483
30052	3	190	1	10000000	cplex	1	0	284	11	1	4	0	1	0	274	282	0.0180510003	0.0420969985	0.0568430014	0.104612999	1.22697794	976
30053	3	190	1	10000000	cplex	1	1	284	3	2	4	0	1	0	274	282	0.0163439997	0.0279610008	0.0388670005	0.0898640007	1.32436705	592
30054	3	190	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	282	0.0149029996	0.043903999	0.0838399976	0.145558998	1.22059298	848
30055	3	190	1	10000000	cplex	1	1	284	1	4	4	0	1	0	274	282	0.014765	0.0109350001	0.0160729997	0.116114996	1.25870097	167
30056	3	191	1	10000000	cplex	0	1	300	3	0	4	0	1	0	274	282	0.0128800003	0.0307170004	0.0543150008	0.116990998	1.32259595	483
30057	3	191	1	10000000	cplex	1	0	284	11	1	4	0	1	0	274	282	0.0154219996	0.024185	0.0524130017	0.103983998	1.20920706	976
30058	3	191	1	10000000	cplex	1	1	284	3	2	4	0	1	0	274	282	0.0169389993	0.0229250006	0.0362670012	0.0876860023	1.25966096	592
30059	3	191	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	282	0.0122950003	0.0356089994	0.080982998	0.279282004	1.230986	848
30060	3	191	1	10000000	cplex	1	1	284	1	4	4	0	1	0	274	282	0.0145300003	0.00952399988	0.0155969998	0.115131997	1.21955502	167
30061	3	192	1	10000000	cplex	0	1	300	3	0	4	0	1	0	274	282	0.0144429998	0.0346890017	0.0522500016	0.117247	1.23703802	483
30062	3	192	1	10000000	cplex	1	0	284	11	1	4	0	1	0	274	282	0.0144809997	0.0943600014	0.0558589995	0.103648998	1.22079098	976
30063	3	192	1	10000000	cplex	1	1	284	3	2	4	0	1	0	274	282	0.0154440003	0.0204969998	0.0350890011	0.0860370025	1.27531004	592
30064	3	192	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	282	0.0148630003	0.0422380008	0.0809049979	0.139921993	1.30571699	848
30065	3	192	1	10000000	cplex	1	1	284	1	4	4	0	1	0	274	282	0.01468	0.00925500039	0.0150349997	0.117044002	1.28428602	167
30066	3	193	1	10000000	cplex	0	1	300	3	0	4	0	1	0	274	282	0.0138849998	0.0335530005	0.0527159981	0.117696002	1.30426002	483
30067	3	193	1	10000000	cplex	1	0	284	11	1	4	0	1	0	274	282	0.0154900001	0.0236750003	0.0516190007	0.110632002	1.25676405	976
30068	3	193	1	10000000	cplex	1	1	284	3	2	4	0	1	0	274	282	0.0149050001	0.0220810007	0.0349389985	0.0865089968	1.28220499	592
30069	3	193	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	282	0.0142200002	0.0388719998	0.0820360035	0.142555997	1.25000405	848
30070	3	193	1	10000000	cplex	1	1	284	1	4	4	0	1	0	274	282	0.0147259999	0.00995299965	0.0153790005	0.116557002	1.22049701	167
30071	3	194	1	10000000	cplex	0	1	300	3	0	4	0	1	0	274	282	0.0149330003	0.0342059992	0.0542480014	0.177212	1.23000896	483
30072	3	194	1	10000000	cplex	1	0	284	11	1	4	0	1	0	274	282	0.0147989998	0.024557	0.0523069985	0.103843004	1.21530199	976
30073	3	194	1	10000000	cplex	1	1	284	3	2	4	0	1	0	274	282	0.0164819993	0.0236269999	0.0385169983	0.0886069983	1.30022204	592
30074	3	194	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	282	0.0130860005	0.0358689986	0.0841670036	0.144144997	1.23396802	848
30075	3	194	1	10000000	cplex	1	1	284	1	4	4	0	1	0	274	282	0.0150739998	0.00992699992	0.0156529993	0.115823999	1.22548604	167
30076	3	195	1	10000000	cplex	0	1	300	3	0	25	0	1	0	274	274	0.094054997	0.374971986	0.731728971	1.64629996	0.954779029	4528
30077	3	195	1	10000000	cplex	1	0	284	11	1	25	0	1	0	274	274	0.0575219989	0.417127997	0.902310014	1.79885995	0.944187999	8633
30078	3	195	1	10000000	cplex	1	1	284	4	2	25	0	1	0	274	274	0.0828159973	0.381484985	0.645860016	1.52728796	0.942129016	5575
30079	3	195	1	10000000	cplex	0	0	300	11	3	25	0	1	0	274	274	0.0858739987	0.476339996	1.12267494	1.97133803	0.937892973	7300
30080	3	195	1	10000000	cplex	1	1	284	1	4	25	0	1	0	274	274	0.0613300018	0.220806003	0.384380013	2.45353508	0.980192006	1888
30081	3	196	1	10000000	cplex	0	1	300	3	0	4	0	1	0	274	282	0.0129209999	0.0305710007	0.0534919985	0.114212997	1.21504104	483
30082	3	196	1	10000000	cplex	1	0	284	11	1	4	0	1	0	274	282	0.0151270004	0.0270809997	0.0530150011	0.171137005	1.22407997	976
30083	3	196	1	10000000	cplex	1	1	284	3	2	4	0	1	0	274	282	0.0153559996	0.0216140002	0.0367869996	0.371327013	1.263327	592
30084	3	196	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	282	0.0123020001	0.0355429985	0.082163997	0.137771994	1.30623698	848
30085	3	196	1	10000000	cplex	1	1	284	1	4	4	0	1	0	274	282	0.0143959997	0.00966800004	0.0168580003	0.116494	1.24194801	167
30086	3	197	1	10000000	cplex	0	1	300	3	0	4	0	1	0	274	282	0.0156909991	0.0336900018	0.0548200011	0.166005	1.28323901	483
30087	3	197	1	10000000	cplex	1	0	284	11	1	4	0	1	0	274	282	0.0147000002	0.0235949997	0.0530340001	0.100766003	1.303859	976
30088	3	197	1	10000000	cplex	1	1	284	3	2	4	0	1	0	274	282	0.0157389995	0.0223859996	0.0358910002	0.0825610012	1.30754995	592
30089	3	197	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	282	0.0130139999	0.0365299992	0.082806997	0.141755	1.25697505	848
30090	3	197	1	10000000	cplex	1	1	284	1	4	4	0	1	0	274	282	0.0142069999	0.0105330003	0.0156529993	0.111670002	1.29950702	167
30091	3	198	1	10000000	cplex	0	1	300	3	0	6	0	1	0	274	274	0.0262669995	0.174336001	0.172794998	0.422603011	0.962170005	1086
30092	3	198	1	10000000	cplex	1	0	284	11	1	6	0	1	0	274	274	0.0302060004	0.0966759995	0.225940004	0.450471997	0.960602999	2072
30093	3	198	1	10000000	cplex	1	1	284	4	2	6	0	1	0	274	274	0.0322699994	0.0852819979	0.151969001	0.393561006	0.928095996	1338
30094	3	198	1	10000000	cplex	0	0	300	11	3	6	0	1	0	274	274	0.0277280007	0.108401	0.263592988	0.50465399	0.931620002	1752
30095	3	198	1	10000000	cplex	1	1	284	1	4	6	0	1	0	274	274	0.0252170004	0.0543109998	0.092445001	0.590535998	0.923425019	453
30096	3	199	1	10000000	cplex	0	1	300	3	0	9	0	1	0	274	274	0.0473240018	0.153415993	0.277815014	0.648998976	0.941956997	1630
30097	3	199	1	10000000	cplex	1	0	284	11	1	9	0	1	0	274	274	0.0404560007	0.149502993	0.340894014	0.698273003	0.93739301	3108
30098	3	199	1	10000000	cplex	1	1	284	4	2	9	0	1	0	274	274	0.0354150012	0.11558	0.227982998	0.598348022	0.925354004	2007
30099	3	199	1	10000000	cplex	0	0	300	11	3	9	0	1	0	274	274	0.0363570005	0.443221003	0.418384999	0.764406979	0.944419026	2628
30100	3	199	1	10000000	cplex	1	1	284	1	4	9	0	1	0	274	274	0.0362219997	0.0893800035	0.142372996	0.883750975	0.956211984	679
30101	3	200	1	10000000	cplex	0	1	300	3	0	35	0	1	0	249	264	0.107294999	1.18402195	2.12422895	2.99237895	1.00589895	8992
30102	3	200	1	10000000	cplex	1	0	284	11	1	35	0	1	0	249	264	0.143439993	1.15615106	2.78478193	3.25658607	1.01565397	15920
30103	3	200	1	10000000	cplex	1	1	284	4	2	35	0	1	0	249	264	0.170233995	0.986306012	1.93996501	2.48985004	1.02151299	10655
30104	3	200	1	10000000	cplex	0	0	300	11	3	35	0	1	0	249	264	0.130807996	1.32377601	2.99769306	3.45941091	1.01270103	13720
30105	3	200	1	10000000	cplex	1	1	284	1	4	35	0	1	0	249	264	0.131174996	0.256054997	0.488840997	2.01810908	1.02326405	2203
30106	3	201	1	10000000	cplex	0	1	300	2	0	2	0	1	0	249	295	0.00306900009	0.00175599998	0.00317299995	0.0106100002	1.05242097	81
30107	3	201	1	10000000	cplex	1	0	284	11	1	2	0	1	0	249	295	0.0087890001	0.00132599997	0.00279100006	0.00645500002	1.04636598	224
30108	3	201	1	10000000	cplex	1	1	284	3	2	2	0	1	0	249	295	0.00883499999	0.00108099997	0.00177500001	0.0051409998	1.04809904	120
30109	3	201	1	10000000	cplex	0	0	300	11	3	2	0	1	0	249	295	0.0029829999	0.00211600005	0.00514899986	0.0123650003	1.06628394	164
30110	3	201	1	10000000	cplex	1	1	284	1	4	2	0	1	0	249	295	0.00882100035	0.000986000057	0.00163099996	0.012596	1.09350598	46
30111	3	202	1	10000000	cplex	0	1	300	4	0	69	0	1	0	249	249	0.247700006	4.34567022	8.46627903	66.4655609	0.315165997	25055
30112	3	202	1	10000000	cplex	1	0	284	11	1	69	0	1	0	249	249	0.222672999	4.58644915	10.759984	69.692215	0.322068989	41505
30113	3	202	1	10000000	cplex	1	1	284	4	2	69	0	1	0	249	249	0.2086	3.96150088	7.79248095	65.0059967	0.306490988	28286
30114	3	202	1	10000000	cplex	0	0	300	11	3	69	0	1	0	249	249	0.253930986	5.35686111	11.7607183	72.3003311	0.309311002	37398
30115	3	202	1	10000000	cplex	1	1	284	1	4	69	0	1	0	249	249	0.234584004	3.64567709	6.35098219	61.1197815	0.288230985	9968
30116	3	203	1	10000000	cplex	0	1	300	4	0	11	0	1	0	249	249	0.116754003	1.09039104	1.37002599	4.63394213	0.169388995	3994
30117	3	203	1	10000000	cplex	1	0	284	11	1	11	0	1	0	249	249	0.0796879977	0.774827003	1.74884903	4.77733803	0.167207003	6616
30118	3	203	1	10000000	cplex	1	1	284	4	2	11	0	1	0	249	249	0.088421002	0.661301017	1.27879	4.3918252	0.177784994	4509
30119	3	203	1	10000000	cplex	0	0	300	11	3	11	0	1	0	249	249	0.089835003	0.828799009	1.93277299	4.97123194	0.167447999	5962
30120	3	203	1	10000000	cplex	1	1	284	1	4	11	0	1	0	249	249	0.0806220025	0.606913984	1.01945496	7.16529417	0.156517997	1589
30121	3	204	1	10000000	cplex	0	1	300	2	0	9	0	1	0	249	295	0.0063649998	0.00688999984	0.0135000004	0.0302329995	1.09888899	365
30122	3	204	1	10000000	cplex	1	0	284	11	1	9	0	1	0	249	295	0.0109069999	0.00495800003	0.0114719998	0.0245229993	1.05748606	1008
30123	3	204	1	10000000	cplex	1	1	284	3	2	9	0	1	0	249	295	0.011159	0.00371000008	0.00703899981	0.0183189996	1.06834698	540
30124	3	204	1	10000000	cplex	0	0	300	11	3	9	0	1	0	249	295	0.0089499997	0.00808699988	0.0205419995	0.0394309983	1.06132102	738
30125	3	204	1	10000000	cplex	1	1	284	1	4	9	0	1	0	249	295	0.0115569998	0.00372499996	0.00637499988	0.0361099988	1.05866694	207
30126	3	205	1	10000000	cplex	0	1	300	2	0	6	0	1	0	249	295	0.00603799988	0.0045429999	0.00908000022	0.0307429992	1.02197397	243
30127	3	205	1	10000000	cplex	1	0	284	11	1	6	0	1	0	249	295	0.0102049997	0.00350399991	0.00779600022	0.0211270005	1.12113297	672
30128	3	205	1	10000000	cplex	1	1	284	3	2	6	0	1	0	249	295	0.0101990001	0.00282400008	0.00507699978	0.0186059996	1.053653	360
30129	3	205	1	10000000	cplex	0	0	300	11	3	6	0	1	0	249	295	0.00552800018	0.0057839998	0.014006	0.0299180001	1.087116	492
30130	3	205	1	10000000	cplex	1	1	284	1	4	6	0	1	0	249	295	0.0100410003	0.0026430001	0.00431500003	0.034322001	1.04412103	138
30133	3	206	1	10000000	cplex	1	1	284	3	2	21	0	1	0	249	295	0.0148910005	0.00874499977	0.0161910001	0.0198909994	1.04350603	1260
30134	3	206	1	10000000	cplex	0	0	300	11	3	21	0	1	0	249	295	0.0162649993	0.0182179995	0.0476769991	0.049904	1.04931402	1722
30135	3	206	1	10000000	cplex	1	1	284	1	4	21	0	1	0	249	295	0.0113500003	0.00812899973	0.0139009999	0.0527089983	1.06488705	483
30136	3	207	1	10000000	cplex	0	1	300	4	0	92	0	1	0	249	249	0.336358011	6.65871906	11.6991844	104.169907	0.320625991	33406
30137	3	207	1	10000000	cplex	1	0	284	11	1	92	0	1	0	249	249	0.259077013	6.64066315	14.848321	106.038177	0.325033993	55340
30138	3	207	1	10000000	cplex	1	1	284	4	2	92	0	1	0	249	249	0.297897995	5.78578997	10.7393608	101.042259	0.310555011	37715
30139	3	207	1	10000000	cplex	0	0	300	11	3	92	0	1	0	249	249	0.426173002	6.91582298	16.2584515	111.789841	0.318690002	49864
30140	3	207	1	10000000	cplex	1	1	284	1	4	92	0	1	0	249	249	0.406538993	4.77217817	8.63423634	107.208557	0.349684	13290
30141	3	208	1	10000000	cplex	0	1	300	4	0	39	0	1	0	249	249	0.204559997	2.48345208	4.93469715	24.4092751	0.203849003	14161
30142	3	208	1	10000000	cplex	1	0	284	11	1	39	0	1	0	249	249	0.167544007	2.67753601	6.43124485	24.8861408	0.195924997	23459
30143	3	208	1	10000000	cplex	1	1	284	4	2	39	0	1	0	249	249	0.158711001	2.41268706	4.66200876	22.2276154	0.192689002	15988
30144	3	208	1	10000000	cplex	0	0	300	11	3	39	0	1	0	249	249	0.205138996	3.05340409	7.06865597	26.4649773	0.215913996	21138
30145	3	208	1	10000000	cplex	1	1	284	1	4	39	0	1	0	249	249	0.137306005	2.0219419	3.54789305	33.9171181	0.253991991	5634
30146	3	209	1	10000000	cplex	0	1	300	2	0	5	0	1	0	249	295	0.00425300002	0.003241	0.0069670002	0.0212600008	1.04595399	203
30147	3	209	1	10000000	cplex	1	0	284	11	1	5	0	1	0	249	295	0.0647170022	0.002629	0.00636600005	0.0161789991	1.06973195	560
30148	3	209	1	10000000	cplex	1	1	284	3	2	5	0	1	0	249	295	0.00923999958	0.00203399989	0.00399600016	0.0114270002	1.42337406	300
30149	3	209	1	10000000	cplex	0	0	300	11	3	5	0	1	0	249	295	0.00595699996	0.00483299978	0.0116959997	0.0255210008	1.07073796	410
30150	3	209	1	10000000	cplex	1	1	284	1	4	5	0	1	0	249	295	0.00910300016	0.0021879999	0.00362999993	0.0268440004	1.12683904	115
30153	3	210	1	10000000	cplex	0	1	300	7	0	97	97	0	0	199		1.81105006	267.835754	499.546906	3899.26343	0	258099
30154	3	210	1	10000000	cplex	1	0	221	11	1	97	97	0	0	199		1.31736302	257.860596	509.859985	3877.3186	0	366494
30201	5	300	1	10000000	cplex	0	1	300	2	0	37	0	1	0	299	299	0.0249799993	0.0283150002	0.021621	0.0148480004	0.875777006	555
30202	5	300	1	10000000	cplex	1	0	290	11	1	37	0	1	0	299	299	0.0106619997	0.0105389999	0.0158580001	0.0141979996	0.666119993	1554
30203	5	300	1	10000000	cplex	1	1	290	2	2	37	0	1	0	299	299	0.0110160001	0.00299800001	0.00453200005	0.00934199989	0.633369982	555
30204	5	300	1	10000000	cplex	0	0	300	11	3	37	0	1	0	299	299	0.00570600014	0.00376300002	0.00803999975	0.014978	0.617317975	1554
30205	5	300	1	10000000	cplex	1	1	290	1	4	37	0	1	0	299	299	0.00929300021	0.00378099992	0.00560599985	0.0257159993	0.625882983	314
30206	5	301	1	10000000	cplex	0	1	300	2	0	38	0	1	0	299	299	0.00602299999	0.00242800009	0.00403500022	0.011132	0.602100015	570
30207	5	301	1	10000000	cplex	1	0	290	11	1	38	0	1	0	299	299	0.00676999986	0.00413700007	0.00771099981	0.0142639996	0.591893971	1596
30208	5	301	1	10000000	cplex	1	1	290	2	2	38	0	1	0	299	299	0.00811500009	0.00211	0.00399699993	0.0112410001	0.606777012	570
30209	5	301	1	10000000	cplex	0	0	300	11	3	38	0	1	0	299	299	0.00555700017	0.00287800003	0.0076009999	0.015873	0.601633012	1596
30210	5	301	1	10000000	cplex	1	1	290	1	4	38	0	1	0	299	299	0.00777499983	0.001942	0.00479299994	0.0264819991	0.590233982	323
30211	5	302	1	10000000	cplex	0	1	300	2	0	28	0	1	0	299	299	0.00446100021	0.000971000001	0.00270000007	0.0100840004	0.955178976	420
30212	5	302	1	10000000	cplex	1	0	290	11	1	28	0	1	0	299	299	0.00630600005	0.00178100006	0.0054870001	0.0128680002	0.918991983	1176
30213	5	302	1	10000000	cplex	1	1	290	2	2	28	0	1	0	299	299	0.00676100003	0.00118400005	0.00267500011	0.00932800025	0.928943992	420
30214	5	302	1	10000000	cplex	0	0	300	11	3	28	0	1	0	299	299	0.00427300017	0.00152100006	0.00537100015	0.0127539998	1.11622298	1176
30215	5	302	1	10000000	cplex	1	1	290	1	4	28	0	1	0	299	299	0.00653199991	0.00123199995	0.00343100005	0.0192850009	0.942501009	238
30216	5	303	1	10000000	cplex	0	1	300	2	0	24	0	1	0	299	299	0.00445300015	0.000950000016	0.00227500009	0.00923599955	0.410728008	360
30217	5	303	1	10000000	cplex	1	0	290	11	1	24	0	1	0	299	299	0.006054	0.00162400003	0.0047129998	0.0102850003	0.401125014	1008
30218	5	303	1	10000000	cplex	1	1	290	2	2	24	0	1	0	299	299	0.00610100012	0.000775999972	0.00230100006	0.00784800015	0.380668998	360
30219	5	303	1	10000000	cplex	0	0	300	11	3	24	0	1	0	299	299	0.00345199998	0.00130700006	0.00470799999	0.0109179998	0.38825199	1008
30220	5	303	1	10000000	cplex	1	1	290	1	4	24	0	1	0	299	299	0.00568700023	0.00112599996	0.00308299996	0.0222929996	0.389458001	204
30221	5	304	1	10000000	cplex	0	1	300	2	0	25	0	1	0	299	299	0.00352400006	0.000885999994	0.00237799995	0.00860400032	0.766822994	375
30222	5	304	1	10000000	cplex	1	0	290	11	1	25	0	1	0	299	299	0.00658999989	0.00155799999	0.00492700003	0.0110449996	0.740235984	1050
30461	5	352	1	10000000	cplex	0	1	300	9	0	18	0	1	0	49	49	0.409208	31.1125641	72.3796921	231.436066	0.899802983	43365
30462	5	352	1	10000000	cplex	1	0	246	11	1	18	0	1	0	49	49	0.321559995	32.9173737	74.1212234	125.804565	0.909004986	55178
30463	5	352	1	10000000	cplex	1	1	246	10	2	18	0	1	0	49	49	0.347667009	31.4091072	71.075386	229.619904	0.903869987	52403
30223	5	304	1	10000000	cplex	1	1	290	2	2	25	0	1	0	299	299	0.0065779998	0.000899999985	0.00244399998	0.00808199961	0.731680989	375
30224	5	304	1	10000000	cplex	0	0	300	11	3	25	0	1	0	299	299	0.00362699991	0.00160900003	0.00490000006	0.0109510003	0.804504991	1050
30225	5	304	1	10000000	cplex	1	1	290	1	4	25	0	1	0	299	299	0.0061110002	0.000959999976	0.00309500005	0.0195579994	0.714080989	212
30226	5	305	1	10000000	cplex	0	1	300	2	0	27	0	1	0	299	299	0.00372599997	0.000773000007	0.00257700006	0.00900799967	0.160321996	405
30227	5	305	1	10000000	cplex	1	0	290	11	1	27	0	1	0	299	299	0.0055300002	0.00133400003	0.00527099986	0.0130230002	0.172169998	1134
30228	5	305	1	10000000	cplex	1	1	290	2	2	27	0	1	0	299	299	0.00652500009	0.000807999982	0.00264400011	0.0093790004	0.164572001	405
30229	5	305	1	10000000	cplex	0	0	300	11	3	27	0	1	0	299	299	0.00460200012	0.00128800003	0.00537199993	0.0120850001	0.163178995	1134
30230	5	305	1	10000000	cplex	1	1	290	1	4	27	0	1	0	299	299	0.00660699978	0.00123399997	0.00338599994	0.0205710009	0.157121003	229
30231	5	306	1	10000000	cplex	0	1	300	2	0	34	0	1	0	299	299	0.00461499998	0.000967999978	0.00334000005	0.0101349996	0.865922987	510
30232	5	306	1	10000000	cplex	1	0	290	11	1	34	0	1	0	299	299	0.00694999984	0.00203999993	0.00652199984	0.0140070003	0.852443993	1428
30233	5	306	1	10000000	cplex	1	1	290	2	2	34	0	1	0	299	299	0.00738100009	0.00115200004	0.00323099992	0.00939499959	0.883229017	510
30234	5	306	1	10000000	cplex	0	0	300	11	3	34	0	1	0	299	299	0.00531799998	0.00164499995	0.00650699995	0.0135690002	0.852905989	1428
30235	5	306	1	10000000	cplex	1	1	290	1	4	34	0	1	0	299	299	0.00671500014	0.00130400003	0.00410800008	0.0218499992	0.859329998	289
30236	5	307	1	10000000	cplex	0	1	300	2	0	23	0	1	0	299	299	0.00406400021	0.000670999987	0.00225699996	0.00946999993	0.247778997	345
30237	5	307	1	10000000	cplex	1	0	290	11	1	23	0	1	0	299	299	0.00609799987	0.00124999997	0.00461799977	0.011159	0.248668	966
30238	5	307	1	10000000	cplex	1	1	290	2	2	23	0	1	0	299	299	0.00527899992	0.00067899999	0.00226700003	0.00952100009	0.257476002	345
30239	5	307	1	10000000	cplex	0	0	300	11	3	23	0	1	0	299	299	0.001834	0.00116500002	0.00461900001	0.0121929999	0.256074011	966
30240	5	307	1	10000000	cplex	1	1	290	1	4	23	0	1	0	299	299	0.00565799978	0.00110500003	0.00292899995	0.0212580003	0.256803989	195
30241	5	308	1	10000000	cplex	0	1	300	2	0	26	0	1	0	299	299	0.00346000004	0.000752000022	0.00253900001	0.0101659996	0.866663992	390
30242	5	308	1	10000000	cplex	1	0	290	11	1	26	0	1	0	299	299	0.00666500023	0.00141499995	0.00520600006	0.011744	0.785582006	1092
30243	5	308	1	10000000	cplex	1	1	290	2	2	26	0	1	0	299	299	0.00587800005	0.00076700002	0.00250099995	0.00922700018	0.803838015	390
30244	5	308	1	10000000	cplex	0	0	300	11	3	26	0	1	0	299	299	0.00401999988	0.00136700005	0.00516999979	0.0112389997	0.771872997	1092
30245	5	308	1	10000000	cplex	1	1	290	1	4	26	0	1	0	299	299	0.00623100018	0.00120599999	0.00324700004	0.0204540007	0.783437014	221
30246	5	309	1	10000000	cplex	0	1	300	2	0	28	0	1	0	299	299	0.00458899979	0.000780000002	0.00272600004	0.0102939997	0.901914001	420
30247	5	309	1	10000000	cplex	1	0	290	11	1	28	0	1	0	299	299	0.00585100008	0.001651	0.00557899987	0.0120000001	0.894455016	1176
30248	5	309	1	10000000	cplex	1	1	290	2	2	28	0	1	0	299	299	0.00591100007	0.000789000012	0.00271299994	0.0100370003	0.910673022	420
30249	5	309	1	10000000	cplex	0	0	300	11	3	28	0	1	0	299	299	0.00373200001	0.00161599996	0.00558800017	0.011527	0.958697975	1176
30250	5	309	1	10000000	cplex	1	1	290	1	4	28	0	1	0	299	299	0.00621500006	0.00121300004	0.00348299998	0.0221929997	0.903138995	238
30251	5	310	1	10000000	cplex	0	1	300	6	0	22	0	1	0	274	274	0.0833889991	0.290818006	0.965197027	0.57555002	0.842517972	3946
30252	5	310	1	10000000	cplex	1	0	269	11	1	22	0	1	0	274	274	0.0143050002	0.0882380009	0.199532002	0.185819998	0.82339102	10897
30253	5	310	1	10000000	cplex	1	1	269	8	2	22	0	1	0	274	274	0.0144389998	0.0963009968	0.169635996	0.164109007	0.830025971	9144
30254	5	310	1	10000000	cplex	0	0	300	11	3	22	0	1	0	274	274	0.0873249993	0.472566992	1.00214005	0.873579979	0.844474018	6424
30255	5	310	1	10000000	cplex	1	1	269	1	4	22	22	0	0	274		0.0335210003	0.193458006	0.329537988	3.85427499	0.083972998	935
30256	5	311	1	10000000	cplex	0	1	300	5	0	33	0	1	0	274	274	0.0657889992	0.478350997	0.897881985	0.791785002	0.310290992	5698
30257	5	311	1	10000000	cplex	1	0	269	11	1	33	0	1	0	274	274	0.0157549996	0.275059015	0.285524994	0.279646009	0.311782002	16346
30258	5	311	1	10000000	cplex	1	1	269	8	2	33	0	1	0	274	274	0.0186420009	0.116769001	0.25850299	0.242919996	0.300974011	13717
30259	5	311	1	10000000	cplex	0	0	300	11	3	33	0	1	0	274	274	0.118915997	0.670404971	1.470065	1.28193903	0.372310996	9636
30260	5	311	1	10000000	cplex	1	1	269	1	4	33	33	0	0	274		0.0288919993	0.212376997	0.388345003	5.54196882	0.0793849975	1279
30261	5	312	1	10000000	cplex	0	1	300	5	0	24	0	1	0	274	274	0.0811839998	0.384306014	0.660565019	0.589429975	0.825330973	4144
30262	5	312	1	10000000	cplex	1	0	269	11	1	24	0	1	0	274	274	0.0149870003	0.0941739976	0.217237994	0.202009007	0.821340024	11888
30263	5	312	1	10000000	cplex	1	1	269	8	2	24	0	1	0	274	274	0.0122739999	0.0742160007	0.178324997	0.177187994	0.813687027	9976
30264	5	312	1	10000000	cplex	0	0	300	11	3	24	0	1	0	274	274	0.0893270001	0.465865999	1.09633994	0.929542005	0.815270007	7008
30265	5	312	1	10000000	cplex	1	1	269	1	4	24	24	0	0	274		0.0154929999	0.065839	0.120975003	2.01789904	0.0857980028	869
30266	5	313	1	10000000	cplex	0	1	300	5	0	22	0	1	0	274	274	0.0976829976	0.354658008	0.611716986	0.56188798	0.464542001	3799
30267	5	313	1	10000000	cplex	1	0	269	11	1	22	0	1	0	274	274	0.01143	0.0792580023	0.194319993	0.185835004	0.469336987	10897
30268	5	313	1	10000000	cplex	1	1	269	8	2	22	0	1	0	274	274	0.0138879996	0.0821830034	0.177652001	0.165380999	0.480812013	9144
30269	5	313	1	10000000	cplex	0	0	300	11	3	22	0	1	0	274	274	0.0680200011	0.480338991	0.994533002	0.859695017	0.474763989	6424
30270	5	313	1	10000000	cplex	1	1	269	1	4	22	22	0	0	274		0.04287	0.340981007	0.618956029	7.35386181	0.061900001	994
30271	5	314	1	10000000	cplex	0	1	300	5	0	26	0	1	0	274	274	0.0958790034	0.304845989	0.715043008	0.666042984	0.869655013	4490
30272	5	314	1	10000000	cplex	1	0	269	11	1	26	0	1	0	274	274	0.0158350002	0.105471	0.241148993	0.216414005	0.872780025	12878
30273	5	314	1	10000000	cplex	1	1	269	8	2	26	0	1	0	274	274	0.012898	0.0836799964	0.196785003	0.194137007	0.857773006	10807
30274	5	314	1	10000000	cplex	0	0	300	11	3	26	0	1	0	274	274	0.0783379972	0.58622998	1.16398096	1.00230503	0.877017021	7592
30275	5	314	1	10000000	cplex	1	1	269	1	4	26	26	0	0	274		0.0339320004	0.144861996	0.252992988	2.99433899	0.0703079998	1041
30276	5	315	1	10000000	cplex	0	1	300	5	0	23	0	1	0	274	274	0.110707998	0.28965801	0.648059011	0.602378011	0.893495023	3971
30277	5	315	1	10000000	cplex	1	0	269	11	1	23	0	1	0	274	274	0.0135709997	0.0806879997	0.204462007	0.193047002	0.892547011	11392
30278	5	315	1	10000000	cplex	1	1	269	8	2	23	0	1	0	274	274	0.0116699999	0.0711539984	0.174090996	0.175055996	0.913133025	9560
30279	5	315	1	10000000	cplex	0	0	300	11	3	23	0	1	0	274	274	0.0462910011	0.531270981	1.04430902	0.897625029	0.92345202	6716
30280	5	315	1	10000000	cplex	1	1	269	1	4	23	23	0	0	274		0.0347900018	0.140257999	0.25315401	2.91517401	0.0599800013	911
30281	5	316	1	10000000	cplex	0	1	300	5	0	19	0	1	0	274	274	0.0821549967	0.229314998	0.527899981	0.523738027	0.833925009	3281
30282	5	316	1	10000000	cplex	1	0	269	11	1	19	0	1	0	274	274	0.0127879996	0.0784609988	0.178884	0.161345005	0.829032004	9411
30283	5	316	1	10000000	cplex	1	1	269	8	2	19	0	1	0	274	274	0.010698	0.0635109991	0.144694999	0.145584002	0.837743998	7897
30284	5	316	1	10000000	cplex	0	0	300	11	3	19	0	1	0	274	274	0.0698280036	0.346453011	0.93494302	0.773549974	0.825905025	5548
30285	5	316	1	10000000	cplex	1	1	269	1	4	19	19	0	0	274		0.0258690007	0.147957996	0.267713994	3.65171409	0.0759090036	776
30286	5	317	1	10000000	cplex	0	1	300	5	0	18	0	1	0	274	274	0.0670379996	0.209525004	0.495705992	0.491479993	0.270155013	3108
30287	5	317	1	10000000	cplex	1	0	269	11	1	18	0	1	0	274	274	0.00990699977	0.0672169998	0.164210007	0.153597996	0.206808999	8916
30288	5	317	1	10000000	cplex	1	1	269	8	2	18	0	1	0	274	274	0.011957	0.067110002	0.146362007	0.142173007	0.195649996	7482
30289	5	317	1	10000000	cplex	0	0	300	11	3	18	0	1	0	274	274	0.0719309971	0.328442007	0.810006976	0.756707013	0.273355991	5256
30290	5	317	1	10000000	cplex	1	1	269	1	4	18	18	0	0	274		0.0132560004	0.0503779985	0.0969550014	1.37638104	0.0806189999	651
30291	5	318	1	10000000	cplex	0	1	300	5	0	25	0	1	0	274	274	0.112411998	0.325594991	0.724676013	0.612047017	0.499267012	4317
30292	5	318	1	10000000	cplex	1	0	269	11	1	25	0	1	0	274	274	0.0126400003	0.0882370025	0.222415999	0.209701002	0.49169901	12383
30293	5	318	1	10000000	cplex	1	1	269	8	2	25	0	1	0	274	274	0.0124350004	0.0773190036	0.190230995	0.187441006	0.484614015	10391
30294	5	318	1	10000000	cplex	0	0	300	11	3	25	0	1	0	274	274	0.0710610002	0.54410398	1.13607001	0.971067011	0.494197994	7300
30295	5	318	1	10000000	cplex	1	1	269	1	4	25	25	0	0	274		0.0291900001	0.150624007	0.272808999	3.21478605	0.0644000024	990
30296	5	319	1	10000000	cplex	0	1	300	5	0	17	0	1	0	274	274	0.0661789998	0.204238996	0.477452993	0.493377	0.46983999	2935
30297	5	319	1	10000000	cplex	1	0	269	11	1	17	0	1	0	274	274	0.0101110004	0.0618189983	0.153313994	0.149452999	0.467869997	8420
30298	5	319	1	10000000	cplex	1	1	269	8	2	17	0	1	0	274	274	0.00971200038	0.0573480017	0.133895993	0.133686006	0.581043005	7066
30299	5	319	1	10000000	cplex	0	0	300	11	3	17	0	1	0	274	274	0.0788690001	0.314096004	0.77609998	0.717456996	0.480659008	4964
30300	5	319	1	10000000	cplex	1	1	269	1	4	17	17	0	0	274		0.0351000018	0.148607999	0.267912	3.15370393	0.0727569982	704
30301	5	320	1	10000000	cplex	0	1	300	7	0	9	0	1	0	249	249	0.0874689966	0.544560015	1.25245094	1.57813597	1.901631	3916
30302	5	320	1	10000000	cplex	1	0	281	11	1	9	0	1	0	249	249	0.0415319987	0.513889015	1.28960001	1.40577602	1.93266904	6132
30303	5	320	1	10000000	cplex	1	1	281	8	2	9	0	1	0	249	249	0.0609739982	0.442741007	1.03601599	1.499614	1.82037604	5195
30304	5	320	1	10000000	cplex	0	0	300	11	3	9	0	1	0	249	249	0.0836180001	0.678277016	1.57090902	1.74665904	1.92336905	4878
30305	5	320	1	10000000	cplex	1	1	281	1	4	9	0	1	0	249	249	0.0547510013	0.158703998	0.27749899	2.91841888	1.96550798	440
30306	5	321	1	10000000	cplex	0	1	300	7	0	30	0	1	0	249	249	0.152695999	1.84142101	4.25896597	4.30455494	0.209202006	13152
30307	5	321	1	10000000	cplex	1	0	279	11	1	30	0	1	0	249	249	0.118309997	1.67459702	3.97669291	4.03020477	0.227096006	21420
30308	5	321	1	10000000	cplex	1	1	279	8	2	30	0	1	0	249	249	0.0874240026	1.47189903	3.54241896	3.68486094	0.244143993	18314
30309	5	321	1	10000000	cplex	0	0	300	11	3	30	0	1	0	249	249	0.195465997	2.38554692	5.11745501	4.92176819	0.210933998	16260
30310	5	321	1	10000000	cplex	1	1	279	1	4	30	30	0	0	249		0.32495901	3.17352104	5.75919199	34.2131348	0.0737570003	3755
30311	5	322	1	10000000	cplex	0	1	300	7	0	18	0	1	0	249	249	0.114270002	1.17342198	2.57235193	2.5866189	0.904220998	7832
30312	5	322	1	10000000	cplex	1	0	281	11	1	18	0	1	0	249	249	0.0560799986	1.10680497	2.45703197	2.44820595	0.886689007	12264
30313	5	322	1	10000000	cplex	1	1	281	8	2	18	0	1	0	249	249	0.0745859966	0.934850991	2.12141299	2.225209	0.895878017	10390
30314	5	322	1	10000000	cplex	0	0	300	11	3	18	0	1	0	249	249	0.0804369971	1.33082104	3.11801004	3.02856898	0.910076022	9756
30315	5	322	1	10000000	cplex	1	1	281	1	4	18	18	0	0	249		0.0910929963	0.248326004	0.447542995	2.73402095	0.0727950037	1230
30316	5	323	1	10000000	cplex	0	1	300	7	0	27	0	1	0	249	249	0.207623005	1.62145901	3.86660194	4.10733604	0.832238019	11749
30317	5	323	1	10000000	cplex	1	0	281	11	1	27	0	1	0	249	249	0.0846699998	1.52917099	3.67476702	3.62055302	0.834173977	18397
30318	5	323	1	10000000	cplex	1	1	281	8	2	27	0	1	0	249	249	0.0900970027	1.33824396	3.15736008	3.60411811	0.817130029	15585
30319	5	323	1	10000000	cplex	0	0	300	11	3	27	0	1	0	249	249	0.124137998	1.90462399	4.6284461	4.4274869	0.834031999	14634
30320	5	323	1	10000000	cplex	1	1	281	1	4	27	27	0	0	249		0.105659999	0.37906599	0.674103975	3.33691096	0.0709780008	1871
30321	5	324	1	10000000	cplex	0	1	300	7	0	19	0	1	0	249	249	0.146467999	1.17470706	2.763376	2.83671498	0.490354002	8392
30322	5	324	1	10000000	cplex	1	0	281	11	1	19	0	1	0	249	249	0.0769359991	1.05688202	2.63735294	2.5917449	0.475744009	12946
30323	5	324	1	10000000	cplex	1	1	281	8	2	19	0	1	0	249	249	0.066147998	0.974020004	2.22104597	2.37794089	0.461879998	10967
30324	5	324	1	10000000	cplex	0	0	300	11	3	19	0	1	0	249	249	0.0933620036	1.34269595	3.32610393	3.15020394	0.481346995	10298
30325	5	324	1	10000000	cplex	1	1	281	1	4	19	19	0	0	249		0.075176999	0.39815101	0.705693007	4.28793812	0.079787001	1253
30326	5	325	1	10000000	cplex	0	1	300	7	0	11	0	1	0	249	249	0.0840179995	0.723664999	1.59218204	1.77025604	1.34174597	4786
30327	5	325	1	10000000	cplex	1	0	281	11	1	11	0	1	0	249	249	0.03737	0.673879981	1.54298902	1.61035097	1.50160694	7495
30328	5	325	1	10000000	cplex	1	1	281	8	2	11	0	1	0	249	249	0.0584469996	0.578468025	1.31764197	1.52574205	1.76959395	6349
30329	5	325	1	10000000	cplex	0	0	300	11	3	11	0	1	0	249	249	0.0764710009	0.788755	1.90623999	1.99820697	1.42083299	5962
30330	5	325	1	10000000	cplex	1	1	281	1	4	11	0	1	0	249	249	0.0585430004	0.114831001	0.213063002	1.23333895	1.14154005	697
30331	5	326	1	10000000	cplex	0	1	300	7	0	15	0	1	0	249	249	0.0894329995	0.969696999	2.13213897	2.21610093	0.892234027	6527
30332	5	326	1	10000000	cplex	1	0	281	11	1	15	0	1	0	249	249	0.0490569994	0.846351981	2.06387901	2.0707829	0.894946992	10220
30333	5	326	1	10000000	cplex	1	1	281	8	2	15	0	1	0	249	249	0.0420389995	0.776881993	1.77087903	1.86487997	0.896525979	8658
30334	5	326	1	10000000	cplex	0	0	300	11	3	15	0	1	0	249	249	0.110297002	1.081622	2.59549689	2.49693394	0.886049986	8130
30335	5	326	1	10000000	cplex	1	1	281	1	4	15	15	0	0	249		0.0876440033	0.212046996	0.379016995	2.2247541	0.0802780017	1025
30336	5	327	1	10000000	cplex	0	1	300	7	0	21	0	1	0	249	249	0.145526007	1.73946202	3.12330389	3.36719608	0.903868973	9138
30337	5	327	1	10000000	cplex	1	0	281	11	1	21	0	1	0	249	249	0.0661590025	1.28954399	2.93032789	2.74973011	0.906033993	14308
30338	5	327	1	10000000	cplex	1	1	281	8	2	21	0	1	0	249	249	0.0929690003	1.12915003	2.55874896	2.58797407	0.93147397	12122
30339	5	327	1	10000000	cplex	0	0	300	11	3	21	0	1	0	249	249	0.148499995	1.54218602	3.69288802	3.46395206	0.915392995	11382
30340	5	327	1	10000000	cplex	1	1	281	1	4	21	21	0	0	249		0.142688006	0.252705991	0.455247998	1.33244395	0.0758320019	1419
30341	5	328	1	10000000	cplex	0	1	300	7	0	24	0	1	0	249	249	0.123847999	1.58299398	3.53575802	3.48327899	0.206839994	10601
30342	5	328	1	10000000	cplex	1	0	281	11	1	24	0	1	0	249	249	0.116114996	1.34073699	3.32499194	3.27322793	0.220278993	16353
30343	5	328	1	10000000	cplex	1	1	281	8	2	24	0	1	0	249	249	0.125097007	1.18689096	2.90700698	2.926018	0.196930006	13854
30344	5	328	1	10000000	cplex	0	0	300	11	3	24	0	1	0	249	249	0.10791	2.14644289	4.25772476	3.98673511	0.200544	13008
30345	5	328	1	10000000	cplex	1	1	281	1	4	24	24	0	0	249		0.117179997	0.562703013	1.02545094	7.44103384	0.0768740028	1575
30346	5	329	1	10000000	cplex	0	1	300	7	0	12	0	1	0	249	249	0.124505997	0.712584972	1.72600102	1.86838198	0.173659995	5221
30347	5	329	1	10000000	cplex	1	0	281	11	1	12	0	1	0	249	249	0.0410909988	0.737290978	1.68248904	1.71892202	0.183662996	8176
30348	5	329	1	10000000	cplex	1	1	281	8	2	12	0	1	0	249	249	0.0658779964	0.640953004	1.52156496	1.56480205	0.179764003	6927
30349	5	329	1	10000000	cplex	0	0	300	11	3	12	0	1	0	249	249	0.0836960003	0.919660985	2.20615411	2.12495589	0.180631995	6504
30350	5	329	1	10000000	cplex	1	1	281	1	4	12	0	1	0	249	249	0.0659789965	0.124675997	0.238882005	1.267223	0.167218	760
30351	5	330	1	10000000	cplex	0	1	300	9	0	18	4	1	0.222222	199	199	0.218270004	4.85958099	11.3525219	14.6101694	0.941582978	17334
30352	5	330	1	10000000	cplex	1	0	246	11	1	18	4	1	0.222222	199	199	0.0940200016	3.48475099	8.24709415	10.0401506	0.964017987	27227
30353	5	330	1	10000000	cplex	1	1	246	10	2	18	4	1	0.222222	199	199	0.0775519982	3.76891088	8.16148186	11.4281874	0.95442301	25849
30354	5	330	1	10000000	cplex	0	0	300	11	3	18	4	1	0.222222	199	199	0.205602005	5.12386322	12.5280495	13.4356833	0.937743008	18756
30355	5	330	1	10000000	cplex	1	1	246	1	4	18	18	0	0	199		0.180673003	0.904852986	1.61140704	10.6671743	0.0780690014	1826
30356	5	331	1	10000000	cplex	0	1	300	9	0	19	4	1	0.210526004	199	199	0.179124996	5.08931303	11.9976864	15.5969801	0.926082015	18297
30357	5	331	1	10000000	cplex	1	0	246	11	1	19	4	1	0.210526004	199	199	0.0983429998	3.54130006	8.75660038	10.5611916	0.915669978	28740
30358	5	331	1	10000000	cplex	1	1	246	10	2	19	4	1	0.210526004	199	199	0.106829002	3.9180541	8.27967739	12.3323908	0.918772995	27286
30359	5	331	1	10000000	cplex	0	0	300	11	3	19	4	1	0.210526004	199	199	0.198097005	5.38027382	13.3675423	14.1897974	0.921359003	19798
30360	5	331	1	10000000	cplex	1	1	246	1	4	19	19	0	0	199		0.162861004	0.727325976	1.21047401	7.48849583	0.0803309977	1767
30361	5	332	1	10000000	cplex	0	1	300	9	0	20	0	1	0	199	199	0.217207998	5.59978294	13.2521572	15.9194136	0.878310978	19260
30362	5	332	1	10000000	cplex	1	0	246	11	1	20	0	1	0	199	199	0.0880879983	4.52540398	9.5723753	11.0338821	0.898118019	30252
30363	5	332	1	10000000	cplex	1	1	246	10	2	20	0	1	0	199	199	0.124454997	3.82730794	9.17318726	12.5189714	0.907046974	28722
30364	5	332	1	10000000	cplex	0	0	300	11	3	20	0	1	0	199	199	0.228948995	5.75620222	14.2703695	14.8760071	0.879712999	20840
30365	5	332	1	10000000	cplex	1	1	246	1	4	20	20	0	0	199		0.195279002	1.17918897	2.05955291	12.1804256	0.0707169995	2186
30366	5	333	1	10000000	cplex	0	1	300	9	0	39	4	1	0.102564	199	199	0.868041992	10.2915878	25.5389309	34.1563301	0.957289994	37980
30367	5	333	1	10000000	cplex	1	0	246	11	1	39	4	1	0.102564	199	199	0.155790001	7.96756887	18.4152527	23.6590347	0.926495016	58992
30368	5	333	1	10000000	cplex	1	1	246	10	2	39	4	1	0.102564	199	199	0.158114001	7.26664495	17.6440239	27.1765194	0.917779028	56008
30369	5	333	1	10000000	cplex	0	0	300	11	3	39	4	1	0.102564	199	199	0.323973	10.9416218	27.2481232	31.2136078	0.915629983	40638
30370	5	333	1	10000000	cplex	1	1	246	1	4	39	39	0	0	199		0.347521007	1.83430099	3.38136697	16.3229961	0.0907730013	4018
30371	5	334	1	10000000	cplex	0	1	300	9	0	23	0	1	0	199	199	0.176891997	6.25941706	14.7586699	18.6198406	0.901582003	22197
30372	5	334	1	10000000	cplex	1	0	246	11	1	23	0	1	0	199	199	0.103789002	4.41252613	10.7292852	13.0045967	0.881556988	34790
30373	5	334	1	10000000	cplex	1	1	246	10	2	23	0	1	0	199	199	0.0865600035	4.29106188	10.3313742	14.7339706	0.879339993	33030
30374	5	334	1	10000000	cplex	0	0	300	11	3	23	0	1	0	199	199	0.173981994	6.510952	16.0119019	17.5789776	0.870815992	23966
30375	5	334	1	10000000	cplex	1	1	246	1	4	23	23	0	0	199		0.175960004	2.38877511	4.11495113	27.8399696	0.0661749989	2404
30376	5	335	1	10000000	cplex	0	1	300	9	0	23	0	1	0	199	199	0.235780001	6.86177778	15.0330076	18.8089256	0.170322999	22197
30377	5	335	1	10000000	cplex	1	0	246	11	1	23	0	1	0	199	199	0.0966480002	4.44979	10.7125645	12.9097166	0.166197002	34790
30378	5	335	1	10000000	cplex	1	1	246	10	2	23	0	1	0	199	199	0.0897900015	4.33135509	10.2368336	14.6533699	0.171230003	33030
30379	5	335	1	10000000	cplex	0	0	300	11	3	23	0	1	0	199	199	0.196039006	6.53598499	15.8522882	17.2424564	0.181888998	23966
30380	5	335	1	10000000	cplex	1	1	246	1	4	23	23	0	0	199		0.155000001	1.68577302	2.90137792	20.707922	0.0603299998	2114
30381	5	336	1	10000000	cplex	0	1	300	9	0	18	4	1	0.222222	199	199	0.233154997	5.08601093	11.7047148	14.6015568	0.910049975	17334
30382	5	336	1	10000000	cplex	1	0	246	11	1	18	4	1	0.222222	199	199	0.105691001	3.53095388	8.41709328	9.89811611	0.891498029	27227
30383	5	336	1	10000000	cplex	1	1	246	10	2	18	4	1	0.222222	199	199	0.0837469995	3.40366602	8.00750542	11.4218597	0.904920995	25849
30384	5	336	1	10000000	cplex	0	0	300	11	3	18	4	1	0.222222	199	199	0.172877997	5.08500814	12.3006535	13.5137844	0.893575013	18756
30385	5	336	1	10000000	cplex	1	1	246	1	4	18	18	0	0	199		0.186777994	0.918982029	1.60571504	12.7122574	0.0790000036	1831
30386	5	337	1	10000000	cplex	0	1	300	9	0	18	4	1	0.222222	199	199	0.255943	5.01984406	11.5972652	14.6493769	0.908918977	17334
30387	5	337	1	10000000	cplex	1	0	246	11	1	18	4	1	0.222222	199	199	0.0979000032	3.482342	8.34622002	9.95308399	0.904007971	27227
30388	5	337	1	10000000	cplex	1	1	246	10	2	18	4	1	0.222222	199	199	0.113812	3.42864108	8.03328133	11.5392113	0.907001972	25849
30389	5	337	1	10000000	cplex	0	0	300	11	3	18	4	1	0.222222	199	199	0.224574998	5.08088493	12.3630924	13.6832848	0.918374002	18756
30390	5	337	1	10000000	cplex	1	1	246	1	4	18	18	0	0	199		0.149893999	0.59573102	1.05731106	6.18752909	0.083968997	1634
30391	5	338	1	10000000	cplex	0	1	300	9	0	17	0	1	0	199	199	0.205953002	4.83703518	11.0298786	14.0102606	0.869256973	16520
30392	5	338	1	10000000	cplex	1	0	246	11	1	17	0	1	0	199	199	0.0829270035	3.36695099	7.98706102	9.52659988	0.87301302	25714
30393	5	338	1	10000000	cplex	1	1	246	10	2	17	0	1	0	199	199	0.0911040008	3.92250395	7.62107897	10.8690939	0.873268008	24413
30394	5	338	1	10000000	cplex	0	0	300	11	3	17	0	1	0	199	199	0.177440003	4.80285692	11.7551098	12.9991531	0.853182971	17714
30395	5	338	1	10000000	cplex	1	1	246	1	4	17	0	1	0	199	199	0.149839997	0.275896996	0.454068005	1.13129795	0.8653	1153
30396	5	339	1	10000000	cplex	0	1	300	9	0	29	4	1	0.137931004	199	199	0.261319011	8.02254105	19.0090694	25.0569534	0.889268994	28181
30397	5	339	1	10000000	cplex	1	0	246	11	1	29	4	1	0.137931004	199	199	0.118761003	5.79988384	13.6555119	17.2625542	0.87451601	43866
30398	5	339	1	10000000	cplex	1	1	246	10	2	29	4	1	0.137931004	199	199	0.135930002	5.49361897	13.9569292	19.8342838	0.885321021	41647
30399	5	339	1	10000000	cplex	0	0	300	11	3	29	4	1	0.137931004	199	199	0.250373006	8.24686146	20.0073147	22.6831627	0.882350028	30218
30400	5	339	1	10000000	cplex	1	1	246	1	4	29	4	1	0.137931004	199	199	0.259418011	0.452600002	0.82356602	1.67820895	0.861862004	1967
30401	5	340	1	10000000	cplex	0	1	300	9	0	30	0	1	0	99	99	0.541966975	34.1574059	78.1321259	188.862549	0.922904015	57935
30402	5	340	1	10000000	cplex	1	0	246	11	1	30	0	1	0	99	99	0.326546013	31.9661751	74.9359894	137.751556	0.908643007	76794
30403	5	340	1	10000000	cplex	1	1	246	10	2	30	0	1	0	99	99	0.373443007	30.5956764	71.0238724	179.917038	0.890734017	72927
30404	5	340	1	10000000	cplex	0	0	300	11	3	30	0	1	0	99	99	0.440171987	35.2869034	81.7468948	142.225983	0.882938027	61260
30405	5	340	1	10000000	cplex	1	1	246	1	4	30	46	0	0.533333004	99	255	0.0237709992	0.0243469998	0.0423489995	0.116145998	0.189965993	1305
30406	5	341	1	10000000	cplex	0	1	300	9	0	23	0	1	0	99	99	0.456229001	26.1999855	59.5766983	130.028915	0.852253973	44417
30407	5	341	1	10000000	cplex	1	0	246	11	1	23	0	1	0	99	99	0.268976003	24.8210106	57.2630959	98.6923523	0.853322983	58875
30408	5	341	1	10000000	cplex	1	1	246	10	2	23	0	1	0	99	99	0.311859012	23.3072319	54.3396149	126.499306	0.85393101	55911
30409	5	341	1	10000000	cplex	0	0	300	11	3	23	0	1	0	99	99	0.366214991	28.1196785	61.585743	100.490875	0.873004973	46966
30410	5	341	1	10000000	cplex	1	1	246	1	4	23	39	0	0.695652008	99	255	0.0146909999	0.0170140006	0.0319389999	0.0755280033	0.282090008	1000
30411	5	342	1	10000000	cplex	0	1	300	9	0	21	0	1	0	99	99	0.431618005	23.020834	55.0271683	117.482857	0.960955977	40554
30412	5	342	1	10000000	cplex	1	0	246	11	1	21	0	1	0	99	99	0.240125	23.0833149	53.8348732	86.7244186	0.931569993	53756
30413	5	342	1	10000000	cplex	1	1	246	10	2	21	0	1	0	99	99	0.292109996	24.1600037	50.1575699	112.751846	0.938674986	51049
30414	5	342	1	10000000	cplex	0	0	300	11	3	21	0	1	0	99	99	0.472602993	23.9333839	57.4001007	91.3311996	0.932129025	42882
30415	5	342	1	10000000	cplex	1	1	246	1	4	21	21	0	0	99		0.154207006	1.22272003	2.01418209	9.05304718	0.0761540011	2276
30416	5	343	1	10000000	cplex	0	1	300	9	0	34	0	1	0	99	99	0.506476998	38.2955284	87.8138962	220.050781	0.808883011	65853
30417	5	343	1	10000000	cplex	1	0	246	11	1	34	0	1	0	99	99	0.335611999	36.6210823	85.0397034	161.495483	0.796261013	87033
30418	5	343	1	10000000	cplex	1	1	246	10	2	34	0	1	0	99	99	0.461396992	34.9378586	82.1940842	218.605377	0.775022984	82651
30419	5	343	1	10000000	cplex	0	0	300	11	3	34	0	1	0	99	99	0.480661988	38.7043686	91.71978	164.520248	0.791037023	69428
30420	5	343	1	10000000	cplex	1	1	246	1	4	34	34	0	0	99		0.258769006	2.49880099	4.41883516	26.4481564	0.0605340004	3495
30421	5	344	1	10000000	cplex	0	1	300	9	0	23	0	1	0	99	99	0.432711005	26.3786392	59.9418182	135.922775	0.345892996	44417
30422	5	344	1	10000000	cplex	1	0	246	11	1	23	0	1	0	99	99	0.257867008	24.2506618	58.4581757	99.7185364	0.356234998	58875
30423	5	344	1	10000000	cplex	1	1	246	10	2	23	0	1	0	99	99	0.313199013	22.8940811	55.4601059	131.811035	0.341858	55911
30424	5	344	1	10000000	cplex	0	0	300	11	3	23	0	1	0	99	99	0.388372004	26.2490273	62.7807961	102.432388	0.381604999	46966
30425	5	344	1	10000000	cplex	1	1	246	1	4	23	39	0	0.695652008	99	255	0.0160990003	0.0183940008	0.0317890011	0.0796450004	0.282471001	1000
30426	5	345	1	10000000	cplex	0	1	300	9	0	31	0	1	0	99	99	0.48873201	34.5898399	79.8984299	193.206924	0.871511996	59929
30427	5	345	1	10000000	cplex	1	0	246	11	1	31	0	1	0	99	99	0.313847989	33.2295265	78.9288254	144.559296	0.891950011	79354
30428	5	345	1	10000000	cplex	1	1	246	10	2	31	0	1	0	99	99	0.350665003	33.7047691	74.3260193	185.263229	0.915093005	75358
30429	5	345	1	10000000	cplex	0	0	300	11	3	31	0	1	0	99	99	0.500854015	36.8578529	85.446579	151.953766	0.896417975	63302
30430	5	345	1	10000000	cplex	1	1	246	1	4	31	31	0	0	99		0.228196993	1.622823	3.12015295	14.0328388	0.0750249997	3361
30431	5	346	1	10000000	cplex	0	1	300	9	0	28	0	1	0	99	99	0.48841399	32.0512047	73.522377	181.600311	0.907471001	54209
30432	5	346	1	10000000	cplex	1	0	246	11	1	28	0	1	0	99	99	0.310290992	29.2891827	70.1569061	124.318115	0.932968974	71675
30433	5	346	1	10000000	cplex	1	1	246	10	2	28	0	1	0	99	99	0.334962994	27.9070244	66.5970993	175.727615	0.909485996	68066
30434	5	346	1	10000000	cplex	0	0	300	11	3	28	0	1	0	99	99	0.423640013	32.6440773	75.2005768	129.122086	0.902283013	57176
30435	5	346	1	10000000	cplex	1	1	246	1	4	28	44	0	0.571429014	99	255	0.0213709995	0.0226240009	0.039797999	0.182511002	0.249329001	1218
30436	5	347	1	10000000	cplex	0	1	300	9	0	19	0	1	0	99	99	0.366807014	20.1606808	48.1593323	107.481277	0.811717987	36692
30437	5	347	1	10000000	cplex	1	0	246	11	1	19	0	1	0	99	99	0.227615997	20.159071	46.887558	78.4708176	0.799682021	48636
30438	5	347	1	10000000	cplex	1	1	246	10	2	19	0	1	0	99	99	0.259662986	19.4918728	45.0285378	104.413918	0.824778974	46187
30439	5	347	1	10000000	cplex	0	0	300	11	3	19	0	1	0	99	99	0.402393997	22.8921242	54.8788376	81.1853027	0.801438987	38798
30440	5	347	1	10000000	cplex	1	1	246	1	4	19	35	0	0.842104971	99	255	0.0167500004	0.015466	0.0267890003	0.0739409998	0.197327003	826
30441	5	348	1	10000000	cplex	0	1	300	9	0	22	0	1	0	99	99	0.430846006	23.7702084	57.8506165	128.62886	0.475584	42532
30442	5	348	1	10000000	cplex	1	0	246	11	1	22	0	1	0	99	99	0.262003988	23.342123	56.5209312	94.0422516	0.422477007	56316
30443	5	348	1	10000000	cplex	1	1	246	10	2	22	0	1	0	99	99	0.293191999	23.0243473	52.5629005	123.107491	0.429277003	53480
30444	5	348	1	10000000	cplex	0	0	300	11	3	22	0	1	0	99	99	0.361503989	23.536808	59.8254204	97.4226685	0.461699009	44924
30445	5	348	1	10000000	cplex	1	1	246	1	4	22	38	0	0.727272987	99	255	0.0102850003	0.0152470004	0.0316700004	0.100542001	0.25959301	957
30446	5	349	1	10000000	cplex	0	1	300	9	0	25	0	1	0	99	99	0.423424006	27.5290928	64.9103622	157.695892	0.810761988	48279
30447	5	349	1	10000000	cplex	1	0	246	11	1	25	0	1	0	99	99	0.255567014	25.4214211	62.4810944	111.571373	0.835093975	63995
30448	5	349	1	10000000	cplex	1	1	246	10	2	25	0	1	0	99	99	0.32673201	25.6071682	59.5867729	151.276566	0.816101015	60773
30449	5	349	1	10000000	cplex	0	0	300	11	3	25	0	1	0	99	99	0.40428701	30.1052361	69.8442383	116.230232	0.808697999	51050
30450	5	349	1	10000000	cplex	1	1	246	1	4	25	41	0	0.639999986	99	255	0.0153580001	0.0196819995	0.0352430008	0.113086	0.291285992	1087
30451	5	350	1	10000000	cplex	0	1	300	9	0	23	0	1	0	49	49	0.524232984	39.5022087	92.7142334	233.910172	0.278369993	55426
30452	5	350	1	10000000	cplex	1	0	246	11	1	23	0	1	0	49	49	0.337897003	37.6754913	92.8965607	170.282532	0.258736998	70505
30453	5	350	1	10000000	cplex	1	1	246	10	2	23	0	1	0	49	49	0.457334012	36.6149864	87.6878662	227.908539	0.284346014	66959
30454	5	350	1	10000000	cplex	0	0	300	11	3	23	0	1	0	49	49	0.507865012	41.8326912	97.172493	172.866486	0.236364007	58466
30455	5	350	1	10000000	cplex	1	1	246	1	4	23	39	0	0.695652008	49	255	0.0145479999	0.0160739999	0.0320720002	0.0413299985	0.185905993	1000
30456	5	351	1	10000000	cplex	0	1	300	9	0	19	0	1	0	49	49	0.467604011	34.0496521	78.5922318	181.227966	0.938313007	45744
30457	5	351	1	10000000	cplex	1	0	246	11	1	19	0	1	0	49	49	0.325982004	34.9356041	79.718399	129.788635	0.876787007	58243
30458	5	351	1	10000000	cplex	1	1	246	10	2	19	0	1	0	49	49	0.355374992	32.6229362	74.6126556	177.979965	0.895166993	55314
30459	5	351	1	10000000	cplex	0	0	300	11	3	19	0	1	0	49	49	0.52868402	37.4189987	84.0331116	135.410904	0.89716202	48298
30460	5	351	1	10000000	cplex	1	1	246	1	4	19	35	0	0.842104971	49	255	0.0167640001	0.0156479999	0.0266490001	0.046751	0.187205002	826
30464	5	352	1	10000000	cplex	0	0	300	11	3	18	0	1	0	49	49	0.429987013	39.5252647	78.3858643	131.173584	0.913429022	45756
30465	5	352	1	10000000	cplex	1	1	246	1	4	18	34	0	0.888889015	49	255	0.0147500001	0.0128079997	0.0253500007	0.0312130004	0.198026001	783
30466	5	353	1	10000000	cplex	0	1	300	9	0	24	0	1	0	49	49	0.509253979	41.1813774	98.2079926	236.80542	0.834590018	57782
30467	5	353	1	10000000	cplex	1	0	246	11	1	24	0	1	0	49	49	0.365565985	42.7120705	96.3681412	179.865814	0.809293985	73570
30468	5	353	1	10000000	cplex	1	1	246	10	2	24	0	1	0	49	49	0.376013994	39.2357864	92.0953064	231.089279	0.813510001	69870
30469	5	353	1	10000000	cplex	0	0	300	11	3	24	0	1	0	49	49	0.43621999	45.8123093	104.325821	188.223251	0.859076977	61008
30470	5	353	1	10000000	cplex	1	1	246	1	4	24	24	0	0	49		0.181649998	1.47159398	2.53943992	13.9142981	0.0828830004	2581
30474	5	355	1	10000000	cplex	0	1	300	9	0	25	0	1	0	49	49	0.533150017	40.4903717	90.4053192	247.04068	0.867615998	60246
30475	5	355	1	10000000	cplex	1	0	246	11	1	25	0	1	0	49	49	0.35689801	38.4339905	88.4307098	187.759506	0.835245013	76636
30476	5	355	1	10000000	cplex	1	1	246	10	2	25	0	1	0	49	49	0.433640987	38.6250648	84.5736313	245.482269	0.934356987	72781
30477	5	355	1	10000000	cplex	0	0	300	11	3	25	0	1	0	49	49	0.540117979	47.0015221	101.014915	195.915894	0.830660999	63550
30478	5	355	1	10000000	cplex	1	1	246	1	4	25	25	0	0	49		0.193151996	1.35334802	2.1080749	9.89348507	0.0850389972	2641
30479	5	356	1	10000000	cplex	0	1	300	9	0	23	0	1	0	49	49	0.525375009	41.2894249	86.1555023	237.620407	0.82188803	55374
30480	5	356	1	10000000	cplex	1	0	246	11	1	23	0	1	0	49	49	0.367496014	40.2547417	85.0814285	170.238815	0.837116003	70505
30481	5	356	1	10000000	cplex	1	1	246	10	2	23	0	1	0	49	49	0.422820985	38.6788063	80.1751709	234.366882	0.822224021	66959
30482	5	356	1	10000000	cplex	0	0	300	11	3	23	0	1	0	49	49	0.456102997	40.6027985	88.3865738	173.159485	0.887215018	58466
30483	5	356	1	10000000	cplex	1	1	246	1	4	23	23	0	0	49		0.230012	1.35523903	2.25914693	14.7117138	0.0863230005	2476
30484	5	357	1	10000000	cplex	0	1	300	9	0	21	0	1	0	49	49	0.494726986	34.9556694	77.4059677	207.569717	0.185127005	50543
30485	5	357	1	10000000	cplex	1	0	246	11	1	21	0	1	0	49	49	0.341221988	34.3606262	75.4463882	148.470703	0.183818996	64374
30486	5	357	1	10000000	cplex	1	1	246	10	2	21	0	1	0	49	49	0.357019007	33.1317558	72.1554337	202.617798	0.183070004	61136
30487	5	357	1	10000000	cplex	0	0	300	11	3	21	0	1	0	49	49	0.430806994	35.8125534	80.300621	154.361725	0.172091007	53382
30488	5	357	1	10000000	cplex	1	1	246	1	4	21	376	0	16.9047623	49	255	0.0141319996	0.0146040004	0.0268690009	0.0495200008	0.227484003	913
30489	5	358	1	10000000	cplex	0	1	300	9	0	25	0	1	0	49	49	0.522076011	41.8577118	91.7786026	250.547592	0.851288974	60246
30490	5	358	1	10000000	cplex	1	0	246	11	1	25	0	1	0	49	49	0.355437994	45.0231285	95.9121323	191.154404	0.833055019	76636
30491	5	358	1	10000000	cplex	1	1	246	10	2	25	0	1	0	49	49	0.439397007	40.2290993	89.0431671	243.08783	0.806159019	72781
30492	5	358	1	10000000	cplex	0	0	300	11	3	25	0	1	0	49	49	0.515751004	42.3716545	97.2333755	197.627808	0.828507006	63550
30493	5	358	1	10000000	cplex	1	1	246	1	4	25	25	0	0	49		0.238002002	1.26800394	2.11405206	10.4678707	0.0625709966	2641
30494	5	359	1	10000000	cplex	0	1	300	9	0	19	0	1	0	49	49	0.435945988	34.3566322	71.4889526	220.638321	0.608642995	45836
30495	5	359	1	10000000	cplex	1	0	246	11	1	19	0	1	0	49	49	0.286413014	33.1825066	72.4602814	133.37413	0.607312024	58243
30496	5	359	1	10000000	cplex	1	1	246	10	2	19	0	1	0	49	49	0.340539008	31.6541367	66.5715408	216.103729	0.599934995	55314
30497	5	359	1	10000000	cplex	0	0	300	11	3	19	0	1	0	49	49	0.408611	35.0680237	75.2122116	136.442139	0.605479002	48298
30498	5	359	1	10000000	cplex	1	1	246	1	4	19	35	0	0.842104971	49	255	0.0151429996	0.0149699999	0.025649	0.050590001	0.206161007	826
30499	5	354	1	10000000	cplex	0	1	300	10	0	28	6	1	0.214286	49	49	0.585051	44.1760292	102.741364	288.305573	0.925355971	67592
30500	5	354	1	10000000	cplex	1	0	246	11	1	28	6	1	0.214286	49	49	0.393878013	42.9437027	101.901543	212.450607	0.898238003	85832
30501	5	354	1	10000000	cplex	1	1	246	10	2	28	6	1	0.214286	49	49	0.431629002	42.7292824	97.3528595	286.147491	0.895139992	81515
30502	5	354	1	10000000	cplex	0	0	300	11	3	28	6	1	0.214286	49	49	0.557640016	46.0159798	107.599892	217.812653	1.02372801	71176
30503	5	354	1	10000000	cplex	1	1	246	1	4	28	28	0	0	49		0.383204013	4.36537695	7.37838316	53.430069	0.248495996	4468
30504	6	360	1	10000000	cplex	0	1	300	3	0	6	0	1	0	299	299	0.0169750005	0.0150359999	0.00697899982	0.0333009996	0.390543997	120
30505	6	360	1	10000000	cplex	1	0	295	11	1	6	0	1	0	299	299	0.0170670003	0.00338599994	0.00439999998	0.0419799984	0.727376997	264
30506	6	360	1	10000000	cplex	1	1	295	3	2	6	0	1	0	299	299	0.0151490001	0.00234299991	0.00255300011	0.0294959992	0.352299988	120
30507	6	360	1	10000000	cplex	0	0	300	11	3	6	0	1	0	299	299	0.00279000006	0.00238600001	0.00344299991	0.0276810005	0.854557991	264
30508	6	360	1	10000000	cplex	1	1	295	1	4	6	49	0.666666985	7.83333302	299	299	0.0135019999	0.00141999999	0.00230800011	0.0161550008	0.195969	57
30509	6	361	1	10000000	cplex	0	1	300	3	0	16	4	1	0.25	299	299	0.00314399996	0.0023060001	0.00323299994	0.0625239983	1.40740597	320
30510	6	361	1	10000000	cplex	1	0	295	11	1	16	4	1	0.25	299	299	0.00967099983	0.00209899992	0.00390799996	0.0727180019	1.39760303	704
30511	6	361	1	10000000	cplex	1	1	295	3	2	16	4	1	0.25	299	299	0.00920899957	0.00139400002	0.00256699999	0.0480390005	1.43801606	320
30512	6	361	1	10000000	cplex	0	0	300	11	3	16	4	1	0.25	299	299	0.00381299993	0.00158299995	0.00343700009	0.282059997	1.46140504	704
30513	6	361	1	10000000	cplex	1	1	295	1	4	16	471	0.25	28.6875	299	299	0.00877500046	0.00190100004	0.00267000007	0.255589992	0.451380998	152
30514	6	362	1	10000000	cplex	0	1	300	3	0	12	0	1	0	299	299	0.00307799992	0.00105600001	0.00171400001	0.264288008	0.208182007	240
30515	6	362	1	10000000	cplex	1	0	295	11	1	12	0	1	0	299	299	0.00868100021	0.00144200004	0.00270899991	0.184798002	0.182338998	528
30516	6	362	1	10000000	cplex	1	1	295	3	2	12	0	1	0	299	299	0.00823399983	0.000907999987	0.00170499994	0.0554829985	0.197763994	240
30517	6	362	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.00255699991	0.001345	0.00269400002	0.340115994	0.187304005	528
30518	6	362	1	10000000	cplex	1	1	295	1	4	12	66	0.333332986	4.83333302	299	299	0.00824800041	0.00152499997	0.00217300002	0.0184620004	0.175845996	114
30519	6	363	1	10000000	cplex	0	1	300	3	0	6	0	1	0	299	299	0.00160099997	0.000600999978	0.000998000032	0.0301329996	1.40254498	120
30520	6	363	1	10000000	cplex	1	0	295	11	1	6	0	1	0	299	299	0.00735899992	0.000613000011	0.00153999997	0.106260002	1.27802396	264
30521	6	363	1	10000000	cplex	1	1	295	3	2	6	0	1	0	299	299	0.00729200011	0.000430999993	0.000986000057	0.0196499992	1.27588499	120
30522	6	363	1	10000000	cplex	0	0	300	11	3	6	0	1	0	299	299	0.00154900004	0.000456999987	0.00153400004	0.0224149991	1.36101902	264
30523	6	363	1	10000000	cplex	1	1	295	1	4	6	536	0.666666985	89	299	299	0.0074169999	0.000639999984	0.00150100002	0.0331760012	0.439303994	57
30524	6	364	1	10000000	cplex	0	1	300	3	0	12	0	1	0	299	299	0.00276200008	0.000686999992	0.00169099995	0.0792969987	0.318697989	240
30525	6	364	1	10000000	cplex	1	0	295	11	1	12	0	1	0	299	299	0.00825800002	0.000996000017	0.00269500003	0.178065002	0.314112991	528
30526	6	364	1	10000000	cplex	1	1	295	3	2	12	0	1	0	299	299	0.00797399972	0.000656999997	0.00168999995	0.0328250006	0.311349005	240
30527	6	364	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.00223700004	0.000816999993	0.00270999991	0.103363	0.307442009	528
30528	6	364	1	10000000	cplex	1	1	295	1	4	12	137	0.333332986	10.75	299	299	0.00802799966	0.00101500005	0.00276400009	0.0641489998	0.607618988	114
30529	6	365	1	10000000	cplex	0	1	300	3	0	8	0	1	0	299	299	0.00181599997	0.000406000006	0.00125299999	0.316343993	0.450002998	160
30530	6	365	1	10000000	cplex	1	0	295	11	1	8	0	1	0	299	299	0.00756100006	0.000584999972	0.00202000001	0.0312720016	0.436569005	352
30531	6	365	1	10000000	cplex	1	1	295	3	2	8	0	1	0	299	299	0.007522	0.000403999991	0.00124100002	0.0283850003	0.437878013	160
30532	6	365	1	10000000	cplex	0	0	300	11	3	8	0	1	0	299	299	0.00170799997	0.00057600002	0.00194099999	0.0856719986	0.420255989	352
30533	6	365	1	10000000	cplex	1	1	295	1	4	8	175	0.5	21.375	299	299	0.00829800032	0.000617999991	0.00185	0.0151749998	0.321392	76
30534	6	366	1	10000000	cplex	0	1	300	3	0	9	4	1	0.444444001	299	299	0.00188500003	0.000444000005	0.00132299995	0.0374700017	1.751755	180
30535	6	366	1	10000000	cplex	1	0	295	11	1	9	4	1	0.444444001	299	299	0.0080380002	0.000838999986	0.00224300008	0.0363489985	1.96498096	396
30536	6	366	1	10000000	cplex	1	1	295	3	2	9	4	1	0.444444001	299	299	0.00736099994	0.00042299999	0.00136300002	0.0423579998	1.58894598	180
30537	6	366	1	10000000	cplex	0	0	300	11	3	9	4	1	0.444444001	299	299	0.00227000006	0.000708999985	0.00222899998	0.0387489982	1.38354897	396
30538	6	366	1	10000000	cplex	1	1	295	1	4	9	537	0.444444001	59.1111107	299	299	0.00678399997	0.000595999998	0.00164799998	0.367062986	0.426683992	85
30539	6	367	1	10000000	cplex	0	1	300	3	0	5	0	1	0	299	299	0.00142800005	0.000253000006	0.000846999988	0.0125209996	0.165300995	100
30540	6	367	1	10000000	cplex	1	0	295	11	1	5	0	1	0	299	299	0.00685099978	0.000421000004	0.00130300003	0.0121309999	0.172909006	220
30541	6	367	1	10000000	cplex	1	1	295	3	2	5	0	1	0	299	299	0.00676399982	0.000258999993	0.000837000029	0.0115660001	0.170876995	100
30542	6	367	1	10000000	cplex	0	0	300	11	3	5	0	1	0	299	299	0.00156700006	0.000289999996	0.001299	0.0122910002	0.258673012	220
30543	6	367	1	10000000	cplex	1	1	295	1	4	5	18	0.800000012	3.4000001	299	299	0.00704200007	0.000386	0.00100799999	0.0145939998	0.155809999	47
30544	6	368	1	10000000	cplex	0	1	300	3	0	12	0	1	0	299	299	0.00218100008	0.000522000017	0.00171600003	0.347483009	1.49203598	240
30545	6	368	1	10000000	cplex	1	0	295	11	1	12	0	1	0	299	299	0.00773400022	0.000872000004	0.00282100006	0.0568079986	1.83738005	528
30546	6	368	1	10000000	cplex	1	1	295	3	2	12	0	1	0	299	299	0.00831499975	0.000630999974	0.00169299997	0.168625996	1.30166101	240
30547	6	368	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.0022760001	0.000939999998	0.00281199999	0.039551001	1.47377002	528
30548	6	368	1	10000000	cplex	1	1	295	1	4	12	293	0.333332986	23.75	299	299	0.00796800014	0.000852000026	0.00200899993	0.0183949992	0.416568995	114
30549	6	369	1	10000000	cplex	0	1	300	3	0	6	0	1	0	299	299	0.00140399998	0.000279	0.000971000001	0.0291830003	1.28880501	120
30550	6	369	1	10000000	cplex	1	0	295	11	1	6	0	1	0	299	299	0.00699299993	0.000429000007	0.00153699995	0.0241739992	1.75045896	264
30551	6	369	1	10000000	cplex	1	1	295	3	2	6	0	1	0	299	299	0.00688700005	0.000308999995	0.000960999983	0.0273320004	1.73208106	120
30552	6	369	1	10000000	cplex	0	0	300	11	3	6	0	1	0	299	299	0.00168400002	0.000333000004	0.00184499996	0.0311239995	1.63213301	264
30553	6	369	1	10000000	cplex	1	1	295	1	4	6	379	0.666666985	62.8333321	299	299	0.00725799985	0.000499000016	0.00116400002	0.0148499999	0.426643997	57
30554	6	370	1	10000000	cplex	0	1	300	7	0	16	0	1	0	274	274	0.0889509991	0.380438	0.706106007	0.698045015	0.259750009	4317
30555	6	370	1	10000000	cplex	1	0	293	11	1	16	0	1	0	274	274	0.0428449996	0.49298501	0.755837023	0.725305974	0.382766992	6089
30556	6	370	1	10000000	cplex	1	1	293	8	2	16	0	1	0	274	274	0.0667859986	0.367639005	0.698637009	0.664085984	0.295419991	5337
30557	6	370	1	10000000	cplex	0	0	300	11	3	16	0	1	0	274	274	0.0611310005	0.411684006	0.826445997	0.792189002	0.333247989	5104
30558	6	370	1	10000000	cplex	1	1	293	1	4	16	16	0	0	274		0.611424029	18.4727535	30.1256771	378.213531	0	4661
30559	6	371	1	10000000	cplex	0	1	300	7	0	15	0	1	0	274	274	0.0724629983	0.357953012	0.691805005	0.680423975	0.191324994	4047
30560	6	371	1	10000000	cplex	1	0	293	11	1	15	0	1	0	274	274	0.0800210014	0.346843988	0.70797801	0.697198987	0.186619997	5709
30561	6	371	1	10000000	cplex	1	1	293	8	2	15	0	1	0	274	274	0.0638040006	0.363106012	0.654340982	0.635088027	0.184540004	5004
30562	6	371	1	10000000	cplex	0	0	300	11	3	15	0	1	0	274	274	0.0911879987	0.37104699	0.76382798	0.783868015	0.196761996	4785
30563	6	371	1	10000000	cplex	1	1	293	1	4	15	15	0	0	274		0.621885002	18.1263142	29.0323315	375.445557	0	4347
30564	6	372	1	10000000	cplex	0	1	300	7	0	9	0	1	0	274	274	0.0604679994	0.212035	0.41100201	0.446532995	0.190738007	2428
30565	6	372	1	10000000	cplex	1	0	293	11	1	9	0	1	0	274	274	0.0513870008	0.227522999	0.433941007	0.442889988	0.225963995	3425
30566	6	372	1	10000000	cplex	1	1	293	8	2	9	0	1	0	274	274	0.0453010015	0.202454999	0.384077996	0.406367987	0.184893996	3002
30567	6	372	1	10000000	cplex	0	0	300	11	3	9	0	1	0	274	274	0.0469999984	0.224370003	0.452879995	0.487993985	0.183828995	2871
30568	6	372	1	10000000	cplex	1	1	293	1	4	9	9	0	0	274		0.42504999	11.7362337	17.8738251	234.588562	0	2607
30569	6	373	1	10000000	cplex	0	1	300	7	0	11	0	1	0	274	274	0.0593740009	0.262762994	0.491338015	0.701858997	0.226119995	2968
30570	6	373	1	10000000	cplex	1	0	293	11	1	11	0	1	0	274	274	0.0660350025	0.277767986	0.538999021	0.568939984	0.225665003	4186
30571	6	373	1	10000000	cplex	1	1	293	8	2	11	0	1	0	274	274	0.0489839986	0.236726999	0.466821998	0.54589802	0.232004002	3669
30572	6	373	1	10000000	cplex	0	0	300	11	3	11	0	1	0	274	274	0.0781780034	0.306641012	0.597832978	0.628024995	0.241209999	3509
30573	6	373	1	10000000	cplex	1	1	293	1	4	11	11	0	0	274		0.481025994	13.4070692	21.4598465	271.515411	0	3184
30574	6	374	1	10000000	cplex	0	1	300	7	0	11	0	1	0	274	274	0.0671920031	0.263951987	0.509429991	0.762220979	0.225529999	2968
30575	6	374	1	10000000	cplex	1	0	293	11	1	11	0	1	0	274	274	0.0534919985	0.254000008	0.516906023	0.542762995	0.232519001	4186
30576	6	374	1	10000000	cplex	1	1	293	8	2	11	0	1	0	274	274	0.0599539988	0.240447	0.468057007	0.50149399	0.229371995	3669
30577	6	374	1	10000000	cplex	0	0	300	11	3	11	0	1	0	274	274	0.0554209985	0.349711001	0.579180002	0.698150992	0.241564006	3509
30578	6	374	1	10000000	cplex	1	1	293	1	4	11	11	0	0	274		0.485920995	13.9750328	21.6754627	278.952881	0	3176
30579	6	375	1	10000000	cplex	0	1	300	7	0	13	0	1	0	274	274	0.0410620011	0.372395992	0.607993007	0.585501015	0.180700004	3508
30580	6	375	1	10000000	cplex	1	0	293	11	1	13	0	1	0	274	274	0.0538359992	0.306205004	0.633304	0.609597981	0.182027996	4947
30581	6	375	1	10000000	cplex	1	1	293	8	2	13	0	1	0	274	274	0.0665739998	0.300549001	0.581176996	0.570243001	0.182095006	4336
30582	6	375	1	10000000	cplex	0	0	300	11	3	13	0	1	0	274	274	0.0742190033	0.346614987	0.798165977	0.677397013	0.191761002	4147
30583	6	375	1	10000000	cplex	1	1	293	1	4	13	13	0	0	274		0.545808017	16.3812809	25.9140186	331.65213	0	3807
30584	6	376	1	10000000	cplex	0	1	300	7	0	10	0	1	0	274	274	0.0614770018	0.242091	0.462036014	0.539299011	0.253526002	2698
30585	6	376	1	10000000	cplex	1	0	293	11	1	10	0	1	0	274	274	0.0592929982	0.236440003	0.476633996	0.50138098	0.263215989	3806
30586	6	376	1	10000000	cplex	1	1	293	8	2	10	0	1	0	274	274	0.0469640009	0.224219993	0.432096988	0.462291002	0.257919997	3336
30587	6	376	1	10000000	cplex	0	0	300	11	3	10	0	1	0	274	274	0.0471380018	0.254996002	0.563546002	0.537319005	0.265399992	3190
30588	6	376	1	10000000	cplex	1	1	293	1	4	10	10	0	0	274		0.456052989	13.0131454	20.5183525	257.354797	0	2916
30589	6	377	1	10000000	cplex	0	1	300	7	0	12	0	1	0	274	274	0.0668630004	0.273425013	0.547435999	0.581942976	0.336771011	3238
30590	6	377	1	10000000	cplex	1	0	293	11	1	12	0	1	0	274	274	0.0650509968	0.293303996	0.599870026	0.582077026	0.579041004	4567
30591	6	377	1	10000000	cplex	1	1	293	8	2	12	0	1	0	274	274	0.0565840006	0.269095987	0.529093027	0.531320989	0.448150992	4003
30592	6	377	1	10000000	cplex	0	0	300	11	3	12	0	1	0	274	274	0.0616770014	0.331308991	0.637615025	0.630463004	0.332035005	3828
30593	6	377	1	10000000	cplex	1	1	293	1	4	12	12	0	0	274		0.496775001	14.6279268	24.1498833	303.381042	0	3511
30594	6	378	1	10000000	cplex	0	1	300	7	0	11	0	1	0	274	274	0.0570610017	0.301537007	0.506802976	0.523446977	0.262001008	2968
30595	6	378	1	10000000	cplex	1	0	293	11	1	11	0	1	0	274	274	0.0576209985	0.280021012	0.546451986	0.546400011	0.260091007	4186
30596	6	378	1	10000000	cplex	1	1	293	8	2	11	0	1	0	274	274	0.0665799975	0.258139014	0.49189499	0.493234992	0.272671014	3669
30597	6	378	1	10000000	cplex	0	0	300	11	3	11	0	1	0	274	274	0.0525670014	0.282460988	0.609687984	0.582735002	0.281392008	3509
30598	6	378	1	10000000	cplex	1	1	293	1	4	11	11	0	0	274		0.490595013	13.9168291	22.2380314	283.667358	0	3195
30599	6	379	1	10000000	cplex	0	1	300	7	0	13	0	1	0	274	274	0.0657539964	0.323260993	0.621632993	0.661954999	0.194028005	3508
30600	6	379	1	10000000	cplex	1	0	293	11	1	13	0	1	0	274	274	0.0725449994	0.317869008	0.653980017	0.605863988	0.177171007	4947
30601	6	379	1	10000000	cplex	1	1	293	8	2	13	0	1	0	274	274	0.0636600032	0.346478999	0.593792021	0.554603994	0.194151998	4336
30602	6	379	1	10000000	cplex	0	0	300	11	3	13	0	1	0	274	274	0.0758500025	0.339735001	0.69986999	0.670629978	0.215075001	4147
30603	6	379	1	10000000	cplex	1	1	293	1	4	13	13	0	0	274		0.536843002	15.9377813	26.0877323	319.308441	0	3770
30604	6	380	1	10000000	cplex	0	1	300	9	0	9	0	1	0	249	249	0.0813869983	0.930171013	1.67240202	1.51510096	1.15401196	5052
30605	6	380	1	10000000	cplex	1	0	284	11	1	9	0	1	0	249	249	0.0400279984	0.777150989	1.48090696	1.26174903	1.19013405	6596
30606	6	380	1	10000000	cplex	1	1	284	10	2	9	0	1	0	249	249	0.0544579998	0.778937995	1.47641098	1.27727997	1.28283095	6429
30607	6	380	1	10000000	cplex	0	0	300	11	3	9	0	1	0	249	249	0.0709249973	0.94037199	1.77240098	1.54753995	1.49454904	5346
30608	6	380	1	10000000	cplex	1	1	284	1	4	9	9	0	0	249		0.462536991	12.4957247	18.2358875	220.212021	0	2541
30609	6	381	1	10000000	cplex	0	1	300	9	0	7	0	1	0	249	249	0.0608609989	0.717880011	1.30625904	1.38557005	0.228257	3930
30610	6	381	1	10000000	cplex	1	0	284	11	1	7	0	1	0	249	249	0.0410699993	0.621568978	1.16595495	1.11321294	0.415495008	5130
30611	6	381	1	10000000	cplex	1	1	284	10	2	7	0	1	0	249	249	0.0519479997	0.599148989	1.13286304	1.18942702	0.196436003	5000
30612	6	381	1	10000000	cplex	0	0	300	11	3	7	0	1	0	249	249	0.0618100017	0.685334027	1.37433803	1.31234002	0.216698006	4158
30613	6	381	1	10000000	cplex	1	1	284	1	4	7	7	0	0	249		0.415302992	8.62623024	12.9808931	134.909775	0	1859
30614	6	382	1	10000000	cplex	0	1	300	9	0	6	0	1	0	249	249	0.0507880002	0.66940999	1.17398298	1.11954105	0.69342798	3368
30615	6	382	1	10000000	cplex	1	0	284	11	1	6	0	1	0	249	249	0.0488310009	0.567718983	1.01479304	0.962212026	0.670531988	4397
30616	6	382	1	10000000	cplex	1	1	284	10	2	6	0	1	0	249	249	0.0443810001	0.54944098	0.985580981	1.27512002	0.610581994	4286
30617	6	382	1	10000000	cplex	0	0	300	11	3	6	0	1	0	249	249	0.0721540004	0.618201971	1.22097301	1.15369105	0.639339983	3564
30618	6	382	1	10000000	cplex	1	1	284	1	4	6	6	0	0	249		0.379431993	7.78657103	12.438571	140.61972	0	1575
30619	6	383	1	10000000	cplex	0	1	300	9	0	10	0	1	0	249	249	0.0790150017	1.03776002	1.88355994	1.66054296	0.517673016	5651
30620	6	383	1	10000000	cplex	1	0	283	11	1	10	0	1	0	249	249	0.0514700003	0.885818005	1.63538694	1.43147004	0.487848997	7480
30621	6	383	1	10000000	cplex	1	1	283	10	2	10	0	1	0	249	249	0.0478040017	0.843693018	1.64876699	1.43892097	0.502547979	7327
30622	6	383	1	10000000	cplex	0	0	300	11	3	10	0	1	0	249	249	0.0756310001	1.06734502	1.97557402	1.74067903	0.549817979	5940
30623	6	383	1	10000000	cplex	1	1	283	1	4	10	10	0	0	249		0.474121988	10.2332602	16.4340229	115.691933	0	2908
30624	6	384	1	10000000	cplex	0	1	300	9	0	8	0	1	0	249	249	0.062061999	0.825487971	1.51150095	1.51735604	0.264582008	4520
30625	6	384	1	10000000	cplex	1	0	283	11	1	8	0	1	0	249	249	0.0478359982	0.705497026	1.32358003	1.66796505	0.277548999	5984
30626	6	384	1	10000000	cplex	1	1	283	10	2	8	0	1	0	249	249	0.0424630009	0.685361028	1.30491197	1.38194895	0.281962991	5862
30627	6	384	1	10000000	cplex	0	0	300	11	3	8	0	1	0	249	249	0.0849800035	0.831479013	1.56997097	1.47766697	0.282505006	4752
30628	6	384	1	10000000	cplex	1	1	283	1	4	8	8	0	0	249		0.439788014	8.19730568	13.7376146	113.358826	0	2374
30629	6	385	1	10000000	cplex	0	1	300	9	0	10	0	1	0	249	249	0.0857049972	1.01652896	1.89615405	2.21715999	0.229509994	5614
30630	6	385	1	10000000	cplex	1	0	284	11	1	10	0	1	0	249	249	0.0497560017	0.878048003	1.69359803	1.58674097	0.225765005	7329
30631	6	385	1	10000000	cplex	1	1	284	10	2	10	0	1	0	249	249	0.0473389998	0.861239016	1.65707803	1.69719303	0.235826999	7144
30632	6	385	1	10000000	cplex	0	0	300	11	3	10	0	1	0	249	249	0.0718659982	1.002321	1.98247194	1.85006499	0.213020995	5940
30633	6	385	1	10000000	cplex	1	1	284	1	4	10	10	0	0	249		0.477800012	11.6066141	18.1173916	209.101501	0	2617
30634	6	386	1	10000000	cplex	0	1	300	9	0	4	0	1	0	249	249	0.053975001	0.445816994	0.762800992	1.03085196	1.51422703	2245
30635	6	386	1	10000000	cplex	1	0	284	11	1	4	0	1	0	249	249	0.0527409986	0.35383299	0.678555012	0.673600972	1.55383503	2931
30636	6	386	1	10000000	cplex	1	1	284	10	2	4	0	1	0	249	249	0.0497869998	0.348129988	0.664267004	0.736329973	1.41836298	2857
30637	6	386	1	10000000	cplex	0	0	300	11	3	4	0	1	0	249	249	0.0658000037	0.403077006	0.805987	1.04893696	1.64400804	2376
30638	6	386	1	10000000	cplex	1	1	284	1	4	4	4	0	0	249		0.369632006	4.85742283	7.22408199	61.9323349	0	1058
30639	6	387	1	10000000	cplex	0	1	300	9	0	3	0	1	0	249	249	0.0590620004	0.313264996	0.580964029	0.84937501	0.297463	1684
30640	6	387	1	10000000	cplex	1	0	284	11	1	3	0	1	0	249	249	0.0308529995	0.276784003	0.514943004	0.677233994	0.377930999	2198
30641	6	387	1	10000000	cplex	1	1	284	10	2	3	0	1	0	249	249	0.0478040017	0.291121989	0.503194988	0.79955101	0.349027008	2143
30642	6	387	1	10000000	cplex	0	0	300	11	3	3	0	1	0	249	249	0.0521249995	0.346311986	0.609996021	1.10308194	0.563162982	1782
30643	6	387	1	10000000	cplex	1	1	284	1	4	3	3	0	0	249		0.334277987	3.05791402	4.54204178	29.7555428	0	745
30644	6	388	1	10000000	cplex	0	1	300	9	0	9	0	1	0	249	249	0.0903809965	0.906939983	1.72929704	1.56325805	0.358514994	5052
30645	6	388	1	10000000	cplex	1	0	284	11	1	9	0	1	0	249	249	0.0477150008	0.764885008	1.50628805	1.36891699	0.423422009	6596
30646	6	388	1	10000000	cplex	1	1	284	10	2	9	0	1	0	249	249	0.0540219992	1.06342697	1.48245299	1.29422402	0.376569003	6429
30647	6	388	1	10000000	cplex	0	0	300	11	3	9	0	1	0	249	249	0.0899299979	0.857954979	1.79317999	1.55713499	0.483359009	5346
30648	6	388	1	10000000	cplex	1	1	284	1	4	9	9	0	0	249		0.428460002	9.83958817	16.0440636	169.380234	0	2360
30649	6	389	1	10000000	cplex	0	1	300	9	0	8	0	1	0	249	249	0.0715719983	0.82269299	1.55759501	1.41800904	0.247342005	4491
30650	6	389	1	10000000	cplex	1	0	284	11	1	8	0	1	0	249	249	0.0532520004	0.697422028	1.39356601	1.25391102	0.252983987	5863
30651	6	389	1	10000000	cplex	1	1	284	10	2	8	0	1	0	249	249	0.0661000013	0.733931005	1.37875104	1.21882498	0.239843994	5715
30652	6	389	1	10000000	cplex	0	0	300	11	3	8	0	1	0	249	249	0.0817980021	0.886684	1.67564201	1.50218499	0.292614996	4752
30653	6	389	1	10000000	cplex	1	1	284	1	4	8	87	0.125	10	249	249	0.0758880004	0.0816010013	0.129819006	1.43836701	0.239421993	300
30654	6	390	1	10000000	cplex	0	1	300	10	0	17	0	1	0	199	199	0.199761003	7.68452787	13.6556406	14.0607357	0.271097004	19253
30655	6	390	1	10000000	cplex	1	0	269	11	1	17	0	1	0	199	199	0.146202996	6.46417522	12.3209047	13.0624208	0.185214996	25245
30656	6	390	1	10000000	cplex	1	1	269	11	2	17	0	1	0	199	199	0.167193994	6.22460318	12.2214708	12.9321098	0.187295005	25245
30657	6	390	1	10000000	cplex	0	0	300	11	3	17	0	1	0	199	199	0.273496002	6.85650587	13.6058149	14.1414499	0.200990006	19448
30658	6	390	1	10000000	cplex	1	1	269	1	4	17	17	0	0	199		0.715777993	11.0754938	19.0227089	158.880402	0	3708
30659	6	391	1	10000000	cplex	0	1	300	10	0	18	0	1	0	199	199	0.219935	7.04729319	13.8901968	15.0146561	0.273400992	20385
30660	6	391	1	10000000	cplex	1	0	269	11	1	18	0	1	0	199	199	0.133792996	6.00187683	12.3744202	13.7390471	0.272381991	26730
30661	6	391	1	10000000	cplex	1	1	269	11	2	18	0	1	0	199	199	0.154422998	5.99769878	12.5080481	13.69524	0.277873993	26730
30662	6	391	1	10000000	cplex	0	0	300	11	3	18	0	1	0	199	199	0.212338001	6.56268597	13.9888649	15.0865421	0.283822	20592
30663	6	391	1	10000000	cplex	1	1	269	1	4	18	18	0	0	199		0.77067399	11.833744	19.7162628	173.869324	0	3924
30664	6	392	1	10000000	cplex	0	1	300	10	0	18	0	1	0	199	199	0.174317002	7.34140205	14.4199286	15.3128433	0.222573996	20385
30665	6	392	1	10000000	cplex	1	0	269	11	1	18	0	1	0	199	199	0.140219003	7.07284212	13.0991583	13.597024	0.243414	26730
30666	6	392	1	10000000	cplex	1	1	269	11	2	18	0	1	0	199	199	0.158194005	6.66663313	13.1226482	13.9630775	0.234334007	26730
30667	6	392	1	10000000	cplex	0	0	300	11	3	18	0	1	0	199	199	0.178739995	7.43300486	14.5023355	14.9896383	0.219638005	20592
30668	6	392	1	10000000	cplex	1	1	269	1	4	18	18	0	0	199		0.723874986	11.5694637	20.0819397	169.677124	0	3920
30669	6	393	1	10000000	cplex	0	1	300	10	0	17	0	1	0	199	199	0.279911995	6.77545309	13.5043011	14.1180925	1.18409705	19253
30670	6	393	1	10000000	cplex	1	0	269	11	1	17	0	1	0	199	199	0.135056004	5.76479387	12.1169443	13.2770424	1.15220904	25245
30671	6	393	1	10000000	cplex	1	1	269	11	2	17	0	1	0	199	199	0.131679997	6.40964079	12.1322527	13.4243612	1.194754	25245
30672	6	393	1	10000000	cplex	0	0	300	11	3	17	0	1	0	199	199	0.221156999	6.97826195	13.7300549	14.2004166	1.16907001	19448
30673	6	393	1	10000000	cplex	1	1	269	1	4	17	17	0	0	199		0.698970973	11.6876249	19.0131111	176.033066	0	3706
30674	6	394	1	10000000	cplex	0	1	300	10	0	12	0	1	0	199	199	0.152436003	4.78904104	9.54117203	9.58992767	1.486359	13590
30675	6	394	1	10000000	cplex	1	0	269	11	1	12	0	1	0	199	199	0.0994959995	4.34460592	8.67202854	9.07597446	1.51823699	17820
30676	6	394	1	10000000	cplex	1	1	269	11	2	12	0	1	0	199	199	0.108066998	4.27044582	8.49683857	9.16700077	1.53090703	17820
30677	6	394	1	10000000	cplex	0	0	300	11	3	12	0	1	0	199	199	0.146739006	4.54954386	9.43776512	9.81296825	1.46692204	13728
30678	6	394	1	10000000	cplex	1	1	269	1	4	12	12	0	0	199		0.482425988	7.70414019	13.7067547	98.6638718	0	2585
30679	6	395	1	10000000	cplex	0	1	300	10	0	16	0	1	0	199	199	0.181265995	6.05882502	12.6528473	12.7599249	1.10340405	18130
30680	6	395	1	10000000	cplex	1	0	269	11	1	16	0	1	0	199	199	0.120742999	5.55275822	11.4144497	12.1287403	1.06998205	23760
30681	6	395	1	10000000	cplex	1	1	269	11	2	16	0	1	0	199	199	0.126883999	6.13945007	11.6362152	12.067688	1.08034301	23760
30682	6	395	1	10000000	cplex	0	0	300	11	3	16	0	1	0	199	199	0.199353993	6.42384911	12.9386501	12.6913023	1.075158	18304
30683	6	395	1	10000000	cplex	1	1	269	1	4	16	16	0	0	199		0.663523972	10.9880857	18.4237804	141.578705	0	2766
30684	6	396	1	10000000	cplex	0	1	300	10	0	20	0	1	0	199	199	0.257138997	8.65939903	16.083849	16.8567772	0.228906006	22650
30685	6	396	1	10000000	cplex	1	0	269	11	1	20	0	1	0	199	199	0.147001997	7.54851818	14.9496794	15.8581238	0.222130001	29700
30686	6	396	1	10000000	cplex	1	1	269	11	2	20	0	1	0	199	199	0.185756996	7.4690938	14.6809053	15.4841261	0.256018996	29700
30687	6	396	1	10000000	cplex	0	0	300	11	3	20	0	1	0	199	199	0.247704998	8.00561619	15.690588	16.7053909	0.235135004	22880
30688	6	396	1	10000000	cplex	1	1	269	1	4	20	20	0	0	199		0.664314985	12.8751345	22.4842205	222.927887	0	4360
30689	6	397	1	10000000	cplex	0	1	300	10	0	21	0	1	0	199	199	0.280207992	8.85732746	16.9930515	17.9210567	0.229867995	23783
30690	6	397	1	10000000	cplex	1	0	269	11	1	21	0	1	0	199	199	0.131957993	6.94591379	14.8710117	16.7819958	0.211322993	31185
30691	6	397	1	10000000	cplex	1	1	269	11	2	21	0	1	0	199	199	0.157481998	7.00289917	14.8663397	16.6240177	0.220385	31185
30692	6	397	1	10000000	cplex	0	0	300	11	3	21	0	1	0	199	199	0.252837986	8.08458328	16.8547649	17.9348736	0.249051005	24024
30693	6	397	1	10000000	cplex	1	1	269	1	4	21	21	0	0	199		0.742425025	14.2978601	23.8897495	217.77475	0	4579
30694	6	398	1	10000000	cplex	0	1	300	10	0	16	0	1	0	199	199	0.224136993	6.66639185	12.7452784	12.9761848	1.12417805	18130
30695	6	398	1	10000000	cplex	1	0	269	11	1	16	0	1	0	199	199	0.134079993	5.50413704	11.4336281	11.7865782	1.15752697	23760
30696	6	398	1	10000000	cplex	1	1	269	11	2	16	0	1	0	199	199	0.148435995	5.51762819	11.4283419	12.0210152	1.10738003	23760
30697	6	398	1	10000000	cplex	0	0	300	11	3	16	0	1	0	199	199	0.147424996	6.02099705	12.5999737	12.8678284	1.11652601	18304
30698	6	398	1	10000000	cplex	1	1	269	1	4	16	16	0	0	199		0.598955989	11.6334028	18.5233593	147.470413	0	2779
30699	6	399	1	10000000	cplex	0	1	300	10	0	14	0	1	0	199	199	0.180767	5.38301086	11.0831633	11.3608236	0.267262012	15855
30700	6	399	1	10000000	cplex	1	0	269	11	1	14	0	1	0	199	199	0.10362	4.84368801	10.0787926	10.4700499	0.252532005	20790
30701	6	399	1	10000000	cplex	1	1	269	11	2	14	0	1	0	199	199	0.117845997	4.92106199	10.0065737	10.5218029	0.27650401	20790
30702	6	399	1	10000000	cplex	0	0	300	11	3	14	0	1	0	199	199	0.180506006	5.52354288	11.1262417	11.5013542	0.248548001	16016
30703	6	399	1	10000000	cplex	1	1	269	1	4	14	14	0	0	199		0.656220019	10.1512337	16.1134281	118.010689	0	3053
30704	6	400	1	10000000	cplex	0	1	300	10	0	11	0	1	0	99	99	0.36638099	16.9110146	34.0211983	51.0863724	0.339819014	24600
30705	6	400	1	10000000	cplex	1	0	253	11	1	11	0	1	0	99	99	0.204999998	16.0159721	32.0953827	49.4163818	0.333371013	30303
30706	6	400	1	10000000	cplex	1	1	253	11	2	11	0	1	0	99	99	0.239779994	17.3995705	32.0997887	49.6912155	0.35046199	30303
30707	6	400	1	10000000	cplex	0	0	300	11	3	11	0	1	0	99	99	0.327019989	16.4453602	33.8872299	51.3251877	0.348078996	24684
30708	6	400	1	10000000	cplex	1	1	253	1	4	11	11	0	0	99		0.405503988	6.48361111	10.4179239	81.1546249	0	1545
30709	6	401	1	10000000	cplex	0	1	300	10	0	10	0	1	0	99	99	0.301205009	15.7896566	31.6747971	44.7349892	0.764311016	22377
30710	6	401	1	10000000	cplex	1	0	215	11	1	10	0	1	0	99	99	0.146718994	13.5441151	26.0871105	40.3393288	0.714465976	31761
30711	6	401	1	10000000	cplex	1	1	215	11	2	10	0	1	0	99	99	0.193076998	13.5889482	26.2620754	39.6398506	0.729269028	31761
30712	6	401	1	10000000	cplex	0	0	300	11	3	10	0	1	0	99	99	0.299075007	16.8612251	32.0891991	44.6626625	0.744459987	22440
30713	6	401	1	10000000	cplex	1	1	215	1	4	10	10	0	0	99		0.524329007	4.85809088	7.80156612	67.7639847	0	1723
30719	6	403	1	10000000	cplex	0	1	300	10	0	10	0	1	0	99	99	0.300763994	15.4576416	31.3689289	45.5957413	0.59277302	22372
30720	6	403	1	10000000	cplex	1	0	253	11	1	10	0	1	0	99	99	0.196179003	16.4404831	30.4005356	44.3220901	0.676150024	27548
30721	6	403	1	10000000	cplex	1	1	253	11	2	10	0	1	0	99	99	0.251150012	14.3271341	29.6839943	44.6113853	0.591602981	27548
30722	6	403	1	10000000	cplex	0	0	300	11	3	10	0	1	0	99	99	0.29034099	15.2081022	31.2911148	45.1146774	0.596789002	22440
30723	6	403	1	10000000	cplex	1	1	253	1	4	10	10	0	0	99		0.421790004	7.69147587	12.6307354	123.491035	0	1767
30724	6	404	1	10000000	cplex	0	1	300	10	0	7	0	1	0	99	99	0.241392002	11.3226042	23.41745	32.5587654	0.190427005	15650
30725	6	404	1	10000000	cplex	1	0	253	11	1	7	0	1	0	99	99	0.153724	10.8969574	21.4672394	31.0841904	0.247134	19284
30726	6	404	1	10000000	cplex	1	1	253	11	2	7	0	1	0	99	99	0.212332994	10.3950586	21.0079346	30.7658634	0.211444005	19284
30727	6	404	1	10000000	cplex	0	0	300	11	3	7	0	1	0	99	99	0.243261993	11.1828012	22.7286873	32.4136047	0.200227007	15708
30728	6	404	1	10000000	cplex	1	1	253	1	4	7	7	0	0	99		0.354799986	4.36261988	6.59314585	48.8787918	0	1211
30729	6	405	1	10000000	cplex	0	1	300	10	0	8	0	1	0	99	99	0.305114001	12.9911556	25.2440376	36.0498695	0.211961001	17886
30730	6	405	1	10000000	cplex	1	0	253	11	1	8	0	1	0	99	99	0.186528996	11.2773647	23.4929714	34.9894485	0.225024	22038
30731	6	405	1	10000000	cplex	1	1	253	11	2	8	0	1	0	99	99	0.209731996	11.1145554	24.0543709	34.8964348	0.217938006	22038
30732	6	405	1	10000000	cplex	0	0	300	11	3	8	0	1	0	99	99	0.227036998	12.2835636	25.159317	36.2512093	0.174586996	17952
30733	6	405	1	10000000	cplex	1	1	253	1	4	8	8	0	0	99		0.366560012	4.68019009	7.39183283	47.6616516	0	1379
30734	6	406	1	10000000	cplex	0	1	300	10	0	11	0	1	0	99	99	0.320338011	17.7298813	34.7148895	51.4613266	0.242027998	24603
30735	6	406	1	10000000	cplex	1	0	253	11	1	11	0	1	0	99	99	0.234920993	16.7893639	33.4954872	49.9344101	0.231897995	30303
30736	6	406	1	10000000	cplex	1	1	253	11	2	11	0	1	0	99	99	0.276645005	16.7986031	34.1951942	49.2701874	0.198796004	30303
30737	6	406	1	10000000	cplex	0	0	300	11	3	11	0	1	0	99	99	0.300516009	16.9396477	34.5242424	51.2248764	0.168788999	24684
30738	6	406	1	10000000	cplex	1	1	253	1	4	11	11	0	0	99		0.400509	5.90680122	10.1140633	51.152565	0	1891
30739	6	407	1	10000000	cplex	0	1	300	10	0	12	0	1	0	99	99	0.297850013	18.9548683	38.0201912	57.4504929	0.590038002	26829
30740	6	407	1	10000000	cplex	1	0	253	11	1	12	0	1	0	99	99	0.233895004	17.8908119	36.720993	56.4546242	0.501915991	33058
30741	6	407	1	10000000	cplex	1	1	253	11	2	12	0	1	0	99	99	0.249244004	18.6777935	36.7218399	55.3440514	0.778419971	33058
30742	6	407	1	10000000	cplex	0	0	300	11	3	12	0	1	0	99	99	0.293159008	18.8738556	38.9819565	58.0408325	0.478987992	26928
30743	6	407	1	10000000	cplex	1	1	253	1	4	12	12	0	0	99		0.472395003	6.7961359	11.1724033	73.402626	0	2069
30744	6	408	1	10000000	cplex	0	1	300	10	0	14	0	1	0	99	99	0.35789299	21.6773548	45.5468292	65.4745026	0.182519004	31381
30745	6	408	1	10000000	cplex	1	0	253	11	1	14	0	1	0	99	99	0.234840006	19.6833477	41.3450165	62.9612274	0.170947999	38568
30746	6	408	1	10000000	cplex	1	1	253	11	2	14	0	1	0	99	99	0.275344998	19.8132534	41.2978287	62.555336	0.159614995	38568
30747	6	408	1	10000000	cplex	0	0	300	11	3	14	0	1	0	99	99	0.300325006	23.1849384	43.9919319	65.1301041	0.173791006	31416
30748	6	408	1	10000000	cplex	1	1	253	1	4	14	14	0	0	99		0.559816003	5.4827528	8.89944267	79.5610123	0	2172
30749	6	409	1	10000000	cplex	0	1	300	10	0	13	0	1	0	99	99	0.361997008	20.540844	42.1123695	57.0311775	0.646498978	29120
30750	6	409	1	10000000	cplex	1	0	215	11	1	13	0	1	0	99	99	0.181887001	17.2686195	34.1633873	49.902523	0.495608985	41290
30751	6	409	1	10000000	cplex	1	1	215	11	2	13	0	1	0	99	99	0.202999994	16.8588352	34.6681137	50.3095894	0.767238975	41290
30752	6	409	1	10000000	cplex	0	0	300	11	3	13	0	1	0	99	99	0.338501006	21.1547089	41.8357315	55.8904495	0.831314981	29172
30753	6	409	1	10000000	cplex	1	1	215	1	4	13	13	0	0	99		0.515881002	8.08674908	13.3100719	158.746628	0	2367
30754	6	410	1	10000000	cplex	0	1	300	10	0	14	0	1	0	49	49	0.442777991	34.3465462	69.8062439	116.43985	1.21343005	39052
30755	6	410	1	10000000	cplex	1	0	282	11	1	14	0	1	0	49	49	0.317382008	34.2953568	68.9916534	116.67347	1.20465004	41831
30756	6	410	1	10000000	cplex	1	1	282	10	2	14	0	1	0	49	49	0.453833997	35.213707	69.9610138	115.560532	1.21630096	41802
30757	6	410	1	10000000	cplex	0	0	300	11	3	14	0	1	0	49	49	0.361030012	35.8267059	70.3146591	115.717049	1.21433699	39116
30758	6	410	1	10000000	cplex	1	1	282	1	4	14	14	0	0	49		0.570356011	4.98214722	8.37326908	60.9386406	0	2093
30759	6	411	1	10000000	cplex	0	1	300	10	0	11	0	1	0	49	49	0.457630992	26.9028893	55.3920135	93.9007874	1.23831701	30672
30760	6	411	1	10000000	cplex	1	0	289	11	1	11	0	1	0	49	49	0.359504998	29.314909	54.9577255	93.4253769	1.35316098	32046
30761	6	411	1	10000000	cplex	1	1	289	10	2	11	0	1	0	49	49	0.423877001	27.0672474	54.9029083	93.7360229	1.27790594	32002
30762	6	411	1	10000000	cplex	0	0	300	11	3	11	0	1	0	49	49	0.345358014	27.3640842	54.8531418	94.2956085	1.22900295	30734
30763	6	411	1	10000000	cplex	1	1	289	1	4	11	11	0	0	49		0.434123009	6.6816659	11.6659021	136.637299	0	2501
30764	6	412	1	10000000	cplex	0	1	300	10	0	19	0	1	0	49	49	0.561433971	47.5300865	94.2213593	177.244034	0.160915002	53027
30765	6	412	1	10000000	cplex	1	0	253	11	1	19	0	1	0	49	49	0.392226994	46.7709694	92.0293503	175.447617	0.185727999	62820
30766	6	412	1	10000000	cplex	1	1	253	11	2	19	0	1	0	49	49	0.400561005	44.6171188	92.2647095	175.533997	0.178610995	62820
30767	6	412	1	10000000	cplex	0	0	300	11	3	19	0	1	0	49	49	0.460171998	45.4708786	95.7444839	181.50386	0.185919002	53086
30768	6	412	1	10000000	cplex	1	1	253	1	4	19	19	0	0	49		0.653307021	12.8875628	23.6336594	353.54184	0	4661
30769	6	413	1	10000000	cplex	0	1	300	10	0	14	0	1	0	49	49	0.468284994	35.9814377	70.8149414	113.38102	1.11954296	39057
30770	6	413	1	10000000	cplex	1	0	253	11	1	14	0	1	0	49	49	0.315701008	34.9292107	68.2719879	114.017151	1.16862297	46289
30771	6	413	1	10000000	cplex	1	1	253	11	2	14	0	1	0	49	49	0.382683009	33.7848969	67.6797256	113.466133	1.10000205	46289
30772	6	413	1	10000000	cplex	0	0	300	11	3	14	0	1	0	49	49	0.411341012	34.2296371	70.7494431	116.516312	1.13303101	39116
30773	6	413	1	10000000	cplex	1	1	253	1	4	14	14	0	0	49		0.480989993	4.8292079	8.14688778	54.9278259	0	2215
30774	6	414	1	10000000	cplex	0	1	300	10	0	12	0	1	0	49	49	0.438212007	30.5832329	60.7271194	98.16436	0.186754003	33460
30775	6	414	1	10000000	cplex	1	0	289	11	1	12	0	1	0	49	49	0.340519994	30.8133297	61.0671272	98.7037659	0.194814995	34960
30776	6	414	1	10000000	cplex	1	1	289	10	2	12	0	1	0	49	49	0.382429987	30.4894619	61.419735	99.4304276	0.199456006	34911
30777	6	414	1	10000000	cplex	0	0	300	11	3	12	0	1	0	49	49	0.41011399	28.6956539	60.3165817	99.0442963	0.21582	33528
30778	6	414	1	10000000	cplex	1	1	289	1	4	12	12	0	0	49		0.592965007	9.0588007	12.9028854	151.255478	0	2699
30779	6	415	1	10000000	cplex	0	1	300	10	0	13	0	1	0	49	49	0.449710995	31.6247368	65.8584747	109.902596	0.159069002	36248
30780	6	415	1	10000000	cplex	1	0	289	11	1	13	0	1	0	49	49	0.343466014	33.6907616	65.7686386	107.449074	0.159122005	37873
30781	6	415	1	10000000	cplex	1	1	289	10	2	13	0	1	0	49	49	0.437577009	32.1570129	65.1614075	107.435883	0.165222004	37820
30782	6	415	1	10000000	cplex	0	0	300	11	3	13	0	1	0	49	49	0.380308002	32.6899529	65.8234177	108.174438	0.237213001	36322
30783	6	416	1	10000000	cplex	0	1	300	10	0	19	0	1	0	49	49	0.571063995	40.4377899	82.1200714	176.430801	0.264219999	53027
30784	6	416	1	10000000	cplex	1	0	253	11	1	19	0	1	0	49	49	0.392423987	43.2325783	83.3558731	173.148575	0.250064999	62820
30785	6	416	1	10000000	cplex	1	1	253	11	2	19	0	1	0	49	49	0.446464986	43.7916527	84.1839294	172.132736	0.197566003	62820
30786	6	416	1	10000000	cplex	0	0	300	11	3	19	0	1	0	49	49	0.527824998	43.6191978	85.182518	175.855957	0.283268005	53086
30787	6	416	1	10000000	cplex	1	1	253	1	4	19	19	0	0	49		0.764530003	6.3061161	10.2947979	55.3262444	0	3285
30788	6	417	1	10000000	cplex	0	1	300	10	0	13	0	1	0	49	49	0.442876011	31.6510544	59.7815971	111.965874	0.207306996	36248
30789	6	417	1	10000000	cplex	1	0	289	11	1	13	0	1	0	49	49	0.377496004	29.8154526	59.5049782	112.919083	0.219064996	37873
30790	6	417	1	10000000	cplex	1	1	289	10	2	13	0	1	0	49	49	0.427596986	30.0096283	58.7924843	114.931297	0.237598002	37820
30791	6	417	1	10000000	cplex	0	0	300	11	3	13	0	1	0	49	49	0.392031014	31.3035851	59.3815536	114.044975	0.207267001	36322
30792	6	417	1	10000000	cplex	1	1	289	1	4	13	13	0	0	49		0.643812001	7.99567318	12.6677666	165.660324	0	2908
30793	6	418	1	10000000	cplex	0	1	300	10	0	15	0	1	0	49	49	0.466953993	34.9076347	67.1864319	132.713486	1.22539401	41836
30794	6	418	1	10000000	cplex	1	0	253	11	1	15	0	1	0	49	49	0.309213012	33.4682617	63.8618126	129.163498	1.17195594	49595
30795	6	418	1	10000000	cplex	1	1	253	11	2	15	0	1	0	49	49	0.39123401	33.8993149	63.9329872	129.451294	1.18134403	49595
30796	6	418	1	10000000	cplex	0	0	300	11	3	15	0	1	0	49	49	0.432015002	34.2817764	66.2279129	130.059189	1.15541697	41910
30797	6	418	1	10000000	cplex	1	1	253	1	4	15	15	0	0	49		0.646218002	6.2706852	10.1510134	98.8016586	0	2682
30798	6	419	1	10000000	cplex	0	1	300	10	0	14	0	1	0	49	49	0.445820004	33.6123581	64.0729599	119.570892	0.217425004	39042
30799	6	419	1	10000000	cplex	1	0	253	11	1	14	0	1	0	49	49	0.298128009	32.4348564	61.9791794	116.751968	0.235688001	46289
30800	6	419	1	10000000	cplex	1	1	253	11	2	14	0	1	0	49	49	0.398355991	33.7164803	62.2946815	118.294769	0.354896992	46289
30801	6	419	1	10000000	cplex	0	0	300	11	3	14	0	1	0	49	49	0.449402004	33.9032326	63.9115219	117.986992	0.413430005	39116
30802	6	419	1	10000000	cplex	1	1	253	1	4	14	14	0	0	49		0.479332	5.10823393	8.12491512	47.5548973	0	2469
30804	7	420	1	10000000	cplex	0	1	300	4	0	12	0	1	0	299	299	0.0199389998	0.0183949992	0.0120989997	0.0504859984	2.30922794	300
30805	7	420	1	10000000	cplex	1	0	299	11	1	12	0	1	0	299	299	0.0217390005	0.00320399995	0.00675600022	0.0405520014	2.09481692	552
30806	7	420	1	10000000	cplex	1	1	299	4	2	12	0	1	0	299	299	0.018747	0.001651	0.00286899996	0.0314560011	2.14602494	300
30807	7	420	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.00250800001	0.00178000005	0.00326599996	0.0370449983	2.08172798	552
30808	7	420	1	10000000	cplex	1	1	299	1	4	12	245	0.5	19.9166679	299	299	0.0181639995	0.00220500003	0.00347599993	0.0280709993	0.77719003	104
30809	7	421	1	10000000	cplex	0	1	300	4	0	6	0	1	0	299	299	0.00201199995	0.000700999983	0.00130899996	0.00676599983	1.88758397	150
30810	7	421	1	10000000	cplex	1	0	299	11	1	6	0	1	0	299	299	0.0104499999	0.000826000003	0.00177099998	0.00647799997	2.23245001	276
30811	7	421	1	10000000	cplex	1	1	299	4	2	6	0	1	0	299	299	0.0101279998	0.000694999995	0.00130999996	0.007094	2.16813898	150
30812	7	421	1	10000000	cplex	0	0	300	11	3	6	0	1	0	299	299	0.00187100004	0.000577999977	0.00176500005	0.00699299993	2.17358899	276
30813	7	421	1	10000000	cplex	1	1	299	1	4	6	0	1	0	299	299	0.0102599999	0.00091100001	0.00200399989	0.0232350007	2.0612731	52
30814	7	422	1	10000000	cplex	0	1	300	4	0	7	0	1	0	299	299	0.00204499997	0.000570999982	0.00147300004	0.0333859995	0.627532005	175
30815	7	422	1	10000000	cplex	1	0	299	11	1	7	0	1	0	299	299	0.0106380004	0.000685999985	0.00208900007	0.0286120009	0.637540996	322
30816	7	422	1	10000000	cplex	1	1	299	4	2	7	0	1	0	299	299	0.0106370002	0.000730000029	0.00148800004	0.0125900004	0.833190978	175
30817	7	422	1	10000000	cplex	0	0	300	11	3	7	0	1	0	299	299	0.00188800006	0.000605000008	0.002079	0.0124880001	0.644270003	322
30818	7	422	1	10000000	cplex	1	1	299	1	4	7	56	0.857142985	7.85714293	299	299	0.0105290003	0.00103199994	0.0024029999	0.0279089995	0.369410992	60
30819	7	423	1	10000000	cplex	0	1	300	4	0	10	0	1	0	299	299	0.00203000009	0.000623999978	0.00197299989	0.0393939987	0.255816013	250
30820	7	423	1	10000000	cplex	1	0	299	11	1	10	0	1	0	299	299	0.0109510003	0.000880000007	0.00282800011	0.0453019999	0.415019006	460
30821	7	423	1	10000000	cplex	1	1	299	4	2	10	0	1	0	299	299	0.0114230001	0.000847999996	0.00225499994	0.0651490018	0.32199499	250
30822	7	423	1	10000000	cplex	0	0	300	11	3	10	0	1	0	299	299	0.00221200008	0.000962999999	0.00282800011	0.0363259986	0.661534011	460
30823	7	423	1	10000000	cplex	1	1	299	1	4	10	8	0.600000024	0.400000006	299	299	0.0107500004	0.00133	0.00292299991	0.0513609983	0.198791996	86
30824	7	424	1	10000000	cplex	0	1	300	4	0	16	0	1	0	299	299	0.0031020001	0.000988999964	0.00315700006	0.476512015	0.617246985	400
30825	7	424	1	10000000	cplex	1	0	299	11	1	16	0	1	0	299	299	0.0114310002	0.00154099998	0.00447600009	0.469994009	0.563322008	736
30826	7	424	1	10000000	cplex	1	1	299	4	2	16	0	1	0	299	299	0.012329	0.00109300006	0.00310999993	0.256574005	0.634723008	400
30827	7	424	1	10000000	cplex	0	0	300	11	3	16	0	1	0	299	299	0.00294400007	0.00151199999	0.00445199991	0.327877998	0.723339021	736
30828	7	424	1	10000000	cplex	1	1	299	1	4	16	43	0.375	2.0625	299	299	0.011473	0.00196600007	0.00479899999	0.0347819999	0.192292005	138
30829	7	425	1	10000000	cplex	0	1	300	4	0	9	0	1	0	299	299	0.00189800002	0.000563999987	0.00189199997	0.00831000041	0.262158006	225
30830	7	425	1	10000000	cplex	1	0	299	11	1	9	0	1	0	299	299	0.0115189999	0.000905000023	0.00331899989	0.00945799984	0.167411	414
30831	7	425	1	10000000	cplex	1	1	299	4	2	9	0	1	0	299	299	0.0118310004	0.000688	0.00217700005	0.00892100018	0.167218	225
30832	7	425	1	10000000	cplex	0	0	300	11	3	9	0	1	0	299	299	0.00206100009	0.000738999981	0.00269600004	0.00880699977	0.165069997	414
30833	7	425	1	10000000	cplex	1	1	299	1	4	9	3	0.666666985	0	299	299	0.0103850001	0.00110800005	0.00291700009	0.0611220002	0.165386006	78
30834	7	426	1	10000000	cplex	0	1	300	4	0	12	0	1	0	299	299	0.00253099995	0.000923999993	0.00252699992	0.116764002	0.60432303	300
30835	7	426	1	10000000	cplex	1	0	299	11	1	12	0	1	0	299	299	0.0109479995	0.000954999996	0.0034680001	0.0318690017	0.714621007	552
30836	7	426	1	10000000	cplex	1	1	299	4	2	12	0	1	0	299	299	0.0104649998	0.000730000029	0.00246100011	0.0352349989	0.376482993	300
30837	7	426	1	10000000	cplex	0	0	300	11	3	12	0	1	0	299	299	0.0022189999	0.000956000003	0.00344899995	0.0384950005	0.657220006	552
30838	7	426	1	10000000	cplex	1	1	299	1	4	12	55	0.5	4.08333302	299	299	0.0105189998	0.00144899997	0.00354399998	0.0464119986	0.444705993	104
30839	7	427	1	10000000	cplex	0	1	300	4	0	13	0	1	0	299	299	0.00246799993	0.000816999993	0.00257700006	0.103794999	0.174778998	325
30840	7	427	1	10000000	cplex	1	0	299	11	1	13	0	1	0	299	299	0.0103669995	0.00102299999	0.00375199993	0.227046996	0.164390996	598
30841	7	427	1	10000000	cplex	1	1	299	4	2	13	0	1	0	299	299	0.0107140001	0.00117900001	0.0025820001	0.177252993	0.330751985	325
30842	7	427	1	10000000	cplex	0	0	300	11	3	13	0	1	0	299	299	0.00271199993	0.00118200004	0.00367600005	0.115208998	0.155503005	598
30843	7	427	1	10000000	cplex	1	1	299	1	4	13	10	0.230768993	0	299	299	0.0108589996	0.00215200009	0.00548500009	0.0666069984	0.189229995	112
30844	7	428	1	10000000	cplex	0	1	300	4	0	7	0	1	0	299	299	0.00185700005	0.00055300002	0.00153999997	0.0307829995	0.963346004	175
30845	7	428	1	10000000	cplex	1	0	299	11	1	7	0	1	0	299	299	0.00942400005	0.000605000008	0.0021530001	0.0314680003	0.498293996	322
30846	7	428	1	10000000	cplex	1	1	299	4	2	7	0	1	0	299	299	0.00973000005	0.000545000017	0.001513	0.0293409992	0.943388999	175
30847	7	428	1	10000000	cplex	0	0	300	11	3	7	0	1	0	299	299	0.00181199994	0.000735000009	0.00214600004	0.0229240004	0.698082983	322
30848	7	428	1	10000000	cplex	1	1	299	1	4	7	14	0.857142985	1.85714304	299	299	0.00976900011	0.001085	0.00230200007	0.0299880002	0.245995	60
30849	7	429	1	10000000	cplex	0	1	300	4	0	8	0	1	0	299	299	0.00192399998	0.000618999999	0.00168500002	0.0364940017	0.209260002	200
30850	7	429	1	10000000	cplex	1	0	299	11	1	8	0	1	0	299	299	0.0101420004	0.000880000007	0.00240799994	0.0260690004	0.233041003	368
30851	7	429	1	10000000	cplex	1	1	299	4	2	8	0	1	0	299	299	0.01248	0.000545000017	0.00167799997	0.0286190007	0.237682998	200
30852	7	429	1	10000000	cplex	0	0	300	11	3	8	0	1	0	299	299	0.001773	0.000625999994	0.00239300006	0.0320289992	0.213705003	368
30853	7	429	1	10000000	cplex	1	1	299	1	4	8	33	0.75	3.875	299	299	0.00980500039	0.00131800002	0.00359200011	0.0744299963	0.365714997	69
30854	7	430	1	10000000	cplex	0	1	300	9	0	4	0	1	0	274	274	0.0465120003	0.153017998	0.252344996	0.311340004	1.02907896	1320
30855	7	430	1	10000000	cplex	1	0	264	11	1	4	0	1	0	274	274	0.00946099963	0.0118490001	0.0196889993	0.458622009	1.41970098	2584
30856	7	430	1	10000000	cplex	1	1	264	11	2	4	0	1	0	274	274	0.00971399993	0.012255	0.0198860001	0.0512120016	0.95511198	2584
30857	7	430	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	274	0.0280089993	0.225362003	0.258980989	0.301187009	1.53741598	1384
30858	7	430	1	10000000	cplex	1	1	264	1	4	4	4	0	0	274		0.394836992	5.46730614	8.61010456	52.5523262	0	1073
30859	7	431	1	10000000	cplex	0	1	300	9	0	2	0	1	0	274	274	0.0321489982	0.0759700015	0.128002003	0.225757003	0.188953996	660
30860	7	431	1	10000000	cplex	1	0	264	11	1	2	0	1	0	274	274	0.00900399964	0.00611699978	0.00921600033	0.0290559996	0.194043994	1292
30861	7	431	1	10000000	cplex	1	1	264	11	2	2	0	1	0	274	274	0.0092000002	0.00554599985	0.00910899974	0.0391240008	0.182370007	1292
30862	7	431	1	10000000	cplex	0	0	300	11	3	2	0	1	0	274	274	0.0295139998	0.0798370019	0.130584002	0.219061002	0.193020999	692
30863	7	431	1	10000000	cplex	1	1	264	1	4	2	2	0	0	274		0.352016002	2.92315698	4.33830881	26.9459324	0	535
30864	7	432	1	10000000	cplex	0	1	300	9	0	3	0	1	0	274	274	0.0342749991	0.103826001	0.185824007	0.258765012	0.926270008	990
30865	7	432	1	10000000	cplex	1	0	264	11	1	3	0	1	0	274	274	0.00921100006	0.00786499958	0.0137280002	0.0446209982	0.961102009	1938
30866	7	432	1	10000000	cplex	1	1	264	11	2	3	0	1	0	274	274	0.00933500007	0.00760899996	0.0138379997	0.0434570014	0.989777982	1938
30867	7	432	1	10000000	cplex	0	0	300	11	3	3	0	1	0	274	274	0.0387960002	0.110032	0.194833994	0.258064002	1.03202903	1038
30868	7	432	1	10000000	cplex	1	1	264	1	4	3	3	0	0	274		0.353807986	3.93949604	6.12984896	30.9462681	0	835
30869	7	433	1	10000000	cplex	0	1	300	9	0	5	0	1	0	274	274	0.0458309986	0.168309003	0.313926995	0.397105008	0.644110024	1650
30870	7	433	1	10000000	cplex	1	0	264	11	1	5	0	1	0	274	274	0.00945299957	0.0132980002	0.02465	0.0527709983	0.633158982	3230
30871	7	433	1	10000000	cplex	1	1	264	11	2	5	0	1	0	274	274	0.00960899983	0.0125869997	0.0240020007	0.063481003	0.868665993	3230
30872	7	433	1	10000000	cplex	0	0	300	11	3	5	0	1	0	274	274	0.0493699983	0.179021999	0.332989991	0.348158002	0.743641973	1730
30873	7	433	1	10000000	cplex	1	1	264	1	4	5	5	0	0	274		0.374175996	6.74086285	10.9300222	69.9126663	0	1353
30874	7	434	1	10000000	cplex	0	1	300	9	0	6	0	1	0	274	274	0.03486	0.226088002	0.379325002	0.517153025	0.308661014	1980
30875	7	434	1	10000000	cplex	1	0	264	11	1	6	0	1	0	274	274	0.00950499997	0.0329679996	0.0284449998	0.26255399	0.645298004	3876
30876	7	434	1	10000000	cplex	1	1	264	11	2	6	0	1	0	274	274	0.00951999985	0.0161150005	0.0293329991	0.65802598	0.675691009	3876
30877	7	434	1	10000000	cplex	0	0	300	11	3	6	0	1	0	274	274	0.0349779986	0.356833011	0.391860992	0.598289013	0.694314003	2076
30878	7	434	1	10000000	cplex	1	1	264	1	4	6	6	0	0	274		0.464293003	8.28133202	13.2014532	88.269989	0	1703
30879	7	435	1	10000000	cplex	0	1	300	9	0	2	0	1	0	274	274	0.0359219983	0.114818998	0.127682	0.261168003	2.05682111	661
30880	7	435	1	10000000	cplex	1	0	264	11	1	2	0	1	0	274	274	0.00904100016	0.00530199986	0.00902900007	0.378955007	1.93134701	1292
30881	7	435	1	10000000	cplex	1	1	264	11	2	2	0	1	0	274	274	0.00909600034	0.00543399993	0.0230560005	0.446725011	2.24231911	1292
30882	7	435	1	10000000	cplex	0	0	300	11	3	2	0	1	0	274	274	0.0278130006	0.0892419964	0.135734007	0.397015005	2.11156893	692
30883	7	435	1	10000000	cplex	1	1	264	1	4	2	2	0	0	274		0.356388003	2.8416059	4.20648909	21.4979401	0	559
30884	7	436	1	10000000	cplex	0	1	300	9	0	4	0	1	0	274	274	0.0265820008	0.179592997	0.250766993	0.308925003	0.485190004	1320
30885	7	436	1	10000000	cplex	1	0	264	11	1	4	0	1	0	274	274	0.00923900027	0.0227339994	0.0194400009	0.455431998	1.03013802	2584
30886	7	436	1	10000000	cplex	1	1	264	11	2	4	0	1	0	274	274	0.00973599963	0.0116440002	0.0205380004	0.383563995	0.850234985	2584
30887	7	436	1	10000000	cplex	0	0	300	11	3	4	0	1	0	274	274	0.040608	0.164719999	0.272323012	0.487783998	0.393994987	1384
30888	7	436	1	10000000	cplex	1	1	264	1	4	4	4	0	0	274		0.392780006	5.6545949	8.60352039	49.4346504	0	1087
30889	7	437	1	10000000	cplex	0	1	300	9	0	2	0	1	0	274	274	0.0323130004	0.0866150036	0.131109998	0.197091997	0.699280977	660
30890	7	437	1	10000000	cplex	1	0	264	11	1	2	0	1	0	274	274	0.00918699987	0.00586999999	0.00976100005	0.018747	0.639262021	1292
30891	7	437	1	10000000	cplex	1	1	264	11	2	2	0	1	0	274	274	0.00926600024	0.00587699981	0.0100609995	0.0296199992	0.852168024	1292
30892	7	437	1	10000000	cplex	0	0	300	11	3	2	0	1	0	274	274	0.0212609991	0.0948150009	0.138457999	0.201302007	0.338218004	692
30893	7	437	1	10000000	cplex	1	1	264	1	4	2	2	0	0	274		0.359492987	3.16547608	4.6295948	28.0612602	0	533
30894	7	438	1	10000000	cplex	0	1	300	9	0	1	0	1	0	274	274	0.0231960006	0.0707049966	0.0708440021	0.149945006	0.512468994	330
30895	7	438	1	10000000	cplex	1	0	264	11	1	1	0	1	0	274	274	0.00890500005	0.00312700006	0.00472800015	0.00930299982	0.676856995	646
30896	7	438	1	10000000	cplex	1	1	264	11	2	1	0	1	0	274	274	0.00896300003	0.00303700007	0.00472899992	0.00925500039	0.409776002	646
30897	7	438	1	10000000	cplex	0	0	300	11	3	1	0	1	0	274	274	0.0182489995	0.0590789989	0.0725160018	0.152804002	0.622865021	346
30898	7	438	1	10000000	cplex	1	1	264	1	4	1	0	1	0	274	274	0.00882800017	0.00574700022	0.00726199988	0.153519005	0.355578989	58
30899	7	439	1	10000000	cplex	0	1	300	9	0	2	0	1	0	274	274	0.0275170002	0.113802001	0.130766004	0.402164996	0.529642999	660
30900	7	439	1	10000000	cplex	1	0	264	11	1	2	0	1	0	274	274	0.00906299986	0.00609199982	0.00953899976	0.0324800014	0.715222001	1292
30901	7	439	1	10000000	cplex	1	1	264	11	2	2	0	1	0	274	274	0.00914699957	0.00576800015	0.00944800023	0.27730599	0.633773029	1292
30902	7	439	1	10000000	cplex	0	0	300	11	3	2	0	1	0	274	274	0.0278619993	0.0770369992	0.133884996	0.426097006	0.576188982	692
30903	7	439	1	10000000	cplex	1	1	264	1	4	2	2	0	0	274		0.322973013	2.95806599	4.39192677	27.7893333	0	532
30904	7	440	1	10000000	cplex	0	1	300	10	0	8	0	1	0	249	249	0.070524998	1.09091902	1.95048404	1.81116498	0.214715004	5098
30905	7	440	1	10000000	cplex	1	0	297	11	1	8	0	1	0	249	249	0.0772019997	1.05436206	1.96019995	1.84910202	0.197018996	5440
30906	7	440	1	10000000	cplex	1	1	297	10	2	8	0	1	0	249	249	0.0745119974	1.05415297	1.94889796	1.84709001	0.200494006	5386
30907	7	440	1	10000000	cplex	0	0	300	11	3	8	0	1	0	249	249	0.073491998	1.07492399	1.98181105	1.91378105	0.201446995	5168
30908	7	440	1	10000000	cplex	1	1	297	1	4	8	8	0	0	249		0.47429201	25.7581234	41.6948776	534.678833	0	5368
30909	7	441	1	10000000	cplex	0	1	300	10	0	6	0	1	0	249	249	0.0867689997	0.80447799	1.45387197	1.69382501	0.497772992	3822
30910	7	441	1	10000000	cplex	1	0	297	11	1	6	0	1	0	249	249	0.074376002	0.816340983	1.46519303	1.69519401	0.591551006	4080
30911	7	441	1	10000000	cplex	1	1	297	10	2	6	0	1	0	249	249	0.0821790025	0.843984008	1.46813405	1.95951402	0.601722002	4039
30912	7	441	1	10000000	cplex	0	0	300	11	3	6	0	1	0	249	249	0.0693750009	0.808560014	1.60346997	2.07574105	0.180714995	3876
30913	7	441	1	10000000	cplex	1	1	297	1	4	6	6	0	0	249		0.488153011	14.8364658	25.0536366	512.476501	0	3584
30914	7	442	1	10000000	cplex	0	1	300	10	0	5	0	1	0	249	249	0.0746589974	0.706586003	1.22631001	1.38264799	0.646251023	3185
30915	7	442	1	10000000	cplex	1	0	297	11	1	5	0	1	0	249	249	0.0597949997	0.722477019	1.28288901	1.38118398	0.500045002	3400
30916	7	442	1	10000000	cplex	1	1	297	10	2	5	0	1	0	249	249	0.0780019984	0.702108026	1.26069903	1.40487003	0.697135985	3366
30917	7	442	1	10000000	cplex	0	0	300	11	3	5	0	1	0	249	249	0.0592110008	0.680495024	1.25968003	1.42218101	0.698437989	3230
30918	7	442	1	10000000	cplex	1	1	297	1	4	5	5	0	0	249		0.434433997	12.7202654	21.2206364	478.432983	0	2944
30919	7	443	1	10000000	cplex	0	1	300	10	0	12	0	1	0	249	249	0.0827020034	1.74020302	3.061939	2.71083093	0.163323998	7651
30920	7	443	1	10000000	cplex	1	0	287	11	1	12	0	1	0	249	249	0.0698150024	1.54996598	2.84123302	2.48668694	0.165053993	9381
30921	7	443	1	10000000	cplex	1	1	287	10	2	12	0	1	0	249	249	0.074529998	1.66119897	2.75195789	2.50485611	0.180234998	9376
30922	7	443	1	10000000	cplex	0	0	300	11	3	12	0	1	0	249	249	0.0966629982	1.63490999	3.0558629	2.68851089	0.192450002	7752
30923	7	443	1	10000000	cplex	1	1	287	1	4	12	12	0	0	249		0.555419028	27.2407207	46.4551849	528.52948	0	5507
30924	7	444	1	10000000	cplex	0	1	300	10	0	8	0	1	0	249	249	0.0853400007	1.165676	2.07138896	1.87435102	0.332145005	5096
30925	7	444	1	10000000	cplex	1	0	297	11	1	8	0	1	0	249	249	0.0720269978	1.13515103	2.0689919	2.09369493	0.34129101	5440
30926	7	444	1	10000000	cplex	1	1	297	10	2	8	0	1	0	249	249	0.0795750022	1.09100401	2.0827291	2.08673	0.357326001	5386
30927	7	444	1	10000000	cplex	0	0	300	11	3	8	0	1	0	249	249	0.0775569975	1.10824203	2.05470991	1.84858406	0.353836	5168
30928	7	444	1	10000000	cplex	1	1	297	1	4	8	8	0	0	249		0.523065984	19.6515312	34.0091095	1033.43225	0	4776
30929	7	445	1	10000000	cplex	0	1	300	10	0	7	0	1	0	249	249	0.0651350021	1.03132796	1.826455	1.76342702	0.474792987	4464
30930	7	445	1	10000000	cplex	1	0	270	11	1	7	0	1	0	249	249	0.0359119996	0.649895012	1.18459594	1.273646	0.488799006	7042
30931	7	445	1	10000000	cplex	1	1	270	11	2	7	0	1	0	249	249	0.0465589985	0.805490017	1.17282295	1.24597895	0.507245004	7042
30932	7	445	1	10000000	cplex	0	0	300	11	3	7	0	1	0	249	249	0.0728629977	0.979556024	1.86277199	1.807212	0.451074988	4522
30933	7	445	1	10000000	cplex	1	1	270	1	4	7	7	0	0	249		0.438793004	18.7459259	30.4045887	435.731598	0	3736
30934	7	446	1	10000000	cplex	0	1	300	10	0	9	0	1	0	249	249	0.0843610018	1.492082	2.30735493	2.43896604	0.242393002	5733
30935	7	446	1	10000000	cplex	1	0	297	11	1	9	0	1	0	249	249	0.0775889978	1.26585996	2.30583	2.38209391	0.274370998	6120
30936	7	446	1	10000000	cplex	1	1	297	10	2	9	0	1	0	249	249	0.0991770029	1.21830702	2.26808	2.3143611	0.242989004	6059
30937	7	446	1	10000000	cplex	0	0	300	11	3	9	0	1	0	249	249	0.0994929969	1.17359304	2.33828402	2.63590407	0.237021998	5814
30938	7	446	1	10000000	cplex	1	1	297	1	4	9	9	0	0	249		0.541312993	23.2387218	38.7259865	1014.87805	0	5377
30939	7	447	1	10000000	cplex	0	1	300	10	0	8	0	1	0	249	249	0.0806580037	1.12869895	2.0441339	2.08699703	0.298788011	5101
30940	7	447	1	10000000	cplex	1	0	279	11	1	8	0	1	0	249	249	0.0471940003	0.976813972	1.69989002	1.80276	0.301808	7120
30941	7	447	1	10000000	cplex	1	1	279	10	2	8	0	1	0	249	249	0.0563630015	0.939764977	1.70877194	1.58037305	0.289503992	7112
30942	7	447	1	10000000	cplex	0	0	300	11	3	8	0	1	0	249	249	0.101815	1.14180195	2.10461402	2.12154388	0.313786	5168
30943	7	447	1	10000000	cplex	1	1	279	1	4	8	8	0	0	249		0.488682002	20.4089966	35.2497368	559.005554	0	4057
30944	7	448	1	10000000	cplex	0	1	300	10	0	7	0	1	0	249	249	0.0813319981	1.03282797	1.81973004	1.89396203	0.308077008	4459
30945	7	448	1	10000000	cplex	1	0	297	11	1	7	0	1	0	249	249	0.0785569996	0.981122971	1.84972501	1.68878496	0.282453001	4760
30946	7	448	1	10000000	cplex	1	1	297	10	2	7	0	1	0	249	249	0.0879639983	1.00425804	1.821311	1.69834602	0.292057991	4712
30947	7	448	1	10000000	cplex	0	0	300	11	3	7	0	1	0	249	249	0.0923459977	1.225142	1.87505198	1.78662395	0.274177015	4522
30948	7	448	1	10000000	cplex	1	1	297	1	4	7	7	0	0	249		0.498124003	18.6552105	30.2120705	677.642334	0	4166
30949	7	449	1	10000000	cplex	0	1	300	10	0	6	0	1	0	249	249	0.0698229969	1.05620301	1.50128901	1.66094995	0.327484012	3823
30950	7	449	1	10000000	cplex	1	0	297	11	1	6	0	1	0	249	249	0.0661209971	0.827042997	1.51096797	1.60220504	0.336957008	4080
30951	7	449	1	10000000	cplex	1	1	297	10	2	6	0	1	0	249	249	0.0820749998	0.792346001	1.49278402	1.64347601	0.327286988	4039
30952	7	449	1	10000000	cplex	0	0	300	11	3	6	0	1	0	249	249	0.0605840012	0.81447202	1.52835095	1.495875	0.347535014	3876
30953	7	449	1	10000000	cplex	1	1	297	1	4	6	6	0	0	249		0.448314011	19.0920067	32.3815994	293.143738	0	4197
30954	7	450	1	10000000	cplex	0	1	300	10	0	8	0	1	0	199	199	0.132886007	4.39578819	7.83371305	7.19890785	0.7324	9933
30955	7	450	1	10000000	cplex	1	0	264	11	1	8	0	1	0	199	199	0.0981549993	3.87086511	6.94410181	6.32546091	0.619545996	13370
30956	7	450	1	10000000	cplex	1	1	264	11	2	8	0	1	0	199	199	0.109327003	3.6564219	6.78277588	6.30352211	0.54251498	13370
30957	7	450	1	10000000	cplex	0	0	300	11	3	8	0	1	0	199	199	0.120447002	4.64499378	8.21077538	7.2544589	0.490462989	9968
30958	7	450	1	10000000	cplex	1	1	264	1	4	8	8	0	0	199		0.527491987	17.4669094	30.3022442	404.111755	0	4351
30959	7	451	1	10000000	cplex	0	1	300	10	0	9	0	1	0	199	199	0.167067006	4.924932	9.09705067	8.67721272	0.265208989	11185
30960	7	451	1	10000000	cplex	1	0	264	11	1	9	0	1	0	199	199	0.103556998	4.32168388	7.85357094	7.42830992	0.274266988	15042
30961	7	451	1	10000000	cplex	1	1	264	11	2	9	0	1	0	199	199	0.0999900028	4.26875305	7.85448599	7.8120079	0.257279992	15042
30962	7	451	1	10000000	cplex	0	0	300	11	3	9	0	1	0	199	199	0.135764003	4.77488708	8.98269081	8.65918541	0.575300992	11214
30963	7	451	1	10000000	cplex	1	1	264	1	4	9	9	0	0	199		0.523304999	18.0625172	30.6456165	391.447632	0	4822
30964	7	452	1	10000000	cplex	0	1	300	10	0	4	0	1	0	199	199	0.132060006	2.26747298	3.9638679	3.99387407	0.345539004	4965
30965	7	452	1	10000000	cplex	1	0	264	11	1	4	0	1	0	199	199	0.0741589963	2.02360702	3.45154405	3.53421903	0.30170399	6685
30966	7	452	1	10000000	cplex	1	1	264	11	2	4	0	1	0	199	199	0.0927760005	2.14793205	3.46162701	3.51368308	0.306246012	6685
30967	7	452	1	10000000	cplex	0	0	300	11	3	4	0	1	0	199	199	0.136666998	2.14400005	3.88299298	3.95805311	0.324157	4984
30968	7	452	1	10000000	cplex	1	1	264	1	4	4	4	0	0	199		0.443058997	4.84475517	7.87899494	45.5524521	0	1197
30969	7	453	1	10000000	cplex	0	1	300	10	0	5	0	1	0	199	199	0.157416999	2.63448191	4.83948183	4.7363019	0.730829	6209
30970	7	453	1	10000000	cplex	1	0	263	11	1	5	0	1	0	199	199	0.0725380033	2.30381608	4.22273588	4.01261997	0.650255978	8436
30971	7	453	1	10000000	cplex	1	1	263	11	2	5	0	1	0	199	199	0.0956299976	2.36317992	4.25303507	4.13745308	0.395906001	8436
30972	7	453	1	10000000	cplex	0	0	300	11	3	5	0	1	0	199	199	0.128090993	2.72426796	4.9066062	4.52735281	0.657620013	6230
30973	7	453	1	10000000	cplex	1	1	263	1	4	5	5	0	0	199		0.442948014	3.96675992	6.40703487	30.9656429	0	986
30974	7	454	1	10000000	cplex	0	1	300	10	0	7	0	1	0	199	199	0.187686995	3.59749103	6.89069414	6.37522888	0.843362987	8690
30975	7	454	1	10000000	cplex	1	0	264	11	1	7	0	1	0	199	199	0.0929900035	3.33689904	6.06279182	5.80419397	0.517399013	11699
30976	7	454	1	10000000	cplex	1	1	264	11	2	7	0	1	0	199	199	0.0991490036	3.33559799	6.06427813	5.74855185	0.617834985	11699
30977	7	454	1	10000000	cplex	0	0	300	11	3	7	0	1	0	199	199	0.117181003	3.82674503	6.99356794	6.77147102	0.671748996	8722
30978	7	454	1	10000000	cplex	1	1	264	1	4	7	7	0	0	199		0.462271005	8.82481003	14.8732586	111.501671	0	2164
30979	7	455	1	10000000	cplex	0	1	300	10	0	7	0	1	0	199	199	0.130059004	4.1051631	6.75936222	6.45996094	0.277110994	8693
30980	7	455	1	10000000	cplex	1	0	263	11	1	7	0	1	0	199	199	0.0829489976	3.14286208	5.87376404	5.8987298	0.251527011	11811
30981	7	455	1	10000000	cplex	1	1	263	11	2	7	0	1	0	199	199	0.0965149999	3.25908899	6.03010702	5.69982195	0.264268994	11811
30982	7	455	1	10000000	cplex	0	0	300	11	3	7	0	1	0	199	199	0.159557998	3.7560339	6.97035885	6.46581888	0.28767401	8722
30983	7	455	1	10000000	cplex	1	1	263	1	4	7	7	0	0	199		0.468306988	5.32319021	9.06399059	53.4250145	0	1380
30984	7	456	1	10000000	cplex	0	1	300	10	0	7	0	1	0	199	199	0.153684005	3.53392005	6.82500505	6.33525896	0.345167011	8691
30985	7	456	1	10000000	cplex	1	0	264	11	1	7	0	1	0	199	199	0.0956650004	3.04070807	5.89409208	5.58645916	0.433786988	11699
30986	7	456	1	10000000	cplex	1	1	264	11	2	7	0	1	0	199	199	0.0949549973	3.39328909	5.90112114	6.11297798	0.317277014	11699
30987	7	456	1	10000000	cplex	0	0	300	11	3	7	0	1	0	199	199	0.105976999	3.57063794	6.86296701	6.6834178	0.548138976	8722
30988	7	456	1	10000000	cplex	1	1	264	1	4	7	7	0	0	199		0.472184002	13.6444321	23.7340641	227.397141	0	3919
30989	7	457	1	10000000	cplex	0	1	300	10	0	3	0	1	0	199	199	0.112124003	1.71944797	2.9259901	2.91347003	1.58484495	3724
30990	7	457	1	10000000	cplex	1	0	264	11	1	3	0	1	0	199	199	0.0786869973	1.37467694	2.51252604	2.53039289	1.56595898	5014
30991	7	457	1	10000000	cplex	1	1	264	11	2	3	0	1	0	199	199	0.0709019974	1.38029897	2.48701811	2.48801303	1.52395999	5014
30992	7	457	1	10000000	cplex	0	0	300	11	3	3	0	1	0	199	199	0.104037002	1.607898	2.9517951	2.9145391	1.35630405	3738
30993	7	457	1	10000000	cplex	1	1	264	1	4	3	3	0	0	199		0.394876987	3.61307096	5.90221596	30.0025196	0.271061003	870
30994	7	458	1	10000000	cplex	0	1	300	10	0	7	0	1	0	199	199	0.142405003	3.79926705	7.13190079	6.84783888	0.673039019	8690
30995	7	458	1	10000000	cplex	1	0	264	11	1	7	0	1	0	199	199	0.0923300013	3.1416831	6.082335	5.67819691	0.698880017	11699
30996	7	458	1	10000000	cplex	1	1	264	11	2	7	0	1	0	199	199	0.116933003	3.08362007	5.88356781	5.82221985	0.579689026	11699
30997	7	458	1	10000000	cplex	0	0	300	11	3	7	0	1	0	199	199	0.174316004	3.88896894	6.79191494	6.75324917	0.844511986	8722
30998	7	458	1	10000000	cplex	1	1	264	1	4	7	7	0	0	199		0.457666993	9.47687435	16.414259	150.629807	0	2237
30999	7	459	1	10000000	cplex	0	1	300	10	0	3	0	1	0	199	199	0.122767001	1.61735499	2.892519	2.80046296	1.52399004	3724
31000	7	459	1	10000000	cplex	1	0	264	11	1	3	0	1	0	199	199	0.0740899965	1.36411405	2.47169805	2.383497	1.74964595	5014
31001	7	459	1	10000000	cplex	1	1	264	11	2	3	0	1	0	199	199	0.0925699994	1.40037298	2.52420902	2.50651193	1.90263498	5014
31002	7	459	1	10000000	cplex	0	0	300	11	3	3	0	1	0	199	199	0.100804999	1.66539001	2.93394804	2.78981304	1.95537496	3738
31003	7	459	1	10000000	cplex	1	1	264	1	4	3	3	0	0	199		0.423859	3.75540805	6.01969624	29.8604908	0.278833002	870
31004	7	460	1	10000000	cplex	0	1	300	10	0	12	0	1	0	99	99	0.383565009	25.1383686	46.9865341	64.9417572	0.50512898	29334
31005	7	460	1	10000000	cplex	1	0	250	11	1	12	0	1	0	99	99	0.211452007	23.6270657	43.4823456	62.0336075	0.87687403	36544
31006	7	460	1	10000000	cplex	1	1	250	11	2	12	0	1	0	99	99	0.293635011	21.8507137	42.9278908	62.4463844	0.399246007	36544
31007	7	460	1	10000000	cplex	0	0	300	11	3	12	0	1	0	99	99	0.331438005	24.9394245	46.3807678	64.3026733	0.737057984	29352
31008	7	460	1	10000000	cplex	1	1	250	1	4	12	12	0	0	99		0.558007002	12.4189968	22.2618198	173.601501	0	2853
31009	7	461	1	10000000	cplex	0	1	300	10	0	7	0	1	0	99	99	0.292571008	14.2614536	27.3471775	35.6710472	0.778649986	17110
31010	7	461	1	10000000	cplex	1	0	250	11	1	7	0	1	0	99	99	0.184682995	14.4522591	26.0798111	34.3384628	0.879483998	21317
31011	7	461	1	10000000	cplex	1	1	250	11	2	7	0	1	0	99	99	0.238378003	14.4335833	26.3306236	35.0475388	0.497741014	21317
31012	7	461	1	10000000	cplex	0	0	300	11	3	7	0	1	0	99	99	0.25703299	14.3637314	27.6269646	35.3647156	0.750124991	17122
31013	7	461	1	10000000	cplex	1	1	250	1	4	7	7	0	0	99		0.463595003	15.0163984	25.3945141	246.399887	0	3557
31014	7	462	1	10000000	cplex	0	1	300	10	0	5	0	1	0	99	99	0.299854994	10.5216494	19.4282722	25.6607037	0.968410015	12222
31015	7	462	1	10000000	cplex	1	0	250	11	1	5	0	1	0	99	99	0.159770995	9.92049217	18.3051815	25.144289	0.886425972	15226
31016	7	462	1	10000000	cplex	1	1	250	11	2	5	0	1	0	99	99	0.229524001	9.52930546	18.0144882	25.3013363	0.727998018	15226
31017	7	462	1	10000000	cplex	0	0	300	11	3	5	0	1	0	99	99	0.229267001	10.217535	19.3500195	26.1805286	0.828342974	12230
31018	7	462	1	10000000	cplex	1	1	250	1	4	5	5	0	0	99		0.429580003	8.91277599	14.8553343	134.25119	0	2090
31019	7	463	1	10000000	cplex	0	1	300	10	0	7	0	1	0	99	99	0.273936987	15.3509951	28.2204723	38.1133156	1.17651606	17111
31020	7	463	1	10000000	cplex	1	0	250	11	1	7	0	1	0	99	99	0.212353006	13.6563234	25.9893608	36.8543625	0.987619996	21317
31021	7	463	1	10000000	cplex	1	1	250	11	2	7	0	1	0	99	99	0.221345007	12.9753323	25.4553356	36.4094429	0.616149008	21317
31022	7	463	1	10000000	cplex	0	0	300	11	3	7	0	1	0	99	99	0.279783994	14.1689577	27.5904789	37.9017296	1.05381501	17122
31023	7	463	1	10000000	cplex	1	1	250	1	4	7	7	0	0	99		0.43513	11.7054234	20.2914753	200.712601	0	2815
31024	7	464	1	10000000	cplex	0	1	300	10	0	5	0	1	0	99	99	0.281892002	11.1642323	20.0623112	26.9030666	1.15891004	12221
31025	7	464	1	10000000	cplex	1	0	250	11	1	5	0	1	0	99	99	0.155885994	10.0865116	18.6111431	26.4420547	0.562314987	15226
31026	7	464	1	10000000	cplex	1	1	250	11	2	5	0	1	0	99	99	0.223196998	10.4336224	18.8147106	25.9462395	0.573512971	15226
31027	7	464	1	10000000	cplex	0	0	300	11	3	5	0	1	0	99	99	0.213942006	11.1709948	20.0686779	27.2540531	0.547289014	12230
31028	7	464	1	10000000	cplex	1	1	250	1	4	5	5	0	0	99		0.427204996	10.5923176	18.0501213	162.006958	0	2572
31029	7	465	1	10000000	cplex	0	1	300	10	0	6	0	1	0	99	99	0.278788	12.1023951	23.2249069	33.1874771	0.722407997	14666
31030	7	465	1	10000000	cplex	1	0	250	11	1	6	0	1	0	99	99	0.215794995	11.6224489	21.4716358	31.5566139	0.730041981	18272
31031	7	465	1	10000000	cplex	1	1	250	11	2	6	0	1	0	99	99	0.230883002	11.667882	22.0593014	31.8429585	0.847814977	18272
31032	7	465	1	10000000	cplex	0	0	300	11	3	6	0	1	0	99	99	0.243346006	12.0637703	23.240263	32.9286499	0.586522996	14676
31033	7	465	1	10000000	cplex	1	1	250	1	4	6	6	0	0	99		0.429605991	8.09584427	13.8009329	115.75518	0	2168
31034	7	466	1	10000000	cplex	0	1	300	10	0	8	0	1	0	99	99	0.301901013	17.0727901	31.3587532	40.0162125	0.326440006	19558
31035	7	466	1	10000000	cplex	1	0	250	11	1	8	0	1	0	99	99	0.207124993	16.1142368	29.5414066	38.5819931	0.293365002	24362
31036	7	466	1	10000000	cplex	1	1	250	11	2	8	0	1	0	99	99	0.283785999	15.9437532	29.7314129	38.4864006	0.300702006	24362
31037	7	466	1	10000000	cplex	0	0	300	11	3	8	0	1	0	99	99	0.254750013	16.1958847	31.6358795	39.3657379	0.290302992	19568
31038	7	466	1	10000000	cplex	1	1	250	1	4	8	8	0	0	99		0.471731007	9.25892735	16.1062317	102.933022	0	2608
31039	7	467	1	10000000	cplex	0	1	300	10	0	6	0	1	0	99	99	0.255820006	13.241456	23.9585629	30.4991646	0.675382972	14666
31040	7	467	1	10000000	cplex	1	0	250	11	1	6	0	1	0	99	99	0.168749005	12.4520483	22.4030724	30.133234	0.733796	18272
31041	7	467	1	10000000	cplex	1	1	250	11	2	6	0	1	0	99	99	0.241453007	12.1010056	22.2929306	29.6738205	0.779618979	18272
31042	7	467	1	10000000	cplex	0	0	300	11	3	6	0	1	0	99	99	0.245399997	13.102335	23.6651688	31.3497944	0.700896978	14676
31043	7	467	1	10000000	cplex	1	1	250	1	4	6	6	0	0	99		0.427596986	10.4096889	18.3389587	169.599304	0	2523
31044	7	468	1	10000000	cplex	0	1	300	10	0	3	1	1	0.333332986	99	149	0.180795997	3.62466502	6.73748302	8.21078014	1.743981	5531
31045	7	468	1	10000000	cplex	1	0	250	11	1	3	1	1	0.333332986	99	149	0.104208998	3.38290191	6.05096197	7.42474604	1.71305299	7335
31046	7	468	1	10000000	cplex	1	1	250	11	2	3	1	1	0.333332986	99	149	0.129850999	3.36715794	6.05035782	7.4491148	1.65613699	7335
31047	7	468	1	10000000	cplex	0	0	300	11	3	3	1	1	0.333332986	99	149	0.167511001	3.77394509	6.75898409	8.17045879	1.59489405	5538
31048	7	468	1	10000000	cplex	1	1	250	1	4	3	3	0	0	99		0.40359199	4.9139142	8.00585365	48.6777954	0	1219
31049	7	469	1	10000000	cplex	0	1	300	10	0	4	0	1	0	99	99	0.30161199	8.50314617	16.0001259	21.6024933	0.384021997	9777
31050	7	469	1	10000000	cplex	1	0	250	11	1	4	0	1	0	99	99	0.126772001	7.69464111	14.4199743	20.558733	0.419551998	12181
31051	7	469	1	10000000	cplex	1	1	250	11	2	4	0	1	0	99	99	0.217467993	7.58849907	14.4392624	20.1656075	0.455325991	12181
31052	7	469	1	10000000	cplex	0	0	300	11	3	4	0	1	0	99	99	0.221532002	8.8797884	16.2025471	21.5393314	0.398167014	9784
31053	7	469	1	10000000	cplex	1	1	250	1	4	4	4	0	0	99		1.09214306	7.086411	11.9414806	80.4066696	0	1757
31054	7	470	1	10000000	cplex	0	1	300	10	0	10	0	1	0	49	49	0.421647012	33.0514603	61.6835213	81.9505997	0.846138	30447
31055	7	470	1	10000000	cplex	1	0	250	11	1	10	0	1	0	49	49	0.274064988	30.8896446	59.8906784	81.32621	0.323987007	36455
31056	7	470	1	10000000	cplex	1	1	250	11	2	10	0	1	0	49	49	0.347137988	30.4800396	59.1514587	80.1075668	0.299028993	36455
31057	7	470	1	10000000	cplex	0	0	300	11	3	10	0	1	0	49	49	0.339394987	33.8195763	63.2358475	82.4792709	0.327544004	30460
31058	7	470	1	10000000	cplex	1	1	250	1	4	10	10	0	0	49		0.631350994	4.97481823	8.97746658	35.4525719	0	2072
31059	7	471	1	10000000	cplex	0	1	300	10	0	10	0	1	0	49	49	0.403302997	33.2414398	62.8541069	83.7559891	0.485334992	30447
31060	7	471	1	10000000	cplex	1	0	250	11	1	10	0	1	0	49	49	0.334178001	32.3570175	60.3343239	83.4339523	0.624962986	36455
31061	7	472	1	10000000	cplex	0	1	300	10	0	9	0	1	0	49	49	0.426257998	26.1315651	49.7332306	71.6106186	0.349411011	27403
31062	7	472	1	10000000	cplex	1	0	250	11	1	9	0	1	0	49	49	0.266925991	26.5170994	48.5446167	69.6581726	0.780300021	32809
31063	7	472	1	10000000	cplex	1	1	250	11	2	9	0	1	0	49	49	0.404980004	25.5264187	47.7744598	69.2759171	0.480477005	32809
31064	7	472	1	10000000	cplex	0	0	300	11	3	9	0	1	0	49	49	0.362471998	27.1704483	50.2845802	71.3929901	0.77275002	27414
31065	7	472	1	10000000	cplex	1	1	250	1	4	9	9	0	0	49		0.555534005	4.62334013	7.46178389	33.7923431	0	1865
31066	7	473	1	10000000	cplex	0	1	300	10	0	6	0	1	0	49	49	0.344161987	18.7088833	34.290596	43.5252419	0.916634977	18268
31067	7	473	1	10000000	cplex	1	0	250	11	1	6	0	1	0	49	49	0.216060996	18.1436234	32.3061752	43.1918488	0.890371978	21873
31068	7	473	1	10000000	cplex	1	1	250	11	2	6	0	1	0	49	49	0.293224007	16.9811668	31.4279957	43.1068192	0.902864993	21873
31069	7	473	1	10000000	cplex	0	0	300	11	3	6	0	1	0	49	49	0.255228996	18.0254726	32.8670273	43.9122772	0.861060023	18276
31070	7	473	1	10000000	cplex	1	1	250	1	4	6	6	0	0	49		0.388707012	3.1284411	4.80267811	20.3679924	0	1241
31071	7	474	1	10000000	cplex	0	1	300	10	0	11	0	1	0	49	49	0.413738996	35.9736595	64.1717072	91.6426468	0.219594002	33494
31072	7	474	1	10000000	cplex	1	0	250	11	1	11	0	1	0	49	49	0.287622005	36.9347076	61.7798347	87.5291061	0.177248001	40100
31073	7	474	1	10000000	cplex	1	1	250	11	2	11	0	1	0	49	49	0.344725996	35.5503502	61.4816589	88.4253922	0.192728996	40100
31074	7	474	1	10000000	cplex	0	0	300	11	3	11	0	1	0	49	49	0.337370992	33.6002502	62.1548386	90.6121368	0.313921988	33506
31075	7	474	1	10000000	cplex	1	1	250	1	4	11	11	0	0	49		0.579091012	4.99576187	8.48469257	34.9730263	0	2127
31076	7	475	1	10000000	cplex	0	1	300	10	0	9	0	1	0	49	49	0.392275989	29.955925	53.6715927	70.9369278	0.207441002	27402
31077	7	475	1	10000000	cplex	1	0	250	11	1	9	0	1	0	49	49	0.257247001	28.0668545	49.6041679	68.8174744	0.212704003	32809
31078	7	475	1	10000000	cplex	1	1	250	11	2	9	0	1	0	49	49	0.406747997	26.819313	49.5313072	69.9538574	0.224353999	32809
31079	7	475	1	10000000	cplex	0	0	300	11	3	9	0	1	0	49	49	0.290856004	31.1077042	54.1235199	71.057724	0.182034001	27414
31080	7	475	1	10000000	cplex	1	1	250	1	4	9	9	0	0	49		0.491654009	4.85713005	7.92227697	39.7963028	0	1877
31081	7	476	1	10000000	cplex	0	1	300	10	0	11	0	1	0	49	49	0.424679995	36.2619171	64.5252914	93.3636169	0.550297022	33495
31082	7	476	1	10000000	cplex	1	0	250	11	1	11	0	1	0	49	49	0.279442012	33.1387978	60.6123428	89.6011276	0.917505026	40100
31083	7	476	1	10000000	cplex	1	1	250	11	2	11	0	1	0	49	49	0.349868	34.2750473	61.0452538	91.2269058	0.661244988	40100
31084	7	476	1	10000000	cplex	0	0	300	11	3	11	0	1	0	49	49	0.380394012	36.204731	63.5893097	91.163147	1.03964496	33506
31085	7	476	1	10000000	cplex	1	1	250	1	4	11	11	0	0	49		0.563556015	5.30092907	9.29520988	44.3930817	0	2279
31086	7	477	1	10000000	cplex	0	1	300	10	0	10	0	1	0	49	49	0.394677013	32.533699	59.3731232	80.6541214	0.370617986	30447
31087	7	477	1	10000000	cplex	1	0	250	11	1	10	0	1	0	49	49	0.273400992	32.0517082	57.4779549	79.3454056	0.373750001	36455
31088	7	477	1	10000000	cplex	1	1	250	11	2	10	0	1	0	49	49	0.341634005	32.8123894	57.7869072	79.6104126	0.391225994	36455
31089	7	477	1	10000000	cplex	0	0	300	11	3	10	0	1	0	49	49	0.346794993	33.5425453	59.1595268	80.0494003	0.354063988	30460
31090	7	477	1	10000000	cplex	1	1	250	1	4	10	10	0	0	49		0.512190998	4.90966702	8.72769928	35.7883682	0	2072
31091	7	478	1	10000000	cplex	0	1	300	10	0	7	0	1	0	49	49	0.382921994	21.6861	40.2815018	53.8494797	0.781590998	21315
31092	7	478	1	10000000	cplex	1	0	250	11	1	7	0	1	0	49	49	0.26343599	22.1504898	39.1055069	51.2823715	0.895195007	25518
31093	7	478	1	10000000	cplex	1	1	250	11	2	7	0	1	0	49	49	0.316774011	21.4032364	39.1974297	51.5193977	1.22763395	25518
31094	7	478	1	10000000	cplex	0	0	300	11	3	7	0	1	0	49	49	0.297457993	23.9601498	42.045105	52.9543381	0.894303024	21322
31095	7	478	1	10000000	cplex	1	1	250	1	4	7	7	0	0	49		0.44728899	3.58613801	6.00859785	26.4411259	0	1450
31096	7	479	1	10000000	cplex	0	1	300	10	0	8	0	1	0	49	49	0.416611999	26.2506943	47.4632034	61.6765709	0.295453995	24357
31097	7	479	1	10000000	cplex	1	0	250	11	1	8	0	1	0	49	49	0.223083004	27.5697823	46.6645279	59.1847839	0.846278012	29164
31098	7	479	1	10000000	cplex	1	1	250	11	2	8	0	1	0	49	49	0.309287012	25.7972069	45.9196053	60.366375	0.885774016	29164
31099	7	479	1	10000000	cplex	0	0	300	11	3	8	0	1	0	49	49	0.320627004	26.3971691	48.1955376	61.6054535	0.279089004	24368
31100	7	479	1	10000000	cplex	1	1	250	1	4	8	8	0	0	49		0.496443003	4.15339518	7.04933596	27.6490574	0	1658
\.


--
-- Name: exps_exp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xlwang
--

SELECT pg_catalog.setval('exps_exp_id_seq', 75, true);


--
-- Name: exps_pkey; Type: CONSTRAINT; Schema: public; Owner: xlwang; Tablespace: 
--

ALTER TABLE ONLY exps
    ADD CONSTRAINT exps_pkey PRIMARY KEY (exp_id);


--
-- PostgreSQL database dump complete
--

