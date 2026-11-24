--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: device_kinds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device_kinds (
    kind_id smallint NOT NULL,
    name text NOT NULL,
    CONSTRAINT device_kinds_name_check CHECK ((btrim(name) <> ''::text))
);


--
-- Name: devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.devices (
    inventory_number text NOT NULL,
    kind_id smallint NOT NULL,
    model text NOT NULL,
    room_code text,
    purchase_date date NOT NULL,
    CONSTRAINT devices_inventory_number_check CHECK ((btrim(inventory_number) <> ''::text)),
    CONSTRAINT devices_model_check CHECK ((btrim(model) <> ''::text))
);


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms (
    room_code text NOT NULL,
    name text NOT NULL,
    CONSTRAINT rooms_name_check CHECK ((btrim(name) <> ''::text)),
    CONSTRAINT rooms_room_code_check CHECK ((btrim(room_code) <> ''::text))
);


--
-- Data for Name: device_kinds; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.device_kinds VALUES (1, 'Computer');
INSERT INTO public.device_kinds VALUES (2, 'Monitor');
INSERT INTO public.device_kinds VALUES (3, 'Projector');
INSERT INTO public.device_kinds VALUES (4, 'Printer');


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.devices VALUES ('INV-0001', 1, 'Dell OptiPlex 7060', '101', '2018-09-10');
INSERT INTO public.devices VALUES ('INV-0002', 1, 'Dell OptiPlex 7010', '101', '2024-09-02');
INSERT INTO public.devices VALUES ('INV-0003', 2, 'Dell P2422H', '101', '2024-09-02');
INSERT INTO public.devices VALUES ('INV-0004', 3, 'Epson EB-X27', '101', '2015-08-20');
INSERT INTO public.devices VALUES ('INV-0005', 1, 'Lenovo ThinkCentre M720', '102', '2020-02-29');
INSERT INTO public.devices VALUES ('INV-0006', 2, 'Dell P2422H', '102', '2021-11-24');
INSERT INTO public.devices VALUES ('INV-0007', 4, 'Brother HL-L2350DW', '102', '2023-03-15');
INSERT INTO public.devices VALUES ('INV-0008', 1, 'HP ProDesk 400', '201', '2022-09-01');
INSERT INTO public.devices VALUES ('INV-0009', 2, 'HP E24 G4', '201', '2021-11-23');
INSERT INTO public.devices VALUES ('INV-0010', 3, 'BenQ MS536', '201', '2021-11-25');
INSERT INTO public.devices VALUES ('INV-0011', 3, 'Epson EB-X27', NULL, '2016-06-01');
INSERT INTO public.devices VALUES ('INV-0012', 2, 'Dell P2422H', NULL, '2025-01-10');


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rooms VALUES ('101', 'Computer lab');
INSERT INTO public.rooms VALUES ('102', 'Science classroom');
INSERT INTO public.rooms VALUES ('201', 'Language classroom');


--
-- Name: device_kinds device_kinds_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_kinds
    ADD CONSTRAINT device_kinds_name_key UNIQUE (name);


--
-- Name: device_kinds device_kinds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_kinds
    ADD CONSTRAINT device_kinds_pkey PRIMARY KEY (kind_id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (inventory_number);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_code);


--
-- Name: devices devices_kind_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_kind_id_fkey FOREIGN KEY (kind_id) REFERENCES public.device_kinds(kind_id);


--
-- Name: devices devices_room_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_room_code_fkey FOREIGN KEY (room_code) REFERENCES public.rooms(room_code);


--
-- PostgreSQL database dump complete
--

