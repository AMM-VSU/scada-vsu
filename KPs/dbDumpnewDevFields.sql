--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.1
-- Dumped by pg_dump version 9.4.1
-- Started on 2015-05-02 21:28:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE scadatest;
--
-- TOC entry 2079 (class 1262 OID 16460)
-- Name: scadatest; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE scadatest WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';


ALTER DATABASE scadatest OWNER TO postgres;

\connect scadatest

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 186 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 186
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 16541)
-- Name: allowed_commands; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE allowed_commands (
    device_id_device integer NOT NULL,
    command_type_id_command_type integer NOT NULL,
    descr character varying(15)
);


ALTER TABLE allowed_commands OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 16495)
-- Name: command; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE command (
    id_command integer NOT NULL,
    descr character varying(15),
    action character varying(15) NOT NULL,
    id_command_state integer NOT NULL,
    id_device integer NOT NULL,
    id_command_type integer NOT NULL,
    command_data character varying(40) NOT NULL
);


ALTER TABLE command OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 16493)
-- Name: command_id_command_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE command_id_command_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE command_id_command_seq OWNER TO postgres;

--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 179
-- Name: command_id_command_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE command_id_command_seq OWNED BY command.id_command;


--
-- TOC entry 178 (class 1259 OID 16487)
-- Name: command_state; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE command_state (
    id_command_state integer NOT NULL,
    name character varying(15) NOT NULL
);


ALTER TABLE command_state OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 16485)
-- Name: command_state_id_command_state_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE command_state_id_command_state_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE command_state_id_command_state_seq OWNER TO postgres;

--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 177
-- Name: command_state_id_command_state_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE command_state_id_command_state_seq OWNED BY command_state.id_command_state;


--
-- TOC entry 185 (class 1259 OID 16548)
-- Name: command_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE command_type (
    id_command_type integer NOT NULL,
    name character varying(15)
);


ALTER TABLE command_type OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16546)
-- Name: command_type_id_command_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE command_type_id_command_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE command_type_id_command_type_seq OWNER TO postgres;

--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 184
-- Name: command_type_id_command_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE command_type_id_command_type_seq OWNED BY command_type.id_command_type;


--
-- TOC entry 182 (class 1259 OID 16503)
-- Name: data; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE data (
    id_data integer NOT NULL,
    "time" integer NOT NULL,
    id_device integer NOT NULL,
    channel integer NOT NULL,
    value real NOT NULL,
    state integer NOT NULL,
    descr character varying(15)
);


ALTER TABLE data OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16501)
-- Name: data_id_data_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE data_id_data_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE data_id_data_seq OWNER TO postgres;

--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 181
-- Name: data_id_data_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE data_id_data_seq OWNED BY data.id_data;


--
-- TOC entry 173 (class 1259 OID 16463)
-- Name: device; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE device (
    id_device integer NOT NULL,
    ser_addr character varying(15) NOT NULL,
    descr text,
    has_graph boolean DEFAULT false NOT NULL,
    has_state boolean DEFAULT false NOT NULL
);


ALTER TABLE device OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16461)
-- Name: device_id_device_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE device_id_device_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device_id_device_seq OWNER TO postgres;

--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 172
-- Name: device_id_device_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE device_id_device_seq OWNED BY device.id_device;


--
-- TOC entry 175 (class 1259 OID 16474)
-- Name: device_state; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE device_state (
    id_device_state integer NOT NULL,
    name character varying(15) NOT NULL
);


ALTER TABLE device_state OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 16480)
-- Name: device_state_has_device; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE device_state_has_device (
    id_device_state integer NOT NULL,
    id_device integer NOT NULL,
    "time" integer NOT NULL
);


ALTER TABLE device_state_has_device OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 16472)
-- Name: device_state_id_device_state_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE device_state_id_device_state_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device_state_id_device_state_seq OWNER TO postgres;

--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 174
-- Name: device_state_id_device_state_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE device_state_id_device_state_seq OWNED BY device_state.id_device_state;


--
-- TOC entry 1925 (class 2604 OID 16498)
-- Name: id_command; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY command ALTER COLUMN id_command SET DEFAULT nextval('command_id_command_seq'::regclass);


--
-- TOC entry 1924 (class 2604 OID 16490)
-- Name: id_command_state; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY command_state ALTER COLUMN id_command_state SET DEFAULT nextval('command_state_id_command_state_seq'::regclass);


--
-- TOC entry 1927 (class 2604 OID 16551)
-- Name: id_command_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY command_type ALTER COLUMN id_command_type SET DEFAULT nextval('command_type_id_command_type_seq'::regclass);


--
-- TOC entry 1926 (class 2604 OID 16506)
-- Name: id_data; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY data ALTER COLUMN id_data SET DEFAULT nextval('data_id_data_seq'::regclass);


--
-- TOC entry 1920 (class 2604 OID 16466)
-- Name: id_device; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device ALTER COLUMN id_device SET DEFAULT nextval('device_id_device_seq'::regclass);


--
-- TOC entry 1923 (class 2604 OID 16477)
-- Name: id_device_state; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device_state ALTER COLUMN id_device_state SET DEFAULT nextval('device_state_id_device_state_seq'::regclass);


--
-- TOC entry 2072 (class 0 OID 16541)
-- Dependencies: 183
-- Data for Name: allowed_commands; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2069 (class 0 OID 16495)
-- Dependencies: 180
-- Data for Name: command; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 179
-- Name: command_id_command_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('command_id_command_seq', 1, false);


--
-- TOC entry 2067 (class 0 OID 16487)
-- Dependencies: 178
-- Data for Name: command_state; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO command_state (id_command_state, name) VALUES (1, 'added');
INSERT INTO command_state (id_command_state, name) VALUES (2, 'sent');


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 177
-- Name: command_state_id_command_state_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('command_state_id_command_state_seq', 2, true);


--
-- TOC entry 2074 (class 0 OID 16548)
-- Dependencies: 185
-- Data for Name: command_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 184
-- Name: command_type_id_command_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('command_type_id_command_type_seq', 1, false);


--
-- TOC entry 2071 (class 0 OID 16503)
-- Dependencies: 182
-- Data for Name: data; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1, 1429913026, 1, 2, 1.79999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (2, 1429913026, 1, 1, 54.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (3, 1429913101, 1, 2, 29.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (4, 1429913101, 1, 1, 94.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (5, 1429913123, 1, 2, 23.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (6, 1429913123, 1, 1, 98.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (7, 1429913142, 1, 2, 11.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (8, 1429913142, 1, 1, 61.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (9, 1429913151, 1, 2, 15.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (10, 1429913151, 1, 1, 59.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (11, 1429913153, 1, 2, 18.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (12, 1429913153, 1, 1, 87.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (13, 1429913156, 1, 2, 44.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (14, 1429913156, 1, 1, 56.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (15, 1429913158, 1, 2, 91.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (16, 1429913158, 1, 1, 8.39999962, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (17, 1429913160, 1, 2, 84.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (18, 1429913160, 1, 1, 65.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (19, 1429913162, 1, 2, 68.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (20, 1429913162, 1, 1, 28.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (21, 1429913164, 1, 2, 30, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (22, 1429913164, 1, 1, 7.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (23, 1429913167, 1, 2, 10.1999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (24, 1429913167, 1, 1, 21.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (25, 1429913169, 1, 2, 84.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (26, 1429913169, 1, 1, 10.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (27, 1429913171, 1, 2, 83.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (28, 1429913171, 1, 1, 84.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (29, 1429913173, 1, 2, 48.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (30, 1429913173, 1, 1, 42.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (31, 1429913175, 1, 2, 8.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (32, 1429913175, 1, 1, 51.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (33, 1429913178, 1, 2, 41.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (34, 1429913178, 1, 1, 75.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (35, 1429913180, 1, 2, 38.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (36, 1429913180, 1, 1, 35.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (37, 1429913182, 1, 2, 43.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (38, 1429913182, 1, 1, 97.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (39, 1429913184, 1, 2, 0.600000024, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (40, 1429913184, 1, 1, 4.5999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (41, 1429913187, 1, 2, 4, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (42, 1429913187, 1, 1, 63.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (43, 1429913189, 1, 2, 9, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (44, 1429913189, 1, 1, 89.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (45, 1429913191, 1, 2, 73.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (46, 1429913191, 1, 1, 16.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (47, 1429913193, 1, 2, 96.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (48, 1429913193, 1, 1, 85.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (49, 1429913195, 1, 2, 0.100000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (50, 1429913195, 1, 1, 70.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (51, 1429913198, 1, 2, 28.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (52, 1429913198, 1, 1, 5.4000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (53, 1429913200, 1, 2, 91.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (54, 1429913200, 1, 1, 94.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (55, 1429913202, 1, 2, 68.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (56, 1429913202, 1, 1, 3.79999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (57, 1429913204, 1, 2, 51.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (58, 1429913204, 1, 1, 58.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (59, 1429913206, 1, 2, 51.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (60, 1429913206, 1, 1, 69, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (61, 1429913209, 1, 2, 9.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (62, 1429913209, 1, 1, 72, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (63, 1429913211, 1, 2, 84.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (64, 1429913211, 1, 1, 73.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (65, 1429913213, 1, 2, 51.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (66, 1429913213, 1, 1, 67, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (67, 1429913215, 1, 2, 46, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (68, 1429913215, 1, 1, 69.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (69, 1429913217, 1, 2, 17.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (70, 1429913217, 1, 1, 55.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (71, 1429913220, 1, 2, 64.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (72, 1429913220, 1, 1, 87.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (73, 1429913222, 1, 2, 65, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (74, 1429913222, 1, 1, 63.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (75, 1429913224, 1, 2, 24.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (76, 1429913224, 1, 1, 66.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (77, 1429913226, 1, 2, 98.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (78, 1429913226, 1, 1, 20.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (79, 1429913229, 1, 2, 48.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (80, 1429913229, 1, 1, 68.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (81, 1429913231, 1, 2, 14.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (82, 1429913231, 1, 1, 97.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (83, 1429913233, 1, 2, 84.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (84, 1429913233, 1, 1, 78, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (85, 1429913235, 1, 2, 14.1999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (86, 1429913235, 1, 1, 3.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (87, 1429913237, 1, 2, 60.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (88, 1429913237, 1, 1, 47.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (89, 1429913240, 1, 2, 6.4000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (90, 1429913240, 1, 1, 34.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (91, 1429913242, 1, 2, 83.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (92, 1429913242, 1, 1, 85.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (93, 1429913244, 1, 2, 45.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (94, 1429913244, 1, 1, 31.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (95, 1429913246, 1, 2, 94.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (96, 1429913246, 1, 1, 32, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (97, 1429913249, 1, 2, 78.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (98, 1429913249, 1, 1, 35.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (99, 1429913251, 1, 2, 38.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (100, 1429913251, 1, 1, 6.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (101, 1429913253, 1, 2, 70.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (102, 1429913253, 1, 1, 27.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (103, 1429913255, 1, 2, 67.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (104, 1429913255, 1, 1, 44.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (105, 1429913257, 1, 2, 6.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (106, 1429913257, 1, 1, 41, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (107, 1429913260, 1, 2, 40.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (108, 1429913260, 1, 1, 27.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (109, 1429913262, 1, 2, 69.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (110, 1429913262, 1, 1, 2.4000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (111, 1429913264, 1, 2, 5.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (112, 1429913264, 1, 1, 30.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (113, 1429913266, 1, 2, 9.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (114, 1429913266, 1, 1, 83.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (115, 1429913268, 1, 2, 54.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (116, 1429913268, 1, 1, 12.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (117, 1429913271, 1, 2, 87.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (118, 1429913271, 1, 1, 6.5999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (119, 1429913273, 1, 2, 58.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (120, 1429913273, 1, 1, 48.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (121, 1429913275, 1, 2, 6.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (122, 1429913275, 1, 1, 98.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (123, 1429913277, 1, 2, 62.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (124, 1429913277, 1, 1, 82.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (125, 1429913280, 1, 2, 72, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (126, 1429913280, 1, 1, 79, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (127, 1429913282, 1, 2, 41.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (128, 1429913282, 1, 1, 33.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (129, 1429913284, 1, 2, 68.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (130, 1429913284, 1, 1, 92.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (131, 1429913286, 1, 2, 87.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (132, 1429913286, 1, 1, 62.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (133, 1429913288, 1, 2, 82.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (134, 1429913288, 1, 1, 42, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (135, 1429913291, 1, 2, 98.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (136, 1429913291, 1, 1, 86.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (137, 1429913293, 1, 2, 29.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (138, 1429913293, 1, 1, 40.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (139, 1429913295, 1, 2, 71.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (140, 1429913295, 1, 1, 73.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (141, 1429913297, 1, 2, 62.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (142, 1429913297, 1, 1, 32.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (143, 1429913299, 1, 2, 77.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (144, 1429913299, 1, 1, 3.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (145, 1429913302, 1, 2, 29.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (146, 1429913302, 1, 1, 52.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (147, 1429913304, 1, 2, 75.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (148, 1429913304, 1, 1, 62.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (149, 1429913306, 1, 2, 76.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (150, 1429913306, 1, 1, 82.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (151, 1429913308, 1, 2, 44.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (152, 1429913308, 1, 1, 72.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (153, 1429913311, 1, 2, 76.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (154, 1429913311, 1, 1, 90, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (155, 1429913313, 1, 2, 99.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (156, 1429913313, 1, 1, 71.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (157, 1429913315, 1, 2, 64.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (158, 1429913315, 1, 1, 85, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (159, 1429913317, 1, 2, 72.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (160, 1429913317, 1, 1, 27.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (161, 1429913319, 1, 2, 99.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (162, 1429913319, 1, 1, 7, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (163, 1429913322, 1, 2, 58.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (164, 1429913322, 1, 1, 76.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (165, 1429913324, 1, 2, 15, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (166, 1429913324, 1, 1, 42.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (167, 1429913326, 1, 2, 48.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (168, 1429913326, 1, 1, 67.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (169, 1429913328, 1, 2, 84.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (170, 1429913328, 1, 1, 67.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (171, 1429913331, 1, 2, 83.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (172, 1429913331, 1, 1, 47.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (173, 1429913333, 1, 2, 34.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (174, 1429913333, 1, 1, 85.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (175, 1429913335, 1, 2, 85.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (176, 1429913335, 1, 1, 73.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (177, 1429913337, 1, 2, 20.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (178, 1429913337, 1, 1, 58.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (179, 1429913339, 1, 2, 53.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (180, 1429913339, 1, 1, 19.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (181, 1429913342, 1, 2, 3.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (182, 1429913342, 1, 1, 78.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (183, 1429913344, 1, 2, 56.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (184, 1429913344, 1, 1, 86.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (185, 1429913346, 1, 2, 48.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (186, 1429913346, 1, 1, 15, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (187, 1429913348, 1, 2, 85.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (188, 1429913348, 1, 1, 92.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (189, 1429913350, 1, 2, 42.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (190, 1429913350, 1, 1, 26.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (191, 1429913353, 1, 2, 22.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (192, 1429913353, 1, 1, 44.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (193, 1429913355, 1, 2, 68, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (194, 1429913355, 1, 1, 44.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (195, 1429913357, 1, 2, 73.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (196, 1429913357, 1, 1, 55.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (197, 1429913359, 1, 2, 73.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (198, 1429913359, 1, 1, 1.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (199, 1429913362, 1, 2, 88.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (200, 1429913362, 1, 1, 86.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (201, 1429913364, 1, 2, 4.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (202, 1429913364, 1, 1, 7.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (203, 1429913366, 1, 2, 77.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (204, 1429913366, 1, 1, 8.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (205, 1429913368, 1, 2, 98.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (206, 1429913368, 1, 1, 97.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (207, 1429913371, 1, 2, 37.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (208, 1429913371, 1, 1, 91.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (209, 1429913373, 1, 2, 4.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (210, 1429913373, 1, 1, 26.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (211, 1429913375, 1, 2, 51, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (212, 1429913375, 1, 1, 5.5999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (213, 1429913377, 1, 2, 31.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (214, 1429913377, 1, 1, 52.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (215, 1429913379, 1, 2, 23.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (216, 1429913379, 1, 1, 20.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (217, 1429913382, 1, 2, 50.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (218, 1429913382, 1, 1, 72.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (219, 1429913384, 1, 2, 28.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (220, 1429913384, 1, 1, 0, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (221, 1429913386, 1, 2, 57, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (222, 1429913386, 1, 1, 55.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (223, 1429913388, 1, 2, 25.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (224, 1429913388, 1, 1, 58.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (225, 1429913391, 1, 2, 45.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (226, 1429913391, 1, 1, 38.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (227, 1429913393, 1, 2, 79.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (228, 1429913393, 1, 1, 90.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (229, 1429913395, 1, 2, 12.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (230, 1429913395, 1, 1, 29.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (231, 1429913397, 1, 2, 99.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (232, 1429913397, 1, 1, 19.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (233, 1429913399, 1, 2, 70, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (234, 1429913399, 1, 1, 66.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (235, 1429913402, 1, 2, 14.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (236, 1429913402, 1, 1, 95.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (237, 1429913404, 1, 2, 0.800000012, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (238, 1429913404, 1, 1, 47.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (239, 1429913406, 1, 2, 87.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (240, 1429913406, 1, 1, 51, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (241, 1429913408, 1, 2, 77.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (242, 1429913408, 1, 1, 94.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (243, 1429913410, 1, 2, 88, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (244, 1429913410, 1, 1, 15.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (245, 1429913413, 1, 2, 75.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (246, 1429913413, 1, 1, 16.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (247, 1429913415, 1, 2, 12.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (248, 1429913415, 1, 1, 15, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (249, 1429913417, 1, 2, 20.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (250, 1429913417, 1, 1, 52.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (251, 1429913419, 1, 2, 5.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (252, 1429913419, 1, 1, 1.39999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (253, 1429913421, 1, 2, 72.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (254, 1429913421, 1, 1, 88.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (255, 1429913424, 1, 2, 29.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (256, 1429913424, 1, 1, 48.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (257, 1429913426, 1, 2, 82.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (258, 1429913426, 1, 1, 19.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (259, 1429913428, 1, 2, 63.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (260, 1429913428, 1, 1, 60, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (261, 1429913430, 1, 2, 18.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (262, 1429913430, 1, 1, 46.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (263, 1429913433, 1, 2, 79, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (264, 1429913433, 1, 1, 74.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (265, 1429913435, 1, 2, 26.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (266, 1429913435, 1, 1, 31.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (267, 1429913437, 1, 2, 35.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (268, 1429913437, 1, 1, 65.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (269, 1429913439, 1, 2, 38.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (270, 1429913439, 1, 1, 28.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (271, 1429913441, 1, 2, 19.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (272, 1429913441, 1, 1, 2.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (273, 1429913444, 1, 2, 84.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (274, 1429913444, 1, 1, 77.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (275, 1429913446, 1, 2, 22.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (276, 1429913446, 1, 1, 62.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (277, 1429913448, 1, 2, 67.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (278, 1429913448, 1, 1, 9.60000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (279, 1429913450, 1, 2, 82.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (280, 1429913450, 1, 1, 28.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (281, 1429913453, 1, 2, 26.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (282, 1429913453, 1, 1, 64, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (283, 1429913455, 1, 2, 70, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (284, 1429913455, 1, 1, 59.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (285, 1429913457, 1, 2, 24.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (286, 1429913457, 1, 1, 98.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (287, 1429913459, 1, 2, 46.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (288, 1429913459, 1, 1, 81.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (289, 1429913461, 1, 2, 36.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (290, 1429913461, 1, 1, 65.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (291, 1429913464, 1, 2, 12.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (292, 1429913464, 1, 1, 81, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (293, 1429913466, 1, 2, 84.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (294, 1429913466, 1, 1, 27.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (295, 1429913468, 1, 2, 32.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (296, 1429913468, 1, 1, 30.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (297, 1429913470, 1, 2, 15.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (298, 1429913470, 1, 1, 13.1999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (299, 1429913472, 1, 2, 89.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (300, 1429913472, 1, 1, 44, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (301, 1429913475, 1, 2, 81.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (302, 1429913475, 1, 1, 47.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (303, 1429913477, 1, 2, 76.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (304, 1429913477, 1, 1, 91.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (305, 1429913479, 1, 2, 32.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (306, 1429913479, 1, 1, 2.70000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (307, 1429913481, 1, 2, 16.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (308, 1429913481, 1, 1, 95.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (309, 1429913484, 1, 2, 66.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (310, 1429913484, 1, 1, 67.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (311, 1429913486, 1, 2, 81.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (312, 1429913486, 1, 1, 72.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (313, 1429913488, 1, 2, 37.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (314, 1429913488, 1, 1, 34.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (315, 1429913490, 1, 2, 33.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (316, 1429913490, 1, 1, 54.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (317, 1429913492, 1, 2, 76.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (318, 1429913492, 1, 1, 19.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (319, 1429913495, 1, 2, 50.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (320, 1429913495, 1, 1, 28.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (321, 1429913497, 1, 2, 85.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (322, 1429913497, 1, 1, 54.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (323, 1429913499, 1, 2, 28.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (324, 1429913499, 1, 1, 72.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (325, 1429913501, 1, 2, 15.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (326, 1429913501, 1, 1, 38.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (327, 1429913503, 1, 2, 18.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (328, 1429913503, 1, 1, 57.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (329, 1429913506, 1, 2, 44.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (330, 1429913506, 1, 1, 91.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (331, 1429913508, 1, 2, 47, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (332, 1429913508, 1, 1, 54.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (333, 1429913510, 1, 2, 20, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (334, 1429913510, 1, 1, 38.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (335, 1429913512, 1, 2, 47.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (336, 1429913512, 1, 1, 78.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (337, 1429913515, 1, 2, 87.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (338, 1429913515, 1, 1, 78.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (339, 1429913517, 1, 2, 26.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (340, 1429913517, 1, 1, 21.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (341, 1429913519, 1, 2, 81.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (342, 1429913519, 1, 1, 50.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (343, 1429913521, 1, 2, 14.8000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (344, 1429913521, 1, 1, 69.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (345, 1429913523, 1, 2, 84.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (346, 1429913523, 1, 1, 40.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (347, 1429913526, 1, 2, 43.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (348, 1429913526, 1, 1, 49.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (349, 1429913528, 1, 2, 93.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (350, 1429913528, 1, 1, 78.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (351, 1429913530, 1, 2, 53.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (352, 1429913530, 1, 1, 95.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (353, 1429913532, 1, 2, 62.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (354, 1429913532, 1, 1, 61.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (355, 1429913534, 1, 2, 58.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (356, 1429913534, 1, 1, 26.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (357, 1429913537, 1, 2, 19, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (358, 1429913537, 1, 1, 4, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (359, 1429913539, 1, 2, 76, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (360, 1429913539, 1, 1, 93.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (361, 1429913541, 1, 2, 84.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (362, 1429913541, 1, 1, 59, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (363, 1429913543, 1, 2, 51.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (364, 1429913543, 1, 1, 74.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (365, 1429913546, 1, 2, 20.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (366, 1429913546, 1, 1, 27, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (367, 1429913548, 1, 2, 52.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (368, 1429913548, 1, 1, 98.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (369, 1429913550, 1, 2, 87.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (370, 1429913550, 1, 1, 55, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (371, 1429913552, 1, 2, 66.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (372, 1429913552, 1, 1, 98.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (373, 1429913554, 1, 2, 93.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (374, 1429913554, 1, 1, 28.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (375, 1429913557, 1, 2, 46.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (376, 1429913557, 1, 1, 34.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (377, 1429913559, 1, 2, 39.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (378, 1429913559, 1, 1, 59, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (379, 1429913561, 1, 2, 88.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (380, 1429913561, 1, 1, 75.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (381, 1429913563, 1, 2, 95.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (382, 1429913563, 1, 1, 68.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (383, 1429913565, 1, 2, 63.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (384, 1429913565, 1, 1, 65.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (385, 1429913568, 1, 2, 37.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (386, 1429913568, 1, 1, 51.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (387, 1429913570, 1, 2, 91.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (388, 1429913570, 1, 1, 58.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (389, 1429913572, 1, 2, 79.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (390, 1429913572, 1, 1, 20.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (391, 1429913574, 1, 2, 59.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (392, 1429913574, 1, 1, 83.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (393, 1429913577, 1, 2, 2.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (394, 1429913577, 1, 1, 32.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (395, 1429913579, 1, 2, 37, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (396, 1429913579, 1, 1, 22.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (397, 1429913581, 1, 2, 99.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (398, 1429913581, 1, 1, 40, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (399, 1429913583, 1, 2, 49.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (400, 1429913583, 1, 1, 57.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (401, 1429913585, 1, 2, 87.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (402, 1429913585, 1, 1, 44.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (403, 1429913588, 1, 2, 61.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (404, 1429913588, 1, 1, 38.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (405, 1429913590, 1, 2, 11.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (406, 1429913590, 1, 1, 55.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (407, 1429913592, 1, 2, 2.70000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (408, 1429913592, 1, 1, 34.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (409, 1429913594, 1, 2, 14.8000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (410, 1429913594, 1, 1, 24.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (411, 1429913596, 1, 2, 87.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (412, 1429913597, 1, 1, 59.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (413, 1429913599, 1, 2, 15.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (414, 1429913599, 1, 1, 0.300000012, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (415, 1429913601, 1, 2, 98.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (416, 1429913601, 1, 1, 16, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (417, 1429913603, 1, 2, 95.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (418, 1429913603, 1, 1, 85.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (419, 1429913605, 1, 2, 37.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (420, 1429913605, 1, 1, 68.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (421, 1429913608, 1, 2, 35.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (422, 1429913608, 1, 1, 93.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (423, 1429913610, 1, 2, 19.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (424, 1429913610, 1, 1, 67.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (425, 1429913612, 1, 2, 95.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (426, 1429913612, 1, 1, 83.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (427, 1429913614, 1, 2, 96.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (428, 1429913614, 1, 1, 60.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (429, 1429913616, 1, 2, 91.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (430, 1429913616, 1, 1, 23.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (431, 1429913619, 1, 2, 35, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (432, 1429913619, 1, 1, 99.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (433, 1429913621, 1, 2, 9.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (434, 1429913621, 1, 1, 31.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (435, 1429913623, 1, 2, 88.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (436, 1429913623, 1, 1, 50.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (437, 1429913625, 1, 2, 6.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (438, 1429913625, 1, 1, 25.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (439, 1429913628, 1, 2, 54.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (440, 1429913628, 1, 1, 82.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (441, 1429913630, 1, 2, 48.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (442, 1429913630, 1, 1, 57.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (443, 1429913632, 1, 2, 43.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (444, 1429913632, 1, 1, 55.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (445, 1429913634, 1, 2, 32.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (446, 1429913634, 1, 1, 99.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (447, 1429913636, 1, 2, 67.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (448, 1429913636, 1, 1, 1.79999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (449, 1429913639, 1, 2, 33.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (450, 1429913639, 1, 1, 21, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (451, 1429913641, 1, 2, 27.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (452, 1429913641, 1, 1, 14.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (453, 1429913643, 1, 2, 2.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (454, 1429913643, 1, 1, 80.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (455, 1429913645, 1, 2, 21.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (456, 1429913645, 1, 1, 93.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (457, 1429913647, 1, 2, 25.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (458, 1429913647, 1, 1, 94.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (459, 1429913650, 1, 2, 43.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (460, 1429913650, 1, 1, 27.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (461, 1429913652, 1, 2, 58.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (462, 1429913652, 1, 1, 42.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (463, 1429913654, 1, 2, 42.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (464, 1429913654, 1, 1, 90.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (465, 1429913656, 1, 2, 89.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (466, 1429913656, 1, 1, 88, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (467, 1429913659, 1, 2, 50.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (468, 1429913659, 1, 1, 84.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (469, 1429913661, 1, 2, 12.1999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (470, 1429913661, 1, 1, 48.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (471, 1429913663, 1, 2, 9.10000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (472, 1429913663, 1, 1, 69.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (473, 1429913665, 1, 2, 31.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (474, 1429913665, 1, 1, 54.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (475, 1429913667, 1, 2, 20.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (476, 1429913667, 1, 1, 78.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (477, 1429913670, 1, 2, 49.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (478, 1429913670, 1, 1, 63.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (479, 1429913672, 1, 2, 34.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (480, 1429913672, 1, 1, 95.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (481, 1429913674, 1, 2, 16.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (482, 1429913674, 1, 1, 94.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (483, 1429913676, 1, 2, 26.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (484, 1429913676, 1, 1, 70.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (485, 1429913678, 1, 2, 96.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (486, 1429913678, 1, 1, 20.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (487, 1429913681, 1, 1, 29.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (488, 1429913683, 1, 2, 9.60000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (489, 1429913683, 1, 1, 94.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (490, 1429913685, 1, 2, 25.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (491, 1429913685, 1, 1, 12.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (492, 1429913687, 1, 2, 82.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (493, 1429913687, 1, 1, 26.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (494, 1429913690, 1, 2, 23.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (495, 1429913690, 1, 1, 6.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (496, 1429913692, 1, 2, 14.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (497, 1429913692, 1, 1, 52.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (498, 1429913694, 1, 2, 66.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (499, 1429913694, 1, 1, 44.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (500, 1429913696, 1, 2, 49.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (501, 1429913696, 1, 1, 82.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (502, 1429913698, 1, 2, 89.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (503, 1429913698, 1, 1, 85.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (504, 1429913701, 1, 2, 11.8000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (505, 1429913701, 1, 1, 57.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (506, 1429913703, 1, 2, 83, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (507, 1429913703, 1, 1, 48.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (508, 1429913705, 1, 2, 59.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (509, 1429913705, 1, 1, 43.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (510, 1429913707, 1, 2, 43.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (511, 1429913707, 1, 1, 61.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (512, 1429913709, 1, 2, 59.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (513, 1429913709, 1, 1, 47.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (514, 1429913712, 1, 2, 11.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (515, 1429913712, 1, 1, 64.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (516, 1429913714, 1, 2, 15.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (517, 1429913714, 1, 1, 71.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (518, 1429913716, 1, 2, 94.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (519, 1429913716, 1, 1, 68.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (520, 1429913718, 1, 2, 91.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (521, 1429913718, 1, 1, 20.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (522, 1429913721, 1, 2, 74.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (523, 1429913721, 1, 1, 17.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (524, 1429913723, 1, 2, 22.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (525, 1429913723, 1, 1, 96.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (526, 1429913725, 1, 2, 87.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (527, 1429913725, 1, 1, 4.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (528, 1429913727, 1, 2, 31, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (529, 1429913727, 1, 1, 14, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (530, 1429913729, 1, 2, 63.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (531, 1429913729, 1, 1, 97, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (532, 1429913732, 1, 2, 97.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (533, 1429913732, 1, 1, 89.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (534, 1429913734, 1, 2, 46.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (535, 1429913734, 1, 1, 33.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (536, 1429913736, 1, 2, 4.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (537, 1429913736, 1, 1, 40.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (538, 1429913738, 1, 2, 58.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (539, 1429913738, 1, 1, 38.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (540, 1429913740, 1, 2, 37.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (541, 1429913740, 1, 1, 48.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (542, 1429913743, 1, 2, 69.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (543, 1429913743, 1, 1, 66.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (544, 1429913745, 1, 2, 50.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (545, 1429913745, 1, 1, 63.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (546, 1429913747, 1, 2, 52.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (547, 1429913747, 1, 1, 34.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (548, 1429913749, 1, 2, 14.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (549, 1429913749, 1, 1, 59.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (550, 1429913752, 1, 2, 90.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (551, 1429913752, 1, 1, 42.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (552, 1429913754, 1, 2, 58.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (553, 1429913754, 1, 1, 97.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (554, 1429913756, 1, 2, 53.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (555, 1429913756, 1, 1, 28.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (556, 1429913758, 1, 2, 8.10000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (557, 1429913758, 1, 1, 71.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (558, 1429913760, 1, 2, 62.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (559, 1429913760, 1, 1, 15, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (560, 1429913763, 1, 2, 69.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (561, 1429913763, 1, 1, 78.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (562, 1429913765, 1, 2, 17.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (563, 1429913765, 1, 1, 45.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (564, 1429913767, 1, 2, 79.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (565, 1429913767, 1, 1, 46.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (566, 1429913769, 1, 2, 63.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (567, 1429913769, 1, 1, 69.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (568, 1429913772, 1, 2, 1.29999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (569, 1429913772, 1, 1, 78.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (570, 1429913774, 1, 2, 59.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (571, 1429913774, 1, 1, 74.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (572, 1429913776, 1, 2, 13.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (573, 1429913776, 1, 1, 55.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (574, 1429913778, 1, 2, 30.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (575, 1429913778, 1, 1, 43.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (576, 1429913780, 1, 2, 50.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (577, 1429913780, 1, 1, 8.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (578, 1429913783, 1, 2, 66.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (579, 1429913783, 1, 1, 58.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (580, 1429913785, 1, 2, 43.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (581, 1429913785, 1, 1, 52.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (582, 1429913787, 1, 2, 90.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (583, 1429913787, 1, 1, 71.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (584, 1429913789, 1, 2, 23.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (585, 1429913789, 1, 1, 20.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (586, 1429913791, 1, 2, 38.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (587, 1429913791, 1, 1, 99.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (588, 1429913794, 1, 2, 36.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (589, 1429913794, 1, 1, 17.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (590, 1429913796, 1, 2, 25.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (591, 1429913796, 1, 1, 33, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (592, 1429913798, 1, 2, 78, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (593, 1429913798, 1, 1, 43.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (594, 1429913800, 1, 2, 69.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (595, 1429913800, 1, 1, 59.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (596, 1429913803, 1, 2, 31.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (597, 1429913803, 1, 1, 23.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (598, 1429913805, 1, 2, 86.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (599, 1429913805, 1, 1, 4.4000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (600, 1429913807, 1, 2, 0.200000003, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (601, 1429913807, 1, 1, 83, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (602, 1429913809, 1, 2, 33.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (603, 1429913809, 1, 1, 36.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (604, 1429913811, 1, 2, 0, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (605, 1429913811, 1, 1, 16.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (606, 1429913814, 1, 2, 29.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (607, 1429913814, 1, 1, 3.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (608, 1429913816, 1, 2, 67.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (609, 1429913816, 1, 1, 10, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (610, 1429913818, 1, 2, 78.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (611, 1429913818, 1, 1, 99.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (612, 1429913820, 1, 2, 5.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (613, 1429913820, 1, 1, 3.79999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (614, 1429913822, 1, 2, 71.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (615, 1429913822, 1, 1, 16.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (616, 1429913825, 1, 2, 88, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (617, 1429913825, 1, 1, 45.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (618, 1429913827, 1, 2, 22.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (619, 1429913827, 1, 1, 58.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (620, 1429913829, 1, 2, 8, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (621, 1429913829, 1, 1, 63.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (622, 1429913831, 1, 2, 32.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (623, 1429913831, 1, 1, 84.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (624, 1429913834, 1, 2, 53.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (625, 1429913834, 1, 1, 26.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (626, 1429913836, 1, 2, 96.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (627, 1429913836, 1, 1, 69.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (628, 1429913838, 1, 2, 86.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (629, 1429913838, 1, 1, 70.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (630, 1429913840, 1, 2, 11.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (631, 1429913840, 1, 1, 26.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (632, 1429913842, 1, 2, 21.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (633, 1429913842, 1, 1, 62.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (634, 1429913845, 1, 2, 58.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (635, 1429913845, 1, 1, 60.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (636, 1429913847, 1, 2, 19.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (637, 1429913847, 1, 1, 53.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (638, 1429913849, 1, 2, 71.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (639, 1429913849, 1, 1, 6.5999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (640, 1429913851, 1, 2, 91.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (641, 1429913851, 1, 1, 35.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (642, 1429913853, 1, 2, 32.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (643, 1429913853, 1, 1, 26.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (644, 1429913856, 1, 2, 38.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (645, 1429913856, 1, 1, 25.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (646, 1429913858, 1, 2, 27.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (647, 1429913858, 1, 1, 74.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (648, 1429913860, 1, 2, 72.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (649, 1429913860, 1, 1, 52.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (650, 1429913862, 1, 2, 71.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (651, 1429913862, 1, 1, 85.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (652, 1429913865, 1, 2, 1.29999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (653, 1429913865, 1, 1, 28.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (654, 1429913867, 1, 2, 96.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (655, 1429913867, 1, 1, 36.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (656, 1429913869, 1, 2, 50.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (657, 1429913869, 1, 1, 49.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (658, 1429913871, 1, 2, 83.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (659, 1429913871, 1, 1, 73.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (660, 1429913873, 1, 2, 20.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (661, 1429913873, 1, 1, 60.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (662, 1429913876, 1, 2, 16.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (663, 1429913876, 1, 1, 96.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (664, 1429913878, 1, 2, 98, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (665, 1429913878, 1, 1, 51.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (666, 1429913880, 1, 2, 78.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (667, 1429913880, 1, 1, 42.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (668, 1429913882, 1, 2, 45.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (669, 1429913882, 1, 1, 10.1999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (670, 1429913885, 1, 2, 97.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (671, 1429913885, 1, 1, 34.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (672, 1429913887, 1, 2, 73.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (673, 1429913887, 1, 1, 16, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (674, 1429913889, 1, 2, 67.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (675, 1429913889, 1, 1, 72.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (676, 1429913891, 1, 2, 31.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (677, 1429913891, 1, 1, 6, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (678, 1429913893, 1, 2, 45.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (679, 1429913893, 1, 1, 27.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (680, 1429913896, 1, 2, 98.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (681, 1429913896, 1, 1, 22.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (682, 1429913898, 1, 2, 96.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (683, 1429913898, 1, 1, 34.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (684, 1429913900, 1, 2, 99, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (685, 1429913900, 1, 1, 26.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (686, 1429913902, 1, 2, 25.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (687, 1429913902, 1, 1, 93.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (688, 1429913905, 1, 2, 65.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (689, 1429913905, 1, 1, 22.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (690, 1429913907, 1, 2, 10.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (691, 1429913907, 1, 1, 70.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (692, 1429913909, 1, 2, 70.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (693, 1429913909, 1, 1, 97.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (694, 1429913911, 1, 2, 86.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (695, 1429913911, 1, 1, 31, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (696, 1429913913, 1, 2, 18.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (697, 1429913913, 1, 1, 35.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (698, 1429913916, 1, 2, 28.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (699, 1429913916, 1, 1, 87.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (700, 1429913918, 1, 2, 46.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (701, 1429913918, 1, 1, 84.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (702, 1429913920, 1, 2, 29, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (703, 1429913920, 1, 1, 62.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (704, 1429913922, 1, 2, 54.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (705, 1429913922, 1, 1, 37.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (706, 1429913924, 1, 2, 11.8000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (707, 1429913924, 1, 1, 85.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (708, 1429913927, 1, 2, 60.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (709, 1429913927, 1, 1, 23.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (710, 1429913929, 1, 2, 4.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (711, 1429913929, 1, 1, 44.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (712, 1429913931, 1, 2, 3.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (713, 1429913931, 1, 1, 55.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (714, 1429913933, 1, 2, 75.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (715, 1429913933, 1, 1, 97.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (716, 1429913936, 1, 2, 63.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (717, 1429913936, 1, 1, 82.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (718, 1429913938, 1, 2, 97.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (719, 1429913938, 1, 1, 71.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (720, 1429913940, 1, 2, 25.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (721, 1429913940, 1, 1, 85.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (722, 1429913942, 1, 2, 76.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (723, 1429913942, 1, 1, 22.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (724, 1429913944, 1, 2, 99.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (725, 1429913944, 1, 1, 27.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (726, 1429913947, 1, 2, 64, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (727, 1429913947, 1, 1, 76, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (728, 1429913949, 1, 2, 29.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (729, 1429913949, 1, 1, 36.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (730, 1429913951, 1, 2, 54.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (731, 1429913951, 1, 1, 96.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (732, 1429913953, 1, 2, 77.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (733, 1429913953, 1, 1, 57.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (734, 1429913955, 1, 2, 81.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (735, 1429913955, 1, 1, 13.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (736, 1429913958, 1, 2, 93.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (737, 1429913958, 1, 1, 34.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (738, 1429913960, 1, 2, 79.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (739, 1429913960, 1, 1, 61.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (740, 1429913962, 1, 2, 14.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (741, 1429913962, 1, 1, 40.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (742, 1429913964, 1, 2, 32.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (743, 1429913964, 1, 1, 42.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (744, 1429913967, 1, 2, 17.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (745, 1429913967, 1, 1, 66.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (746, 1429913969, 1, 2, 66.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (747, 1429913969, 1, 1, 14.8000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (748, 1429913971, 1, 2, 22.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (749, 1429913971, 1, 1, 88.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (750, 1429913973, 1, 2, 67.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (751, 1429913973, 1, 1, 35.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (752, 1429913975, 1, 2, 37.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (753, 1429913975, 1, 1, 57, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (754, 1429913978, 1, 2, 61.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (755, 1429913978, 1, 1, 61.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (756, 1429913980, 1, 2, 7.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (757, 1429913980, 1, 1, 6.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (758, 1429913982, 1, 2, 62.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (759, 1429913982, 1, 1, 27.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (760, 1429913984, 1, 2, 73.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (761, 1429913984, 1, 1, 35.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (762, 1429913987, 1, 2, 55.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (763, 1429913987, 1, 1, 24.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (764, 1429913989, 1, 2, 69.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (765, 1429913989, 1, 1, 8.60000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (766, 1429913991, 1, 2, 66.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (767, 1429913991, 1, 1, 46.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (768, 1429913993, 1, 2, 74.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (769, 1429913993, 1, 1, 61.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (770, 1429913995, 1, 2, 4.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (771, 1429913995, 1, 1, 28.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (772, 1429913998, 1, 2, 3.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (773, 1429913998, 1, 1, 35.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (774, 1429914000, 1, 2, 57.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (775, 1429914000, 1, 1, 85.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (776, 1429914002, 1, 2, 52.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (777, 1429914002, 1, 1, 34.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (778, 1429914004, 1, 2, 5.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (779, 1429914004, 1, 1, 33, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (780, 1429914007, 1, 2, 60.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (781, 1429914007, 1, 1, 49.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (782, 1429914009, 1, 2, 53.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (783, 1429914009, 1, 1, 40.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (784, 1429914011, 1, 2, 68.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (785, 1429914011, 1, 1, 18.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (786, 1429914013, 1, 2, 58.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (787, 1429914013, 1, 1, 20.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (788, 1429914015, 1, 2, 95.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (789, 1429914015, 1, 1, 19.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (790, 1429914018, 1, 2, 5.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (791, 1429914018, 1, 1, 86.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (792, 1429914020, 1, 2, 71.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (793, 1429914020, 1, 1, 51.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (794, 1429914022, 1, 2, 88.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (795, 1429914022, 1, 1, 78.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (796, 1429914024, 1, 2, 84.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (797, 1429914024, 1, 1, 8.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (798, 1429914027, 1, 2, 72.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (799, 1429914027, 1, 1, 8.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (800, 1429914029, 1, 2, 99.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (801, 1429914029, 1, 1, 20, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (802, 1429914031, 1, 2, 40.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (803, 1429914031, 1, 1, 60.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (804, 1429914033, 1, 2, 83.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (805, 1429914033, 1, 1, 39.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (806, 1429914035, 1, 2, 32.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (807, 1429914035, 1, 1, 1.60000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (808, 1429914038, 1, 2, 99.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (809, 1429914038, 1, 1, 76.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (810, 1429914040, 1, 2, 8.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (811, 1429914040, 1, 1, 73.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (812, 1429914042, 1, 2, 0.899999976, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (813, 1429914042, 1, 1, 29.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (814, 1429914044, 1, 2, 66.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (815, 1429914044, 1, 1, 23.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (816, 1429914046, 1, 2, 82.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (817, 1429914046, 1, 1, 14.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (818, 1429914049, 1, 2, 55.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (819, 1429914049, 1, 1, 51.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (820, 1429914051, 1, 2, 50, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (821, 1429914051, 1, 1, 46.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (822, 1429914053, 1, 2, 50.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (823, 1429914053, 1, 1, 54.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (824, 1429914055, 1, 2, 55.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (825, 1429914055, 1, 1, 17.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (826, 1429914058, 1, 2, 56.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (827, 1429914058, 1, 1, 51.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (828, 1429914060, 1, 2, 47.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (829, 1429914060, 1, 1, 78.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (830, 1429914062, 1, 2, 1.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (831, 1429914062, 1, 1, 44.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (832, 1429914064, 1, 2, 61.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (833, 1429914064, 1, 1, 96.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (834, 1429914066, 1, 2, 33.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (835, 1429914066, 1, 1, 40.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (836, 1429914069, 1, 2, 8.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (837, 1429914069, 1, 1, 92.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (838, 1429914071, 1, 2, 57.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (839, 1429914071, 1, 1, 29.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (840, 1429914073, 1, 2, 85.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (841, 1429914073, 1, 1, 56.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (842, 1429914075, 1, 2, 20.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (843, 1429914075, 1, 1, 19.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (844, 1429914077, 1, 2, 11.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (845, 1429914077, 1, 1, 32.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (846, 1429914080, 1, 2, 85.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (847, 1429914080, 1, 1, 42.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (848, 1429914082, 1, 2, 85.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (849, 1429914082, 1, 1, 64.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (850, 1429914084, 1, 2, 96.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (851, 1429914084, 1, 1, 69.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (852, 1429914086, 1, 2, 52.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (853, 1429914086, 1, 1, 21.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (854, 1429914088, 1, 2, 58.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (855, 1429914088, 1, 1, 53.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (856, 1429914091, 1, 2, 69.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (857, 1429914091, 1, 1, 86.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (858, 1429914093, 1, 2, 5.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (859, 1429914093, 1, 1, 65.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (860, 1429914095, 1, 2, 82.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (861, 1429914095, 1, 1, 81.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (862, 1429914097, 1, 2, 54.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (863, 1429914097, 1, 1, 20.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (864, 1429914100, 1, 2, 74.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (865, 1429914100, 1, 1, 63.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (866, 1429914102, 1, 2, 11.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (867, 1429914102, 1, 1, 4.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (868, 1429914104, 1, 2, 96.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (869, 1429914104, 1, 1, 25.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (870, 1429914106, 1, 2, 15.3000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (871, 1429914106, 1, 1, 89.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (872, 1429914108, 1, 2, 57.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (873, 1429914108, 1, 1, 26.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (874, 1429914111, 1, 2, 65.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (875, 1429914111, 1, 1, 93.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (876, 1429914113, 1, 2, 25.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (877, 1429914113, 1, 1, 30.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (878, 1429914115, 1, 2, 43, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (879, 1429914115, 1, 1, 23.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (880, 1429914117, 1, 2, 31.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (881, 1429914117, 1, 1, 14.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (882, 1429914119, 1, 2, 65.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (883, 1429914119, 1, 1, 82.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (884, 1429914122, 1, 2, 82.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (885, 1429914122, 1, 1, 31.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (886, 1429914124, 1, 2, 92, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (887, 1429914124, 1, 1, 40, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (888, 1429914126, 1, 2, 37.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (889, 1429914126, 1, 1, 80, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (890, 1429914128, 1, 2, 71.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (891, 1429914128, 1, 1, 22.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (892, 1429914131, 1, 2, 87.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (893, 1429914131, 1, 1, 91.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (894, 1429914133, 1, 2, 46.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (895, 1429914133, 1, 1, 3.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (896, 1429914135, 1, 2, 2.5999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (897, 1429914135, 1, 1, 99.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (898, 1429914137, 1, 2, 44.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (899, 1429914137, 1, 1, 47.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (900, 1429914139, 1, 2, 20.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (901, 1429914139, 1, 1, 81.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (902, 1429914142, 1, 2, 45.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (903, 1429914142, 1, 1, 59.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (904, 1429914144, 1, 2, 49.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (905, 1429914144, 1, 1, 6.69999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (906, 1429914146, 1, 2, 11.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (907, 1429914146, 1, 1, 26.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (908, 1429914148, 1, 2, 55.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (909, 1429914148, 1, 1, 65.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (910, 1429914151, 1, 2, 27.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (911, 1429914151, 1, 1, 38.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (912, 1429914153, 1, 2, 43.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (913, 1429914153, 1, 1, 82, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (914, 1429914155, 1, 2, 33.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (915, 1429914155, 1, 1, 68.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (916, 1429914157, 1, 2, 15.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (917, 1429914157, 1, 1, 71.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (918, 1429914159, 1, 2, 38.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (919, 1429914159, 1, 1, 43, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (920, 1429914162, 1, 2, 71.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (921, 1429914162, 1, 1, 71.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (922, 1429914164, 1, 2, 66.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (923, 1429914164, 1, 1, 16.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (924, 1429914166, 1, 2, 54.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (925, 1429914166, 1, 1, 92.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (926, 1429914168, 1, 2, 2.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (927, 1429914168, 1, 1, 66.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (928, 1429914170, 1, 2, 80.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (929, 1429914170, 1, 1, 61.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (930, 1429914173, 1, 2, 90.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (931, 1429914173, 1, 1, 26.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (932, 1429914175, 1, 2, 85.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (933, 1429914175, 1, 1, 95.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (934, 1429914177, 1, 2, 2.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (935, 1429914177, 1, 1, 50.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (936, 1429914179, 1, 2, 68.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (937, 1429914179, 1, 1, 6.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (938, 1429914182, 1, 2, 33.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (939, 1429914182, 1, 1, 75.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (940, 1429914184, 1, 2, 20.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (941, 1429914184, 1, 1, 65.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (942, 1429914186, 1, 2, 84.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (943, 1429914186, 1, 1, 71.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (944, 1429914188, 1, 2, 52.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (945, 1429914188, 1, 1, 32.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (946, 1429914190, 1, 2, 79.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (947, 1429914190, 1, 1, 5.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (948, 1429914193, 1, 2, 57.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (949, 1429914193, 1, 1, 77.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (950, 1429914195, 1, 2, 88.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (951, 1429914195, 1, 1, 30.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (952, 1429914197, 1, 2, 61, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (953, 1429914197, 1, 1, 1.70000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (954, 1429914199, 1, 2, 76, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (955, 1429914199, 1, 1, 49.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (956, 1429914201, 1, 2, 14.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (957, 1429914201, 1, 1, 29.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (958, 1429914204, 1, 2, 4.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (959, 1429914204, 1, 1, 56.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (960, 1429914206, 1, 2, 4.4000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (961, 1429914206, 1, 1, 45, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (962, 1429914208, 1, 2, 46.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (963, 1429914208, 1, 1, 94, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (964, 1429914210, 1, 2, 75, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (965, 1429914210, 1, 1, 1, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (966, 1429914213, 1, 2, 52.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (967, 1429914213, 1, 1, 47.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (968, 1429914215, 1, 2, 79.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (969, 1429914215, 1, 1, 83.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (970, 1429914217, 1, 2, 0.400000006, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (971, 1429914217, 1, 1, 9.39999962, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (972, 1429914219, 1, 2, 38.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (973, 1429914219, 1, 1, 62.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (974, 1429914221, 1, 2, 22.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (975, 1429914221, 1, 1, 5.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (976, 1429914224, 1, 2, 87.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (977, 1429914224, 1, 1, 94.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (978, 1429914226, 1, 2, 63.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (979, 1429914226, 1, 1, 22.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (980, 1429914228, 1, 2, 13.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (981, 1429914228, 1, 1, 96.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (982, 1429914230, 1, 2, 9, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (983, 1429914230, 1, 1, 2.4000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (984, 1429914232, 1, 2, 73.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (985, 1429914232, 1, 1, 59.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (986, 1429914235, 1, 2, 65.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (987, 1429914235, 1, 1, 84.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (988, 1429914237, 1, 2, 19.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (989, 1429914237, 1, 1, 52.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (990, 1429914239, 1, 2, 35.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (991, 1429914239, 1, 1, 38.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (992, 1429914241, 1, 2, 1.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (993, 1429914241, 1, 1, 76.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (994, 1429914244, 1, 2, 71.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (995, 1429914244, 1, 1, 75.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (996, 1429914246, 1, 2, 19.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (997, 1429914246, 1, 1, 90.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (998, 1429914248, 1, 2, 96.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (999, 1429914248, 1, 1, 51.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1000, 1429914250, 1, 2, 79.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1001, 1429914250, 1, 1, 31.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1002, 1429914252, 1, 2, 25.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1003, 1429914252, 1, 1, 74.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1004, 1429914255, 1, 2, 77.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1005, 1429914255, 1, 1, 78.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1006, 1429914257, 1, 2, 92.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1007, 1429914257, 1, 1, 98.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1008, 1429914259, 1, 2, 79, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1009, 1429914259, 1, 1, 70.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1010, 1429914261, 1, 2, 61.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1011, 1429914261, 1, 1, 19.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1012, 1429914263, 1, 2, 66.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1013, 1429914263, 1, 1, 82.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1014, 1429914266, 1, 2, 42.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1015, 1429914266, 1, 1, 7.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1016, 1429914268, 1, 2, 36, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1017, 1429914268, 1, 1, 43.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1018, 1429914270, 1, 2, 20.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1019, 1429914270, 1, 1, 15.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1020, 1429914272, 1, 2, 35.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1021, 1429914272, 1, 1, 68.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1022, 1429914275, 1, 2, 28.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1023, 1429914275, 1, 1, 26.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1024, 1429914277, 1, 2, 47.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1025, 1429914277, 1, 1, 62, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1026, 1429914279, 1, 2, 8.10000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1027, 1429914279, 1, 1, 61.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1028, 1429914281, 1, 2, 91.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1029, 1429914281, 1, 1, 47.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1030, 1429914283, 1, 2, 86.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1031, 1429914283, 1, 1, 97.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1032, 1429914286, 1, 2, 98, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1033, 1429914286, 1, 1, 11.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1034, 1429914288, 1, 2, 43, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1035, 1429914288, 1, 1, 82.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1036, 1429914290, 1, 2, 71.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1037, 1429914290, 1, 1, 34.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1038, 1429914292, 1, 2, 25.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1039, 1429914292, 1, 1, 94.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1040, 1429914295, 1, 2, 67, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1041, 1429914295, 1, 1, 67.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1042, 1429914297, 1, 2, 5.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1043, 1429914297, 1, 1, 49, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1044, 1429914299, 1, 2, 90.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1045, 1429914299, 1, 1, 16.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1046, 1429914301, 1, 2, 72.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1047, 1429914301, 1, 1, 18.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1048, 1429914303, 1, 2, 34.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1049, 1429914303, 1, 1, 63.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1050, 1429914306, 1, 2, 39.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1051, 1429914306, 1, 1, 76, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1052, 1429914308, 1, 2, 69.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1053, 1429914308, 1, 1, 81.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1054, 1429914310, 1, 2, 15.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1055, 1429914310, 1, 1, 10.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1056, 1429914312, 1, 2, 2.5999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1057, 1429914312, 1, 1, 98.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1058, 1429914314, 1, 2, 26.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1059, 1429914314, 1, 1, 15.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1060, 1429914317, 1, 2, 70.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1061, 1429914317, 1, 1, 31.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1062, 1429914319, 1, 2, 6.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1063, 1429914319, 1, 1, 31.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1064, 1429914321, 1, 2, 84, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1065, 1429914321, 1, 1, 64.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1066, 1429914323, 1, 2, 21.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1067, 1429914323, 1, 1, 54.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1068, 1429914325, 1, 2, 39.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1069, 1429914325, 1, 1, 60.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1070, 1429914328, 1, 2, 36.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1071, 1429914328, 1, 1, 1.10000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1072, 1429914330, 1, 2, 18.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1073, 1429914330, 1, 1, 25.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1074, 1429914332, 1, 2, 48.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1075, 1429914332, 1, 1, 68.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1076, 1429914334, 1, 2, 63.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1077, 1429914334, 1, 1, 79.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1078, 1429914337, 1, 2, 35.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1079, 1429914337, 1, 1, 31, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1080, 1429914339, 1, 2, 89.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1081, 1429914339, 1, 1, 89.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1082, 1429914341, 1, 2, 27, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1083, 1429914341, 1, 1, 28.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1084, 1429914343, 1, 2, 8.10000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1085, 1429914343, 1, 1, 10.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1086, 1429914345, 1, 2, 27.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1087, 1429914345, 1, 1, 16.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1088, 1429914348, 1, 2, 95.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1089, 1429914348, 1, 1, 32.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1090, 1429914350, 1, 2, 79.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1091, 1429914350, 1, 1, 72.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1092, 1429914352, 1, 2, 8.10000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1093, 1429914352, 1, 1, 10.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1094, 1429914354, 1, 2, 23.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1095, 1429914354, 1, 1, 35.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1096, 1429914357, 1, 2, 60.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1097, 1429914357, 1, 1, 73.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1098, 1429914359, 1, 2, 64.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1099, 1429914359, 1, 1, 26, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1100, 1429914361, 1, 2, 94.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1101, 1429914361, 1, 1, 17.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1102, 1429914363, 1, 2, 79, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1103, 1429914363, 1, 1, 74.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1104, 1429914365, 1, 2, 27.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1105, 1429914365, 1, 1, 38.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1106, 1429914368, 1, 2, 57.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1107, 1429914368, 1, 1, 43.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1108, 1429914370, 1, 2, 32.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1109, 1429914370, 1, 1, 47.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1110, 1429914372, 1, 2, 47.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1111, 1429914372, 1, 1, 23, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1112, 1429914374, 1, 2, 62.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1113, 1429914374, 1, 1, 95.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1114, 1429914376, 1, 2, 25.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1115, 1429914376, 1, 1, 81.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1116, 1429914379, 1, 2, 4, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1117, 1429914379, 1, 1, 78.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1118, 1429914381, 1, 2, 23.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1119, 1429914381, 1, 1, 73.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1120, 1429914383, 1, 2, 37.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1121, 1429914383, 1, 1, 4.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1122, 1429914385, 1, 2, 58.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1123, 1429914385, 1, 1, 7.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1124, 1429914388, 1, 2, 80.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1125, 1429914388, 1, 1, 63.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1126, 1429914390, 1, 2, 92.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1127, 1429914390, 1, 1, 8.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1128, 1429914392, 1, 2, 2.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1129, 1429914392, 1, 1, 12.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1130, 1429914395, 1, 2, 7.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1131, 1429914395, 1, 1, 89.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1132, 1429914397, 1, 2, 14.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1133, 1429914397, 1, 1, 9.69999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1134, 1429914399, 1, 2, 36.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1135, 1429914399, 1, 1, 72.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1136, 1429914401, 1, 2, 10.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1137, 1429914401, 1, 1, 52.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1138, 1429914403, 1, 2, 0.800000012, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1139, 1429914403, 1, 1, 69.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1140, 1429914406, 1, 2, 52.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1141, 1429914406, 1, 1, 83.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1142, 1429914408, 1, 2, 83.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1143, 1429914408, 1, 1, 48.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1144, 1429914410, 1, 2, 85, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1145, 1429914410, 1, 1, 56.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1146, 1429914412, 1, 2, 9.69999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1147, 1429914412, 1, 1, 12.3000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1148, 1429914415, 1, 2, 84.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1149, 1429914415, 1, 1, 42.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1150, 1429914417, 1, 2, 31.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1151, 1429914417, 1, 1, 82.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1152, 1429914419, 1, 2, 50.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1153, 1429914419, 1, 1, 91, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1154, 1429914421, 1, 2, 88.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1155, 1429914421, 1, 1, 90, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1156, 1429914423, 1, 2, 58.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1157, 1429914423, 1, 1, 71.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1158, 1429914426, 1, 2, 93.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1159, 1429914426, 1, 1, 63.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1160, 1429914428, 1, 2, 45.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1161, 1429914428, 1, 1, 49.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1162, 1429914430, 1, 2, 41.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1163, 1429914430, 1, 1, 20.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1164, 1429914432, 1, 2, 39.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1165, 1429914432, 1, 1, 57.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1166, 1429914434, 1, 2, 8.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1167, 1429914434, 1, 1, 53, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1168, 1429914437, 1, 2, 59.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1169, 1429914439, 1, 2, 70.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1170, 1429914439, 1, 1, 51, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1171, 1429914441, 1, 2, 77.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1172, 1429914441, 1, 1, 53.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1173, 1429914443, 1, 2, 21.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1174, 1429914443, 1, 1, 53.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1175, 1429914446, 1, 2, 20.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1176, 1429914446, 1, 1, 10.3000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1177, 1429914448, 1, 2, 22.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1178, 1429914448, 1, 1, 23.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1179, 1429914450, 1, 2, 53.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1180, 1429914450, 1, 1, 80.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1181, 1429914452, 1, 2, 23.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1182, 1429914452, 1, 1, 59.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1183, 1429914454, 1, 2, 80.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1184, 1429914454, 1, 1, 25.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1185, 1429914457, 1, 2, 39.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1186, 1429914457, 1, 1, 23.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1187, 1429914459, 1, 2, 21, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1188, 1429914459, 1, 1, 46.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1189, 1429914461, 1, 2, 13.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1190, 1429914461, 1, 1, 38.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1191, 1429914463, 1, 2, 59.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1192, 1429914463, 1, 1, 37.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1193, 1429914465, 1, 2, 24.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1194, 1429914465, 1, 1, 3, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1195, 1429914468, 1, 2, 42.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1196, 1429914468, 1, 1, 63.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1197, 1429914470, 1, 2, 9.10000038, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1198, 1429914470, 1, 1, 27.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1199, 1429914472, 1, 2, 48.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1200, 1429914472, 1, 1, 56.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1201, 1429914474, 1, 2, 52.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1202, 1429914474, 1, 1, 31.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1203, 1429914477, 1, 2, 71.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1204, 1429914477, 1, 1, 80.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1205, 1429914479, 1, 2, 5.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1206, 1429914479, 1, 1, 96.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1207, 1429914481, 1, 2, 69.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1208, 1429914481, 1, 1, 35, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1209, 1429914483, 1, 2, 69, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1210, 1429914483, 1, 1, 48.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1211, 1429914485, 1, 2, 49.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1212, 1429914485, 1, 1, 69.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1213, 1429914488, 1, 2, 9.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1214, 1429914488, 1, 1, 64.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1215, 1429914490, 1, 2, 25.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1216, 1429914490, 1, 1, 81.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1217, 1429914492, 1, 2, 39.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1218, 1429914492, 1, 1, 14, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1219, 1429914494, 1, 2, 17.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1220, 1429914494, 1, 1, 84.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1221, 1429914496, 1, 2, 31.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1222, 1429914496, 1, 1, 13.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1223, 1429914499, 1, 2, 39.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1224, 1429914499, 1, 1, 31.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1225, 1429914501, 1, 2, 91.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1226, 1429914501, 1, 1, 40.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1227, 1429914503, 1, 2, 28.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1228, 1429914503, 1, 1, 18.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1229, 1429914505, 1, 2, 11.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1230, 1429914505, 1, 1, 57.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1231, 1429914508, 1, 2, 1.20000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1232, 1429914508, 1, 1, 94.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1233, 1429914510, 1, 2, 75.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1234, 1429914510, 1, 1, 97.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1235, 1429914512, 1, 2, 27.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1236, 1429914512, 1, 1, 91.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1237, 1429914514, 1, 2, 87.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1238, 1429914514, 1, 1, 0, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1239, 1429914516, 1, 2, 19.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1240, 1429914516, 1, 1, 42.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1241, 1429914519, 1, 2, 54, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1242, 1429914519, 1, 1, 86, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1243, 1429914521, 1, 2, 77, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1244, 1429914521, 1, 1, 65.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1245, 1429914523, 1, 2, 89.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1246, 1429914523, 1, 1, 89.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1247, 1429914525, 1, 2, 27.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1248, 1429914525, 1, 1, 60.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1249, 1429914528, 1, 2, 77, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1250, 1429914528, 1, 1, 60.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1251, 1429914530, 1, 2, 24.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1252, 1429914530, 1, 1, 95.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1253, 1429914532, 1, 2, 9.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1254, 1429914532, 1, 1, 63.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1255, 1429914534, 1, 2, 24.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1256, 1429914534, 1, 1, 39.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1257, 1429914536, 1, 2, 92.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1258, 1429914536, 1, 1, 40, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1259, 1429914539, 1, 2, 88.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1260, 1429914539, 1, 1, 65.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1261, 1429914541, 1, 2, 68, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1262, 1429914541, 1, 1, 51.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1263, 1429914543, 1, 2, 23.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1264, 1429914543, 1, 1, 11.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1265, 1429914545, 1, 2, 47.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1266, 1429914545, 1, 1, 54.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1267, 1429914547, 1, 2, 94.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1268, 1429914547, 1, 1, 12.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1269, 1429914550, 1, 2, 36.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1270, 1429914550, 1, 1, 34.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1271, 1429914552, 1, 2, 94.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1272, 1429914552, 1, 1, 39.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1273, 1429914554, 1, 2, 94.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1274, 1429914554, 1, 1, 74.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1275, 1429914556, 1, 2, 30.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1276, 1429914556, 1, 1, 45.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1277, 1429914558, 1, 2, 36.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1278, 1429914558, 1, 1, 74.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1279, 1429914561, 1, 2, 42.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1280, 1429914561, 1, 1, 2, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1281, 1429914563, 1, 2, 12.6999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1282, 1429914563, 1, 1, 68.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1283, 1429914565, 1, 2, 41.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1284, 1429914565, 1, 1, 51.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1285, 1429914567, 1, 2, 33.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1286, 1429914567, 1, 1, 6.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1287, 1429914570, 1, 2, 84.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1288, 1429914570, 1, 1, 11.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1289, 1429914572, 1, 2, 72.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1290, 1429914572, 1, 1, 88.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1291, 1429914574, 1, 2, 99.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1292, 1429914574, 1, 1, 47.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1293, 1429914576, 1, 2, 11, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1294, 1429914576, 1, 1, 54.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1295, 1429914578, 1, 2, 74.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1296, 1429914578, 1, 1, 2.70000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1297, 1429914581, 1, 2, 62.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1298, 1429914581, 1, 1, 65.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1299, 1429914583, 1, 2, 17.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1300, 1429914583, 1, 1, 34.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1301, 1429914585, 1, 2, 95.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1302, 1429914585, 1, 1, 14.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1303, 1429914587, 1, 2, 23.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1304, 1429914587, 1, 1, 42.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1305, 1429914590, 1, 2, 65.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1306, 1429914590, 1, 1, 84.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1307, 1429914592, 1, 2, 0.899999976, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1308, 1429914592, 1, 1, 34.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1309, 1429914594, 1, 2, 33.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1310, 1429914594, 1, 1, 78.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1311, 1429914596, 1, 2, 3, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1312, 1429914596, 1, 1, 17.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1313, 1429914598, 1, 2, 97.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1314, 1429914598, 1, 1, 86.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1315, 1429914601, 1, 2, 52.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1316, 1429914601, 1, 1, 99.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1317, 1429914603, 1, 2, 10, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1318, 1429914603, 1, 1, 72.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1319, 1429914605, 1, 2, 78.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1320, 1429914605, 1, 1, 41, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1321, 1429914607, 1, 2, 70.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1322, 1429914607, 1, 1, 82.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1323, 1429914609, 1, 2, 40.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1324, 1429914609, 1, 1, 48.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1325, 1429914612, 1, 2, 34.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1326, 1429914612, 1, 1, 46.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1327, 1429914614, 1, 2, 28.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1328, 1429914614, 1, 1, 39.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1329, 1429914616, 1, 2, 0.100000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1330, 1429914616, 1, 1, 27.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1331, 1429914618, 1, 2, 83.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1332, 1429914618, 1, 1, 70.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1333, 1429914621, 1, 2, 56.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1334, 1429914621, 1, 1, 8, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1335, 1429914623, 1, 2, 6.69999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1336, 1429914623, 1, 1, 98, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1337, 1429914625, 1, 2, 45.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1338, 1429914625, 1, 1, 98.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1339, 1429914627, 1, 2, 85.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1340, 1429914627, 1, 1, 48.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1341, 1429914629, 1, 2, 5.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1342, 1429914629, 1, 1, 49.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1343, 1429914632, 1, 2, 78.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1344, 1429914632, 1, 1, 93.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1345, 1429914634, 1, 2, 85.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1346, 1429914634, 1, 1, 81.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1347, 1429914636, 1, 2, 50, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1348, 1429914636, 1, 1, 24.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1349, 1429914638, 1, 2, 2.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1350, 1429914638, 1, 1, 75.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1351, 1429914640, 1, 2, 92.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1352, 1429914640, 1, 1, 90.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1353, 1429914643, 1, 2, 86.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1354, 1429914643, 1, 1, 76.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1355, 1429914645, 1, 2, 64.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1356, 1429914645, 1, 1, 12.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1357, 1429914647, 1, 2, 74.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1358, 1429914647, 1, 1, 74.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1359, 1429914649, 1, 2, 8, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1360, 1429914649, 1, 1, 19.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1361, 1429914651, 1, 2, 56.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1362, 1429914652, 1, 1, 61.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1363, 1429914654, 1, 2, 34.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1364, 1429914654, 1, 1, 5.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1365, 1429914656, 1, 2, 95.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1366, 1429914656, 1, 1, 32, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1367, 1429914658, 1, 2, 61.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1368, 1429914658, 1, 1, 89.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1369, 1429914660, 1, 2, 80.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1370, 1429914660, 1, 1, 54.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1371, 1429914663, 1, 2, 54.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1372, 1429914663, 1, 1, 11.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1373, 1429914665, 1, 2, 87, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1374, 1429914665, 1, 1, 30.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1375, 1429914667, 1, 2, 35.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1376, 1429914667, 1, 1, 20.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1377, 1429914669, 1, 2, 4.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1378, 1429914669, 1, 1, 46.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1379, 1429914671, 1, 2, 63.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1380, 1429914671, 1, 1, 53.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1381, 1429914674, 1, 2, 96.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1382, 1429914674, 1, 1, 4, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1383, 1429914676, 1, 2, 37.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1384, 1429914676, 1, 1, 24.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1385, 1429914678, 1, 2, 35.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1386, 1429914678, 1, 1, 93.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1387, 1429914680, 1, 2, 84.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1388, 1429914680, 1, 1, 79.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1389, 1429914682, 1, 2, 43.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1390, 1429914682, 1, 1, 94.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1391, 1429914685, 1, 2, 23.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1392, 1429914685, 1, 1, 70.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1393, 1429914687, 1, 2, 90.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1394, 1429914687, 1, 1, 66.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1395, 1429914689, 1, 2, 91.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1396, 1429914689, 1, 1, 43.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1397, 1429914691, 1, 2, 15.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1398, 1429914691, 1, 1, 73.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1399, 1429914694, 1, 2, 98.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1400, 1429914694, 1, 1, 53.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1401, 1429914696, 1, 2, 20.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1402, 1429914696, 1, 1, 60.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1403, 1429914698, 1, 2, 44, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1404, 1429914698, 1, 1, 47.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1405, 1429914700, 1, 2, 20.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1406, 1429914700, 1, 1, 81, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1407, 1429914702, 1, 2, 3.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1408, 1429914702, 1, 1, 56.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1409, 1429914705, 1, 2, 41, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1410, 1429914705, 1, 1, 44.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1411, 1429914707, 1, 2, 8.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1412, 1429914707, 1, 1, 27.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1413, 1429914709, 1, 2, 11.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1414, 1429914709, 1, 1, 54.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1415, 1429914711, 1, 2, 22.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1416, 1429914711, 1, 1, 52.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1417, 1429914714, 1, 2, 24.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1418, 1429914714, 1, 1, 9.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1419, 1429914716, 1, 2, 69.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1420, 1429914716, 1, 1, 2.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1421, 1429914718, 1, 2, 47.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1422, 1429914718, 1, 1, 81.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1423, 1429914720, 1, 2, 45.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1424, 1429914720, 1, 1, 85.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1425, 1429914722, 1, 2, 30.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1426, 1429914722, 1, 1, 83.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1427, 1429914725, 1, 2, 21.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1428, 1429914725, 1, 1, 20.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1429, 1429914727, 1, 2, 38.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1430, 1429914727, 1, 1, 92.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1431, 1429914729, 1, 2, 5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1432, 1429914729, 1, 1, 30.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1433, 1429914731, 1, 2, 48.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1434, 1429914731, 1, 1, 9.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1435, 1429914733, 1, 2, 32.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1436, 1429914733, 1, 1, 35.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1437, 1429914736, 1, 2, 59.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1438, 1429914736, 1, 1, 89.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1439, 1429914738, 1, 2, 3.9000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1440, 1429914738, 1, 1, 54.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1441, 1429914740, 1, 2, 90.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1442, 1429914740, 1, 1, 27.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1443, 1429914742, 1, 2, 38.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1444, 1429914742, 1, 1, 99.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1445, 1429914745, 1, 2, 85.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1446, 1429914745, 1, 1, 95.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1447, 1429914747, 1, 2, 59, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1448, 1429914747, 1, 1, 35.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1449, 1429914749, 1, 2, 43.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1450, 1429914749, 1, 1, 38.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1451, 1429914751, 1, 2, 19.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1452, 1429914751, 1, 1, 5.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1453, 1429914753, 1, 2, 3.29999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1454, 1429914753, 1, 1, 96, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1455, 1429914756, 1, 2, 5.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1456, 1429914756, 1, 1, 38.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1457, 1429914758, 1, 2, 14.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1458, 1429914758, 1, 1, 58.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1459, 1429914760, 1, 2, 16.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1460, 1429914760, 1, 1, 37.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1461, 1429914762, 1, 2, 59.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1462, 1429914762, 1, 1, 82.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1463, 1429914765, 1, 2, 17.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1464, 1429914765, 1, 1, 48.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1465, 1429914767, 1, 2, 39.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1466, 1429914767, 1, 1, 77.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1467, 1429914769, 1, 2, 79.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1468, 1429914769, 1, 1, 1.70000005, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1469, 1429914771, 1, 2, 22.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1470, 1429914771, 1, 1, 86.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1471, 1429914773, 1, 2, 92.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1472, 1429914773, 1, 1, 34.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1473, 1429914776, 1, 2, 5.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1474, 1429914776, 1, 1, 15.8000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1475, 1429914778, 1, 2, 12, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1476, 1429914778, 1, 1, 19.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1477, 1429914780, 1, 2, 43.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1478, 1429914780, 1, 1, 46, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1479, 1429914782, 1, 2, 0.300000012, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1480, 1429914782, 1, 1, 35.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1481, 1429914785, 1, 2, 24.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1482, 1429914785, 1, 1, 85.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1483, 1429914787, 1, 2, 77.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1484, 1429914787, 1, 1, 0.100000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1485, 1429914789, 1, 2, 72.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1486, 1429914789, 1, 1, 99.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1487, 1429914791, 1, 2, 27.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1488, 1429914791, 1, 1, 52.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1489, 1429914793, 1, 2, 4.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1490, 1429914793, 1, 1, 94.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1491, 1429914796, 1, 2, 20.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1492, 1429914796, 1, 1, 1.79999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1493, 1429914798, 1, 2, 72.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1494, 1429914798, 1, 1, 66.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1495, 1429914800, 1, 2, 94.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1496, 1429914800, 1, 1, 7.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1497, 1429914802, 1, 2, 10.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1498, 1429914802, 1, 1, 89.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1499, 1429914805, 1, 2, 60.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1500, 1429914805, 1, 1, 7.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1501, 1429914807, 1, 2, 15.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1502, 1429914807, 1, 1, 57.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1503, 1429914809, 1, 2, 13.3000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1504, 1429914809, 1, 1, 56.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1505, 1429914811, 1, 2, 46, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1506, 1429914811, 1, 1, 84.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1507, 1429914813, 1, 2, 99.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1508, 1429914813, 1, 1, 87.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1509, 1429914816, 1, 2, 83.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1510, 1429914816, 1, 1, 85.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1511, 1429914818, 1, 2, 94.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1512, 1429914818, 1, 1, 68.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1513, 1429914820, 1, 2, 57.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1514, 1429914820, 1, 1, 81.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1515, 1429914822, 1, 2, 12.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1516, 1429914822, 1, 1, 74.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1517, 1429914824, 1, 2, 4.80000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1518, 1429914824, 1, 1, 17.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1519, 1429914827, 1, 2, 75.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1520, 1429914827, 1, 1, 39.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1521, 1429914829, 1, 2, 50.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1522, 1429914829, 1, 1, 27.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1523, 1429914831, 1, 2, 97.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1524, 1429914831, 1, 1, 27.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1525, 1429914833, 1, 2, 65.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1526, 1429914833, 1, 1, 90.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1527, 1429914836, 1, 2, 62.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1528, 1429914836, 1, 1, 39, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1529, 1429914838, 1, 2, 21.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1530, 1429914838, 1, 1, 4.0999999, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1531, 1429914840, 1, 2, 9.19999981, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1532, 1429914840, 1, 1, 53.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1533, 1429914842, 1, 2, 85.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1534, 1429914842, 1, 1, 92.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1535, 1429914844, 1, 2, 19.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1536, 1429914844, 1, 1, 67.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1537, 1429914847, 1, 2, 72.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1538, 1429914847, 1, 1, 20.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1539, 1429914849, 1, 2, 54, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1540, 1429914849, 1, 1, 88.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1541, 1429914851, 1, 2, 0, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1542, 1429914851, 1, 1, 39.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1543, 1429914853, 1, 2, 68.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1544, 1429914853, 1, 1, 18.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1545, 1429914856, 1, 2, 99.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1546, 1429914856, 1, 1, 52.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1547, 1429914858, 1, 2, 44, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1548, 1429914858, 1, 1, 90.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1549, 1429914860, 1, 2, 54.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1550, 1429914860, 1, 1, 20.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1551, 1429914862, 1, 2, 3, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1552, 1429914862, 1, 1, 93.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1553, 1429914864, 1, 2, 13.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1554, 1429914864, 1, 1, 20.8999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1555, 1429914867, 1, 2, 57.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1556, 1429914867, 1, 1, 88.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1557, 1429914869, 1, 2, 59.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1558, 1429914869, 1, 1, 85.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1559, 1429914871, 1, 2, 91.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1560, 1429914871, 1, 1, 55.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1561, 1429914873, 1, 2, 22.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1562, 1429914873, 1, 1, 60.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1563, 1429914875, 1, 2, 65.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1564, 1429914875, 1, 1, 79.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1565, 1429914878, 1, 2, 76.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1566, 1429914878, 1, 1, 41.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1567, 1429914880, 1, 2, 83.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1568, 1429914880, 1, 1, 65.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1569, 1429914882, 1, 2, 62.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1570, 1429914882, 1, 1, 45.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1571, 1429914884, 1, 2, 1.79999995, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1572, 1429914884, 1, 1, 84.3000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1573, 1429914887, 1, 2, 63.0999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1574, 1429914887, 1, 1, 87.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1575, 1429914889, 1, 2, 39.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1576, 1429914889, 1, 1, 10.1999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1577, 1429914891, 1, 2, 59, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1578, 1429914891, 1, 1, 78.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1579, 1429914893, 1, 2, 28.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1580, 1429914893, 1, 1, 13.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1581, 1429914895, 1, 2, 46.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1582, 1429914895, 1, 1, 71.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1583, 1429914898, 1, 2, 84.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1584, 1429914898, 1, 1, 1.39999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1585, 1429914900, 1, 2, 1.10000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1586, 1429914900, 1, 1, 15.8000002, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1587, 1429914902, 1, 2, 39.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1588, 1429914902, 1, 1, 64.6999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1589, 1429914904, 1, 2, 34.7999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1590, 1429914904, 1, 1, 30.7000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1591, 1429914907, 1, 2, 7.4000001, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1592, 1429914907, 1, 1, 86.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1593, 1429914909, 1, 2, 29.1000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1594, 1429914909, 1, 1, 98.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1595, 1429914911, 1, 2, 65.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1596, 1429914911, 1, 1, 39.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1597, 1429914913, 1, 2, 74, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1598, 1429914913, 1, 1, 88.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1599, 1429914915, 1, 2, 42.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1600, 1429914915, 1, 1, 58.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1601, 1429914918, 1, 2, 68.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1602, 1429914918, 1, 1, 78.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1603, 1429914920, 1, 2, 28.3999996, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1604, 1429914920, 1, 1, 9, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1605, 1429914922, 1, 2, 18.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1606, 1429914922, 1, 1, 18.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1607, 1429914924, 1, 2, 30.2000008, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1608, 1429914924, 1, 1, 26.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1609, 1429914926, 1, 2, 81.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1610, 1429914926, 1, 1, 47.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1611, 1429914929, 1, 2, 29.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1612, 1429914929, 1, 1, 81.1999969, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1613, 1429914931, 1, 2, 57.4000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1614, 1429914931, 1, 1, 77.8000031, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1615, 1429914933, 1, 2, 8.30000019, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1616, 1429914933, 1, 1, 50.9000015, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1617, 1429914935, 1, 2, 75.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1618, 1429914935, 1, 1, 64.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1619, 1429914938, 1, 2, 78.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1620, 1429914938, 1, 1, 60.5999985, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1621, 1429914940, 1, 2, 1.39999998, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1622, 1429914940, 1, 1, 18.5, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1623, 1429914942, 1, 2, 30.2999992, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1624, 1429914942, 1, 1, 31.6000004, 1, NULL);
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1625, 1430565272, 1, 2, 25.5, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1626, 1430565272, 1, 1, 42.9000015, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1627, 1430565274, 1, 2, 74.6999969, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1628, 1430565274, 1, 1, 53.2000008, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1629, 1430565276, 1, 2, 32.2000008, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1630, 1430565276, 1, 1, 87.5, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1631, 1430565278, 1, 2, 96, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1632, 1430565278, 1, 1, 14.6999998, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1633, 1430565281, 1, 2, 23.5, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1634, 1430565281, 1, 1, 9.89999962, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1635, 1430565283, 1, 2, 99.9000015, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1636, 1430565283, 1, 1, 21.2999992, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1637, 1430565285, 1, 2, 74.1999969, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1638, 1430565285, 1, 1, 58, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1639, 1430565287, 1, 2, 81.5, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1640, 1430565287, 1, 1, 83.9000015, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1641, 1430565290, 1, 2, 80.8000031, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1642, 1430565290, 1, 1, 84.4000015, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1643, 1430565292, 1, 2, 2.79999995, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1644, 1430565292, 1, 1, 25.2000008, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1645, 1430565294, 1, 2, 15.1000004, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1646, 1430565294, 1, 1, 50.2000008, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1647, 1430565296, 1, 2, 91.0999985, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1648, 1430565296, 1, 1, 10.5, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1649, 1430565298, 1, 2, 29.2999992, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1650, 1430565298, 1, 1, 55.5, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1651, 1430565301, 1, 2, 15.6000004, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1652, 1430565301, 1, 1, 57.5999985, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1653, 1430565303, 1, 2, 44.4000015, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1654, 1430565303, 1, 1, 49.2000008, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1655, 1430565305, 1, 2, 18.2999992, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1656, 1430565305, 1, 1, 73.0999985, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1657, 1430565307, 1, 2, 81.5999985, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1658, 1430565307, 1, 1, 73.1999969, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1659, 1430565309, 1, 2, 37.5, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1660, 1430565309, 1, 1, 99.3000031, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1661, 1430565312, 1, 2, 86.9000015, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1662, 1430565312, 1, 1, 73.5999985, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1663, 1430565314, 1, 2, 75.9000015, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1664, 1430565314, 1, 1, 18.3999996, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1665, 1430565316, 1, 2, 39.4000015, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1666, 1430565316, 1, 1, 74.5999985, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1667, 1430565318, 1, 2, 32.5999985, 1, 'Humidity');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1668, 1430565318, 1, 1, 97.5, 1, 'Temperature');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1669, 1430565761, 1, 2, 1.20000005, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1670, 1430565761, 1, 1, 35.2000008, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1671, 1430565763, 1, 2, 30.2999992, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1672, 1430565763, 1, 1, 74.9000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1673, 1430565765, 1, 2, 47.7999992, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1674, 1430565765, 1, 1, 36.0999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1675, 1430565768, 1, 2, 33, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1676, 1430565768, 1, 1, 65.4000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1677, 1430565770, 1, 2, 77.1999969, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1678, 1430565770, 1, 1, 73.9000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1679, 1430565772, 1, 2, 3.5999999, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1680, 1430565772, 1, 1, 56.5999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1681, 1430565774, 1, 2, 29.2000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1682, 1430565774, 1, 1, 65.0999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1683, 1430565777, 1, 2, 97.0999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1684, 1430565777, 1, 1, 63.4000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1685, 1430565779, 1, 2, 75.4000015, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1686, 1430565779, 1, 1, 89.6999969, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1687, 1430565781, 1, 2, 82.6999969, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1688, 1430565781, 1, 1, 16.5, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1689, 1430565783, 1, 2, 45.7000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1690, 1430565783, 1, 1, 43.2000008, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1691, 1430565785, 1, 2, 40.2999992, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1692, 1430565785, 1, 1, 10.6000004, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1693, 1430565788, 1, 2, 99, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1694, 1430565788, 1, 1, 53.7999992, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1695, 1430565790, 1, 2, 48.5999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1696, 1430565790, 1, 1, 0.600000024, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1697, 1430565792, 1, 2, 45.7000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1698, 1430565792, 1, 1, 60.9000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1699, 1430565794, 1, 2, 98.0999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1700, 1430565794, 1, 1, 15.6999998, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1701, 1430565796, 1, 2, 49.7999992, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1702, 1430565796, 1, 1, 25.3999996, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1703, 1430565799, 1, 2, 4.0999999, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1704, 1430565799, 1, 1, 21.8999996, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1705, 1430565801, 1, 2, 75.6999969, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1706, 1430565801, 1, 1, 68.1999969, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1707, 1430565803, 1, 2, 86, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1708, 1430565803, 1, 1, 78.5999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1709, 1430565805, 1, 2, 59.7000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1710, 1430565805, 1, 1, 67.8000031, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1711, 1430565807, 1, 2, 79.3000031, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1712, 1430565807, 1, 1, 88.5999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1713, 1430565810, 1, 2, 59, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1714, 1430565810, 1, 1, 48.2999992, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1715, 1430565812, 1, 2, 22.1000004, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1716, 1430565812, 1, 1, 27.2999992, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1717, 1430565814, 1, 2, 37.2000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1718, 1430565814, 1, 1, 65.9000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1719, 1430565816, 1, 2, 82.4000015, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1720, 1430565816, 1, 1, 71.5999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1721, 1430565819, 1, 2, 80.6999969, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1722, 1430565819, 1, 1, 0, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1723, 1430565821, 1, 2, 76.1999969, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1724, 1430565821, 1, 1, 57.9000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1725, 1430565823, 1, 2, 94.8000031, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1726, 1430565823, 1, 1, 19.7000008, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1727, 1430565825, 1, 2, 75.9000015, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1728, 1430565825, 1, 1, 94, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1729, 1430565827, 1, 2, 87.4000015, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1730, 1430565827, 1, 1, 32.2999992, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1731, 1430565830, 1, 2, 19.7000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1732, 1430565830, 1, 1, 16.2999992, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1733, 1430565832, 1, 2, 75.8000031, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1734, 1430565832, 1, 1, 87.9000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1735, 1430565834, 1, 2, 6.69999981, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1736, 1430565834, 1, 1, 3.79999995, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1737, 1430565836, 1, 2, 60.9000015, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1738, 1430565836, 1, 1, 75.0999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1739, 1430565968, 1, 2, 75.5999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1740, 1430565968, 1, 1, 75.3000031, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1741, 1430565970, 1, 2, 62.0999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1742, 1430565970, 1, 1, 24.6000004, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1743, 1430565973, 1, 2, 49.7999992, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1744, 1430565973, 1, 1, 3.4000001, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1745, 1430565975, 1, 2, 87.3000031, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1746, 1430565975, 1, 1, 54.5999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1747, 1430565977, 1, 2, 42.7999992, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1748, 1430565977, 1, 1, 2, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1749, 1430565979, 1, 2, 94.6999969, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1750, 1430565979, 1, 1, 92.5999985, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1751, 1430565981, 1, 2, 82.5, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1752, 1430565981, 1, 1, 58.7999992, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1753, 1430565984, 1, 2, 79.5999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1754, 1430565984, 1, 1, 0.200000003, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1755, 1430565986, 1, 2, 51.2000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1756, 1430565986, 1, 1, 80.9000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1757, 1430565988, 1, 2, 13.8000002, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1758, 1430565988, 1, 1, 90.8000031, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1759, 1430565990, 1, 2, 69.5999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1760, 1430565990, 1, 1, 90.4000015, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1761, 1430565992, 1, 2, 72.5999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1762, 1430565992, 1, 1, 23.7000008, 1, 'Temperature, t');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1763, 1430566006, 1, 2, 17.6000004, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1764, 1430566006, 1, 1, 29, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1765, 1430566008, 1, 2, 25.5, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1766, 1430566008, 1, 1, 91.3000031, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1767, 1430566010, 1, 2, 99, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1768, 1430566010, 1, 1, 7.69999981, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1769, 1430566012, 1, 2, 80.0999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1770, 1430566012, 1, 1, 83.6999969, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1771, 1430566015, 1, 2, 91.8000031, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1772, 1430566015, 1, 1, 88.6999969, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1773, 1430566017, 1, 2, 99.6999969, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1774, 1430566017, 1, 1, 57.7999992, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1775, 1430566019, 1, 2, 21.2000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1776, 1430566019, 1, 1, 3.70000005, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1777, 1430566021, 1, 2, 84.4000015, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1778, 1430566021, 1, 1, 43.2999992, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1779, 1430566023, 1, 2, 96.4000015, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1780, 1430566023, 1, 1, 0.800000012, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1781, 1430566026, 1, 2, 74.0999985, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1782, 1430566026, 1, 1, 80.0999985, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1783, 1430566028, 1, 2, 52, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1784, 1430566028, 1, 1, 85.0999985, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1785, 1430566030, 1, 2, 2.5999999, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1786, 1430566030, 1, 1, 38.4000015, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1787, 1430566032, 1, 2, 90.5, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1788, 1430566032, 1, 1, 90, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1789, 1430566034, 1, 2, 14.3999996, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1790, 1430566034, 1, 1, 37.5, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1791, 1430566037, 1, 2, 51.5, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1792, 1430566037, 1, 1, 30, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1793, 1430566039, 1, 2, 27.2999992, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1794, 1430566039, 1, 1, 19.2000008, 1, 'Temperature, C');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1795, 1430566041, 1, 2, 49.7000008, 1, 'Humidity, %');
INSERT INTO data (id_data, "time", id_device, channel, value, state, descr) VALUES (1796, 1430566041, 1, 1, 35.7999992, 1, 'Temperature, C');


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 181
-- Name: data_id_data_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('data_id_data_seq', 1796, true);


--
-- TOC entry 2062 (class 0 OID 16463)
-- Dependencies: 173
-- Data for Name: device; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO device (id_device, ser_addr, descr, has_graph, has_state) VALUES (1, 'rfcomm1', 'nano dht', false, false);
INSERT INTO device (id_device, ser_addr, descr, has_graph, has_state) VALUES (2, 'rfcomm2', 'uno relay', false, false);


--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 172
-- Name: device_id_device_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('device_id_device_seq', 2, true);


--
-- TOC entry 2064 (class 0 OID 16474)
-- Dependencies: 175
-- Data for Name: device_state; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO device_state (id_device_state, name) VALUES (1, 'off');
INSERT INTO device_state (id_device_state, name) VALUES (2, 'on');


--
-- TOC entry 2065 (class 0 OID 16480)
-- Dependencies: 176
-- Data for Name: device_state_has_device; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 174
-- Name: device_state_id_device_state_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('device_state_id_device_state_seq', 2, true);


--
-- TOC entry 1941 (class 2606 OID 16545)
-- Name: allowed_commands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY allowed_commands
    ADD CONSTRAINT allowed_commands_pkey PRIMARY KEY (device_id_device, command_type_id_command_type);


--
-- TOC entry 1937 (class 2606 OID 16500)
-- Name: command_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY command
    ADD CONSTRAINT command_pkey PRIMARY KEY (id_command);


--
-- TOC entry 1935 (class 2606 OID 16492)
-- Name: command_state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY command_state
    ADD CONSTRAINT command_state_pkey PRIMARY KEY (id_command_state);


--
-- TOC entry 1943 (class 2606 OID 16553)
-- Name: command_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY command_type
    ADD CONSTRAINT command_type_pkey PRIMARY KEY (id_command_type);


--
-- TOC entry 1939 (class 2606 OID 16508)
-- Name: data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY data
    ADD CONSTRAINT data_pkey PRIMARY KEY (id_data);


--
-- TOC entry 1929 (class 2606 OID 16471)
-- Name: device_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id_device);


--
-- TOC entry 1933 (class 2606 OID 16484)
-- Name: device_state_has_device_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY device_state_has_device
    ADD CONSTRAINT device_state_has_device_pkey PRIMARY KEY (id_device_state, id_device, "time");


--
-- TOC entry 1931 (class 2606 OID 16479)
-- Name: device_state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY device_state
    ADD CONSTRAINT device_state_pkey PRIMARY KEY (id_device_state);


--
-- TOC entry 1946 (class 2606 OID 16519)
-- Name: Ref_command_to_command_state; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY command
    ADD CONSTRAINT "Ref_command_to_command_state" FOREIGN KEY (id_command_state) REFERENCES command_state(id_command_state);


--
-- TOC entry 1948 (class 2606 OID 16564)
-- Name: Ref_command_to_command_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY command
    ADD CONSTRAINT "Ref_command_to_command_type" FOREIGN KEY (id_command_type) REFERENCES command_type(id_command_type);


--
-- TOC entry 1947 (class 2606 OID 16524)
-- Name: Ref_command_to_device; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY command
    ADD CONSTRAINT "Ref_command_to_device" FOREIGN KEY (id_device) REFERENCES device(id_device);


--
-- TOC entry 1949 (class 2606 OID 16529)
-- Name: Ref_data_to_device; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY data
    ADD CONSTRAINT "Ref_data_to_device" FOREIGN KEY (id_device) REFERENCES device(id_device);


--
-- TOC entry 1951 (class 2606 OID 16559)
-- Name: Ref_device_has_command_type_to_command_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY allowed_commands
    ADD CONSTRAINT "Ref_device_has_command_type_to_command_type" FOREIGN KEY (command_type_id_command_type) REFERENCES command_type(id_command_type);


--
-- TOC entry 1950 (class 2606 OID 16554)
-- Name: Ref_device_has_command_type_to_device; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY allowed_commands
    ADD CONSTRAINT "Ref_device_has_command_type_to_device" FOREIGN KEY (device_id_device) REFERENCES device(id_device);


--
-- TOC entry 1945 (class 2606 OID 16514)
-- Name: Ref_device_state_has_device_to_device; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device_state_has_device
    ADD CONSTRAINT "Ref_device_state_has_device_to_device" FOREIGN KEY (id_device) REFERENCES device(id_device);


--
-- TOC entry 1944 (class 2606 OID 16509)
-- Name: Ref_device_state_has_device_to_device_state; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY device_state_has_device
    ADD CONSTRAINT "Ref_device_state_has_device_to_device_state" FOREIGN KEY (id_device_state) REFERENCES device_state(id_device_state);


--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-05-02 21:28:51

--
-- PostgreSQL database dump complete
--

