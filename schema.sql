--
-- PostgreSQL database dump
--

\restrict KILm0CaOgfSqClkg95gIjvlf4Qjn0aApkAHgchiOAOMS392xhcd1p6X3W3QeHGW

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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
-- Name: jackpot_pool; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jackpot_pool (
    id integer NOT NULL,
    pool integer DEFAULT 10000000 NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: jackpot_pool_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jackpot_pool_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jackpot_pool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jackpot_pool_id_seq OWNED BY public.jackpot_pool.id;


--
-- Name: player_achievements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.player_achievements (
    id integer NOT NULL,
    player_id integer NOT NULL,
    achievement_id text NOT NULL,
    earned_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: player_achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.player_achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.player_achievements_id_seq OWNED BY public.player_achievements.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id integer NOT NULL,
    torn_id integer NOT NULL,
    name text NOT NULL,
    level integer DEFAULT 1 NOT NULL,
    faction text DEFAULT 'None'::text NOT NULL,
    api_key text NOT NULL,
    total_rolls integer DEFAULT 0 NOT NULL,
    total_won integer DEFAULT 0 NOT NULL,
    total_lost integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    balance integer DEFAULT 10000000 NOT NULL,
    last_daily_claim_at timestamp with time zone
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: rolls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rolls (
    id integer NOT NULL,
    player_id integer NOT NULL,
    roll_number integer NOT NULL,
    result_type text NOT NULL,
    payout integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    bet_amount integer DEFAULT 1000000 NOT NULL
);


--
-- Name: rolls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rolls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rolls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rolls_id_seq OWNED BY public.rolls.id;


--
-- Name: torn_deposits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.torn_deposits (
    id integer NOT NULL,
    player_id integer NOT NULL,
    amount integer NOT NULL,
    torn_log_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: torn_deposits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.torn_deposits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: torn_deposits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.torn_deposits_id_seq OWNED BY public.torn_deposits.id;


--
-- Name: withdrawal_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.withdrawal_requests (
    id integer NOT NULL,
    player_id integer NOT NULL,
    torn_id integer NOT NULL,
    player_name text NOT NULL,
    amount integer NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    resolved_at timestamp with time zone
);


--
-- Name: withdrawal_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.withdrawal_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: withdrawal_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.withdrawal_requests_id_seq OWNED BY public.withdrawal_requests.id;


--
-- Name: jackpot_pool id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_pool ALTER COLUMN id SET DEFAULT nextval('public.jackpot_pool_id_seq'::regclass);


--
-- Name: player_achievements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_achievements ALTER COLUMN id SET DEFAULT nextval('public.player_achievements_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: rolls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rolls ALTER COLUMN id SET DEFAULT nextval('public.rolls_id_seq'::regclass);


--
-- Name: torn_deposits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.torn_deposits ALTER COLUMN id SET DEFAULT nextval('public.torn_deposits_id_seq'::regclass);


--
-- Name: withdrawal_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdrawal_requests ALTER COLUMN id SET DEFAULT nextval('public.withdrawal_requests_id_seq'::regclass);


--
-- Name: jackpot_pool jackpot_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_pool
    ADD CONSTRAINT jackpot_pool_pkey PRIMARY KEY (id);


--
-- Name: player_achievements player_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_achievements
    ADD CONSTRAINT player_achievements_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: players players_torn_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_torn_id_unique UNIQUE (torn_id);


--
-- Name: rolls rolls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rolls
    ADD CONSTRAINT rolls_pkey PRIMARY KEY (id);


--
-- Name: torn_deposits torn_deposits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.torn_deposits
    ADD CONSTRAINT torn_deposits_pkey PRIMARY KEY (id);


--
-- Name: torn_deposits torn_deposits_torn_log_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.torn_deposits
    ADD CONSTRAINT torn_deposits_torn_log_id_key UNIQUE (torn_log_id);


--
-- Name: player_achievements uq_player_achievement; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_achievements
    ADD CONSTRAINT uq_player_achievement UNIQUE (player_id, achievement_id);


--
-- Name: withdrawal_requests withdrawal_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT withdrawal_requests_pkey PRIMARY KEY (id);


--
-- Name: player_achievements player_achievements_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_achievements
    ADD CONSTRAINT player_achievements_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: rolls rolls_player_id_players_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rolls
    ADD CONSTRAINT rolls_player_id_players_id_fk FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: torn_deposits torn_deposits_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.torn_deposits
    ADD CONSTRAINT torn_deposits_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: withdrawal_requests withdrawal_requests_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT withdrawal_requests_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- PostgreSQL database dump complete
--

\unrestrict KILm0CaOgfSqClkg95gIjvlf4Qjn0aApkAHgchiOAOMS392xhcd1p6X3W3QeHGW

