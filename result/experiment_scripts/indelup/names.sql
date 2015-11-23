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
-- Name: names; Type: TABLE; Schema: public; Owner: ewu; Tablespace: 
--

CREATE TABLE names (
    sname text,
    name text
);


ALTER TABLE names OWNER TO ewu;

--
-- Data for Name: names; Type: TABLE DATA; Schema: public; Owner: ewu
--

COPY names (sname, name) FROM stdin;
cplex_allqueries	All Queries
cplex_singlequery	Single Query
Naive_cplex	Exh
cplex_searchall	inc-all
cplex_searchall_1iter	inc-all
cplex_stopearly	inc-1st
cplex_stopearly_1iter	inc-1st
cplex_stopearly_2iter	t,inc-1st
cplex0	ta,inc-1st
cplex1	tq,inc-1st
cplex2	taq,inc-1st
cplex3	t,inc-1st
\.


--
-- PostgreSQL database dump complete
--

