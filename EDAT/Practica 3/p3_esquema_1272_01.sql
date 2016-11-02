--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.10
-- Dumped by pg_dump version 9.1.10
-- Started on 2013-11-10 21:22:08 CET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 170 (class 3079 OID 11719)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1979 (class 0 OID 0)
-- Dependencies: 170
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 163 (class 1259 OID 49175)
-- Dependencies: 5
-- Name: autor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE autor (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.autor OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 49173)
-- Dependencies: 163 5
-- Name: autor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE autor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autor_id_seq OWNER TO postgres;

--
-- TOC entry 1980 (class 0 OID 0)
-- Dependencies: 162
-- Name: autor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE autor_id_seq OWNED BY autor.id;


--
-- TOC entry 166 (class 1259 OID 49195)
-- Dependencies: 5
-- Name: isbnrautor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE isbnrautor (
    isbn integer,
    id_autor integer
);


ALTER TABLE public.isbnrautor OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 49208)
-- Dependencies: 5
-- Name: isbnrtraductor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE isbnrtraductor (
    isbn integer,
    id_traductor integer
);


ALTER TABLE public.isbnrtraductor OWNER TO postgres;

--
-- TOC entry 161 (class 1259 OID 49165)
-- Dependencies: 5
-- Name: libro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE libro (
    isbn integer NOT NULL,
    libro text NOT NULL,
    fecha date NOT NULL,
    idioma text NOT NULL,
    genero text NOT NULL,
    num_total integer,
    num_dis integer
);


ALTER TABLE public.libro OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 49229)
-- Dependencies: 5
-- Name: prestamo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prestamo (
    uid integer,
    isbn integer,
    fecha_prestamo date NOT NULL,
    devuelto integer,
    puntuacion integer
);


ALTER TABLE public.prestamo OWNER TO postgres;

--
-- TOC entry 165 (class 1259 OID 49186)
-- Dependencies: 5
-- Name: traductor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE traductor (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.traductor OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 49184)
-- Dependencies: 5 165
-- Name: traductor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE traductor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.traductor_id_seq OWNER TO postgres;

--
-- TOC entry 1981 (class 0 OID 0)
-- Dependencies: 164
-- Name: traductor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE traductor_id_seq OWNED BY traductor.id;


--
-- TOC entry 168 (class 1259 OID 49221)
-- Dependencies: 5
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    uid integer NOT NULL,
    nombre text NOT NULL,
    sexo character(1) NOT NULL,
    edad integer NOT NULL,
    activado integer NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 1855 (class 2604 OID 49178)
-- Dependencies: 162 163 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autor ALTER COLUMN id SET DEFAULT nextval('autor_id_seq'::regclass);


--
-- TOC entry 1856 (class 2604 OID 49189)
-- Dependencies: 165 164 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY traductor ALTER COLUMN id SET DEFAULT nextval('traductor_id_seq'::regclass);


--
-- TOC entry 1860 (class 2606 OID 49183)
-- Dependencies: 163 163 1973
-- Name: autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id);


--
-- TOC entry 1858 (class 2606 OID 49172)
-- Dependencies: 161 161 1973
-- Name: libro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY libro
    ADD CONSTRAINT libro_pkey PRIMARY KEY (isbn);


--
-- TOC entry 1862 (class 2606 OID 49194)
-- Dependencies: 165 165 1973
-- Name: traductor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY traductor
    ADD CONSTRAINT traductor_pkey PRIMARY KEY (id);


--
-- TOC entry 1864 (class 2606 OID 49228)
-- Dependencies: 168 168 1973
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (uid);


--
-- TOC entry 1866 (class 2606 OID 49203)
-- Dependencies: 163 166 1859 1973
-- Name: isbnrautor_id_autor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrautor
    ADD CONSTRAINT isbnrautor_id_autor_fkey FOREIGN KEY (id_autor) REFERENCES autor(id);


--
-- TOC entry 1865 (class 2606 OID 49198)
-- Dependencies: 1857 166 161 1973
-- Name: isbnrautor_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrautor
    ADD CONSTRAINT isbnrautor_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1868 (class 2606 OID 49216)
-- Dependencies: 1861 165 167 1973
-- Name: isbnrtraductor_id_traductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrtraductor
    ADD CONSTRAINT isbnrtraductor_id_traductor_fkey FOREIGN KEY (id_traductor) REFERENCES traductor(id);


--
-- TOC entry 1867 (class 2606 OID 49211)
-- Dependencies: 1857 167 161 1973
-- Name: isbnrtraductor_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrtraductor
    ADD CONSTRAINT isbnrtraductor_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1870 (class 2606 OID 49237)
-- Dependencies: 1857 169 161 1973
-- Name: prestamo_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT prestamo_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1869 (class 2606 OID 49232)
-- Dependencies: 169 168 1863 1973
-- Name: prestamo_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT prestamo_uid_fkey FOREIGN KEY (uid) REFERENCES usuario(uid);


--
-- TOC entry 1978 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-11-10 21:22:08 CET

--
-- PostgreSQL database dump complete
--

