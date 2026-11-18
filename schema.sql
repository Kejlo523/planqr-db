--
-- PostgreSQL database dump
--

\restrict g41TVm3rpIw22rOcXORYSWh7QBHNfCdlxuaQjIyigVVbiOaHUkkAKdVoKMoQdJx

-- Dumped from database version 15.15
-- Dumped by pg_dump version 15.15

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
-- Name: DeviceList; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DeviceList" (
    id integer NOT NULL,
    "deviceClassroom" text,
    "deviceURL" text,
    "deviceId" text NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "lastSeen" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "macAddress" text,
    "devicePixelRatio" double precision,
    "displayProfileReportedAt" timestamp(3) without time zone,
    "screenHeightPx" integer,
    "screenOrientation" text,
    "screenWidthPx" integer,
    "viewportHeightPx" integer,
    "viewportWidthPx" integer,
    "blackScreenMode" text DEFAULT 'follow'::character varying NOT NULL,
    "displayTheme" text DEFAULT 'dark'::text NOT NULL,
    "lastIpAddress" text
);


--
-- Name: DeviceList_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."DeviceList_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: DeviceList_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."DeviceList_id_seq" OWNED BY public."DeviceList".id;


--
-- Name: Message; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Message" (
    id integer NOT NULL,
    body text NOT NULL,
    lecturer text NOT NULL,
    login text NOT NULL,
    room text NOT NULL,
    "lessonId" integer NOT NULL,
    "group" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "validUntil" timestamp(3) without time zone,
    "isRoomChange" boolean DEFAULT false NOT NULL,
    "newRoom" text,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Message_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Message_id_seq" OWNED BY public."Message".id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admins (
    id text NOT NULL,
    username text NOT NULL,
    "adminSource" text DEFAULT 'database'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: ldap_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ldap_users (
    username text NOT NULL,
    display_name text NOT NULL,
    given_name text,
    surname text,
    title text,
    email text,
    is_active integer DEFAULT 1 NOT NULL,
    ldap_synced_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tablet_display_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_display_settings (
    id integer DEFAULT 1 NOT NULL,
    night_mode_enabled boolean DEFAULT false NOT NULL,
    night_mode_start text DEFAULT '22:00'::text NOT NULL,
    night_mode_end text DEFAULT '06:00'::text NOT NULL,
    black_screen_after_schedule_end boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: tablet_ip_bans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_ip_bans (
    id integer NOT NULL,
    ip_address text NOT NULL,
    device_id text,
    reason text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by text
);


--
-- Name: tablet_ip_bans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tablet_ip_bans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tablet_ip_bans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tablet_ip_bans_id_seq OWNED BY public.tablet_ip_bans.id;


--
-- Name: tablet_priority_message_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_priority_message_assignments (
    device_id integer NOT NULL,
    template_id character varying(80) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text,
    priority integer,
    schedule_id character varying(64),
    source_migrated boolean DEFAULT false NOT NULL
);


--
-- Name: tablet_priority_message_manual_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_priority_message_manual_assignments (
    device_id integer NOT NULL,
    template_id character varying(80) NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text
);


--
-- Name: tablet_priority_message_preset_seed_state; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_priority_message_preset_seed_state (
    id smallint NOT NULL,
    seeded_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tablet_priority_message_presets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_priority_message_presets (
    id character varying(64) NOT NULL,
    name text NOT NULL,
    template_id character varying(80) NOT NULL,
    priority integer NOT NULL,
    duration_mode character varying(24) NOT NULL,
    start_offset_days smallint DEFAULT 0 NOT NULL,
    duration_days smallint DEFAULT 1 NOT NULL,
    created_by text,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tablet_priority_message_schedule_targets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_priority_message_schedule_targets (
    schedule_id character varying(64) NOT NULL,
    device_id integer NOT NULL
);


--
-- Name: tablet_priority_message_schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_priority_message_schedules (
    id character varying(64) NOT NULL,
    template_id character varying(80) NOT NULL,
    priority integer NOT NULL,
    target_type character varying(16) NOT NULL,
    faculty_code character varying(32),
    starts_at timestamp(6) with time zone NOT NULL,
    ends_at timestamp(6) with time zone NOT NULL,
    created_by text,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tablet_priority_message_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tablet_priority_message_templates (
    id character varying(80) NOT NULL,
    name text NOT NULL,
    image_url text NOT NULL,
    media_type character varying(16) DEFAULT 'image'::character varying NOT NULL,
    is_builtin boolean DEFAULT false NOT NULL,
    sort_order integer DEFAULT 100 NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tbldydaktyk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tbldydaktyk (
    id integer NOT NULL,
    username text NOT NULL,
    card_hex text NOT NULL,
    opened_at timestamp without time zone NOT NULL,
    closed_at timestamp without time zone,
    status text,
    is_active integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tbldydaktyk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tbldydaktyk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tbldydaktyk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tbldydaktyk_id_seq OWNED BY public.tbldydaktyk.id;


--
-- Name: tbluser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tbluser (
    id integer NOT NULL,
    username text NOT NULL,
    card_hex text NOT NULL,
    last_access timestamp without time zone NOT NULL,
    status text,
    dydaktyk_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tbluser_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tbluser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tbluser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tbluser_id_seq OWNED BY public.tbluser.id;


--
-- Name: DeviceList id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DeviceList" ALTER COLUMN id SET DEFAULT nextval('public."DeviceList_id_seq"'::regclass);


--
-- Name: Message id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Message" ALTER COLUMN id SET DEFAULT nextval('public."Message_id_seq"'::regclass);


--
-- Name: tablet_ip_bans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_ip_bans ALTER COLUMN id SET DEFAULT nextval('public.tablet_ip_bans_id_seq'::regclass);


--
-- Name: tbldydaktyk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tbldydaktyk ALTER COLUMN id SET DEFAULT nextval('public.tbldydaktyk_id_seq'::regclass);


--
-- Name: tbluser id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tbluser ALTER COLUMN id SET DEFAULT nextval('public.tbluser_id_seq'::regclass);


--
-- Name: DeviceList DeviceList_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DeviceList"
    ADD CONSTRAINT "DeviceList_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: admins admins_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_username_key UNIQUE (username);


--
-- Name: ldap_users ldap_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ldap_users
    ADD CONSTRAINT ldap_users_pkey PRIMARY KEY (username);


--
-- Name: tablet_display_settings tablet_display_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_display_settings
    ADD CONSTRAINT tablet_display_settings_pkey PRIMARY KEY (id);


--
-- Name: tablet_ip_bans tablet_ip_bans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_ip_bans
    ADD CONSTRAINT tablet_ip_bans_pkey PRIMARY KEY (id);


--
-- Name: tablet_priority_message_assignments tablet_priority_message_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_assignments
    ADD CONSTRAINT tablet_priority_message_assignments_pkey PRIMARY KEY (device_id);


--
-- Name: tablet_priority_message_manual_assignments tablet_priority_message_manual_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_manual_assignments
    ADD CONSTRAINT tablet_priority_message_manual_assignments_pkey PRIMARY KEY (device_id);


--
-- Name: tablet_priority_message_preset_seed_state tablet_priority_message_preset_seed_state_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_preset_seed_state
    ADD CONSTRAINT tablet_priority_message_preset_seed_state_pkey PRIMARY KEY (id);


--
-- Name: tablet_priority_message_presets tablet_priority_message_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_presets
    ADD CONSTRAINT tablet_priority_message_presets_pkey PRIMARY KEY (id);


--
-- Name: tablet_priority_message_schedule_targets tablet_priority_message_schedule_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_schedule_targets
    ADD CONSTRAINT tablet_priority_message_schedule_targets_pkey PRIMARY KEY (schedule_id, device_id);


--
-- Name: tablet_priority_message_schedules tablet_priority_message_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_schedules
    ADD CONSTRAINT tablet_priority_message_schedules_pkey PRIMARY KEY (id);


--
-- Name: tablet_priority_message_templates tablet_priority_message_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_templates
    ADD CONSTRAINT tablet_priority_message_templates_pkey PRIMARY KEY (id);


--
-- Name: tbldydaktyk tbldydaktyk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tbldydaktyk
    ADD CONSTRAINT tbldydaktyk_pkey PRIMARY KEY (id);


--
-- Name: tbluser tbluser_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tbluser
    ADD CONSTRAINT tbluser_pkey PRIMARY KEY (id);


--
-- Name: DeviceList_deviceId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "DeviceList_deviceId_key" ON public."DeviceList" USING btree ("deviceId");


--
-- Name: idx_dydaktyk_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dydaktyk_active ON public.tbldydaktyk USING btree (is_active);


--
-- Name: idx_dydaktyk_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dydaktyk_username ON public.tbldydaktyk USING btree (username);


--
-- Name: idx_dydaktyk_username_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_dydaktyk_username_unique ON public.tbldydaktyk USING btree (username);


--
-- Name: idx_ldap_users_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ldap_users_active ON public.ldap_users USING btree (is_active);


--
-- Name: idx_ldap_users_display_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ldap_users_display_name ON public.ldap_users USING btree (display_name);


--
-- Name: idx_tablet_priority_message_assignments_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tablet_priority_message_assignments_active ON public.tablet_priority_message_assignments USING btree (active);


--
-- Name: idx_tablet_priority_message_schedule_targets_device; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tablet_priority_message_schedule_targets_device ON public.tablet_priority_message_schedule_targets USING btree (device_id);


--
-- Name: idx_tablet_priority_message_schedules_faculty; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tablet_priority_message_schedules_faculty ON public.tablet_priority_message_schedules USING btree (faculty_code);


--
-- Name: idx_tablet_priority_message_schedules_window; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tablet_priority_message_schedules_window ON public.tablet_priority_message_schedules USING btree (starts_at, ends_at);


--
-- Name: idx_user_card_hex; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_card_hex ON public.tbluser USING btree (card_hex);


--
-- Name: idx_user_dydaktyk_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_dydaktyk_id ON public.tbluser USING btree (dydaktyk_id);


--
-- Name: idx_user_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_user_unique ON public.tbluser USING btree (username, card_hex);


--
-- Name: idx_user_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_username ON public.tbluser USING btree (username);


--
-- Name: tablet_ip_bans_ip_address_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tablet_ip_bans_ip_address_key ON public.tablet_ip_bans USING btree (ip_address);


--
-- Name: tablet_priority_message_assignments tablet_priority_message_assignments_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_assignments
    ADD CONSTRAINT tablet_priority_message_assignments_device_id_fkey FOREIGN KEY (device_id) REFERENCES public."DeviceList"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tablet_priority_message_assignments tablet_priority_message_assignments_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_assignments
    ADD CONSTRAINT tablet_priority_message_assignments_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.tablet_priority_message_templates(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tablet_priority_message_manual_assignments tablet_priority_message_manual_assignments_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_manual_assignments
    ADD CONSTRAINT tablet_priority_message_manual_assignments_device_id_fkey FOREIGN KEY (device_id) REFERENCES public."DeviceList"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tablet_priority_message_manual_assignments tablet_priority_message_manual_assignments_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_manual_assignments
    ADD CONSTRAINT tablet_priority_message_manual_assignments_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.tablet_priority_message_templates(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tablet_priority_message_presets tablet_priority_message_presets_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_presets
    ADD CONSTRAINT tablet_priority_message_presets_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.tablet_priority_message_templates(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tablet_priority_message_schedule_targets tablet_priority_message_schedule_targets_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_schedule_targets
    ADD CONSTRAINT tablet_priority_message_schedule_targets_device_id_fkey FOREIGN KEY (device_id) REFERENCES public."DeviceList"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tablet_priority_message_schedule_targets tablet_priority_message_schedule_targets_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_schedule_targets
    ADD CONSTRAINT tablet_priority_message_schedule_targets_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.tablet_priority_message_schedules(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tablet_priority_message_schedules tablet_priority_message_schedules_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tablet_priority_message_schedules
    ADD CONSTRAINT tablet_priority_message_schedules_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.tablet_priority_message_templates(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict g41TVm3rpIw22rOcXORYSWh7QBHNfCdlxuaQjIyigVVbiOaHUkkAKdVoKMoQdJx

