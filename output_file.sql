--
-- PostgreSQL database dump
-- 

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

-- Started on 2024-11-15 09:32:17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16924)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    cname character varying(100) NOT NULL,
    population integer
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16966)
-- Name: discover; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discover (
    cname character varying(100) NOT NULL,
    disease_code character varying(50) NOT NULL,
    first_enc_date date
);


ALTER TABLE public.discover OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16899)
-- Name: disease; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disease (
    disease_code character varying(50) NOT NULL,
    pathogen character varying(100) NOT NULL,
    description character varying(255) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.disease OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16894)
-- Name: diseasetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diseasetype (
    id integer NOT NULL,
    description character varying(100) NOT NULL
);


ALTER TABLE public.diseasetype OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16946)
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    email character varying(255) NOT NULL,
    degree character varying(50) NOT NULL
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17016)
-- Name: patientdisease; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patientdisease (
    email character varying(255) NOT NULL,
    disease_code character varying(50) NOT NULL
);


ALTER TABLE public.patientdisease OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16934)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    email character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    surname character varying(100) NOT NULL,
    salary numeric(10,2),
    cname character varying(100),
    phone character varying(15)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17034)
-- Name: patientdiseases; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.patientdiseases AS
 SELECT users.name,
    users.surname,
    disease.description AS disease
   FROM ((public.patientdisease
     JOIN public.users ON (((patientdisease.email)::text = (users.email)::text)))
     JOIN public.disease ON (((patientdisease.disease_code)::text = (disease.disease_code)::text)));


ALTER TABLE public.patientdiseases OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16956)
-- Name: publicservant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publicservant (
    email character varying(255) NOT NULL,
    department character varying(100) NOT NULL
);


ALTER TABLE public.publicservant OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16981)
-- Name: record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.record (
    email character varying(255) NOT NULL,
    cname character varying(100) NOT NULL,
    disease_code character varying(50) NOT NULL,
    total_patients integer
);


ALTER TABLE public.record OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17001)
-- Name: specialize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialize (
    email character varying(255) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.specialize OWNER TO postgres;

--
-- TOC entry 3391 (class 0 OID 16924)
-- Dependencies: 216
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (cname, population) FROM stdin;
Kazakhstan	18500000
Uzbekistan	33000000
Russia	144000000
China	1400000000
India	1350000000
USA	330000000
Brazil	210000000
Germany	83000000
Japan	126000000
South Korea	52000000
\.


--
-- TOC entry 3395 (class 0 OID 16966)
-- Dependencies: 220
-- Data for Name: discover; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discover (cname, disease_code, first_enc_date) FROM stdin;
Kazakhstan	D001	2019-11-17
Uzbekistan	D002	2000-05-12
Russia	D003	2018-03-15
China	D004	1990-06-20
India	D005	2014-08-04
USA	D006	1995-01-11
Brazil	D007	2003-07-19
Germany	D008	2010-04-23
Japan	D009	1983-09-09
South Korea	D010	2001-02-14
\.


--
-- TOC entry 3390 (class 0 OID 16899)
-- Dependencies: 215
-- Data for Name: disease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disease (disease_code, pathogen, description, id) FROM stdin;
D001	virus	Covid-19	1
D002	bacteria	Tuberculosis	2
D003	virus	Flu	1
D004	bacteria	Strep Throat	2
D005	virus	Ebola	1
D006	bacteria	Cholera	2
D007	virus	Measles	1
D008	bacteria	Lyme Disease	2
D009	virus	HIV/AIDS	1
D010	bacteria	Anthrax	2
\.


--
-- TOC entry 3389 (class 0 OID 16894)
-- Dependencies: 214
-- Data for Name: diseasetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diseasetype (id, description) FROM stdin;
1	virology
2	bacteriology
3	infectious diseases
4	neurology
5	cardiology
6	example
7	cancer
8	auto-immune
9	injury
10	lastone
\.


--
-- TOC entry 3393 (class 0 OID 16946)
-- Dependencies: 218
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (email, degree) FROM stdin;
john.doe@example.com	MD
jane.smith@example.com	PhD
maria.garcia@example.com	MD
peter.jones@example.com	MD
anna.schmidt@example.com	PhD
li.wei@example.com	MD
sara.ali@example.com	MD
paul.brown@example.com	PhD
emily.clark@example.com	MD
omar.hassan@example.com	PhD
\.


--
-- TOC entry 3398 (class 0 OID 17016)
-- Dependencies: 223
-- Data for Name: patientdisease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patientdisease (email, disease_code) FROM stdin;
john.doe@example.com	D001
jane.smith@example.com	D003
maria.garcia@example.com	D009
peter.jones@example.com	D002
anna.schmidt@example.com	D004
sara.ali@example.com	D001
paul.brown@example.com	D005
emily.clark@example.com	D006
omar.hassan@example.com	D007
li.wei@example.com	D008
\.


--
-- TOC entry 3394 (class 0 OID 16956)
-- Dependencies: 219
-- Data for Name: publicservant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publicservant (email, department) FROM stdin;
john.doe@example.com	Health
jane.smith@example.com	Research
peter.jones@example.com	Emergency
anna.schmidt@example.com	Health
sara.ali@example.com	Health
omar.hassan@example.com	Research
li.wei@example.com	Emergency
maria.garcia@example.com	Health
paul.brown@example.com	Health
emily.clark@example.com	Health
\.


--
-- TOC entry 3396 (class 0 OID 16981)
-- Dependencies: 221
-- Data for Name: record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.record (email, cname, disease_code, total_patients) FROM stdin;
john.doe@example.com	USA	D001	150
jane.smith@example.com	Russia	D003	80
peter.jones@example.com	Uzbekistan	D002	45
anna.schmidt@example.com	Germany	D004	30
sara.ali@example.com	India	D001	200
paul.brown@example.com	Kazakhstan	D005	10
emily.clark@example.com	South Korea	D006	25
omar.hassan@example.com	Brazil	D007	40
li.wei@example.com	China	D008	60
maria.garcia@example.com	Japan	D009	20
\.


--
-- TOC entry 3397 (class 0 OID 17001)
-- Dependencies: 222
-- Data for Name: specialize; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialize (email, id) FROM stdin;
john.doe@example.com	1
jane.smith@example.com	1
maria.garcia@example.com	3
peter.jones@example.com	2
anna.schmidt@example.com	4
li.wei@example.com	1
sara.ali@example.com	1
paul.brown@example.com	5
emily.clark@example.com	3
omar.hassan@example.com	3
john.doe@example.com	2
john.doe@example.com	3
\.


--
-- TOC entry 3392 (class 0 OID 16934)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (email, name, surname, salary, cname, phone) FROM stdin;
jane.smith@example.com	Jane	Smith	60000.00	Uzbekistan	123-456-7890
maria.garcia@example.com	Maria	Garcia	70000.00	Russia	123-456-7891
peter.jones@example.com	Peter	Jones	55000.00	Brazil	123-456-7892
anna.schmidt@example.com	Anna	Schmidt	65000.00	Germany	123-456-7893
li.wei@example.com	Li	Wei	72000.00	China	123-456-7894
paul.brown@example.com	Paul	Brown	80000.00	Kazakhstan	123-456-7895
emily.clark@example.com	Emily	Clark	75000.00	Japan	123-456-7896
omar.hassan@example.com	Omar	Hassan	62000.00	South Korea	123-456-7897
john.doe@example.com	John	Doe	3200000.00	USA	123-456-7898
sara.ali@example.com	Sara	Ali	4352000.00	India	123-456-7899
user1@example.com	Alibek	Nurlybek	45000.00	Kazakhstan	123-456-7894
\.


--
-- TOC entry 3217 (class 2606 OID 16928)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (cname);


--
-- TOC entry 3226 (class 2606 OID 16970)
-- Name: discover discover_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_pkey PRIMARY KEY (cname, disease_code);


--
-- TOC entry 3215 (class 2606 OID 16903)
-- Name: disease disease_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pkey PRIMARY KEY (disease_code);


--
-- TOC entry 3213 (class 2606 OID 16898)
-- Name: diseasetype diseasetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diseasetype
    ADD CONSTRAINT diseasetype_pkey PRIMARY KEY (id);


--
-- TOC entry 3222 (class 2606 OID 16950)
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (email);


--
-- TOC entry 3232 (class 2606 OID 17020)
-- Name: patientdisease patientdisease_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientdisease
    ADD CONSTRAINT patientdisease_pkey PRIMARY KEY (email, disease_code);


--
-- TOC entry 3224 (class 2606 OID 16960)
-- Name: publicservant publicservant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicservant
    ADD CONSTRAINT publicservant_pkey PRIMARY KEY (email);


--
-- TOC entry 3228 (class 2606 OID 16985)
-- Name: record record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_pkey PRIMARY KEY (email, disease_code, cname);


--
-- TOC entry 3230 (class 2606 OID 17005)
-- Name: specialize specialize_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_pkey PRIMARY KEY (email, id);


--
-- TOC entry 3220 (class 2606 OID 16940)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- TOC entry 3218 (class 1259 OID 17038)
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_users_email ON public.users USING btree (email);


--
-- TOC entry 3237 (class 2606 OID 16971)
-- Name: discover discover_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE CASCADE;


--
-- TOC entry 3238 (class 2606 OID 16976)
-- Name: discover discover_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;


--
-- TOC entry 3233 (class 2606 OID 16904)
-- Name: disease disease_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_id_fkey FOREIGN KEY (id) REFERENCES public.diseasetype(id) ON DELETE CASCADE;


--
-- TOC entry 3235 (class 2606 OID 16951)
-- Name: doctor doctor_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;


--
-- TOC entry 3244 (class 2606 OID 17026)
-- Name: patientdisease patientdisease_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientdisease
    ADD CONSTRAINT patientdisease_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;


--
-- TOC entry 3245 (class 2606 OID 17021)
-- Name: patientdisease patientdisease_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientdisease
    ADD CONSTRAINT patientdisease_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;


--
-- TOC entry 3236 (class 2606 OID 16961)
-- Name: publicservant publicservant_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicservant
    ADD CONSTRAINT publicservant_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;


--
-- TOC entry 3239 (class 2606 OID 16991)
-- Name: record record_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE CASCADE;


--
-- TOC entry 3240 (class 2606 OID 16996)
-- Name: record record_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;


--
-- TOC entry 3241 (class 2606 OID 16986)
-- Name: record record_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_email_fkey FOREIGN KEY (email) REFERENCES public.publicservant(email) ON DELETE CASCADE;


--
-- TOC entry 3242 (class 2606 OID 17006)
-- Name: specialize specialize_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_email_fkey FOREIGN KEY (email) REFERENCES public.doctor(email) ON DELETE CASCADE;


--
-- TOC entry 3243 (class 2606 OID 17011)
-- Name: specialize specialize_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_id_fkey FOREIGN KEY (id) REFERENCES public.diseasetype(id) ON DELETE CASCADE;


--
-- TOC entry 3234 (class 2606 OID 16941)
-- Name: users users_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE CASCADE;


-- Completed on 2024-11-15 09:32:21

--
-- PostgreSQL database dump complete
--

