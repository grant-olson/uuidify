--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bars (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bars_id_seq OWNED BY bars.id;


--
-- Name: foos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE foos (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: foos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE foos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: foos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE foos_id_seq OWNED BY foos.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: uuidify_uuids; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE uuidify_uuids (
    id integer NOT NULL,
    model_name character varying(255),
    model_id integer,
    model_uuid character varying(36)
);


--
-- Name: uuidify_uuids_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uuidify_uuids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uuidify_uuids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE uuidify_uuids_id_seq OWNED BY uuidify_uuids.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bars ALTER COLUMN id SET DEFAULT nextval('bars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY foos ALTER COLUMN id SET DEFAULT nextval('foos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uuidify_uuids ALTER COLUMN id SET DEFAULT nextval('uuidify_uuids_id_seq'::regclass);


--
-- Name: bars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bars
    ADD CONSTRAINT bars_pkey PRIMARY KEY (id);


--
-- Name: foos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY foos
    ADD CONSTRAINT foos_pkey PRIMARY KEY (id);


--
-- Name: uuidify_uuids_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY uuidify_uuids
    ADD CONSTRAINT uuidify_uuids_pkey PRIMARY KEY (id);


--
-- Name: index_uuidify_uuids_on_model_name_and_model_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_uuidify_uuids_on_model_name_and_model_id ON uuidify_uuids USING btree (model_name, model_id);


--
-- Name: index_uuidify_uuids_on_model_uuid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_uuidify_uuids_on_model_uuid ON uuidify_uuids USING btree (model_uuid);


--
-- Name: index_uuidify_uuids_on_model_uuid_and_model_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_uuidify_uuids_on_model_uuid_and_model_id ON uuidify_uuids USING btree (model_uuid, model_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130612135708');

INSERT INTO schema_migrations (version) VALUES ('20130612143347');

INSERT INTO schema_migrations (version) VALUES ('20130613135222');