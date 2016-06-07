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

--
-- Data for Name: taxes; Type: TABLE DATA; Schema: public; Owner: xlwang
--

COPY taxes (employee_id, income, tax_rate, pay) FROM stdin;
1	186000	0.25	\N
2	177000	0.25	\N
3	9000	0.150000006	\N
4	210000	0.300000012	\N
5	172000	0.25	\N
\.


--
-- PostgreSQL database dump complete
--

