--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

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

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ahoy_events; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.ahoy_events (
    id bigint NOT NULL,
    name character varying,
    properties jsonb,
    "time" timestamp without time zone,
    user_id bigint,
    visit_id bigint
);


ALTER TABLE public.ahoy_events OWNER TO root;

--
-- Name: ahoy_events_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.ahoy_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ahoy_events_id_seq OWNER TO root;

--
-- Name: ahoy_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.ahoy_events_id_seq OWNED BY public.ahoy_events.id;


--
-- Name: ahoy_messages; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.ahoy_messages (
    id bigint NOT NULL,
    clicked_at timestamp without time zone,
    content text,
    feedback_message_id bigint,
    mailer character varying,
    opened_at timestamp without time zone,
    sent_at timestamp without time zone,
    subject text,
    "to" text,
    token character varying,
    user_id bigint,
    user_type character varying,
    utm_campaign character varying,
    utm_content character varying,
    utm_medium character varying,
    utm_source character varying,
    utm_term character varying
);


ALTER TABLE public.ahoy_messages OWNER TO root;

--
-- Name: ahoy_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.ahoy_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ahoy_messages_id_seq OWNER TO root;

--
-- Name: ahoy_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.ahoy_messages_id_seq OWNED BY public.ahoy_messages.id;


--
-- Name: ahoy_visits; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.ahoy_visits (
    id bigint NOT NULL,
    started_at timestamp without time zone,
    user_id bigint,
    visit_token character varying,
    visitor_token character varying
);


ALTER TABLE public.ahoy_visits OWNER TO root;

--
-- Name: ahoy_visits_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.ahoy_visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ahoy_visits_id_seq OWNER TO root;

--
-- Name: ahoy_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.ahoy_visits_id_seq OWNED BY public.ahoy_visits.id;


--
-- Name: announcements; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.announcements (
    id bigint NOT NULL,
    banner_style character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.announcements OWNER TO root;

--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.announcements_id_seq OWNER TO root;

--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.announcements_id_seq OWNED BY public.announcements.id;


--
-- Name: api_secrets; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.api_secrets (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    description character varying NOT NULL,
    secret character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.api_secrets OWNER TO root;

--
-- Name: api_secrets_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.api_secrets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_secrets_id_seq OWNER TO root;

--
-- Name: api_secrets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.api_secrets_id_seq OWNED BY public.api_secrets.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO root;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.articles (
    id bigint NOT NULL,
    any_comments_hidden boolean DEFAULT false,
    approved boolean DEFAULT false,
    archived boolean DEFAULT false,
    body_html text,
    body_markdown text,
    boost_states jsonb DEFAULT '{}'::jsonb NOT NULL,
    cached_organization text,
    cached_tag_list character varying,
    cached_user text,
    cached_user_name character varying,
    cached_user_username character varying,
    canonical_url character varying,
    co_author_ids bigint[] DEFAULT '{}'::bigint[],
    collection_id bigint,
    comment_score integer DEFAULT 0,
    comment_template character varying,
    comments_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    crossposted_at timestamp without time zone,
    description character varying,
    edited_at timestamp without time zone,
    email_digest_eligible boolean DEFAULT true,
    experience_level_rating double precision DEFAULT 5.0,
    experience_level_rating_distribution double precision DEFAULT 5.0,
    facebook_last_buffered timestamp without time zone,
    featured boolean DEFAULT false,
    featured_number integer,
    feed_source_url character varying,
    hotness_score integer DEFAULT 0,
    language character varying,
    last_buffered timestamp without time zone,
    last_comment_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    last_experience_level_rating_at timestamp without time zone,
    main_image character varying,
    main_image_background_hex_color character varying DEFAULT '#dddddd'::character varying,
    nth_published_by_author integer DEFAULT 0,
    organic_page_views_count integer DEFAULT 0,
    organic_page_views_past_month_count integer DEFAULT 0,
    organic_page_views_past_week_count integer DEFAULT 0,
    organization_id bigint,
    originally_published_at timestamp without time zone,
    page_views_count integer DEFAULT 0,
    password character varying,
    path character varying,
    positive_reactions_count integer DEFAULT 0 NOT NULL,
    previous_positive_reactions_count integer DEFAULT 0,
    previous_public_reactions_count integer DEFAULT 0 NOT NULL,
    processed_html text,
    public_reactions_count integer DEFAULT 0 NOT NULL,
    published boolean DEFAULT false,
    published_at timestamp without time zone,
    published_from_feed boolean DEFAULT false,
    rating_votes_count integer DEFAULT 0 NOT NULL,
    reactions_count integer DEFAULT 0 NOT NULL,
    reading_time integer DEFAULT 0,
    receive_notifications boolean DEFAULT true,
    score integer DEFAULT 0,
    search_optimized_description_replacement character varying,
    search_optimized_title_preamble character varying,
    show_comments boolean DEFAULT true,
    slug text,
    social_image character varying,
    spaminess_rating integer DEFAULT 0,
    title character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint,
    user_subscriptions_count integer DEFAULT 0 NOT NULL,
    video character varying,
    video_closed_caption_track_url character varying,
    video_code character varying,
    video_duration_in_seconds double precision DEFAULT 0.0,
    video_source_url character varying,
    video_state character varying,
    video_thumbnail_url character varying
);


ALTER TABLE public.articles OWNER TO root;

--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_id_seq OWNER TO root;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: artist_applications; Type: TABLE; Schema: public; Owner: forem_latest
--

CREATE TABLE public.artist_applications (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    date_of_birth date,
    email character varying,
    telephone character varying,
    location_id integer,
    composer_id integer,
    industry_id integer,
    song_language_id integer,
    genre_id integer,
    commission_accepted boolean,
    sell_tracks boolean,
    sell_campaigns boolean,
    spotify_url character varying,
    soundcloud_url character varying,
    itunes_url character varying,
    facebook_url character varying,
    twitter_url character varying,
    website_url character varying,
    accept_terms boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status boolean DEFAULT false,
    user_id integer
);


ALTER TABLE public.artist_applications OWNER TO forem_latest;

--
-- Name: artist_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: forem_latest
--

CREATE SEQUENCE public.artist_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artist_applications_id_seq OWNER TO forem_latest;

--
-- Name: artist_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forem_latest
--

ALTER SEQUENCE public.artist_applications_id_seq OWNED BY public.artist_applications.id;


--
-- Name: audios; Type: TABLE; Schema: public; Owner: forem_latest
--

CREATE TABLE public.audios (
    id bigint NOT NULL,
    name character varying,
    link character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status boolean DEFAULT false,
    music_release_id integer,
    slug character varying
);


ALTER TABLE public.audios OWNER TO forem_latest;

--
-- Name: audios_id_seq; Type: SEQUENCE; Schema: public; Owner: forem_latest
--

CREATE SEQUENCE public.audios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audios_id_seq OWNER TO forem_latest;

--
-- Name: audios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forem_latest
--

ALTER SEQUENCE public.audios_id_seq OWNED BY public.audios.id;


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    category character varying,
    created_at timestamp without time zone NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    roles character varying[],
    slug character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.audit_logs OWNER TO root;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_logs_id_seq OWNER TO root;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: badge_achievements; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.badge_achievements (
    id bigint NOT NULL,
    badge_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    rewarder_id bigint,
    rewarding_context_message text,
    rewarding_context_message_markdown text,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.badge_achievements OWNER TO root;

--
-- Name: badge_achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.badge_achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.badge_achievements_id_seq OWNER TO root;

--
-- Name: badge_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.badge_achievements_id_seq OWNED BY public.badge_achievements.id;


--
-- Name: badges; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.badges (
    id bigint NOT NULL,
    badge_image character varying,
    created_at timestamp without time zone NOT NULL,
    description character varying NOT NULL,
    slug character varying NOT NULL,
    title character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.badges OWNER TO root;

--
-- Name: badges_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.badges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.badges_id_seq OWNER TO root;

--
-- Name: badges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.badges_id_seq OWNED BY public.badges.id;


--
-- Name: banished_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.banished_users (
    id bigint NOT NULL,
    banished_by_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    username character varying
);


ALTER TABLE public.banished_users OWNER TO root;

--
-- Name: banished_users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.banished_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banished_users_id_seq OWNER TO root;

--
-- Name: banished_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.banished_users_id_seq OWNED BY public.banished_users.id;


--
-- Name: blazer_audits; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blazer_audits (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    data_source character varying,
    query_id bigint,
    statement text,
    user_id bigint
);


ALTER TABLE public.blazer_audits OWNER TO root;

--
-- Name: blazer_audits_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.blazer_audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blazer_audits_id_seq OWNER TO root;

--
-- Name: blazer_audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.blazer_audits_id_seq OWNED BY public.blazer_audits.id;


--
-- Name: blazer_checks; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blazer_checks (
    id bigint NOT NULL,
    check_type character varying,
    created_at timestamp without time zone NOT NULL,
    creator_id bigint,
    emails text,
    last_run_at timestamp without time zone,
    message text,
    query_id bigint,
    schedule character varying,
    slack_channels text,
    state character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.blazer_checks OWNER TO root;

--
-- Name: blazer_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.blazer_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blazer_checks_id_seq OWNER TO root;

--
-- Name: blazer_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.blazer_checks_id_seq OWNED BY public.blazer_checks.id;


--
-- Name: blazer_dashboard_queries; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blazer_dashboard_queries (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    dashboard_id bigint,
    "position" integer,
    query_id bigint,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.blazer_dashboard_queries OWNER TO root;

--
-- Name: blazer_dashboard_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.blazer_dashboard_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blazer_dashboard_queries_id_seq OWNER TO root;

--
-- Name: blazer_dashboard_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.blazer_dashboard_queries_id_seq OWNED BY public.blazer_dashboard_queries.id;


--
-- Name: blazer_dashboards; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blazer_dashboards (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    creator_id bigint,
    name text,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.blazer_dashboards OWNER TO root;

--
-- Name: blazer_dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.blazer_dashboards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blazer_dashboards_id_seq OWNER TO root;

--
-- Name: blazer_dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.blazer_dashboards_id_seq OWNED BY public.blazer_dashboards.id;


--
-- Name: blazer_queries; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blazer_queries (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    creator_id bigint,
    data_source character varying,
    description text,
    name character varying,
    statement text,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.blazer_queries OWNER TO root;

--
-- Name: blazer_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.blazer_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blazer_queries_id_seq OWNER TO root;

--
-- Name: blazer_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.blazer_queries_id_seq OWNED BY public.blazer_queries.id;


--
-- Name: broadcasts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.broadcasts (
    id bigint NOT NULL,
    active boolean DEFAULT false,
    active_status_updated_at timestamp without time zone,
    banner_style character varying,
    body_markdown text,
    broadcastable_id bigint,
    broadcastable_type character varying,
    created_at timestamp without time zone,
    processed_html text,
    title character varying,
    type_of character varying,
    updated_at timestamp without time zone
);


ALTER TABLE public.broadcasts OWNER TO root;

--
-- Name: broadcasts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.broadcasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.broadcasts_id_seq OWNER TO root;

--
-- Name: broadcasts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.broadcasts_id_seq OWNED BY public.broadcasts.id;


--
-- Name: buffer_updates; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.buffer_updates (
    id bigint NOT NULL,
    approver_user_id bigint,
    article_id bigint NOT NULL,
    body_text text,
    buffer_id_code character varying,
    buffer_profile_id_code character varying,
    buffer_response text DEFAULT '--- {}
'::text,
    composer_user_id bigint,
    created_at timestamp without time zone NOT NULL,
    social_service_name character varying,
    status character varying DEFAULT 'pending'::character varying,
    tag_id bigint,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.buffer_updates OWNER TO root;

--
-- Name: buffer_updates_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.buffer_updates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buffer_updates_id_seq OWNER TO root;

--
-- Name: buffer_updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.buffer_updates_id_seq OWNED BY public.buffer_updates.id;


--
-- Name: chat_channel_memberships; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.chat_channel_memberships (
    id bigint NOT NULL,
    chat_channel_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    has_unopened_messages boolean DEFAULT false,
    last_opened_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    role character varying DEFAULT 'member'::character varying,
    show_global_badge_notification boolean DEFAULT true,
    status character varying DEFAULT 'active'::character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.chat_channel_memberships OWNER TO root;

--
-- Name: chat_channel_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.chat_channel_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_channel_memberships_id_seq OWNER TO root;

--
-- Name: chat_channel_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.chat_channel_memberships_id_seq OWNED BY public.chat_channel_memberships.id;


--
-- Name: chat_channels; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.chat_channels (
    id bigint NOT NULL,
    channel_name character varying,
    channel_type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    description character varying,
    discoverable boolean DEFAULT false,
    last_message_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    slug character varying,
    status character varying DEFAULT 'active'::character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.chat_channels OWNER TO root;

--
-- Name: chat_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.chat_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_channels_id_seq OWNER TO root;

--
-- Name: chat_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.chat_channels_id_seq OWNED BY public.chat_channels.id;


--
-- Name: classified_listing_categories; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.classified_listing_categories (
    id bigint NOT NULL,
    cost integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    name character varying NOT NULL,
    rules character varying NOT NULL,
    slug character varying NOT NULL,
    social_preview_color character varying,
    social_preview_description character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.classified_listing_categories OWNER TO root;

--
-- Name: classified_listing_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.classified_listing_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classified_listing_categories_id_seq OWNER TO root;

--
-- Name: classified_listing_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.classified_listing_categories_id_seq OWNED BY public.classified_listing_categories.id;


--
-- Name: classified_listing_endorsements; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.classified_listing_endorsements (
    id bigint NOT NULL,
    approved boolean DEFAULT false,
    classified_listing_id bigint,
    content character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.classified_listing_endorsements OWNER TO root;

--
-- Name: classified_listing_endorsements_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.classified_listing_endorsements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classified_listing_endorsements_id_seq OWNER TO root;

--
-- Name: classified_listing_endorsements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.classified_listing_endorsements_id_seq OWNED BY public.classified_listing_endorsements.id;


--
-- Name: classified_listings; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.classified_listings (
    id bigint NOT NULL,
    body_markdown text,
    bumped_at timestamp without time zone,
    cached_tag_list character varying,
    classified_listing_category_id bigint,
    contact_via_connect boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone,
    last_buffered timestamp without time zone,
    location character varying,
    organization_id bigint,
    originally_published_at timestamp without time zone,
    processed_html text,
    published boolean,
    slug character varying,
    title character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.classified_listings OWNER TO root;

--
-- Name: classified_listings_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.classified_listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classified_listings_id_seq OWNER TO root;

--
-- Name: classified_listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.classified_listings_id_seq OWNED BY public.classified_listings.id;


--
-- Name: collections; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.collections (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    description character varying,
    main_image character varying,
    organization_id bigint,
    published boolean DEFAULT false,
    slug character varying,
    social_image character varying,
    title character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.collections OWNER TO root;

--
-- Name: collections_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collections_id_seq OWNER TO root;

--
-- Name: collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.collections_id_seq OWNED BY public.collections.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    ancestry character varying,
    body_html text,
    body_markdown text,
    commentable_id bigint,
    commentable_type character varying,
    created_at timestamp without time zone NOT NULL,
    deleted boolean DEFAULT false,
    edited boolean DEFAULT false,
    edited_at timestamp without time zone,
    hidden_by_commentable_user boolean DEFAULT false,
    id_code character varying,
    markdown_character_count integer,
    positive_reactions_count integer DEFAULT 0 NOT NULL,
    processed_html text,
    public_reactions_count integer DEFAULT 0 NOT NULL,
    reactions_count integer DEFAULT 0 NOT NULL,
    receive_notifications boolean DEFAULT true,
    score integer DEFAULT 0,
    spaminess_rating integer DEFAULT 0,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.comments OWNER TO root;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO root;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: credits; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.credits (
    id bigint NOT NULL,
    cost double precision DEFAULT 0.0,
    created_at timestamp without time zone NOT NULL,
    organization_id bigint,
    purchase_id bigint,
    purchase_type character varying,
    spent boolean DEFAULT false,
    spent_at timestamp without time zone,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.credits OWNER TO root;

--
-- Name: credits_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credits_id_seq OWNER TO root;

--
-- Name: credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.credits_id_seq OWNED BY public.credits.id;


--
-- Name: custom_profile_fields; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.custom_profile_fields (
    id bigint NOT NULL,
    attribute_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    description character varying,
    label public.citext NOT NULL,
    profile_id bigint NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.custom_profile_fields OWNER TO root;

--
-- Name: custom_profile_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.custom_profile_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_profile_fields_id_seq OWNER TO root;

--
-- Name: custom_profile_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.custom_profile_fields_id_seq OWNED BY public.custom_profile_fields.id;


--
-- Name: data_update_scripts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.data_update_scripts (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    file_name character varying,
    finished_at timestamp without time zone,
    run_at timestamp without time zone,
    status integer DEFAULT 0 NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.data_update_scripts OWNER TO root;

--
-- Name: data_update_scripts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.data_update_scripts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_update_scripts_id_seq OWNER TO root;

--
-- Name: data_update_scripts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.data_update_scripts_id_seq OWNED BY public.data_update_scripts.id;


--
-- Name: display_ad_events; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.display_ad_events (
    id bigint NOT NULL,
    category character varying,
    context_type character varying,
    created_at timestamp without time zone NOT NULL,
    display_ad_id bigint,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.display_ad_events OWNER TO root;

--
-- Name: display_ad_events_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.display_ad_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.display_ad_events_id_seq OWNER TO root;

--
-- Name: display_ad_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.display_ad_events_id_seq OWNED BY public.display_ad_events.id;


--
-- Name: display_ads; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.display_ads (
    id bigint NOT NULL,
    approved boolean DEFAULT false,
    body_markdown text,
    clicks_count integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    impressions_count integer DEFAULT 0,
    organization_id bigint,
    placement_area character varying,
    processed_html text,
    published boolean DEFAULT false,
    success_rate double precision DEFAULT 0.0,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.display_ads OWNER TO root;

--
-- Name: display_ads_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.display_ads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.display_ads_id_seq OWNER TO root;

--
-- Name: display_ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.display_ads_id_seq OWNED BY public.display_ads.id;


--
-- Name: email_authorizations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.email_authorizations (
    id bigint NOT NULL,
    confirmation_token character varying,
    created_at timestamp without time zone NOT NULL,
    json_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    type_of character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint,
    verified_at timestamp without time zone
);


ALTER TABLE public.email_authorizations OWNER TO root;

--
-- Name: email_authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.email_authorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_authorizations_id_seq OWNER TO root;

--
-- Name: email_authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.email_authorizations_id_seq OWNED BY public.email_authorizations.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    category character varying,
    cover_image character varying,
    created_at timestamp without time zone NOT NULL,
    description_html text,
    description_markdown text,
    ends_at timestamp without time zone,
    host_name character varying,
    live_now boolean DEFAULT false,
    location_name character varying,
    location_url character varying,
    profile_image character varying,
    published boolean,
    slug character varying,
    starts_at timestamp without time zone,
    title character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.events OWNER TO root;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO root;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: feedback_messages; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.feedback_messages (
    id bigint NOT NULL,
    affected_id bigint,
    category character varying,
    created_at timestamp without time zone,
    feedback_type character varying,
    message text,
    offender_id bigint,
    reported_url character varying,
    reporter_id bigint,
    status character varying DEFAULT 'Open'::character varying,
    updated_at timestamp without time zone
);


ALTER TABLE public.feedback_messages OWNER TO root;

--
-- Name: feedback_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.feedback_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_messages_id_seq OWNER TO root;

--
-- Name: feedback_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.feedback_messages_id_seq OWNED BY public.feedback_messages.id;


--
-- Name: field_test_events; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.field_test_events (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    field_test_membership_id bigint,
    name character varying
);


ALTER TABLE public.field_test_events OWNER TO root;

--
-- Name: field_test_events_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.field_test_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_test_events_id_seq OWNER TO root;

--
-- Name: field_test_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.field_test_events_id_seq OWNED BY public.field_test_events.id;


--
-- Name: field_test_memberships; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.field_test_memberships (
    id bigint NOT NULL,
    converted boolean DEFAULT false,
    created_at timestamp without time zone,
    experiment character varying,
    participant_id character varying,
    participant_type character varying,
    variant character varying
);


ALTER TABLE public.field_test_memberships OWNER TO root;

--
-- Name: field_test_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.field_test_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_test_memberships_id_seq OWNER TO root;

--
-- Name: field_test_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.field_test_memberships_id_seq OWNED BY public.field_test_memberships.id;


--
-- Name: flipper_features; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.flipper_features (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    key character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.flipper_features OWNER TO root;

--
-- Name: flipper_features_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.flipper_features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flipper_features_id_seq OWNER TO root;

--
-- Name: flipper_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.flipper_features_id_seq OWNED BY public.flipper_features.id;


--
-- Name: flipper_gates; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.flipper_gates (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    feature_key character varying NOT NULL,
    key character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    value character varying
);


ALTER TABLE public.flipper_gates OWNER TO root;

--
-- Name: flipper_gates_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.flipper_gates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flipper_gates_id_seq OWNER TO root;

--
-- Name: flipper_gates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.flipper_gates_id_seq OWNED BY public.flipper_gates.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.follows (
    id bigint NOT NULL,
    blocked boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    followable_id bigint NOT NULL,
    followable_type character varying NOT NULL,
    follower_id bigint NOT NULL,
    follower_type character varying NOT NULL,
    points double precision DEFAULT 1.0,
    subscription_status character varying DEFAULT 'all_articles'::character varying NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.follows OWNER TO root;

--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follows_id_seq OWNER TO root;

--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;


--
-- Name: github_issues; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.github_issues (
    id bigint NOT NULL,
    category character varying,
    created_at timestamp without time zone NOT NULL,
    issue_serialized character varying DEFAULT '--- {}
'::character varying,
    processed_html character varying,
    updated_at timestamp without time zone NOT NULL,
    url character varying
);


ALTER TABLE public.github_issues OWNER TO root;

--
-- Name: github_issues_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.github_issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.github_issues_id_seq OWNER TO root;

--
-- Name: github_issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.github_issues_id_seq OWNED BY public.github_issues.id;


--
-- Name: github_repos; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.github_repos (
    id bigint NOT NULL,
    additional_note character varying,
    bytes_size integer,
    created_at timestamp without time zone NOT NULL,
    description character varying,
    featured boolean DEFAULT false,
    fork boolean DEFAULT false,
    github_id_code bigint,
    info_hash text DEFAULT '--- {}
'::text,
    language character varying,
    name character varying,
    priority integer DEFAULT 0,
    stargazers_count integer,
    updated_at timestamp without time zone NOT NULL,
    url character varying,
    user_id bigint,
    watchers_count integer
);


ALTER TABLE public.github_repos OWNER TO root;

--
-- Name: github_repos_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.github_repos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.github_repos_id_seq OWNER TO root;

--
-- Name: github_repos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.github_repos_id_seq OWNED BY public.github_repos.id;


--
-- Name: html_variant_successes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.html_variant_successes (
    id bigint NOT NULL,
    article_id bigint,
    created_at timestamp without time zone NOT NULL,
    html_variant_id bigint,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.html_variant_successes OWNER TO root;

--
-- Name: html_variant_successes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.html_variant_successes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.html_variant_successes_id_seq OWNER TO root;

--
-- Name: html_variant_successes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.html_variant_successes_id_seq OWNED BY public.html_variant_successes.id;


--
-- Name: html_variant_trials; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.html_variant_trials (
    id bigint NOT NULL,
    article_id bigint,
    created_at timestamp without time zone NOT NULL,
    html_variant_id bigint,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.html_variant_trials OWNER TO root;

--
-- Name: html_variant_trials_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.html_variant_trials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.html_variant_trials_id_seq OWNER TO root;

--
-- Name: html_variant_trials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.html_variant_trials_id_seq OWNED BY public.html_variant_trials.id;


--
-- Name: html_variants; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.html_variants (
    id bigint NOT NULL,
    approved boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    "group" character varying,
    html text,
    name character varying,
    published boolean DEFAULT false,
    success_rate double precision DEFAULT 0.0,
    target_tag character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.html_variants OWNER TO root;

--
-- Name: html_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.html_variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.html_variants_id_seq OWNER TO root;

--
-- Name: html_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.html_variants_id_seq OWNED BY public.html_variants.id;


--
-- Name: identities; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.identities (
    id bigint NOT NULL,
    auth_data_dump text,
    created_at timestamp without time zone NOT NULL,
    provider character varying,
    secret character varying,
    token character varying,
    uid character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.identities OWNER TO root;

--
-- Name: identities_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.identities_id_seq OWNER TO root;

--
-- Name: identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.identities_id_seq OWNED BY public.identities.id;


--
-- Name: mentions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.mentions (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    mentionable_id bigint,
    mentionable_type character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.mentions OWNER TO root;

--
-- Name: mentions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.mentions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mentions_id_seq OWNER TO root;

--
-- Name: mentions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.mentions_id_seq OWNED BY public.mentions.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    chat_action character varying,
    chat_channel_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    edited_at timestamp without time zone,
    message_html character varying NOT NULL,
    message_markdown character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.messages OWNER TO root;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO root;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: music_releases; Type: TABLE; Schema: public; Owner: forem_latest
--

CREATE TABLE public.music_releases (
    id bigint NOT NULL,
    title character varying,
    description text,
    slug character varying,
    image character varying,
    pattern_image character varying,
    main_color_hex character varying,
    published boolean,
    status_notice text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.music_releases OWNER TO forem_latest;

--
-- Name: music_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: forem_latest
--

CREATE SEQUENCE public.music_releases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.music_releases_id_seq OWNER TO forem_latest;

--
-- Name: music_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forem_latest
--

ALTER SEQUENCE public.music_releases_id_seq OWNED BY public.music_releases.id;


--
-- Name: music_tracks; Type: TABLE; Schema: public; Owner: forem_latest
--

CREATE TABLE public.music_tracks (
    id bigint NOT NULL,
    title character varying,
    summary character varying,
    body text,
    slug character varying,
    guid character varying,
    image character varying,
    media_url character varying,
    published_at timestamp without time zone,
    music_release_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.music_tracks OWNER TO forem_latest;

--
-- Name: music_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: forem_latest
--

CREATE SEQUENCE public.music_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.music_tracks_id_seq OWNER TO forem_latest;

--
-- Name: music_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forem_latest
--

ALTER SEQUENCE public.music_tracks_id_seq OWNED BY public.music_tracks.id;


--
-- Name: navigation_links; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.navigation_links (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    display_only_when_signed_in boolean DEFAULT false,
    icon character varying NOT NULL,
    name character varying NOT NULL,
    "position" integer,
    updated_at timestamp(6) without time zone NOT NULL,
    url character varying NOT NULL
);


ALTER TABLE public.navigation_links OWNER TO root;

--
-- Name: navigation_links_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.navigation_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.navigation_links_id_seq OWNER TO root;

--
-- Name: navigation_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.navigation_links_id_seq OWNED BY public.navigation_links.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    author_id bigint,
    content text,
    created_at timestamp without time zone NOT NULL,
    noteable_id bigint,
    noteable_type character varying,
    reason character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.notes OWNER TO root;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO root;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: notification_subscriptions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.notification_subscriptions (
    id bigint NOT NULL,
    config text DEFAULT 'all_comments'::text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    notifiable_id bigint NOT NULL,
    notifiable_type character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.notification_subscriptions OWNER TO root;

--
-- Name: notification_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.notification_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_subscriptions_id_seq OWNER TO root;

--
-- Name: notification_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.notification_subscriptions_id_seq OWNED BY public.notification_subscriptions.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    action character varying,
    created_at timestamp without time zone NOT NULL,
    json_data jsonb,
    notifiable_id bigint,
    notifiable_type character varying,
    notified_at timestamp without time zone,
    organization_id bigint,
    read boolean DEFAULT false,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.notifications OWNER TO root;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO root;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.oauth_access_grants (
    id bigint NOT NULL,
    application_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    resource_owner_id bigint NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying,
    token character varying NOT NULL
);


ALTER TABLE public.oauth_access_grants OWNER TO root;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_grants_id_seq OWNER TO root;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.oauth_access_grants_id_seq OWNED BY public.oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.oauth_access_tokens (
    id bigint NOT NULL,
    application_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expires_in integer,
    previous_refresh_token character varying DEFAULT ''::character varying NOT NULL,
    refresh_token character varying,
    resource_owner_id bigint,
    revoked_at timestamp without time zone,
    scopes character varying,
    token character varying NOT NULL
);


ALTER TABLE public.oauth_access_tokens OWNER TO root;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_access_tokens_id_seq OWNER TO root;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.oauth_access_tokens_id_seq OWNED BY public.oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.oauth_applications (
    id bigint NOT NULL,
    confidential boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    name character varying NOT NULL,
    redirect_uri text NOT NULL,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    secret character varying NOT NULL,
    uid character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.oauth_applications OWNER TO root;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_applications_id_seq OWNER TO root;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.oauth_applications_id_seq OWNED BY public.oauth_applications.id;


--
-- Name: organization_memberships; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.organization_memberships (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    organization_id bigint NOT NULL,
    type_of_user character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL,
    user_title character varying
);


ALTER TABLE public.organization_memberships OWNER TO root;

--
-- Name: organization_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.organization_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_memberships_id_seq OWNER TO root;

--
-- Name: organization_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.organization_memberships_id_seq OWNED BY public.organization_memberships.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    articles_count integer DEFAULT 0 NOT NULL,
    bg_color_hex character varying,
    company_size character varying,
    created_at timestamp without time zone NOT NULL,
    credits_count integer DEFAULT 0 NOT NULL,
    cta_body_markdown text,
    cta_button_text character varying,
    cta_button_url character varying,
    cta_processed_html text,
    dark_nav_image character varying,
    email character varying,
    github_username character varying,
    last_article_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    location character varying,
    name character varying,
    nav_image character varying,
    old_old_slug character varying,
    old_slug character varying,
    profile_image character varying,
    profile_updated_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    proof text,
    secret character varying,
    slug character varying,
    spent_credits_count integer DEFAULT 0 NOT NULL,
    story character varying,
    summary text,
    tag_line character varying,
    tech_stack character varying,
    text_color_hex character varying,
    twitter_username character varying,
    unspent_credits_count integer DEFAULT 0 NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    url character varying,
    processed_story_html text
);


ALTER TABLE public.organizations OWNER TO root;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO root;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: page_views; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.page_views (
    id bigint NOT NULL,
    article_id bigint,
    counts_for_number_of_views integer DEFAULT 1,
    created_at timestamp without time zone NOT NULL,
    domain character varying,
    path character varying,
    referrer character varying,
    time_tracked_in_seconds integer DEFAULT 15,
    updated_at timestamp without time zone NOT NULL,
    user_agent character varying,
    user_id bigint
);


ALTER TABLE public.page_views OWNER TO root;

--
-- Name: page_views_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.page_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_views_id_seq OWNER TO root;

--
-- Name: page_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.page_views_id_seq OWNED BY public.page_views.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.pages (
    id bigint NOT NULL,
    body_html text,
    body_json jsonb,
    body_markdown text,
    created_at timestamp without time zone NOT NULL,
    description character varying,
    is_top_level_path boolean DEFAULT false,
    processed_html text,
    slug character varying,
    social_image character varying,
    template character varying,
    title character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.pages OWNER TO root;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO root;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: payment_providers; Type: TABLE; Schema: public; Owner: forem_latest
--

CREATE TABLE public.payment_providers (
    id bigint NOT NULL,
    external_id character varying,
    access_token character varying,
    refresh_token character varying,
    descriptor character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.payment_providers OWNER TO forem_latest;

--
-- Name: payment_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: forem_latest
--

CREATE SEQUENCE public.payment_providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_providers_id_seq OWNER TO forem_latest;

--
-- Name: payment_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forem_latest
--

ALTER SEQUENCE public.payment_providers_id_seq OWNED BY public.payment_providers.id;


--
-- Name: podcast_episodes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.podcast_episodes (
    id bigint NOT NULL,
    any_comments_hidden boolean DEFAULT false,
    body text,
    comments_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    duration_in_seconds integer,
    guid character varying NOT NULL,
    https boolean DEFAULT true,
    image character varying,
    itunes_url character varying,
    media_url character varying NOT NULL,
    podcast_id bigint,
    processed_html text,
    published_at timestamp without time zone,
    quote text,
    reachable boolean DEFAULT true,
    reactions_count integer DEFAULT 0 NOT NULL,
    slug character varying NOT NULL,
    social_image character varying,
    status_notice character varying,
    subtitle character varying,
    summary text,
    title character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    website_url character varying
);


ALTER TABLE public.podcast_episodes OWNER TO root;

--
-- Name: podcast_episodes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.podcast_episodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.podcast_episodes_id_seq OWNER TO root;

--
-- Name: podcast_episodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.podcast_episodes_id_seq OWNED BY public.podcast_episodes.id;


--
-- Name: podcasts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.podcasts (
    id bigint NOT NULL,
    android_url character varying,
    created_at timestamp without time zone NOT NULL,
    creator_id bigint,
    description text,
    feed_url character varying NOT NULL,
    image character varying NOT NULL,
    itunes_url character varying,
    main_color_hex character varying NOT NULL,
    overcast_url character varying,
    pattern_image character varying,
    published boolean DEFAULT false,
    reachable boolean DEFAULT true,
    slug character varying NOT NULL,
    soundcloud_url character varying,
    status_notice text DEFAULT ''::text,
    title character varying NOT NULL,
    twitter_username character varying,
    "unique_website_url?" boolean DEFAULT true,
    updated_at timestamp without time zone NOT NULL,
    website_url character varying,
    user_id integer
);


ALTER TABLE public.podcasts OWNER TO root;

--
-- Name: podcasts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.podcasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.podcasts_id_seq OWNER TO root;

--
-- Name: podcasts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.podcasts_id_seq OWNED BY public.podcasts.id;


--
-- Name: poll_options; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.poll_options (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    markdown character varying,
    poll_id bigint,
    poll_votes_count integer DEFAULT 0 NOT NULL,
    processed_html character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.poll_options OWNER TO root;

--
-- Name: poll_options_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.poll_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poll_options_id_seq OWNER TO root;

--
-- Name: poll_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.poll_options_id_seq OWNED BY public.poll_options.id;


--
-- Name: poll_skips; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.poll_skips (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    poll_id bigint,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.poll_skips OWNER TO root;

--
-- Name: poll_skips_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.poll_skips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poll_skips_id_seq OWNER TO root;

--
-- Name: poll_skips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.poll_skips_id_seq OWNED BY public.poll_skips.id;


--
-- Name: poll_votes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.poll_votes (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    poll_id bigint NOT NULL,
    poll_option_id bigint NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.poll_votes OWNER TO root;

--
-- Name: poll_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.poll_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poll_votes_id_seq OWNER TO root;

--
-- Name: poll_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.poll_votes_id_seq OWNED BY public.poll_votes.id;


--
-- Name: polls; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.polls (
    id bigint NOT NULL,
    article_id bigint,
    created_at timestamp without time zone NOT NULL,
    poll_options_count integer DEFAULT 0 NOT NULL,
    poll_skips_count integer DEFAULT 0 NOT NULL,
    poll_votes_count integer DEFAULT 0 NOT NULL,
    prompt_html character varying,
    prompt_markdown character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.polls OWNER TO root;

--
-- Name: polls_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.polls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polls_id_seq OWNER TO root;

--
-- Name: polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.polls_id_seq OWNED BY public.polls.id;


--
-- Name: profile_field_groups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.profile_field_groups (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    description character varying,
    name character varying NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.profile_field_groups OWNER TO root;

--
-- Name: profile_field_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.profile_field_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_field_groups_id_seq OWNER TO root;

--
-- Name: profile_field_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.profile_field_groups_id_seq OWNED BY public.profile_field_groups.id;


--
-- Name: profile_fields; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.profile_fields (
    id bigint NOT NULL,
    attribute_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    description character varying,
    display_area integer DEFAULT 1 NOT NULL,
    input_type integer DEFAULT 0 NOT NULL,
    label public.citext NOT NULL,
    placeholder_text character varying,
    profile_field_group_id bigint,
    show_in_onboarding boolean DEFAULT false NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.profile_fields OWNER TO root;

--
-- Name: profile_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.profile_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_fields_id_seq OWNER TO root;

--
-- Name: profile_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.profile_fields_id_seq OWNED BY public.profile_fields.id;


--
-- Name: profile_pins; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.profile_pins (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    pinnable_id bigint,
    pinnable_type character varying,
    profile_id bigint,
    profile_type character varying,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.profile_pins OWNER TO root;

--
-- Name: profile_pins_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.profile_pins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_pins_id_seq OWNER TO root;

--
-- Name: profile_pins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.profile_pins_id_seq OWNED BY public.profile_pins.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.profiles (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.profiles OWNER TO root;

--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_id_seq OWNER TO root;

--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;


--
-- Name: rating_votes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.rating_votes (
    id bigint NOT NULL,
    article_id bigint,
    context character varying DEFAULT 'explicit'::character varying,
    created_at timestamp without time zone NOT NULL,
    "group" character varying,
    rating double precision,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.rating_votes OWNER TO root;

--
-- Name: rating_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.rating_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_votes_id_seq OWNER TO root;

--
-- Name: rating_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.rating_votes_id_seq OWNED BY public.rating_votes.id;


--
-- Name: reactions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.reactions (
    id bigint NOT NULL,
    category character varying,
    created_at timestamp without time zone NOT NULL,
    points double precision DEFAULT 1.0,
    reactable_id bigint,
    reactable_type character varying,
    status character varying DEFAULT 'valid'::character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.reactions OWNER TO root;

--
-- Name: reactions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.reactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reactions_id_seq OWNER TO root;

--
-- Name: reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.reactions_id_seq OWNED BY public.reactions.id;


--
-- Name: response_templates; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.response_templates (
    id bigint NOT NULL,
    content text NOT NULL,
    content_type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    title character varying NOT NULL,
    type_of character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.response_templates OWNER TO root;

--
-- Name: response_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.response_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.response_templates_id_seq OWNER TO root;

--
-- Name: response_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.response_templates_id_seq OWNED BY public.response_templates.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    name character varying,
    resource_id bigint,
    resource_type character varying,
    updated_at timestamp without time zone
);


ALTER TABLE public.roles OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO root;

--
-- Name: services; Type: TABLE; Schema: public; Owner: forem_latest
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    name character varying,
    price double precision,
    currency character varying,
    artist_application_id bigint NOT NULL,
    user_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.services OWNER TO forem_latest;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: forem_latest
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO forem_latest;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forem_latest
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: site_configs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.site_configs (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    value text,
    var character varying NOT NULL
);


ALTER TABLE public.site_configs OWNER TO root;

--
-- Name: site_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.site_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.site_configs_id_seq OWNER TO root;

--
-- Name: site_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.site_configs_id_seq OWNED BY public.site_configs.id;


--
-- Name: sponsorships; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.sponsorships (
    id bigint NOT NULL,
    blurb_html text,
    created_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone,
    featured_number integer DEFAULT 0 NOT NULL,
    instructions text,
    instructions_updated_at timestamp without time zone,
    level character varying NOT NULL,
    organization_id bigint,
    sponsorable_id bigint,
    sponsorable_type character varying,
    status character varying DEFAULT 'none'::character varying NOT NULL,
    tagline character varying,
    updated_at timestamp without time zone NOT NULL,
    url character varying,
    user_id bigint
);


ALTER TABLE public.sponsorships OWNER TO root;

--
-- Name: sponsorships_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.sponsorships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sponsorships_id_seq OWNER TO root;

--
-- Name: sponsorships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.sponsorships_id_seq OWNED BY public.sponsorships.id;


--
-- Name: tag_adjustments; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.tag_adjustments (
    id bigint NOT NULL,
    adjustment_type character varying,
    article_id bigint,
    created_at timestamp without time zone NOT NULL,
    reason_for_adjustment character varying,
    status character varying,
    tag_id bigint,
    tag_name character varying,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.tag_adjustments OWNER TO root;

--
-- Name: tag_adjustments_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.tag_adjustments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_adjustments_id_seq OWNER TO root;

--
-- Name: tag_adjustments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.tag_adjustments_id_seq OWNED BY public.tag_adjustments.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.taggings (
    id bigint NOT NULL,
    context character varying(128),
    created_at timestamp without time zone,
    tag_id bigint,
    taggable_id bigint,
    taggable_type character varying,
    tagger_id bigint,
    tagger_type character varying
);


ALTER TABLE public.taggings OWNER TO root;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggings_id_seq OWNER TO root;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.taggings_id_seq OWNED BY public.taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    alias_for character varying,
    badge_id bigint,
    bg_color_hex character varying,
    buffer_profile_id_code character varying,
    category character varying DEFAULT 'uncategorized'::character varying NOT NULL,
    created_at timestamp without time zone,
    hotness_score integer DEFAULT 0,
    keywords_for_search character varying,
    mod_chat_channel_id bigint,
    name character varying,
    pretty_name character varying,
    profile_image character varying,
    requires_approval boolean DEFAULT false,
    rules_html text,
    rules_markdown text,
    short_summary character varying,
    social_image character varying,
    social_preview_template character varying DEFAULT 'article'::character varying,
    submission_template text,
    supported boolean DEFAULT false,
    taggings_count integer DEFAULT 0,
    text_color_hex character varying,
    updated_at timestamp without time zone,
    wiki_body_html text,
    wiki_body_markdown text
);


ALTER TABLE public.tags OWNER TO root;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO root;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: tweets; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.tweets (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    extended_entities_serialized text DEFAULT '--- {}
'::text,
    favorite_count integer,
    full_fetched_object_serialized text DEFAULT '--- {}
'::text,
    hashtags_serialized character varying DEFAULT '--- []
'::character varying,
    in_reply_to_status_id_code character varying,
    in_reply_to_user_id_code character varying,
    in_reply_to_username character varying,
    is_quote_status boolean,
    last_fetched_at timestamp without time zone,
    media_serialized text DEFAULT '--- []
'::text,
    mentioned_usernames_serialized character varying DEFAULT '--- []
'::character varying,
    profile_image character varying,
    quoted_tweet_id_code character varying,
    retweet_count integer,
    source character varying,
    text character varying,
    tweeted_at timestamp without time zone,
    twitter_id_code character varying,
    twitter_name character varying,
    twitter_uid character varying,
    twitter_user_followers_count integer,
    twitter_user_following_count integer,
    twitter_username character varying,
    updated_at timestamp without time zone NOT NULL,
    urls_serialized text DEFAULT '--- []
'::text,
    user_id bigint,
    user_is_verified boolean
);


ALTER TABLE public.tweets OWNER TO root;

--
-- Name: tweets_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.tweets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tweets_id_seq OWNER TO root;

--
-- Name: tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.tweets_id_seq OWNED BY public.tweets.id;


--
-- Name: user_blocks; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_blocks (
    id bigint NOT NULL,
    blocked_id bigint NOT NULL,
    blocker_id bigint NOT NULL,
    config character varying DEFAULT 'default'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_blocks OWNER TO root;

--
-- Name: user_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.user_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_blocks_id_seq OWNER TO root;

--
-- Name: user_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.user_blocks_id_seq OWNED BY public.user_blocks.id;


--
-- Name: user_documents; Type: TABLE; Schema: public; Owner: forem_latest
--

CREATE TABLE public.user_documents (
    id bigint NOT NULL,
    government_id character varying,
    card_last_4 character varying,
    exp_year character varying,
    exp_month character varying,
    cvc character varying,
    iban_number character varying,
    ethereum_address character varying,
    bitcoin_address character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status boolean DEFAULT false,
    bank_account character varying
);


ALTER TABLE public.user_documents OWNER TO forem_latest;

--
-- Name: user_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: forem_latest
--

CREATE SEQUENCE public.user_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_documents_id_seq OWNER TO forem_latest;

--
-- Name: user_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forem_latest
--

ALTER SEQUENCE public.user_documents_id_seq OWNED BY public.user_documents.id;


--
-- Name: user_subscriptions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.user_subscriptions (
    id bigint NOT NULL,
    author_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    subscriber_email character varying NOT NULL,
    subscriber_id bigint NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_subscription_sourceable_id bigint,
    user_subscription_sourceable_type character varying
);


ALTER TABLE public.user_subscriptions OWNER TO root;

--
-- Name: user_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.user_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_subscriptions_id_seq OWNER TO root;

--
-- Name: user_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.user_subscriptions_id_seq OWNED BY public.user_subscriptions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    articles_count integer DEFAULT 0 NOT NULL,
    available_for character varying,
    badge_achievements_count integer DEFAULT 0 NOT NULL,
    behance_url character varying,
    bg_color_hex character varying,
    blocked_by_count bigint DEFAULT 0 NOT NULL,
    blocking_others_count bigint DEFAULT 0 NOT NULL,
    checked_code_of_conduct boolean DEFAULT false,
    checked_terms_and_conditions boolean DEFAULT false,
    comments_count integer DEFAULT 0 NOT NULL,
    config_font character varying DEFAULT 'default'::character varying,
    config_navbar character varying DEFAULT 'default'::character varying NOT NULL,
    config_theme character varying DEFAULT 'default'::character varying,
    confirmation_sent_at timestamp without time zone,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    contact_consent boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    credits_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    currently_hacking_on character varying,
    currently_learning character varying,
    display_announcements boolean DEFAULT true,
    display_sponsors boolean DEFAULT true,
    dribbble_url character varying,
    editor_version character varying DEFAULT 'v1'::character varying,
    education character varying,
    email character varying,
    email_badge_notifications boolean DEFAULT true,
    email_comment_notifications boolean DEFAULT true,
    email_community_mod_newsletter boolean DEFAULT false,
    email_connect_messages boolean DEFAULT true,
    email_digest_periodic boolean DEFAULT false NOT NULL,
    email_follower_notifications boolean DEFAULT true,
    email_membership_newsletter boolean DEFAULT false,
    email_mention_notifications boolean DEFAULT true,
    email_newsletter boolean DEFAULT false,
    email_public boolean DEFAULT false,
    email_tag_mod_newsletter boolean DEFAULT false,
    email_unread_notifications boolean DEFAULT true,
    employer_name character varying,
    employer_url character varying,
    employment_title character varying,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    experience_level integer,
    export_requested boolean DEFAULT false,
    exported_at timestamp without time zone,
    facebook_created_at timestamp without time zone,
    facebook_url character varying,
    facebook_username character varying,
    failed_attempts integer DEFAULT 0,
    feed_admin_publish_permission boolean DEFAULT true,
    feed_fetched_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    feed_mark_canonical boolean DEFAULT false,
    feed_referential_link boolean DEFAULT true NOT NULL,
    feed_url character varying,
    following_orgs_count integer DEFAULT 0 NOT NULL,
    following_tags_count integer DEFAULT 0 NOT NULL,
    following_users_count integer DEFAULT 0 NOT NULL,
    github_created_at timestamp without time zone,
    github_repos_updated_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    github_username character varying,
    gitlab_url character varying,
    inbox_guidelines character varying,
    inbox_type character varying DEFAULT 'private'::character varying,
    instagram_url character varying,
    invitation_accepted_at timestamp without time zone,
    invitation_created_at timestamp without time zone,
    invitation_limit integer,
    invitation_sent_at timestamp without time zone,
    invitation_token character varying,
    invitations_count integer DEFAULT 0,
    invited_by_id bigint,
    invited_by_type character varying,
    language_settings jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_article_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    last_comment_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    last_followed_at timestamp without time zone,
    last_moderation_notification timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    last_notification_activity timestamp without time zone,
    last_onboarding_page character varying,
    last_reacted_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    last_sign_in_ip inet,
    linkedin_url character varying,
    location character varying,
    locked_at timestamp without time zone,
    looking_for_work boolean DEFAULT false,
    looking_for_work_publicly boolean DEFAULT false,
    mastodon_url character varying,
    medium_url character varying,
    mobile_comment_notifications boolean DEFAULT true,
    mod_roundrobin_notifications boolean DEFAULT true,
    monthly_dues integer DEFAULT 0,
    mostly_work_with character varying,
    name character varying,
    old_old_username character varying,
    old_username character varying,
    onboarding_package_requested boolean DEFAULT false,
    organization_info_updated_at timestamp without time zone,
    payment_pointer character varying,
    permit_adjacent_sponsors boolean DEFAULT true,
    profile_image character varying,
    profile_updated_at timestamp without time zone DEFAULT '2017-01-01 05:00:00'::timestamp without time zone,
    rating_votes_count integer DEFAULT 0 NOT NULL,
    reaction_notifications boolean DEFAULT true,
    reactions_count integer DEFAULT 0 NOT NULL,
    registered boolean DEFAULT true,
    registered_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    remember_token character varying,
    reputation_modifier double precision DEFAULT 1.0,
    reset_password_sent_at timestamp without time zone,
    reset_password_token character varying,
    saw_onboarding boolean DEFAULT true,
    score integer DEFAULT 0,
    secret character varying,
    sign_in_count integer DEFAULT 0 NOT NULL,
    signup_cta_variant character varying,
    spent_credits_count integer DEFAULT 0 NOT NULL,
    stackoverflow_url character varying,
    stripe_id_code character varying,
    subscribed_to_user_subscriptions_count integer DEFAULT 0 NOT NULL,
    summary text,
    text_color_hex character varying,
    twitch_url character varying,
    twitter_created_at timestamp without time zone,
    twitter_followers_count integer,
    twitter_following_count integer,
    twitter_username character varying,
    unconfirmed_email character varying,
    unlock_token character varying,
    unspent_credits_count integer DEFAULT 0 NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    username character varying,
    website_url character varying,
    welcome_notifications boolean DEFAULT true NOT NULL,
    workshop_expiration timestamp without time zone,
    youtube_url character varying,
    google_created_at timestamp without time zone,
    google_url character varying,
    google_username character varying,
    first_name character varying,
    last_name character varying,
    date_of_birth date,
    telephone character varying,
    location_id integer,
    composer_id integer,
    industry_id integer,
    song_language_id integer,
    genre_id character varying,
    commission_accepted boolean DEFAULT false,
    sell_tracks boolean DEFAULT false,
    sell_campaigns boolean DEFAULT false,
    spotify_url character varying,
    soundcloud_url character varying,
    itunes_url character varying,
    twitter_url character varying,
    is_verified boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.users_roles (
    role_id bigint,
    user_id bigint
);


ALTER TABLE public.users_roles OWNER TO root;

--
-- Name: webhook_endpoints; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.webhook_endpoints (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    events character varying[] NOT NULL,
    oauth_application_id bigint,
    source character varying,
    target_url character varying NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.webhook_endpoints OWNER TO root;

--
-- Name: webhook_endpoints_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.webhook_endpoints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webhook_endpoints_id_seq OWNER TO root;

--
-- Name: webhook_endpoints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.webhook_endpoints_id_seq OWNED BY public.webhook_endpoints.id;


--
-- Name: welcome_notifications; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.welcome_notifications (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.welcome_notifications OWNER TO root;

--
-- Name: welcome_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.welcome_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.welcome_notifications_id_seq OWNER TO root;

--
-- Name: welcome_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.welcome_notifications_id_seq OWNED BY public.welcome_notifications.id;


--
-- Name: ahoy_events id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_events ALTER COLUMN id SET DEFAULT nextval('public.ahoy_events_id_seq'::regclass);


--
-- Name: ahoy_messages id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_messages ALTER COLUMN id SET DEFAULT nextval('public.ahoy_messages_id_seq'::regclass);


--
-- Name: ahoy_visits id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_visits ALTER COLUMN id SET DEFAULT nextval('public.ahoy_visits_id_seq'::regclass);


--
-- Name: announcements id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.announcements ALTER COLUMN id SET DEFAULT nextval('public.announcements_id_seq'::regclass);


--
-- Name: api_secrets id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.api_secrets ALTER COLUMN id SET DEFAULT nextval('public.api_secrets_id_seq'::regclass);


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: artist_applications id; Type: DEFAULT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.artist_applications ALTER COLUMN id SET DEFAULT nextval('public.artist_applications_id_seq'::regclass);


--
-- Name: audios id; Type: DEFAULT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.audios ALTER COLUMN id SET DEFAULT nextval('public.audios_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: badge_achievements id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.badge_achievements ALTER COLUMN id SET DEFAULT nextval('public.badge_achievements_id_seq'::regclass);


--
-- Name: badges id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.badges ALTER COLUMN id SET DEFAULT nextval('public.badges_id_seq'::regclass);


--
-- Name: banished_users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.banished_users ALTER COLUMN id SET DEFAULT nextval('public.banished_users_id_seq'::regclass);


--
-- Name: blazer_audits id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_audits ALTER COLUMN id SET DEFAULT nextval('public.blazer_audits_id_seq'::regclass);


--
-- Name: blazer_checks id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_checks ALTER COLUMN id SET DEFAULT nextval('public.blazer_checks_id_seq'::regclass);


--
-- Name: blazer_dashboard_queries id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_dashboard_queries ALTER COLUMN id SET DEFAULT nextval('public.blazer_dashboard_queries_id_seq'::regclass);


--
-- Name: blazer_dashboards id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_dashboards ALTER COLUMN id SET DEFAULT nextval('public.blazer_dashboards_id_seq'::regclass);


--
-- Name: blazer_queries id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_queries ALTER COLUMN id SET DEFAULT nextval('public.blazer_queries_id_seq'::regclass);


--
-- Name: broadcasts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.broadcasts ALTER COLUMN id SET DEFAULT nextval('public.broadcasts_id_seq'::regclass);


--
-- Name: buffer_updates id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.buffer_updates ALTER COLUMN id SET DEFAULT nextval('public.buffer_updates_id_seq'::regclass);


--
-- Name: chat_channel_memberships id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.chat_channel_memberships ALTER COLUMN id SET DEFAULT nextval('public.chat_channel_memberships_id_seq'::regclass);


--
-- Name: chat_channels id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.chat_channels ALTER COLUMN id SET DEFAULT nextval('public.chat_channels_id_seq'::regclass);


--
-- Name: classified_listing_categories id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listing_categories ALTER COLUMN id SET DEFAULT nextval('public.classified_listing_categories_id_seq'::regclass);


--
-- Name: classified_listing_endorsements id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listing_endorsements ALTER COLUMN id SET DEFAULT nextval('public.classified_listing_endorsements_id_seq'::regclass);


--
-- Name: classified_listings id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listings ALTER COLUMN id SET DEFAULT nextval('public.classified_listings_id_seq'::regclass);


--
-- Name: collections id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.collections ALTER COLUMN id SET DEFAULT nextval('public.collections_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: credits id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.credits ALTER COLUMN id SET DEFAULT nextval('public.credits_id_seq'::regclass);


--
-- Name: custom_profile_fields id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.custom_profile_fields ALTER COLUMN id SET DEFAULT nextval('public.custom_profile_fields_id_seq'::regclass);


--
-- Name: data_update_scripts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.data_update_scripts ALTER COLUMN id SET DEFAULT nextval('public.data_update_scripts_id_seq'::regclass);


--
-- Name: display_ad_events id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.display_ad_events ALTER COLUMN id SET DEFAULT nextval('public.display_ad_events_id_seq'::regclass);


--
-- Name: display_ads id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.display_ads ALTER COLUMN id SET DEFAULT nextval('public.display_ads_id_seq'::regclass);


--
-- Name: email_authorizations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.email_authorizations ALTER COLUMN id SET DEFAULT nextval('public.email_authorizations_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: feedback_messages id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.feedback_messages ALTER COLUMN id SET DEFAULT nextval('public.feedback_messages_id_seq'::regclass);


--
-- Name: field_test_events id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field_test_events ALTER COLUMN id SET DEFAULT nextval('public.field_test_events_id_seq'::regclass);


--
-- Name: field_test_memberships id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field_test_memberships ALTER COLUMN id SET DEFAULT nextval('public.field_test_memberships_id_seq'::regclass);


--
-- Name: flipper_features id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.flipper_features ALTER COLUMN id SET DEFAULT nextval('public.flipper_features_id_seq'::regclass);


--
-- Name: flipper_gates id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.flipper_gates ALTER COLUMN id SET DEFAULT nextval('public.flipper_gates_id_seq'::regclass);


--
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);


--
-- Name: github_issues id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.github_issues ALTER COLUMN id SET DEFAULT nextval('public.github_issues_id_seq'::regclass);


--
-- Name: github_repos id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.github_repos ALTER COLUMN id SET DEFAULT nextval('public.github_repos_id_seq'::regclass);


--
-- Name: html_variant_successes id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_successes ALTER COLUMN id SET DEFAULT nextval('public.html_variant_successes_id_seq'::regclass);


--
-- Name: html_variant_trials id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_trials ALTER COLUMN id SET DEFAULT nextval('public.html_variant_trials_id_seq'::regclass);


--
-- Name: html_variants id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variants ALTER COLUMN id SET DEFAULT nextval('public.html_variants_id_seq'::regclass);


--
-- Name: identities id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identities ALTER COLUMN id SET DEFAULT nextval('public.identities_id_seq'::regclass);


--
-- Name: mentions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.mentions ALTER COLUMN id SET DEFAULT nextval('public.mentions_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: music_releases id; Type: DEFAULT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.music_releases ALTER COLUMN id SET DEFAULT nextval('public.music_releases_id_seq'::regclass);


--
-- Name: music_tracks id; Type: DEFAULT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.music_tracks ALTER COLUMN id SET DEFAULT nextval('public.music_tracks_id_seq'::regclass);


--
-- Name: navigation_links id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.navigation_links ALTER COLUMN id SET DEFAULT nextval('public.navigation_links_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: notification_subscriptions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notification_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.notification_subscriptions_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: oauth_access_grants id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_grants_id_seq'::regclass);


--
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_tokens_id_seq'::regclass);


--
-- Name: oauth_applications id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_applications ALTER COLUMN id SET DEFAULT nextval('public.oauth_applications_id_seq'::regclass);


--
-- Name: organization_memberships id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.organization_memberships ALTER COLUMN id SET DEFAULT nextval('public.organization_memberships_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: page_views id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.page_views ALTER COLUMN id SET DEFAULT nextval('public.page_views_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: payment_providers id; Type: DEFAULT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.payment_providers ALTER COLUMN id SET DEFAULT nextval('public.payment_providers_id_seq'::regclass);


--
-- Name: podcast_episodes id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.podcast_episodes ALTER COLUMN id SET DEFAULT nextval('public.podcast_episodes_id_seq'::regclass);


--
-- Name: podcasts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.podcasts ALTER COLUMN id SET DEFAULT nextval('public.podcasts_id_seq'::regclass);


--
-- Name: poll_options id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_options ALTER COLUMN id SET DEFAULT nextval('public.poll_options_id_seq'::regclass);


--
-- Name: poll_skips id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_skips ALTER COLUMN id SET DEFAULT nextval('public.poll_skips_id_seq'::regclass);


--
-- Name: poll_votes id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_votes ALTER COLUMN id SET DEFAULT nextval('public.poll_votes_id_seq'::regclass);


--
-- Name: polls id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.polls ALTER COLUMN id SET DEFAULT nextval('public.polls_id_seq'::regclass);


--
-- Name: profile_field_groups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profile_field_groups ALTER COLUMN id SET DEFAULT nextval('public.profile_field_groups_id_seq'::regclass);


--
-- Name: profile_fields id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profile_fields ALTER COLUMN id SET DEFAULT nextval('public.profile_fields_id_seq'::regclass);


--
-- Name: profile_pins id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profile_pins ALTER COLUMN id SET DEFAULT nextval('public.profile_pins_id_seq'::regclass);


--
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);


--
-- Name: rating_votes id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.rating_votes ALTER COLUMN id SET DEFAULT nextval('public.rating_votes_id_seq'::regclass);


--
-- Name: reactions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reactions ALTER COLUMN id SET DEFAULT nextval('public.reactions_id_seq'::regclass);


--
-- Name: response_templates id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.response_templates ALTER COLUMN id SET DEFAULT nextval('public.response_templates_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: site_configs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.site_configs ALTER COLUMN id SET DEFAULT nextval('public.site_configs_id_seq'::regclass);


--
-- Name: sponsorships id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.sponsorships ALTER COLUMN id SET DEFAULT nextval('public.sponsorships_id_seq'::regclass);


--
-- Name: tag_adjustments id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag_adjustments ALTER COLUMN id SET DEFAULT nextval('public.tag_adjustments_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggings ALTER COLUMN id SET DEFAULT nextval('public.taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: tweets id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tweets ALTER COLUMN id SET DEFAULT nextval('public.tweets_id_seq'::regclass);


--
-- Name: user_blocks id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_blocks ALTER COLUMN id SET DEFAULT nextval('public.user_blocks_id_seq'::regclass);


--
-- Name: user_documents id; Type: DEFAULT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.user_documents ALTER COLUMN id SET DEFAULT nextval('public.user_documents_id_seq'::regclass);


--
-- Name: user_subscriptions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.user_subscriptions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: webhook_endpoints id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.webhook_endpoints ALTER COLUMN id SET DEFAULT nextval('public.webhook_endpoints_id_seq'::regclass);


--
-- Name: welcome_notifications id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.welcome_notifications ALTER COLUMN id SET DEFAULT nextval('public.welcome_notifications_id_seq'::regclass);


--
-- Data for Name: ahoy_events; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.ahoy_events (id, name, properties, "time", user_id, visit_id) FROM stdin;
1	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-11-26 14:01:17.861999	12	1
2	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-11-26 14:01:34.046999	12	1
3	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:35:35.773999	12	1
4	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:02.296	12	1
5	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:03.003	12	1
6	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:03.663	12	1
7	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:04.474999	12	1
8	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:05.545	12	1
9	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:06.053999	12	1
10	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:07.637	12	1
11	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:36:12.322999	12	1
12	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:58:07.653	12	1
13	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 13:58:09.878999	12	1
14	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 14:01:27.187	12	1
15	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 14:21:49.976999	12	1
16	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-22 14:21:58.789	12	1
17	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-24 11:18:35.246	12	1
18	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-24 11:18:42.188999	12	1
19	Podcast Player Streaming	{"action": "play", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-24 11:18:42.953999	12	1
20	Podcast Player Streaming	{"action": "pause", "episode": "292-pythonic-identity-auth-in-python-ecosystem", "podcast": "talkpython", "deviceType": "web"}	2020-12-24 11:18:45.743999	12	1
21	Podcast Player Streaming	{"action": "play", "episode": "m-music-track-1", "podcast": "musicrelease3", "deviceType": "web"}	2020-12-27 22:01:36.559999	12	1
22	Podcast Player Streaming	{"action": "pause", "episode": "m-music-track-1", "podcast": "musicrelease3", "deviceType": "web"}	2020-12-27 22:01:43.104	12	1
23	Podcast Player Streaming	{"action": "play", "episode": "m-music-track-1", "podcast": "musicrelease3", "deviceType": "web"}	2020-12-27 22:10:35.915999	12	1
24	Podcast Player Streaming	{"action": "pause", "episode": "m-music-track-1", "podcast": "musicrelease3", "deviceType": "web"}	2020-12-27 22:10:42.441999	12	1
25	Podcast Player Streaming	{"action": "play", "episode": "m-music-track-1", "podcast": "musicrelease3", "deviceType": "web"}	2020-12-27 22:18:21.438999	12	1
26	Podcast Player Streaming	{"action": "pause", "episode": "m-music-track-1", "podcast": "musicrelease3", "deviceType": "web"}	2020-12-27 22:18:23.690999	12	1
27	Podcast Player Streaming	{"action": "play", "episode": "m-music-track-1", "podcast": "musicrelease3", "deviceType": "web"}	2020-12-27 22:18:27.535	12	1
28	Podcast Player Streaming	{"action": "play", "episode": "mmusicnewss", "podcast": "musicreleasedes", "deviceType": "web"}	2020-12-27 23:23:29.171999	12	1
29	Podcast Player Streaming	{"action": "pause", "episode": "mmusicnewss", "podcast": "musicreleasedes", "deviceType": "web"}	2020-12-27 23:23:30.676	12	1
30	Podcast Player Streaming	{"action": "play", "episode": "kmk", "podcast": "musicrelease2", "deviceType": "web"}	2020-12-28 14:52:57.242	12	1
31	Podcast Player Streaming	{"action": "pause", "episode": "kmk", "podcast": "musicrelease2", "deviceType": "web"}	2020-12-28 14:53:00.336999	12	1
32	Podcast Player Streaming	{"action": "play", "episode": "asdasdasd", "podcast": "asdasdasdsad", "deviceType": "web"}	2021-01-09 13:08:04.289999	\N	1
33	Podcast Player Streaming	{"action": "play", "episode": "295-gis-python", "podcast": "talkpython", "deviceType": "web"}	2021-01-09 13:12:09.441999	12	1
34	Podcast Player Streaming	{"action": "pause", "episode": "295-gis-python", "podcast": "talkpython", "deviceType": "web"}	2021-01-09 13:12:25.821	12	1
35	Podcast Player Streaming	{"action": "play", "episode": "mmusicnewss", "podcast": "musicreleasedes", "deviceType": "web"}	2021-01-09 13:20:37.68	12	1
36	Podcast Player Streaming	{"action": "pause", "episode": "mmusicnewss", "podcast": "musicreleasedes", "deviceType": "web"}	2021-01-09 13:20:44.109999	12	1
37	Podcast Player Streaming	{"action": "play", "episode": "mmusicnewss", "podcast": "musicreleasedes", "deviceType": "web"}	2021-01-09 13:20:44.851	12	1
\.


--
-- Data for Name: ahoy_messages; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.ahoy_messages (id, clicked_at, content, feedback_message_id, mailer, opened_at, sent_at, subject, "to", token, user_id, user_type, utm_campaign, utm_content, utm_medium, utm_source, utm_term) FROM stdin;
1	\N	Date: Wed, 25 Nov 2020 18:54:58 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: lesch+tora@collier.net\r\nMessage-ID: <5fbe623231d01_124622e487351a@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe62322ab8a_124622e48734c0";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe62322ab8a_124622e48734c0\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Tora Lesch! You got the fugit 93 badge! Be sure to check out your profile.\r\n\r\nVoluptatem nobis voluptatem nihil.\r\n\r\n\r\nDicta.\r\n\r\n\r\n\r\n    Enter fullscreen mode\r\n    \r\n\r\n\r\n    Exit fullscreen mode\r\n    \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/tora_lesch\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe62322ab8a_124622e48734c0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Tora Lesch! You received the <b>fugit 93</b> badge!=0D=\n\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/2/21.png" style=3D"height:200p=\nx" alt=3D"fugit 93 badge">=0D\n  </p>=0D\n  <p>=0D\n    Voluptatem nobis voluptatem nihil.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n<code>Dicta.=0D\n</code>=0D\n=0D\n=0D\n    Enter fullscreen mode=0D\n    =0D\n=0D\n=0D\n    Exit fullscreen mode=0D\n    =0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/xyvQ1oDaZ8R1F7zUvo9G00=\ncSydBRCS0F/click?signature=3D654b1132c3a422f6b4110438a3b4094a4d4eb4f0&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Ftora_lesch%3Futm_source%3Dnotify_m=\nailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D"fon=\nt-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border-rad=\nius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/x=\nyvQ1oDaZ8R1F7zUvo9G00cSydBRCS0F/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/xyvQ1oDaZ8R1F7zUvo9G00cSydBRCS0F/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/xyvQ1oDaZ8R1F7=\nzUvo9G00cSydBRCS0F/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkHOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7AYMqY2wY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--8d5a38861cd56cfb5eb66464435da9b74e6f6595">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/xyvQ1oDaZ8R1F7=\nzUvo9G00cSydBRCS0F/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/xyvQ1oDaZ8R1F7zU=\nvo9G00cSydBRCS0F/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe62322ab8a_124622e48734c0--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:54:59.958481	You just got a badge	lesch+tora@collier.net	xyvQ1oDaZ8R1F7zUvo9G00cSydBRCS0F	2	User	new_badge_email	\N	email	notify_mailer	\N
2	\N	Date: Wed, 25 Nov 2020 18:54:58 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: rolfson+kasey@muller-koepp.co\r\nMessage-ID: <5fbe62325fe59_12462348873746@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe62325d94a_1246234887365f";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe62325d94a_1246234887365f\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Kasey Rolfson! You got the fugit 93 badge! Be sure to check out your profile.\r\n\r\nVoluptatem nobis voluptatem nihil.\r\n\r\n\r\n  \r\n  \r\n  Aut\r\n\r\n\r\nSuscipit molestias molestiae. Saepe ut voluptates. Excepturi est incidunt.\r\nAut.\r\n\r\n\r\n\r\nhttp://localhost:3000/rolfsonkasey\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe62325d94a_1246234887365f\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Kasey Rolfson! You received the <b>fugit 93</b> badg=\ne!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/2/21.png" style=3D"height:200p=\nx" alt=3D"fugit 93 badge">=0D\n  </p>=0D\n  <p>=0D\n    Voluptatem nobis voluptatem nihil.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n  <a name=3D"aut" href=3D"#aut">=0D\n  </a>=0D\n  Aut=0D\n=0D\n=0D\nSuscipit molestias molestiae. Saepe ut voluptates. Excepturi est incidunt=\n.=0D\n<code>Aut.</code>=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/4L7ljb7DsIadyPNEUiSmbf=\nRSoiPDDoyL/click?signature=3D59d09811206280e3653d530b219b379e4ca6e6b2&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Frolfsonkasey%3Futm_source%3Dnotify=\n_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D"f=\nont-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border-r=\nadius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/4=\nL7ljb7DsIadyPNEUiSmbfRSoiPDDoyL/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/4L7ljb7DsIadyPNEUiSmbfRSoiPDDoyL/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/4L7ljb7DsIadyP=\nNEUiSmbfRSoiPDDoyL/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkGOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7AM7Ck2wY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--a68de70e5f1bcfbdc7a5340142d60512318e2612">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/4L7ljb7DsIadyP=\nNEUiSmbfRSoiPDDoyL/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/4L7ljb7DsIadyPNE=\nUiSmbfRSoiPDDoyL/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe62325d94a_1246234887365f--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:00.058656	You just got a badge	rolfson+kasey@muller-koepp.co	4L7ljb7DsIadyPNEUiSmbfRSoiPDDoyL	1	User	new_badge_email	\N	email	notify_mailer	\N
3	\N	Date: Wed, 25 Nov 2020 18:55:00 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: shanahan+laveta@fritsch.net\r\nMessage-ID: <5fbe6234d1e3_124621b887397b@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe6234b4d9_124621b88738f8";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe6234b4d9_124621b88738f8\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Laveta Shanahan! You got the magni 82 badge! Be sure to check out your profile.\r\n\r\nAd minus soluta accusantium.\r\n\r\n\r\n\r\n\r\net\r\nitaque\r\neos\r\n\r\n\r\n\r\n\r\nomnis\r\ndicta\r\nmaiores\r\n\r\n\r\nvoluptas\r\ndignissimos\r\nnostrum\r\n\r\n\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/shanahan_laveta\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe6234b4d9_124621b88738f8\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Laveta Shanahan! You received the <b>magni 82</b> ba=\ndge!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/4/9.png" style=3D"height:200px=\n" alt=3D"magni 82 badge">=0D\n  </p>=0D\n  <p>=0D\n    Ad minus soluta accusantium.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n=0D\n=0D\net=0D\nitaque=0D\neos=0D\n=0D\n=0D\n=0D\n=0D\nomnis=0D\ndicta=0D\nmaiores=0D\n=0D\n=0D\nvoluptas=0D\ndignissimos=0D\nnostrum=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/pDCiXOeYgTkdGQfRDneQE0=\nwxHWzZgVbH/click?signature=3D1e5599c0cc193e1d4f40247bd9b34bd7fac5fa20&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fshanahan_laveta%3Futm_source%3Dnot=\nify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D=\n"font-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border=\n-radius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/p=\nDCiXOeYgTkdGQfRDneQE0wxHWzZgVbH/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/pDCiXOeYgTkdGQfRDneQE0wxHWzZgVbH/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/pDCiXOeYgTkdGQ=\nfRDneQE0wxHWzZgVbH/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkJOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7A0Pm%2B2wY6CXpvbmVJIghVVEMGOgZFRkkiCFVU=\nQwY7DFRACQ%3D%3D--79cd0850369690245f156a01d5716a6ade805d69">Unsubscribe</=\na> |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/pDCiXOeYgTkdGQ=\nfRDneQE0wxHWzZgVbH/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/pDCiXOeYgTkdGQfR=\nDneQE0wxHWzZgVbH/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe6234b4d9_124621b88738f8--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:01.739623	You just got a badge	shanahan+laveta@fritsch.net	pDCiXOeYgTkdGQfRDneQE0wxHWzZgVbH	4	User	new_badge_email	\N	email	notify_mailer	\N
4	\N	Date: Wed, 25 Nov 2020 18:55:00 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: mcglynn+md+dee@altenwerth-reichel.net\r\nMessage-ID: <5fbe623434629_12462894c741b6@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe62343207d_12462894c740d8";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe62343207d_12462894c740d8\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Dee McGlynn MD! You got the magni 82 badge! Be sure to check out your profile.\r\n\r\nAd minus soluta accusantium.\r\n\r\n\r\n  \r\n  \r\n  Id\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/md_mcglynn_dee\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe62343207d_12462894c740d8\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Dee McGlynn MD! You received the <b>magni 82</b> bad=\nge!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/4/9.png" style=3D"height:200px=\n" alt=3D"magni 82 badge">=0D\n  </p>=0D\n  <p>=0D\n    Ad minus soluta accusantium.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n  <a name=3D"id" href=3D"#id">=0D\n  </a>=0D\n  Id=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/Kd1lr9RDnaqyDOrZpHuJSF=\n0mlyAEPlmX/click?signature=3D124edae9ab01929b6a78f143b7814ebd5469de92&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fmd_mcglynn_dee%3Futm_source%3Dnoti=\nfy_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D=\n"font-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border=\n-radius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/K=\nd1lr9RDnaqyDOrZpHuJSF0mlyAEPlmX/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/Kd1lr9RDnaqyDOrZpHuJSF0mlyAEPlmX/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/Kd1lr9RDnaqyDO=\nrZpHuJSF0mlyAEPlmX/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkIOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7AiOIB3AY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--4f9fa4e241e12fe8551f071531f2643d1f9cf346">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/Kd1lr9RDnaqyDO=\nrZpHuJSF0mlyAEPlmX/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/Kd1lr9RDnaqyDOrZ=\npHuJSF0mlyAEPlmX/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe62343207d_12462894c740d8--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:01.753443	You just got a badge	mcglynn+md+dee@altenwerth-reichel.net	Kd1lr9RDnaqyDOrZpHuJSF0mlyAEPlmX	3	User	new_badge_email	\N	email	notify_mailer	\N
5	\N	Date: Wed, 25 Nov 2020 18:55:01 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: admin@forem.local\r\nMessage-ID: <5fbe6235d5bf7_124623488743cb@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe6235d3fc8_1246234887426a";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe6235d3fc8_1246234887426a\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Admin McAdmin! You got the magni 82 badge! Be sure to check out your profile.\r\n\r\nAd minus soluta accusantium.\r\n\r\n\r\n  \r\n  \r\n  Eum\r\n\r\n\r\nEveniet ea unde. Dolorem voluptatum vel. Qui sint odit.\r\n\r\n\r\n  \r\n  \r\n  Qui\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/admin_mcadmin\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe6235d3fc8_1246234887426a\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Admin McAdmin! You received the <b>magni 82</b> badg=\ne!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/4/9.png" style=3D"height:200px=\n" alt=3D"magni 82 badge">=0D\n  </p>=0D\n  <p>=0D\n    Ad minus soluta accusantium.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n  <a name=3D"eum" href=3D"#eum">=0D\n  </a>=0D\n  Eum=0D\n=0D\n=0D\nEveniet ea unde. Dolorem voluptatum vel. Qui sint odit.=0D\n=0D\n=0D\n  <a name=3D"qui" href=3D"#qui">=0D\n  </a>=0D\n  Qui=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/yTl71K366hUSEQRDoQoGxP=\naHCNzaDalz/click?signature=3Dd76eae8f92b1f930f42e91006728e71b2473fd27&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fadmin_mcadmin%3Futm_source%3Dnotif=\ny_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D"=\nfont-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border-=\nradius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/y=\nTl71K366hUSEQRDoQoGxPaHCNzaDalz/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/yTl71K366hUSEQRDoQoGxPaHCNzaDalz/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/yTl71K366hUSEQ=\nRDoQoGxPaHCNzaDalz/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b></b> to authenticate your account, so use a=\nny of those to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkQOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7AkzMc3AY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--9a3d26115ee1d80b7cd386d0d73e0d6780873ab0">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/yTl71K366hUSEQ=\nRDoQoGxPaHCNzaDalz/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/yTl71K366hUSEQRD=\noQoGxPaHCNzaDalz/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe6235d3fc8_1246234887426a--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:03.349897	You just got a badge	admin@forem.local	yTl71K366hUSEQRDoQoGxPaHCNzaDalz	11	User	new_badge_email	\N	email	notify_mailer	\N
6	\N	Date: Wed, 25 Nov 2020 18:55:02 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: jacob+lehner@lowe-marvin.org\r\nMessage-ID: <5fbe623679c1b_12463a714745d0@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe6236779c0_12463a714744f";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe6236779c0_12463a714744f\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Jacob Lehner! You got the doloribus 77 badge! Be sure to check out your profile.\r\n\r\nFuga veniam officiis qui.\r\n\r\n\r\n\r\n\r\nfacilis\r\nmolestiae\r\nprovident\r\n\r\n\r\n\r\n\r\nalias\r\nconsequatur\r\nfuga\r\n\r\n\r\net\r\nmolestias\r\nvoluptatem\r\n\r\n\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/lehner_jacob\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe6236779c0_12463a714744f\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Jacob Lehner! You received the <b>doloribus 77</b> b=\nadge!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/5/30.png" style=3D"height:200p=\nx" alt=3D"doloribus 77 badge">=0D\n  </p>=0D\n  <p>=0D\n    Fuga veniam officiis qui.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n=0D\n=0D\nfacilis=0D\nmolestiae=0D\nprovident=0D\n=0D\n=0D\n=0D\n=0D\nalias=0D\nconsequatur=0D\nfuga=0D\n=0D\n=0D\net=0D\nmolestias=0D\nvoluptatem=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/Brf7b9XUwBIv3z0kHnilPM=\nB18KpHURCN/click?signature=3D1da4f57104f27acd8ebf8adbe4fc513fbfa6dd69&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Flehner_jacob%3Futm_source%3Dnotify=\n_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D"f=\nont-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border-r=\nadius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/B=\nrf7b9XUwBIv3z0kHnilPMB18KpHURCN/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/Brf7b9XUwBIv3z0kHnilPMB18KpHURCN/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/Brf7b9XUwBIv3z=\n0kHnilPMB18KpHURCN/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkLOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7Ag%2B0l3AY6CXpvbmVJIghVVEMGOgZFRkkiCFVU=\nQwY7DFRACQ%3D%3D--ff3400bf517d9029489df9759e3c56a8b12e059d">Unsubscribe</=\na> |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/Brf7b9XUwBIv3z=\n0kHnilPMB18KpHURCN/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/Brf7b9XUwBIv3z0k=\nHnilPMB18KpHURCN/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe6236779c0_12463a714744f--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:03.886863	You just got a badge	jacob+lehner@lowe-marvin.org	Brf7b9XUwBIv3z0kHnilPMB18KpHURCN	6	User	new_badge_email	\N	email	notify_mailer	\N
7	\N	Date: Wed, 25 Nov 2020 18:55:02 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: hackett+gov+guadalupe@larkin.info\r\nMessage-ID: <5fbe6236bdedf_12463a7b47478b@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe6236bc4e4_12463a7b4746dd";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe6236bc4e4_12463a7b4746dd\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Gov. Guadalupe Hackett! You got the sed 27 badge! Be sure to check out your profile.\r\n\r\nQui qui maxime cumque.\r\n\r\n\r\nEos. \r\nAutem. \r\nAd. \r\nAlias. \r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/guadalupehackettgov\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe6236bc4e4_12463a7b4746dd\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Gov. Guadalupe Hackett! You received the <b>sed 27</=\nb> badge!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/3/28.png" style=3D"height:200p=\nx" alt=3D"sed 27 badge">=0D\n  </p>=0D\n  <p>=0D\n    Qui qui maxime cumque.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\nEos. =0D\nAutem. =0D\nAd. =0D\nAlias. =0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/Bankmsgc10FcAdBTR91lUV=\nRxXSUt8Cu5/click?signature=3Df6de3da0310bedd2771fe398258fe1f75d017f64&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fguadalupehackettgov%3Futm_source%3=\nDnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" sty=\nle=3D"font-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;b=\norder-radius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/B=\nankmsgc10FcAdBTR91lUVRxXSUt8Cu5/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/Bankmsgc10FcAdBTR91lUVRxXSUt8Cu5/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/Bankmsgc10FcAd=\nBTR91lUVRxXSUt8Cu5/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkKOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7Asrgq3AY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--6b7e1192505fc18724b1730bfae96e6edc247b20">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/Bankmsgc10FcAd=\nBTR91lUVRxXSUt8Cu5/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/Bankmsgc10FcAdBT=\nR91lUVRxXSUt8Cu5/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe6236bc4e4_12463a7b4746dd--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:04.159692	You just got a badge	hackett+gov+guadalupe@larkin.info	Bankmsgc10FcAdBTR91lUVRxXSUt8Cu5	5	User	new_badge_email	\N	email	notify_mailer	\N
8	\N	Date: Wed, 25 Nov 2020 18:55:03 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: wiegand+pablo@kuhic.io\r\nMessage-ID: <5fbe623776687_12462894c74983@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe6237749d4_12462894c748d1";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe6237749d4_12462894c748d1\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Pablo Wiegand! You got the quis 62 badge! Be sure to check out your profile.\r\n\r\nEt molestiae ea reiciendis.\r\n\r\n\r\n  \r\n  \r\n  Quis\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/pablowiegand\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe6237749d4_12462894c748d1\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Pablo Wiegand! You received the <b>quis 62</b> badge=\n!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/1/38.png" style=3D"height:200p=\nx" alt=3D"quis 62 badge">=0D\n  </p>=0D\n  <p>=0D\n    Et molestiae ea reiciendis.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n  <a name=3D"quis" href=3D"#quis">=0D\n  </a>=0D\n  Quis=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/zP55BgqydjDQ2GSoAbuDRm=\nFpxLFjRzRr/click?signature=3D7ec57dc8eddd97acaae52cefcb9b2816e3a9ac78&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fpablowiegand%3Futm_source%3Dnotify=\n_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D"f=\nont-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border-r=\nadius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/z=\nP55BgqydjDQ2GSoAbuDRmFpxLFjRzRr/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/zP55BgqydjDQ2GSoAbuDRmFpxLFjRzRr/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/zP55BgqydjDQ2G=\nSoAbuDRmFpxLFjRzRr/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkNOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7AePI13AY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--fc37181c66dd0e70a3ccd2f4c781c924abe5a0e8">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/zP55BgqydjDQ2G=\nSoAbuDRmFpxLFjRzRr/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/zP55BgqydjDQ2GSo=\nAbuDRmFpxLFjRzRr/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe6237749d4_12462894c748d1--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:04.935339	You just got a badge	wiegand+pablo@kuhic.io	zP55BgqydjDQ2GSoAbuDRmFpxLFjRzRr	8	User	new_badge_email	\N	email	notify_mailer	\N
9	\N	Date: Wed, 25 Nov 2020 18:55:34 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: marvin+esteban@bashirian.info\r\nMessage-ID: <5fbe6256be50f_12465143c751a1@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe6256bcb03_12465143c750d7";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe6256bcb03_12465143c750d7\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Esteban Marvin! You got the fugit 93 badge! Be sure to check out your profile.\r\n\r\nVoluptatem nobis voluptatem nihil.\r\n\r\n\r\nSoluta.\r\n\r\n\r\n\r\n    Enter fullscreen mode\r\n    \r\n\r\n\r\n    Exit fullscreen mode\r\n    \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/estebanmarvin\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe6256bcb03_12465143c750d7\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Esteban Marvin! You received the <b>fugit 93</b> bad=\nge!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/2/21.png" style=3D"height:200p=\nx" alt=3D"fugit 93 badge">=0D\n  </p>=0D\n  <p>=0D\n    Voluptatem nobis voluptatem nihil.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n<code>Soluta.=0D\n</code>=0D\n=0D\n=0D\n    Enter fullscreen mode=0D\n    =0D\n=0D\n=0D\n    Exit fullscreen mode=0D\n    =0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/MHHievKIc7CkztzjYuQaSW=\nTLvfig2iOB/click?signature=3D9760c8f766e754e8bd4e31718ed3a1d86d367024&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Festebanmarvin%3Futm_source%3Dnotif=\ny_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D"=\nfont-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border-=\nradius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/M=\nHHievKIc7CkztzjYuQaSWTLvfig2iOB/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/MHHievKIc7CkztzjYuQaSWTLvfig2iOB/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/MHHievKIc7Ckzt=\nzjYuQaSWTLvfig2iOB/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b>Twitter</b> to authenticate your account, s=\no use that to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkOOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7AHNco3gY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--2c72abeb932ff2678ac3326e19479e77005fd7c8">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/MHHievKIc7Ckzt=\nzjYuQaSWTLvfig2iOB/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/MHHievKIc7Ckztzj=\nYuQaSWTLvfig2iOB/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe6256bcb03_12465143c750d7--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:36.109544	You just got a badge	marvin+esteban@bashirian.info	MHHievKIc7CkztzjYuQaSWTLvfig2iOB	9	User	new_badge_email	\N	email	notify_mailer	\N
10	\N	Date: Wed, 25 Nov 2020 18:55:47 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nTo: cremin+tressie@yundt.biz\r\nMessage-ID: <5fbe6263c07a1_124653598753e9@Macbooks-MBP.mail>\r\nSubject: You just got a badge\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5fbe6263bec45_12465359875230";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5fbe6263bec45_12465359875230\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nCongratulations, Tressie Cremin! You got the magni 82 badge! Be sure to check out your profile.\r\n\r\nAd minus soluta accusantium.\r\n\r\n\r\n  \r\n  \r\n  Aut\r\n\r\n\r\n\r\n\r\nhttp://localhost:3000/cremintressie\r\n\r\nYou also get 5 new credits to use for community listings if you have anything you'd like to promote: http://localhost:3000/listings\r\n\r\nTo manage your credits: visit: http://localhost:3000/credits\r\n\r\nFor more information about listings, visit: http://localhost:3000/about-listings\r\n\r\n\r\n----==_mimepart_5fbe6263bec45_12465359875230\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=\n.w3.org/TR/REC-html40/loose.dtd">=0D\n<html>=0D\n<body style=3D'font-family: "HelveticaNeue-Light", "Helvetica Neue Light"=\n, "Helvetica Neue", Helvetica, Arial, sans-serif;'>=0D\n<table style=3D"width:100%;max-width:700px;margin:auto;font-size:18px">=0D=\n\n  <tr>=0D\n    <td style=3D"padding:4%;">=0D\n      <center>=0D\n  <p>=0D\n    Congratulations, Tressie Cremin! You received the <b>magni 82</b> bad=\nge!=0D\n  </p>=0D\n  <p style=3D"text-align:center;padding:20px 0px">=0D\n    <img src=3D"/uploads/badge/badge_image/4/9.png" style=3D"height:200px=\n" alt=3D"magni 82 badge">=0D\n  </p>=0D\n  <p>=0D\n    Ad minus soluta accusantium.=0D\n  </p>=0D\n=0D\n    <p>=0D\n      <em>=0D\n        =0D\n  <a name=3D"aut" href=3D"#aut">=0D\n  </a>=0D\n  Aut=0D\n=0D\n=0D\n=0D\n      </em>=0D\n    </p>=0D\n    <br>=0D\n=0D\n  <p>=0D\n    <a href=3D"http://localhost:3000/ahoy/messages/ZrkUKgNihVWyzcIE6cu4gv=\nsNlTBHN1DE/click?signature=3Df92ecdf9bb4d6f9915d938ffc45c860f496d9101&amp=\n;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcremintressie%3Futm_source%3Dnotif=\ny_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email" style=3D"=\nfont-weight:bold;color:white;background:#4e57ef;padding: 5px 10px;border-=\nradius:3px;text-decoration:none">=0D\n      Check out your profile=0D\n    </a>=0D\n  </p>=0D\n  <hr style=3D"opacity:0.4;width: 150px;margin: 30px auto;">=0D\n  <p>=0D\n    You also get <strong><a href=3D"http://localhost:3000/ahoy/messages/Z=\nrkUKgNihVWyzcIE6cu4gvsNlTBHN1DE/click?signature=3Daabc641e0c8fae09dd09709=\n4e061ebfee49e4f68&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fcredits%3Futm=\n_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_e=\nmail">5 new credits</a></strong> to use for <strong><a href=3D"http://loc=\nalhost:3000/ahoy/messages/ZrkUKgNihVWyzcIE6cu4gvsNlTBHN1DE/click?signatur=\ne=3D06f71bc2e5f3adf21a05d4497836e05cf480a484&amp;url=3Dhttp%3A%2F%2Flocal=\nhost%3A3000%2Flistings%3Futm_source%3Dnotify_mailer%26utm_medium%3Demail%=\n26utm_campaign%3Dnew_badge_email">community listings</a></strong><br>=0D\n    if you have anything you'd like to promote. =F0=9F=8E=89=0D\n  </p>=0D\n  <p>=0D\n    <strong><a href=3D"http://localhost:3000/ahoy/messages/ZrkUKgNihVWyzc=\nIE6cu4gvsNlTBHN1DE/click?signature=3D7216f802d376cc23af9c4c18c34ec022e44d=\n0720&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fabout-listings%3Futm_sourc=\ne%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_badge_email">=\nMore information about listings</a><a></a></strong>=0D\n  </p>=0D\n</center>=0D\n=0D\n    </td>=0D\n  </tr>=0D\n    <tr>=0D\n      <td style=3D"padding:3% 12% 2% 4%;font-size:18px;line-height:22px;c=\nolor:#7d7d7d">=0D\n        Reminder: You used <b></b> to authenticate your account, so use a=\nny of those to sign in if prompted.=0D\n=0D\n        <br><br>=0D\n        <div style=3D"font-size:0.78em">=0D\n            <a style=3D"color:#7d7d7d" href=3D"http://localhost:3000/emai=\nl_subscriptions/unsubscribe?ut=3DBAh7CDoMdXNlcl9pZGkPOg9lbWFpbF90eXBlOh5l=\nbWFpbF9iYWRnZV9ub3RpZmljYXRpb25zOg9leHBpcmVzX2F0VTogQWN0aXZlU3VwcG9ydDo6V=\nGltZVdpdGhab25lWwhJdToJVGltZQ1NLx7AJw373gY6CXpvbmVJIghVVEMGOgZFRkkiCFVUQw=\nY7DFRACQ%3D%3D--1f2dfefe4e1034e6928054ec1ba0645c48a4f817">Unsubscribe</a>=\n |=0D\n            <a href=3D"http://localhost:3000/ahoy/messages/ZrkUKgNihVWyzc=\nIE6cu4gvsNlTBHN1DE/click?signature=3D6347389c130af3944af3c9984a1185b86498=\ne9fe&amp;url=3Dhttp%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3=\nFutm_source%3Dnotify_mailer%26utm_medium%3Demail%26utm_campaign%3Dnew_bad=\nge_email" style=3D"color:#7d7d7d">Adjust your email settings</a>=0D\n        </div>=0D\n      </td>=0D\n    </tr>=0D\n</table>=0D\n<img alt=3D"" src=3D"http://localhost:3000/ahoy/messages/ZrkUKgNihVWyzcIE=\n6cu4gvsNlTBHN1DE/open.gif" width=3D"1" height=3D"1">=0D\n</body>=0D\n</html>=0D\n\r\n----==_mimepart_5fbe6263bec45_12465359875230--\r\n	\N	NotifyMailer#new_badge_email	\N	2020-11-25 13:55:49.194585	You just got a badge	cremin+tressie@yundt.biz	ZrkUKgNihVWyzcIE6cu4gvsNlTBHN1DE	10	User	new_badge_email	\N	email	notify_mailer	\N
14	\N	Date: Wed, 30 Dec 2020 20:13:30 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nReply-To: DEV Community <yo@dev.to> (local)\r\nTo: pihov48469@1092df.com\r\nMessage-ID: <5fec991a6404a_523f3d4dc5560@Macbooks-MBP.mail>\r\nSubject: Confirmation instructions\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html><body>\r\n<p>Welcome pihov48469@1092df.com!</p>\r\n\r\n<p>You can confirm your account email through the link below:</p>\r\n\r\n<p><a href="http://localhost:3000/ahoy/messages/QEkQE1HThHZyYvPTuBGR6v03P52yibf3/click?signature=fa1d2a990d6214e4251a1947cd562b05ff02ea0a&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fconfirmation%3Fconfirmation_token%3DoBXRWVwsV_WR7EcykEdV%26utm_source%3Ddevise_mailer%26utm_medium%3Demail%26utm_campaign%3Dconfirmation_instructions">Confirm my account</a></p>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/QEkQE1HThHZyYvPTuBGR6v03P52yibf3/open.gif" width="1" height="1">\r\n</body></html>\r\n	\N	DeviseMailer#confirmation_instructions	\N	2020-12-30 15:13:31.660296	Confirmation instructions	pihov48469@1092df.com	QEkQE1HThHZyYvPTuBGR6v03P52yibf3	19	User	confirmation_instructions	\N	email	devise_mailer	\N
15	\N	Date: Wed, 30 Dec 2020 20:13:31 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: pihov48469@1092df.com\r\nMessage-ID: <5fec991bb2f2b_523f3d4dc563@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that your first step verification has been approved.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="/user_documents/new?user_id=19">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/zZiB03DpvspKlX7wd34RNn2maW38tndb/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/zZiB03DpvspKlX7wd34RNn2maW38tndb/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n	\N	VerificationMailer#user_documents_email	\N	2020-12-30 15:13:32.941038	Additional Documents Needed For DEV(local) Account	pihov48469@1092df.com	zZiB03DpvspKlX7wd34RNn2maW38tndb	19	User	user_documents_email	\N	email	verification_mailer	\N
16	\N	Date: Thu, 31 Dec 2020 19:22:28 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: pihov48469@1092df.com\r\nMessage-ID: <5feddea476ace_93ea8d68072487@Macbooks-MBP.mail>\r\nSubject: Verification successful\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  Congratulations! you've been verified successfully\r\n</p>\r\n\r\n<p>\r\n  Below are the credentials, do not share these with anyone\r\n  Email: pihov48469@1092df.com\r\n  Password: \r\n</p>\r\n\r\n<p>\r\n Feel free to login from here: <a href="http://localhost:3000/ahoy/messages/ihkh6g1JILLW8ThLxGCGUiL8AKDWtDFd/click?signature=b35fce3b0192adba27aafd3d4f9348522eac1a5a&amp;url=http%3A%2F%2Funitedbits.io%2Fenter%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Dartist_verified">login</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/ihkh6g1JILLW8ThLxGCGUiL8AKDWtDFd/click?signature=47b9c16abd471c219fd1fa127451edee0b324bd3&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Dartist_verified">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/ihkh6g1JILLW8ThLxGCGUiL8AKDWtDFd/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n	\N	VerificationMailer#artist_verified	\N	2020-12-31 14:22:30.028478	Verification successful	pihov48469@1092df.com	ihkh6g1JILLW8ThLxGCGUiL8AKDWtDFd	19	User	artist_verified	\N	email	verification_mailer	\N
17	\N	Date: Sun, 03 Jan 2021 19:02:28 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: mj@jm.com\r\nMessage-ID: <5ff1ce743fd1_8943fb605292e@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff1ce7466f_8943fb60528c2";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff1ce7466f_8943fb60528c2\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=20">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff1ce7466f_8943fb60528c2\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/Xx4hw4x1ak1838vMKOcRFBiPO7gckxjK/click?signature=0eebe4ada3bc465ea35f92b579abf70d2e15a2e9&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D20%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/Xx4hw4x1ak1838vMKOcRFBiPO7gckxjK/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/Xx4hw4x1ak1838vMKOcRFBiPO7gckxjK/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/Xx4hw4x1ak1838vMKOcRFBiPO7gckxjK/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff1ce7466f_8943fb60528c2--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-03 14:02:29.309406	Additional Documents Needed For DEV(local) Account	mj@jm.com	Xx4hw4x1ak1838vMKOcRFBiPO7gckxjK	20	User	user_documents_email	\N	email	verification_mailer	\N
18	\N	Date: Sun, 03 Jan 2021 19:13:13 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: ok@ok.com\r\nMessage-ID: <5ff1d0f9271ba_8953d22052922@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff1d0f9245dc_8953d220528cc";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff1d0f9245dc_8953d220528cc\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=21">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff1d0f9245dc_8953d220528cc\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/mluTYRFzv3JeU7VrbgMXMZZQC9S3rqbz/click?signature=0ce65bd095e13c30be616da500ca1fbd18b485e8&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D21%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/mluTYRFzv3JeU7VrbgMXMZZQC9S3rqbz/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/mluTYRFzv3JeU7VrbgMXMZZQC9S3rqbz/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/mluTYRFzv3JeU7VrbgMXMZZQC9S3rqbz/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff1d0f9245dc_8953d220528cc--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-03 14:13:14.415403	Additional Documents Needed For DEV(local) Account	ok@ok.com	mluTYRFzv3JeU7VrbgMXMZZQC9S3rqbz	21	User	user_documents_email	\N	email	verification_mailer	\N
19	\N	Date: Sun, 03 Jan 2021 19:36:10 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: uh@hu.com\r\nMessage-ID: <5ff1d65aa8074_8953d9145312a@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff1d65aa5699_8953d9145307";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff1d65aa5699_8953d9145307\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=22">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff1d65aa5699_8953d9145307\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/pTqsdwpQnn7zTvQHmXclxZ5l6pulSmPQ/click?signature=3a6467dc4db9c90cc0dff57fefbc5bfca43fa319&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D22%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/pTqsdwpQnn7zTvQHmXclxZ5l6pulSmPQ/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/pTqsdwpQnn7zTvQHmXclxZ5l6pulSmPQ/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/pTqsdwpQnn7zTvQHmXclxZ5l6pulSmPQ/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff1d65aa5699_8953d9145307--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-03 14:36:11.949309	Additional Documents Needed For DEV(local) Account	uh@hu.com	pTqsdwpQnn7zTvQHmXclxZ5l6pulSmPQ	22	User	user_documents_email	\N	email	verification_mailer	\N
20	\N	Date: Sun, 03 Jan 2021 19:44:20 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: qw@qw.com\r\nMessage-ID: <5ff1d844e023_89414c8053142@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff1d844b8bc_89414c805303";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff1d844b8bc_89414c805303\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=23">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff1d844b8bc_89414c805303\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/K15hOTTYFAMvIXph7ANChfBhruFqp0dW/click?signature=bf1715537ca10fb30267caf4c7d1282db2412f37&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D23%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/K15hOTTYFAMvIXph7ANChfBhruFqp0dW/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/K15hOTTYFAMvIXph7ANChfBhruFqp0dW/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/K15hOTTYFAMvIXph7ANChfBhruFqp0dW/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff1d844b8bc_89414c805303--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-03 14:44:21.304801	Additional Documents Needed For DEV(local) Account	qw@qw.com	K15hOTTYFAMvIXph7ANChfBhruFqp0dW	23	User	user_documents_email	\N	email	verification_mailer	\N
21	\N	Date: Sun, 03 Jan 2021 19:57:15 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: yy@yy.com\r\nMessage-ID: <5ff1db4b98bdc_8943fb6053332@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff1db4b9627c_8943fb605326a";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff1db4b9627c_8943fb605326a\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=24">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff1db4b9627c_8943fb605326a\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/e2G4zp3mYRI3oOcz5B7v8ANkx2ccXLUd/click?signature=5722f71b67ca4769f837ebda377cf8e4d80a9773&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D24%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/e2G4zp3mYRI3oOcz5B7v8ANkx2ccXLUd/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/e2G4zp3mYRI3oOcz5B7v8ANkx2ccXLUd/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/e2G4zp3mYRI3oOcz5B7v8ANkx2ccXLUd/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff1db4b9627c_8943fb605326a--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-03 14:57:16.901303	Additional Documents Needed For DEV(local) Account	yy@yy.com	e2G4zp3mYRI3oOcz5B7v8ANkx2ccXLUd	24	User	user_documents_email	\N	email	verification_mailer	\N
22	\N	Date: Tue, 05 Jan 2021 17:11:56 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nReply-To: DEV Community <yo@dev.to> (local)\r\nTo: muzamil.mujahid11@gmail.commmm\r\nMessage-ID: <5ff4578ceb09e_b233da68184a8@Macbooks-MBP.mail>\r\nSubject: Confirmation instructions\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html><body>\r\n<p>Welcome muzamil.mujahid11@gmail.commmm!</p>\r\n\r\n<p>You can confirm your account email through the link below:</p>\r\n\r\n<p><a href="http://localhost:3000/ahoy/messages/GZnuYYj6snTWgiYO60ogJ8LEYc0zzLtK/click?signature=25f7596fbe1cf5f76a5ca5798e6ec822c7a541dd&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fconfirmation%3Fconfirmation_token%3DZTJE28CMqzZ5UZFszbxj%26utm_source%3Ddevise_mailer%26utm_medium%3Demail%26utm_campaign%3Dconfirmation_instructions">Confirm my account</a></p>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/GZnuYYj6snTWgiYO60ogJ8LEYc0zzLtK/open.gif" width="1" height="1">\r\n</body></html>\r\n	\N	DeviseMailer#confirmation_instructions	\N	2021-01-05 12:11:58.230869	Confirmation instructions	muzamil.mujahid11@gmail.commmm	GZnuYYj6snTWgiYO60ogJ8LEYc0zzLtK	25	User	confirmation_instructions	\N	email	devise_mailer	\N
23	\N	Date: Tue, 05 Jan 2021 17:11:58 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: muzamil.mujahid11@gmail.commmm\r\nMessage-ID: <5ff4578ec1c75_b233da681866@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff4578ebf4eb_b233da6818581";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff4578ebf4eb_b233da6818581\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=25">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff4578ebf4eb_b233da6818581\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/wvbwXGWbp2tE8nLQmYUP7rRXbvMXt9X2/click?signature=a7f2d094e9a28388e9af1992ff796ba13fc81ca5&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D25%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/wvbwXGWbp2tE8nLQmYUP7rRXbvMXt9X2/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/wvbwXGWbp2tE8nLQmYUP7rRXbvMXt9X2/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/wvbwXGWbp2tE8nLQmYUP7rRXbvMXt9X2/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff4578ebf4eb_b233da6818581--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-05 12:12:00.019992	Additional Documents Needed For DEV(local) Account	muzamil.mujahid11@gmail.commmm	wvbwXGWbp2tE8nLQmYUP7rRXbvMXt9X2	25	User	user_documents_email	\N	email	verification_mailer	\N
24	\N	Date: Tue, 05 Jan 2021 17:34:56 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nReply-To: DEV Community <yo@dev.to> (local)\r\nTo: mkmkm@kmkm.com\r\nMessage-ID: <5ff45cf05068a_b2314c8018746@Macbooks-MBP.mail>\r\nSubject: Confirmation instructions\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html><body>\r\n<p>Welcome mkmkm@kmkm.com!</p>\r\n\r\n<p>You can confirm your account email through the link below:</p>\r\n\r\n<p><a href="http://localhost:3000/ahoy/messages/HDazHoISi5GozC7KjEXPOlJC9ih5CHBO/click?signature=0c0a9cbe39f1f025aea3a49c60cb043573692bee&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fconfirmation%3Fconfirmation_token%3DLz6RGzshirHsxzFNRLcx%26utm_source%3Ddevise_mailer%26utm_medium%3Demail%26utm_campaign%3Dconfirmation_instructions">Confirm my account</a></p>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/HDazHoISi5GozC7KjEXPOlJC9ih5CHBO/open.gif" width="1" height="1">\r\n</body></html>\r\n	\N	DeviseMailer#confirmation_instructions	\N	2021-01-05 12:34:57.549148	Confirmation instructions	mkmkm@kmkm.com	HDazHoISi5GozC7KjEXPOlJC9ih5CHBO	26	User	confirmation_instructions	\N	email	devise_mailer	\N
25	\N	Date: Tue, 05 Jan 2021 17:34:57 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: mkmkm@kmkm.com\r\nMessage-ID: <5ff45cf1a9f06_b2314c80189eb@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff45cf1a5a0b_b2314c80188b0";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff45cf1a5a0b_b2314c80188b0\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=26">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff45cf1a5a0b_b2314c80188b0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/mb9Nzc3IJBz6HHU1Jcsg7QgCGcmXs5wy/click?signature=067381862746aff1d99856f4e077bd35ce7d14b5&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D26%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/mb9Nzc3IJBz6HHU1Jcsg7QgCGcmXs5wy/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/mb9Nzc3IJBz6HHU1Jcsg7QgCGcmXs5wy/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/mb9Nzc3IJBz6HHU1Jcsg7QgCGcmXs5wy/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff45cf1a5a0b_b2314c80188b0--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-05 12:34:58.888146	Additional Documents Needed For DEV(local) Account	mkmkm@kmkm.com	mb9Nzc3IJBz6HHU1Jcsg7QgCGcmXs5wy	26	User	user_documents_email	\N	email	verification_mailer	\N
26	\N	Date: Tue, 05 Jan 2021 17:42:18 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nReply-To: DEV Community <yo@dev.to> (local)\r\nTo: muzamil.mujahid11@gmail.comasassaas\r\nMessage-ID: <5ff45eaa8adfc_b2414d5c184c4@Macbooks-MBP.mail>\r\nSubject: Confirmation instructions\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html><body>\r\n<p>Welcome muzamil.mujahid11@gmail.comasassaas!</p>\r\n\r\n<p>You can confirm your account email through the link below:</p>\r\n\r\n<p><a href="http://localhost:3000/ahoy/messages/CqOHZfLayTivj7wM4PDVIf9FhbMiCPDy/click?signature=23f95480efd634cb73675a424641208d16687cf8&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fconfirmation%3Fconfirmation_token%3DeixRomLBnUGJkAz2_U_z%26utm_source%3Ddevise_mailer%26utm_medium%3Demail%26utm_campaign%3Dconfirmation_instructions">Confirm my account</a></p>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/CqOHZfLayTivj7wM4PDVIf9FhbMiCPDy/open.gif" width="1" height="1">\r\n</body></html>\r\n	\N	DeviseMailer#confirmation_instructions	\N	2021-01-05 12:42:19.81727	Confirmation instructions	muzamil.mujahid11@gmail.comasassaas	CqOHZfLayTivj7wM4PDVIf9FhbMiCPDy	27	User	confirmation_instructions	\N	email	devise_mailer	\N
27	\N	Date: Tue, 05 Jan 2021 17:42:20 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: muzamil.mujahid11@gmail.comasassaas\r\nMessage-ID: <5ff45eacfe3_b2414d5c18662@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff45eabf2b8f_b2414d5c18578";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff45eabf2b8f_b2414d5c18578\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=27">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff45eabf2b8f_b2414d5c18578\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/QU5ty9wRGCVAecx7OeOVU0mo5hxop0y9/click?signature=d0b787a50d5826e39be09621b637ee93e7b2e166&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D27%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/QU5ty9wRGCVAecx7OeOVU0mo5hxop0y9/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/QU5ty9wRGCVAecx7OeOVU0mo5hxop0y9/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/QU5ty9wRGCVAecx7OeOVU0mo5hxop0y9/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff45eabf2b8f_b2414d5c18578--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-05 12:42:21.211162	Additional Documents Needed For DEV(local) Account	muzamil.mujahid11@gmail.comasassaas	QU5ty9wRGCVAecx7OeOVU0mo5hxop0y9	27	User	user_documents_email	\N	email	verification_mailer	\N
28	\N	Date: Fri, 08 Jan 2021 16:55:22 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nReply-To: DEV Community <yo@dev.to> (local)\r\nTo: muzamil.mujahid11@gmail.comjkasnkjdaskj\r\nMessage-ID: <5ff8482a55b18_59923ff84644dc@Macbooks-MBP.mail>\r\nSubject: Confirmation instructions\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html><body>\r\n<p>Welcome muzamil.mujahid11@gmail.comjkasnkjdaskj!</p>\r\n<br>\r\n<p>Hi there,</p>\r\n<br>\r\n<p>Yotta here from UnitedBits. Noticed that you just joined UnitedBits. How things work?</p>\r\n<br>\r\n<p>Verify your email account to establish a communication channel and access your account</p>\r\n<p>Setup your online business using the Music-Business launcher.</p>\r\n<p>Verify your banking account details to receive commissions and payments</p>\r\n<p>Once you are ready tos start accepting commissions notify us to start your business in unitedbits.</p>\r\n<br><br>\r\n<p>Here are two resources you might find useful as you navigate the UnitedBits:</p>\r\n<p>Business launcher features, to help you explore the potential of your platform.</p>\r\n<p>Direct messaging feature, to communicate with us your needs. Hop on to start building your business and community.</p>\r\n<p>Hope that helps!</p>\r\n<br>\r\n<h3>Confirm Email to proceed</h3>\r\n<p>You can confirm your account email through the link below:</p>\r\n\r\n<p><a href="http://localhost:3000/ahoy/messages/v3JejT3vAEwaDLglf212bkU88PUtRNKn/click?signature=bf21e3141387715eb8315256abf91c7943b6d480&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fconfirmation%3Fconfirmation_token%3DiesvPwmtETeHxgp6_22J%26utm_source%3Ddevise_mailer%26utm_medium%3Demail%26utm_campaign%3Dconfirmation_instructions">Confirm my account</a></p>\r\n<br><br><br>\r\n<p>Yotta</p>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/v3JejT3vAEwaDLglf212bkU88PUtRNKn/open.gif" width="1" height="1">\r\n</body></html>\r\n	\N	DeviseMailer#confirmation_instructions	\N	2021-01-08 11:55:23.615411	Confirmation instructions	muzamil.mujahid11@gmail.comjkasnkjdaskj	v3JejT3vAEwaDLglf212bkU88PUtRNKn	29	User	confirmation_instructions	\N	email	devise_mailer	\N
29	\N	Date: Fri, 08 Jan 2021 16:55:23 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: muzamil.mujahid11@gmail.comjkasnkjdaskj\r\nMessage-ID: <5ff8482beb824_59923ff8464635@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff8482be9164_59923ff846454e";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff8482be9164_59923ff846454e\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=29">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff8482be9164_59923ff846454e\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/fwq9s4pSh7T31zEUF8Y52uxG7t6P251B/click?signature=8fcbc8beaadc1167804129283f9ee3e763aa496f&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D29%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/fwq9s4pSh7T31zEUF8Y52uxG7t6P251B/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/fwq9s4pSh7T31zEUF8Y52uxG7t6P251B/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/fwq9s4pSh7T31zEUF8Y52uxG7t6P251B/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff8482be9164_59923ff846454e--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-08 11:55:25.166633	Additional Documents Needed For DEV(local) Account	muzamil.mujahid11@gmail.comjkasnkjdaskj	fwq9s4pSh7T31zEUF8Y52uxG7t6P251B	29	User	user_documents_email	\N	email	verification_mailer	\N
30	\N	Date: Fri, 08 Jan 2021 17:54:18 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nReply-To: DEV Community <yo@dev.to> (local)\r\nTo: ghgh@ghgh.com\r\nMessage-ID: <5ff855fa86060_599114c9464479@Macbooks-MBP.mail>\r\nSubject: Confirmation instructions\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html><body>\r\n<p>Welcome ghgh@ghgh.com!</p>\r\n<br>\r\n<p>Hi there,</p>\r\n<br>\r\n<p>Yotta here from UnitedBits. Noticed that you just joined UnitedBits. How things work?</p>\r\n<br>\r\n<p>Verify your email account to establish a communication channel and access your account</p>\r\n<p>Setup your online business using the Music-Business launcher.</p>\r\n<p>Verify your banking account details to receive commissions and payments</p>\r\n<p>Once you are ready tos start accepting commissions notify us to start your business in unitedbits.</p>\r\n<br><br>\r\n<p>Here are two resources you might find useful as you navigate the UnitedBits:</p>\r\n<p>Business launcher features, to help you explore the potential of your platform.</p>\r\n<p>Direct messaging feature, to communicate with us your needs. Hop on to start building your business and community.</p>\r\n<p>Hope that helps!</p>\r\n<br>\r\n<h3>Confirm Email to proceed</h3>\r\n<p>You can confirm your account email through the link below:</p>\r\n\r\n<p><a href="http://localhost:3000/ahoy/messages/e1fJooFtHSGetPplcYww4oU59LfyfMgH/click?signature=29eed8d74090a24b1746b8f208b3c123e7fbccf7&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fconfirmation%3Fconfirmation_token%3D73d5qx3q_WqznSBt7iU8%26utm_source%3Ddevise_mailer%26utm_medium%3Demail%26utm_campaign%3Dconfirmation_instructions">Confirm my account</a></p>\r\n<br><br><br>\r\n<p>Yotta</p>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/e1fJooFtHSGetPplcYww4oU59LfyfMgH/open.gif" width="1" height="1">\r\n</body></html>\r\n	\N	DeviseMailer#confirmation_instructions	\N	2021-01-08 12:54:19.817927	Confirmation instructions	ghgh@ghgh.com	e1fJooFtHSGetPplcYww4oU59LfyfMgH	30	User	confirmation_instructions	\N	email	devise_mailer	\N
31	\N	Date: Fri, 08 Jan 2021 17:54:20 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: ghgh@ghgh.com\r\nMessage-ID: <5ff855fc27c70_599114c94646ca@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff855fc25724_599114c9464564";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff855fc25724_599114c9464564\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=30">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff855fc25724_599114c9464564\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/2mVZfsITg6xWNhv712KvFYC0gWs4p5OS/click?signature=0f310163db020194ce1823085fc43cdbf342135e&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D30%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/2mVZfsITg6xWNhv712KvFYC0gWs4p5OS/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/2mVZfsITg6xWNhv712KvFYC0gWs4p5OS/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/2mVZfsITg6xWNhv712KvFYC0gWs4p5OS/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff855fc25724_599114c9464564--\r\n	\N	VerificationMailer#user_documents_email	\N	2021-01-08 12:54:21.363675	Additional Documents Needed For DEV(local) Account	ghgh@ghgh.com	2mVZfsITg6xWNhv712KvFYC0gWs4p5OS	30	User	user_documents_email	\N	email	verification_mailer	\N
32	\N	Date: Sat, 09 Jan 2021 18:28:20 +0500\r\nFrom: DEV Community <yo@dev.to> (local)\r\nReply-To: DEV Community <yo@dev.to> (local)\r\nTo: muj@test.com\r\nMessage-ID: <5ff9af74883dd_1bc414c949498@Macbooks-MBP.mail>\r\nSubject: Confirmation instructions\r\nMime-Version: 1.0\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html><body>\r\n<p>Welcome muj@test.com!</p>\r\n<br>\r\n<p>Hi there,</p>\r\n<br>\r\n<p>Yotta here from UnitedBits. Noticed that you just joined UnitedBits. How things work?</p>\r\n<br>\r\n<p>Verify your email account to establish a communication channel and access your account</p>\r\n<p>Setup your online business using the Music-Business launcher.</p>\r\n<p>Verify your banking account details to receive commissions and payments</p>\r\n<p>Once you are ready tos start accepting commissions notify us to start your business in unitedbits.</p>\r\n<br><br>\r\n<p>Here are two resources you might find useful as you navigate the UnitedBits:</p>\r\n<p>Business launcher features, to help you explore the potential of your platform.</p>\r\n<p>Direct messaging feature, to communicate with us your needs. Hop on to start building your business and community.</p>\r\n<p>Hope that helps!</p>\r\n<br>\r\n<h3>Confirm Email to proceed</h3>\r\n<p>You can confirm your account email through the link below:</p>\r\n\r\n<p><a href="http://localhost:3000/ahoy/messages/8bBiBC8nbWSMGMfIjsvkXHItH7BHeFPp/click?signature=3900e702e7ddc59ca8ae169e08bf2aebcee3de7c&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fconfirmation%3Fconfirmation_token%3D1GSUaDBs8PgcSf62E7XF%26utm_source%3Ddevise_mailer%26utm_medium%3Demail%26utm_campaign%3Dconfirmation_instructions">Confirm my account</a></p>\r\n<br><br><br>\r\n<p>Yotta</p>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/8bBiBC8nbWSMGMfIjsvkXHItH7BHeFPp/open.gif" width="1" height="1">\r\n</body></html>\r\n	\N	DeviseMailer#confirmation_instructions	\N	2021-01-09 13:28:21.808066	Confirmation instructions	muj@test.com	8bBiBC8nbWSMGMfIjsvkXHItH7BHeFPp	31	User	confirmation_instructions	\N	email	devise_mailer	\N
33	2021-01-09 13:36:23.296274	Date: Sat, 09 Jan 2021 18:28:22 +0500\r\nFrom: DEV <yo@dev.to> (local)\r\nTo: muj@test.com\r\nMessage-ID: <5ff9af7613e90_1bc414c9495123@Macbooks-MBP.mail>\r\nSubject: Additional Documents Needed For DEV(local) Account\r\nMime-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary="--==_mimepart_5ff9af76115b4_1bc414c949507b";\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\n----==_mimepart_5ff9af76115b4_1bc414c949507b\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n\r\nHey MuzzamilMujahid!\r\n\r\nWe're sending this email to inform you that your first step verification has been approved.\r\n\r\nPlease fill the form below and provide us with the required details to get full access of your account\r\n\r\nForm link:  <strong><a href="http://localhost:3000/user_documents/new?user_id=31">click here</a></strong> to fill the information.\r\n\r\n\r\n----==_mimepart_5ff9af76115b4_1bc414c949507b\r\nContent-Type: text/html;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\r\n<html>\r\n<body style='font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;'>\r\n<table style="width:100%;max-width:700px;margin:auto;font-size:18px">\r\n  <tr>\r\n    <td style="padding:4%;">\r\n      <p>\r\n  Hey MuzzamilMujahid!\r\n</p>\r\n\r\n<p>\r\n  We're sending this email to inform you that you need to verify your account information and confirm banking details to receive payments for your services.\r\n</p>\r\n\r\n<p>\r\n  Please fill the form below and provide us with the required details to get full access of your account\r\n</p>\r\n\r\n<p>\r\n  Form link:  <strong><a href="http://localhost:3000/ahoy/messages/i5kMpZlrWCHahQkvAaI9f1lS85iREE5F/click?signature=a8b823f7d9d1510911bcc31175d9e97be5f12e85&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fuser_documents%2Fnew%3Fuser_id%3D31%26utm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">click here</a></strong> to fill the information.\r\n</p>\r\n\r\n<p>\r\n  <strong>Reminder: </strong> You used to authenticate your account, so use any of those to sign in if prompted.\r\n</p>\r\n\r\n<p>\r\n  Don't want to get emails like this? Adjust your email settings <a href="http://localhost:3000/ahoy/messages/i5kMpZlrWCHahQkvAaI9f1lS85iREE5F/click?signature=d8ff86c78208687677178439642b4d6d87f38fdf&amp;url=http%3A%2F%2Funitedbits.io%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email"> here</a>\r\n</p>\r\n\r\n    </td>\r\n  </tr>\r\n    <tr>\r\n      <td style="padding:3% 12% 2% 4%;font-size:18px;line-height:22px;color:#7d7d7d">\r\n        Reminder: You used <b></b> to authenticate your account, so use any of those to sign in if prompted.\r\n\r\n        <br><br>\r\n        <div style="font-size:0.78em">\r\n            Don't want to get emails like this? Adjust your email settings at\r\n            <a href="http://localhost:3000/ahoy/messages/i5kMpZlrWCHahQkvAaI9f1lS85iREE5F/click?signature=0ccf91c23dff09303d54bd87bab379312c06ed92&amp;url=http%3A%2F%2Flocalhost%3A3000%2Fsettings%2Fnotifications%3Futm_source%3Dverification_mailer%26utm_medium%3Demail%26utm_campaign%3Duser_documents_email">http://localhost:3000/settings/notifications</a>\r\n        </div>\r\n      </td>\r\n    </tr>\r\n</table>\r\n<img alt="" src="http://localhost:3000/ahoy/messages/i5kMpZlrWCHahQkvAaI9f1lS85iREE5F/open.gif" width="1" height="1">\r\n</body>\r\n</html>\r\n\r\n----==_mimepart_5ff9af76115b4_1bc414c949507b--\r\n	\N	VerificationMailer#user_documents_email	2021-01-09 13:36:23.296274	2021-01-09 13:28:23.288233	Additional Documents Needed For DEV(local) Account	muj@test.com	i5kMpZlrWCHahQkvAaI9f1lS85iREE5F	31	User	user_documents_email	\N	email	verification_mailer	\N
\.


--
-- Data for Name: ahoy_visits; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.ahoy_visits (id, started_at, user_id, visit_token, visitor_token) FROM stdin;
1	2020-11-26 14:01:17.861999	12	e885bc0c-94ff-5a0a-ad5d-4454e2635340	c1293146-3239-531d-a6a1-e42794c3c856
\.


--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.announcements (id, banner_style, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: api_secrets; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.api_secrets (id, created_at, description, secret, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2020-11-17 14:29:30.617831	2020-11-17 14:29:30.617831
schema_sha1	3191222b51718200071c3edcf86e4d3380f64f8f	2020-11-17 14:29:30.623991	2020-11-17 14:29:30.623991
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.articles (id, any_comments_hidden, approved, archived, body_html, body_markdown, boost_states, cached_organization, cached_tag_list, cached_user, cached_user_name, cached_user_username, canonical_url, co_author_ids, collection_id, comment_score, comment_template, comments_count, created_at, crossposted_at, description, edited_at, email_digest_eligible, experience_level_rating, experience_level_rating_distribution, facebook_last_buffered, featured, featured_number, feed_source_url, hotness_score, language, last_buffered, last_comment_at, last_experience_level_rating_at, main_image, main_image_background_hex_color, nth_published_by_author, organic_page_views_count, organic_page_views_past_month_count, organic_page_views_past_week_count, organization_id, originally_published_at, page_views_count, password, path, positive_reactions_count, previous_positive_reactions_count, previous_public_reactions_count, processed_html, public_reactions_count, published, published_at, published_from_feed, rating_votes_count, reactions_count, reading_time, receive_notifications, score, search_optimized_description_replacement, search_optimized_title_preamble, show_comments, slug, social_image, spaminess_rating, title, updated_at, user_id, user_subscriptions_count, video, video_closed_caption_track_url, video_code, video_duration_in_seconds, video_source_url, video_state, video_thumbnail_url) FROM stdin;
31	f	f	f	\N	dguidfhigdf	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N		--- !ruby/struct:Articles::CachedEntity\nname: MuzzamilMujahid\nusername: muzzamil219\nslug: muzzamil219\nprofile_image_90: https://res.cloudinary.com/Optional/image/fetch/s--SsxbauSi--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://thepracticaldev.s3.amazonaws.com/i/99mvlsfu5tfj9m7ku25d.png\nprofile_image_url: \n	MuzzamilMujahid	muzzamil219	\N	{}	\N	0	\N	0	2021-01-03 16:53:52.607794	\N	dguidfhigdf	\N	t	5	5	\N	f	1609692832	\N	0	\N	\N	2021-01-03 16:53:52.60294	\N	\N	#dddddd	2	0	0	0	\N	\N	1	175e157f6c86b1ff2ea74d5a7cedeefffe0e153c3c58f4ee0d4a83e0aa484b94ccdb5248cb85541bcab9799e184421aeb82d94c7deec97e9f6c6f246	/muzzamil219/udfghdifughiudf-17p7	0	0	0	<p>dguidfhigdf</p>\n\n	0	t	2021-01-04 11:45:10.268464	f	0	0	1	t	0	\N	\N	t	udfghdifughiudf-17p7	\N	0	udfghdifughiudf	2021-01-03 16:53:52.607794	24	0	\N	\N	\N	0	\N	\N	\N
2	f	f	f	\N	---\ntitle:  The Parliament of Man Rem quis\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/3.png\ntags: java, discuss, career\n---\n\nGastropub bespoke sriracha fingerstache echo plaid. Tilde williamsburg everyday normcore thundercats cronut stumptown wolf.\n# Aut\nDolor illo dignissimos. Et blanditiis ex. Et quod earum.\nConsequatur dolore et. ~Ab~ animi adipisci. Veritatis assumenda voluptas.\nStreet craft beer banjo listicle sriracha 3 wolf moon. Butcher intelligentsia portland. Biodiesel paleo hoodie cray.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	java, discuss, career	--- !ruby/struct:Articles::CachedEntity\nname: Laveta Shanahan\nusername: shanahan_laveta\nslug: shanahan_laveta\nprofile_image_90: "/uploads/user/profile_image/4/8a0bc7f7-5387-45cb-8030-1a0020924ac9.png"\nprofile_image_url: "/uploads/user/profile_image/4/8a0bc7f7-5387-45cb-8030-1a0020924ac9.png"\n	Laveta Shanahan	shanahan_laveta	\N	{}	\N	0	\N	0	2020-11-17 14:29:39.644019	\N	Gastropub bespoke sriracha fingerstache echo plaid. Tilde williamsburg everyday normcore thundercats...	\N	t	5	5	\N	t	1605623379	\N	0	\N	\N	2020-11-17 14:29:39.633726	\N	https://pigment.github.io/fake-logos/logos/medium/color/3.png	#dddddd	1	0	0	0	\N	\N	0	a716d4ffa4f428512e8930cf6e85837515c107323317b89864a8a27dad490ec8d3baf78e3433d46745653cf7a84d263f66898868b5a73a7c2e23bf77	/shanahan_laveta/the-parliament-of-man-rem-quis-559p	0	0	0	<p>Gastropub bespoke sriracha fingerstache echo plaid. Tilde williamsburg everyday normcore thundercats cronut stumptown wolf.</p>\n\n<h1>\n  <a name="aut" href="#aut" class="anchor">\n  </a>\n  Aut\n</h1>\n\n<p>Dolor illo dignissimos. Et blanditiis ex. Et quod earum.<br>\nConsequatur dolore et. ~Ab~ animi adipisci. Veritatis assumenda voluptas.<br>\nStreet craft beer banjo listicle sriracha 3 wolf moon. Butcher intelligentsia portland. Biodiesel paleo hoodie cray.</p>\n\n	0	t	2020-11-17 14:29:39.633726	f	0	0	1	t	0	\N	\N	t	the-parliament-of-man-rem-quis-559p	\N	0	 The Parliament of Man Rem quis	2020-11-17 14:29:53.811671	4	0	\N	\N	\N	0	\N	\N	\N
4	f	f	f	\N	---\ntitle:  Death Be Not Proud Quia veritatis\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/1.png\ntags: discuss, computerscience, webdev, security\n---\n\nHella put a bird on it sustainable fingerstache. You probably haven't heard of them banjo swag thundercats. Viral photo booth normcore. Lo-fi cold-pressed fixie.\n`Aut.`\nAesthetic bushwick hammock dreamcatcher meggings next level ethical retro. Pork belly yr kale chips umami pickled bushwick phlogiston single-origin coffee.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, computerscience, webdev, security	--- !ruby/struct:Articles::CachedEntity\nname: Dee McGlynn MD\nusername: md_mcglynn_dee\nslug: md_mcglynn_dee\nprofile_image_90: "/uploads/user/profile_image/3/9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png"\nprofile_image_url: "/uploads/user/profile_image/3/9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png"\n	Dee McGlynn MD	md_mcglynn_dee	\N	{}	\N	0	\N	1	2020-11-17 14:29:39.796964	\N	Hella put a bird on it sustainable fingerstache. You probably haven't heard of them banjo swag thunde...	\N	t	5	5	\N	t	1605623379	\N	0	en	\N	2020-11-25 14:04:10.723103	\N	https://pigment.github.io/fake-logos/logos/medium/color/1.png	#dddddd	1	0	0	0	\N	\N	0	a9a3e7c15cfcfcc3dfb75b2ed9651a880d993ad21bfddafd05aac0aeb1013cb297c9087e99067692cdcaf20eadb4f76d7874eafee0c0b7b6407f86a8	/md_mcglynn_dee/death-be-not-proud-quia-veritatis-30i1	0	0	0	<p>Hella put a bird on it sustainable fingerstache. You probably haven't heard of them banjo swag thundercats. Viral photo booth normcore. Lo-fi cold-pressed fixie.<br>\n<code>Aut.</code><br>\nAesthetic bushwick hammock dreamcatcher meggings next level ethical retro. Pork belly yr kale chips umami pickled bushwick phlogiston single-origin coffee.</p>\n\n	0	t	2020-11-17 14:29:39.787691	f	0	1	1	t	0	\N	\N	t	death-be-not-proud-quia-veritatis-30i1	\N	0	 Death Be Not Proud Quia veritatis	2020-11-25 14:04:10.723103	3	0	\N	\N	\N	0	\N	\N	\N
32	f	f	f	\N	sjhskjs	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N		--- !ruby/struct:Articles::CachedEntity\nname: Muzzamil123\nusername: muzzamil123\nslug: muzzamil123\nprofile_image_90: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\nprofile_image_url: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\n	Muzzamil123	muzzamil123	\N	{}	\N	0	\N	0	2021-01-04 11:45:26.237301	\N	sjhskjs	\N	t	5	5	\N	f	1609760726	\N	0	\N	\N	2021-01-04 11:45:26.231621	\N	https://pigment.github.io/fake-logos/logos/medium/color/1.png	#dddddd	4	0	0	0	\N	\N	0	80c9c89b3c2cf5f4613305ccccb1f5d2e0b20200a35e0199f2da484fe6d72456ce20fce3357438f0ced19459f78c5c314fe2b9522055eb0863354ca8	/muzzamil123/testtttt-38mh	0	0	0	<p>sjhskjs</p>\n\n	0	t	2021-01-04 11:45:26.231621	f	0	0	1	t	0	\N	\N	t	testtttt-38mh	\N	0	testtttt	2021-01-04 11:45:26.237301	12	0	\N	\N	\N	0	\N	\N	\N
8	f	f	f	\N	---\ntitle:  Brandy of the Damned Qui magnam\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/1.png\ntags: python, javascript, career\n---\n\nShabby chic before they sold out muggle magic thundercats fingerstache gluten-free. Venmo sustainable art party umami fanny pack flexitarian. Actually literally post-ironic blue bottle cred tumblr.\n##### Sunt\nBlog williamsburg church-key cronut blue bottle park synth tote bag. Lumbersexual vhs heirloom next level dreamcatcher chambray.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	python, javascript, career	--- !ruby/struct:Articles::CachedEntity\nname: Jacob Lehner\nusername: lehner_jacob\nslug: lehner_jacob\nprofile_image_90: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\nprofile_image_url: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\n	Jacob Lehner	lehner_jacob	\N	{}	\N	0	\N	2	2020-11-17 14:29:40.13242	\N	Shabby chic before they sold out muggle magic thundercats fingerstache gluten-free. Venmo sustainable...	\N	t	5	5	\N	t	1605623380	\N	0	en	\N	2020-11-25 14:07:17.51621	\N	https://pigment.github.io/fake-logos/logos/medium/color/1.png	#dddddd	1	0	0	0	\N	\N	0	c8961fd7d806d8087701e10d7bbae1b8c818fbfcdb6a1abac4123bb434d0a00db72270c032a22e3f04e03605dbf10e6c7b0a82b72f3ffced4910bbc8	/lehner_jacob/brandy-of-the-damned-qui-magnam-29c0	0	0	0	<p>Shabby chic before they sold out muggle magic thundercats fingerstache gluten-free. Venmo sustainable art party umami fanny pack flexitarian. Actually literally post-ironic blue bottle cred tumblr.</p>\n\n<h5>\n  <a name="sunt" href="#sunt" class="anchor">\n  </a>\n  Sunt\n</h5>\n\n<p>Blog williamsburg church-key cronut blue bottle park synth tote bag. Lumbersexual vhs heirloom next level dreamcatcher chambray.</p>\n\n	0	t	2020-11-17 14:29:40.122768	f	0	0	1	t	0	\N	\N	t	brandy-of-the-damned-qui-magnam-29c0	\N	0	 Brandy of the Damned Qui magnam	2020-11-25 14:07:17.51621	6	0	\N	\N	\N	0	\N	\N	\N
7	f	f	f	\N	---\ntitle:  The Last Temptation Quae dolor\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/10.png\ntags: discuss, python, webdev, beginners\n---\n\nUmami organic cleanse literally. Marfa squid gastropub small batch meggings godard austin poutine.\n0. Autem. \n1. Nisi. \n2. Qui. \n3. Autem. \n4. Libero. \n5. Unde. \n6. Aut. \n\nDirect trade xoxo wolf marfa. Chia intelligentsia pop-up. Freegan diy swag neutra franzen. Portland gastropub tacos.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, python, webdev, beginners	--- !ruby/struct:Articles::CachedEntity\nname: Tora Lesch\nusername: tora_lesch\nslug: tora_lesch\nprofile_image_90: "/uploads/user/profile_image/2/2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png"\nprofile_image_url: "/uploads/user/profile_image/2/2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png"\n	Tora Lesch	tora_lesch	\N	{}	\N	0	\N	2	2020-11-17 14:29:40.044253	\N	Umami organic cleanse literally. Marfa squid gastropub small batch meggings godard austin poutine....	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-25 14:07:13.941464	\N	https://pigment.github.io/fake-logos/logos/medium/color/10.png	#dddddd	1	0	0	0	\N	\N	0	a1c4d17587a06ea1a46460f5d05b5564e67a9f471887ebe753d0a5e28abc44bfbffedf8b45ff50a1f2d1c932ebb84c3b3f226a686440e4138116cd28	/tora_lesch/the-last-temptation-quae-dolor-27oo	0	0	0	<p>Umami organic cleanse literally. Marfa squid gastropub small batch meggings godard austin poutine.</p>\n\n<ol>\n<li>Autem. </li>\n<li>Nisi. </li>\n<li>Qui. </li>\n<li>Autem. </li>\n<li>Libero. </li>\n<li>Unde. </li>\n<li>Aut. </li>\n</ol>\n\n<p>Direct trade xoxo wolf marfa. Chia intelligentsia pop-up. Freegan diy swag neutra franzen. Portland gastropub tacos.</p>\n\n	0	t	2020-11-17 14:29:40.033829	f	0	0	1	t	0	\N	\N	t	the-last-temptation-quae-dolor-27oo	\N	0	 The Last Temptation Quae dolor	2020-11-25 14:07:13.941464	2	0	\N	\N	\N	0	\N	\N	\N
11	f	f	f	\N	---\ntitle:  Carrion Comfort Labore ratione\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/9.png\ntags: productivity, discuss, go\n---\n\nActually blue bottle thundercats seitan deep v mumblecore pitchfork keffiyeh. Tumblr sriracha authentic microdosing photo booth. Beard whatever meditation yolo authentic deep v kitsch.\n`Exercitationem.`\nDirect trade five dollar toast post-ironic williamsburg stumptown. Small batch ramps hoodie selfies farm-to-table gastropub. Quinoa bitters tote bag listicle poutine kogi. Sustainable austin celiac pour-over aesthetic gluten-free pabst.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	productivity, discuss, go	--- !ruby/struct:Articles::CachedEntity\nname: Esteban Marvin\nusername: estebanmarvin\nslug: estebanmarvin\nprofile_image_90: "/uploads/user/profile_image/9/75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png"\nprofile_image_url: "/uploads/user/profile_image/9/75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png"\n	Esteban Marvin	estebanmarvin	\N	{}	\N	0	\N	1	2020-11-17 14:29:40.375716	\N	Actually blue bottle thundercats seitan deep v mumblecore pitchfork keffiyeh. Tumblr sriracha authent...	\N	t	5	5	\N	t	1605623380	\N	0	en	\N	2020-11-25 14:07:13.951609	\N	https://pigment.github.io/fake-logos/logos/medium/color/9.png	#dddddd	2	0	0	0	\N	\N	0	7f0e5bb5793cd81caef65c6fb18e84075a94f0f04b45bb40a521121e28d0e1e21bb692cf0ff9ab78d3adc3c9e8989255e6aaea0211067e113694308f	/estebanmarvin/carrion-comfort-labore-ratione-d6b	0	0	0	<p>Actually blue bottle thundercats seitan deep v mumblecore pitchfork keffiyeh. Tumblr sriracha authentic microdosing photo booth. Beard whatever meditation yolo authentic deep v kitsch.<br>\n<code>Exercitationem.</code><br>\nDirect trade five dollar toast post-ironic williamsburg stumptown. Small batch ramps hoodie selfies farm-to-table gastropub. Quinoa bitters tote bag listicle poutine kogi. Sustainable austin celiac pour-over aesthetic gluten-free pabst.</p>\n\n	0	t	2020-11-17 14:29:40.366824	f	0	0	1	t	0	\N	\N	t	carrion-comfort-labore-ratione-d6b	\N	0	 Carrion Comfort Labore ratione	2020-11-25 14:07:13.951609	9	0	\N	\N	\N	0	\N	\N	\N
13	f	f	f	\N	---\ntitle:  A Scanner Darkly Dolorem similique\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/7.png\ntags: discuss, discuss, linux, python\n---\n\nSlow-carb stumptown migas. Trust fund craft beer swag tote bag leggings ethical ennui chambray. Normcore leggings neutra offal.\n* Autem. \n* Quasi. \n* Laborum. \n* Dolorem. \n* Voluptas. \n* Dolorem. \n* Explicabo. \n* Distinctio. \n* Rerum. \n\nSriracha 8-bit green juice knausgaard loko. Small batch fanny pack biodiesel tofu 90's stumptown organic.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, linux, python	--- !ruby/struct:Articles::CachedEntity\nname: Dee McGlynn MD\nusername: md_mcglynn_dee\nslug: md_mcglynn_dee\nprofile_image_90: "/uploads/user/profile_image/3/9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png"\nprofile_image_url: "/uploads/user/profile_image/3/9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png"\n	Dee McGlynn MD	md_mcglynn_dee	\N	{}	\N	0	\N	0	2020-11-17 14:29:40.52719	\N	Slow-carb stumptown migas. Trust fund craft beer swag tote bag leggings ethical ennui chambray. Normc...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-17 14:29:40.516795	\N	https://pigment.github.io/fake-logos/logos/medium/color/7.png	#dddddd	2	0	0	0	\N	\N	0	00871f7e830149c4e9a7a2650712418eba59381a536e1a16c27ac7414b8492cff511a22c5f53643bacfa4c4426866df75ffe8f8cc139267fc97c5718	/md_mcglynn_dee/a-scanner-darkly-dolorem-similique-1io1	0	0	0	<p>Slow-carb stumptown migas. Trust fund craft beer swag tote bag leggings ethical ennui chambray. Normcore leggings neutra offal.</p>\n\n<ul>\n<li>Autem. </li>\n<li>Quasi. </li>\n<li>Laborum. </li>\n<li>Dolorem. </li>\n<li>Voluptas. </li>\n<li>Dolorem. </li>\n<li>Explicabo. </li>\n<li>Distinctio. </li>\n<li>Rerum. </li>\n</ul>\n\n<p>Sriracha 8-bit green juice knausgaard loko. Small batch fanny pack biodiesel tofu 90's stumptown organic.</p>\n\n	0	t	2020-11-17 14:29:40.516795	f	0	0	1	t	0	\N	\N	t	a-scanner-darkly-dolorem-similique-1io1	\N	0	 A Scanner Darkly Dolorem similique	2020-11-17 14:29:54.381113	3	0	\N	\N	\N	0	\N	\N	\N
25	f	f	f	\N	---\ntitle:  The Heart Is a Lonely Hunter Tempora quia\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/9.png\ntags: discuss, javascript, productivity, computerscience\n---\n\nYuccie dreamcatcher semiotics tacos aesthetic tofu lo-fi farm-to-table. Intelligentsia freegan stumptown chia kickstarter hoodie roof. Listicle kombucha bicycle rights sriracha you probably haven't heard of them brooklyn. Waistcoat wes anderson tacos stumptown brooklyn direct trade muggle magic shabby chic.\n`Quo.`\nSelvage tofu bitters roof locavore. Kogi echo truffaut deep v letterpress flannel. Tofu street flannel literally chicharrones bicycle rights. Aesthetic wes anderson keytar polaroid farm-to-table kitsch lomo hammock.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, javascript, productivity, computerscience	--- !ruby/struct:Articles::CachedEntity\nname: Tressie Cremin\nusername: cremintressie\nslug: cremintressie\nprofile_image_90: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\nprofile_image_url: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\n	Tressie Cremin	cremintressie	\N	{}	\N	0	\N	0	2020-11-17 14:29:41.469561	\N	Yuccie dreamcatcher semiotics tacos aesthetic tofu lo-fi farm-to-table. Intelligentsia freegan stumpt...	\N	t	5	5	\N	t	1605623381	\N	0	en	\N	2020-11-17 14:29:41.460339	\N	https://pigment.github.io/fake-logos/logos/medium/color/9.png	#dddddd	4	0	0	0	\N	\N	2	4dcbcad3a3dbbbbd782d49a78113b8d9fd29d8317c67ee20f69d5d3e978a720a0046b82f1aa1235031b2d45fa532269c4591fe2a46627185da977bca	/cremintressie/the-heart-is-a-lonely-hunter-tempora-quia-1nmb	0	0	0	<p>Yuccie dreamcatcher semiotics tacos aesthetic tofu lo-fi farm-to-table. Intelligentsia freegan stumptown chia kickstarter hoodie roof. Listicle kombucha bicycle rights sriracha you probably haven't heard of them brooklyn. Waistcoat wes anderson tacos stumptown brooklyn direct trade muggle magic shabby chic.<br>\n<code>Quo.</code><br>\nSelvage tofu bitters roof locavore. Kogi echo truffaut deep v letterpress flannel. Tofu street flannel literally chicharrones bicycle rights. Aesthetic wes anderson keytar polaroid farm-to-table kitsch lomo hammock.</p>\n\n	0	t	2020-11-17 14:29:41.460339	f	0	0	1	t	0	\N	\N	t	the-heart-is-a-lonely-hunter-tempora-quia-1nmb	\N	0	 The Heart Is a Lonely Hunter Tempora quia	2020-11-17 14:29:54.968739	10	0	\N	\N	\N	0	\N	\N	\N
24	f	f	f	\N	---\ntitle:  Taming a Sea Horse Tempora odit\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/7.png\ntags: discuss, career, computerscience\n---\n\nWolf plaid church-key deep v cold-pressed typewriter chillwave pbr&b. Narwhal meh viral freegan trust fund banjo vice meggings.\n# Adipisci\nSed asperiores eum. Enim repudiandae culpa. Porro et eum.\n`Voluptates.`\nEveryday green juice raw denim photo booth. Chartreuse bushwick tousled crucifix iphone. Helvetica master brunch etsy tousled street 3 wolf moon salvia. Street muggle magic humblebrag selfies synth seitan ennui.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, career, computerscience	--- !ruby/struct:Articles::CachedEntity\nname: Laveta Shanahan\nusername: shanahan_laveta\nslug: shanahan_laveta\nprofile_image_90: "/uploads/user/profile_image/4/8a0bc7f7-5387-45cb-8030-1a0020924ac9.png"\nprofile_image_url: "/uploads/user/profile_image/4/8a0bc7f7-5387-45cb-8030-1a0020924ac9.png"\n	Laveta Shanahan	shanahan_laveta	\N	{}	\N	0	\N	1	2020-11-17 14:29:41.390727	\N	Wolf plaid church-key deep v cold-pressed typewriter chillwave pbr&amp;b. Narwhal meh viral freegan t...	\N	t	5	5	\N	t	1605623381	\N	0	en	\N	2020-11-25 14:06:24.539124	\N	https://pigment.github.io/fake-logos/logos/medium/color/7.png	#dddddd	3	0	0	0	\N	\N	0	608879bb46e1cb3eb9e1456fbf77758ead9dca826c9855e2a278ac24d5264fac83e810323f5a7913470b64f3de401be1c9e2b3679d426b1e10deeb29	/shanahan_laveta/taming-a-sea-horse-tempora-odit-46dd	0	0	0	<p>Wolf plaid church-key deep v cold-pressed typewriter chillwave pbr&amp;b. Narwhal meh viral freegan trust fund banjo vice meggings.</p>\n\n<h1>\n  <a name="adipisci" href="#adipisci" class="anchor">\n  </a>\n  Adipisci\n</h1>\n\n<p>Sed asperiores eum. Enim repudiandae culpa. Porro et eum.<br>\n<code>Voluptates.</code><br>\nEveryday green juice raw denim photo booth. Chartreuse bushwick tousled crucifix iphone. Helvetica master brunch etsy tousled street 3 wolf moon salvia. Street muggle magic humblebrag selfies synth seitan ennui.</p>\n\n	0	t	2020-11-17 14:29:41.38107	f	0	0	1	t	0	\N	\N	t	taming-a-sea-horse-tempora-odit-46dd	\N	0	 Taming a Sea Horse Tempora odit	2020-11-25 14:06:24.539124	4	0	\N	\N	\N	0	\N	\N	\N
16	f	f	f	\N	---\ntitle:  I Sing the Body Electric Maxime eum\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/6.png\ntags: discuss, python, java, computerscience\n---\n\nWilliamsburg kale chips sriracha. Cliche lomo fingerstache park chillwave offal ramps chicharrones. Chillwave forage scenester 8-bit loko try-hard before they sold out freegan. Bushwick fixie ethical.\n#### Mollitia\nBeard readymade pop-up. Sustainable keytar farm-to-table. Helvetica poutine ramps paleo. Artisan carry mlkshk celiac twee.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, python, java, computerscience	--- !ruby/struct:Articles::CachedEntity\nname: Tressie Cremin\nusername: cremintressie\nslug: cremintressie\nprofile_image_90: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\nprofile_image_url: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\n	Tressie Cremin	cremintressie	\N	{}	\N	0	\N	2	2020-11-17 14:29:40.758128	\N	Williamsburg kale chips sriracha. Cliche lomo fingerstache park chillwave offal ramps chicharrones. C...	\N	t	5	5	\N	t	1605623380	\N	0	en	\N	2020-11-25 14:05:24.675292	\N	https://pigment.github.io/fake-logos/logos/medium/color/6.png	#dddddd	2	0	0	0	\N	\N	0	df507a582aead697b2d653a9df7a810b10a83713e2d78aeef0075457b198f3f127bc886120fe927217a954a881ad66556f9701619099b2ea53533419	/cremintressie/i-sing-the-body-electric-maxime-eum-4285	0	0	0	<p>Williamsburg kale chips sriracha. Cliche lomo fingerstache park chillwave offal ramps chicharrones. Chillwave forage scenester 8-bit loko try-hard before they sold out freegan. Bushwick fixie ethical.</p>\n\n<h4>\n  <a name="mollitia" href="#mollitia" class="anchor">\n  </a>\n  Mollitia\n</h4>\n\n<p>Beard readymade pop-up. Sustainable keytar farm-to-table. Helvetica poutine ramps paleo. Artisan carry mlkshk celiac twee.</p>\n\n	0	t	2020-11-17 14:29:40.747742	f	0	1	1	t	0	\N	\N	t	i-sing-the-body-electric-maxime-eum-4285	\N	0	 I Sing the Body Electric Maxime eum	2020-11-25 14:05:24.675292	10	0	\N	\N	\N	0	\N	\N	\N
19	f	f	f	\N	---\ntitle:  That Good Night Ea labore\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/2.png\ntags: discuss, computerscience, productivity, webdev\n---\n\nIntelligentsia asymmetrical sustainable listicle. Tilde mumblecore thundercats umami selvage. Kombucha sriracha sustainable beard +1 intelligentsia five dollar toast direct trade.\nConsequatur reprehenderit *ut.* Eos omnis quia. Animi rerum eum.\nKeffiyeh portland drinking sartorial ethical cray sustainable. Schlitz xoxo next level irony polaroid cronut butcher. Mixtape cold-pressed drinking.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, computerscience, productivity, webdev	--- !ruby/struct:Articles::CachedEntity\nname: Pablo Wiegand\nusername: pablowiegand\nslug: pablowiegand\nprofile_image_90: "/uploads/user/profile_image/8/6f0f13f0-2744-45e1-b8bf-ee4621a0b9ec.png"\nprofile_image_url: "/uploads/user/profile_image/8/6f0f13f0-2744-45e1-b8bf-ee4621a0b9ec.png"\n	Pablo Wiegand	pablowiegand	\N	{}	\N	0	\N	0	2020-11-17 14:29:40.994272	\N	Intelligentsia asymmetrical sustainable listicle. Tilde mumblecore thundercats umami selvage. Kombuch...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-17 14:29:40.984999	\N	https://pigment.github.io/fake-logos/logos/medium/color/2.png	#dddddd	1	0	0	0	\N	\N	0	6333e148743e5c19736a37433c032f0a27a08563849d36fc83cb8d5136eeefce33aff138f6b0fd92b816988bce9c86b2267ab147347920419d2bf854	/pablowiegand/that-good-night-ea-labore-2kcp	0	0	0	<p>Intelligentsia asymmetrical sustainable listicle. Tilde mumblecore thundercats umami selvage. Kombucha sriracha sustainable beard +1 intelligentsia five dollar toast direct trade.<br>\nConsequatur reprehenderit <em>ut.</em> Eos omnis quia. Animi rerum eum.<br>\nKeffiyeh portland drinking sartorial ethical cray sustainable. Schlitz xoxo next level irony polaroid cronut butcher. Mixtape cold-pressed drinking.</p>\n\n	0	t	2020-11-17 14:29:40.984999	f	0	0	1	t	0	\N	\N	t	that-good-night-ea-labore-2kcp	\N	0	 That Good Night Ea labore	2020-11-17 14:29:54.673987	8	0	\N	\N	\N	0	\N	\N	\N
20	f	f	f	\N	---\ntitle:  Sleep the Brave A enim\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/8.png\ntags: productivity, go, computerscience\n---\n\nTousled literally twee umami. Diy quinoa flannel chicharrones mustache authentic kombucha small batch. Humblebrag kinfolk tote bag park xoxo.\n##### Dolores\nPhoto booth tousled muggle magic everyday. Small batch gastropub humblebrag meh beard. Pabst chillwave bespoke meh tumblr keffiyeh normcore. +1 small batch iphone.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	productivity, go, computerscience	--- !ruby/struct:Articles::CachedEntity\nname: Tora Lesch\nusername: tora_lesch\nslug: tora_lesch\nprofile_image_90: "/uploads/user/profile_image/2/2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png"\nprofile_image_url: "/uploads/user/profile_image/2/2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png"\n	Tora Lesch	tora_lesch	\N	{}	\N	0	\N	0	2020-11-17 14:29:41.080169	\N	Tousled literally twee umami. Diy quinoa flannel chicharrones mustache authentic kombucha small batch...	\N	t	5	5	\N	t	1605623381	\N	0	\N	\N	2020-11-17 14:29:41.070381	\N	https://pigment.github.io/fake-logos/logos/medium/color/8.png	#dddddd	2	0	0	0	\N	\N	0	26a9d124f1fe0bd95709b284f41d0b07fa5059ca1af06605201891f55d6004762d8b1d563938987fda81bef652a8fc0abd082446fd5bcb52ad2b2afe	/tora_lesch/sleep-the-brave-a-enim-26h1	0	0	0	<p>Tousled literally twee umami. Diy quinoa flannel chicharrones mustache authentic kombucha small batch. Humblebrag kinfolk tote bag park xoxo.</p>\n\n<h5>\n  <a name="dolores" href="#dolores" class="anchor">\n  </a>\n  Dolores\n</h5>\n\n<p>Photo booth tousled muggle magic everyday. Small batch gastropub humblebrag meh beard. Pabst chillwave bespoke meh tumblr keffiyeh normcore. +1 small batch iphone.</p>\n\n	0	t	2020-11-17 14:29:41.070381	f	0	0	1	t	0	\N	\N	t	sleep-the-brave-a-enim-26h1	\N	0	 Sleep the Brave A enim	2020-11-17 14:29:54.7283	2	0	\N	\N	\N	0	\N	\N	\N
23	f	f	f	\N	---\ntitle:  The Wealth of Nations Ad totam\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/8.png\ntags: go, webdev, computerscience\n---\n\nSynth stumptown distillery pbr&b hashtag hoodie intelligentsia. Brooklyn narwhal disrupt tattooed skateboard celiac cronut. Trust fund beard ugh.\n* Facilis. \n* Fugit. \n* Et. \n* Repellendus. \n* Ut. \n* Quia. \n\nNormcore sriracha ennui godard lo-fi. Migas whatever drinking bitters kinfolk.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	go, webdev, computerscience	--- !ruby/struct:Articles::CachedEntity\nname: Jeromy Schimmel\nusername: schimmeljeromy\nslug: schimmeljeromy\nprofile_image_90: "/uploads/user/profile_image/7/fc3554c2-3141-4ec7-a899-d39c289a0d06.png"\nprofile_image_url: "/uploads/user/profile_image/7/fc3554c2-3141-4ec7-a899-d39c289a0d06.png"\n	Jeromy Schimmel	schimmeljeromy	\N	{}	\N	0	\N	1	2020-11-17 14:29:41.315128	\N	Synth stumptown distillery pbr&amp;b hashtag hoodie intelligentsia. Brooklyn narwhal disrupt tattooed...	\N	t	5	5	\N	t	1605623381	\N	0	\N	\N	2020-11-25 14:06:34.879675	\N	https://pigment.github.io/fake-logos/logos/medium/color/8.png	#dddddd	2	0	0	0	\N	\N	0	f2b9307ccdaff320d63a3c6bf6ee6b5c18b014ff37d22ca327ed829f71b5b899877d8e0998e7575fa36d779bd5fa9bfc353c2a38b79cdac5c189383e	/schimmeljeromy/the-wealth-of-nations-ad-totam-62j	0	0	0	<p>Synth stumptown distillery pbr&amp;b hashtag hoodie intelligentsia. Brooklyn narwhal disrupt tattooed skateboard celiac cronut. Trust fund beard ugh.</p>\n\n<ul>\n<li>Facilis. </li>\n<li>Fugit. </li>\n<li>Et. </li>\n<li>Repellendus. </li>\n<li>Ut. </li>\n<li>Quia. </li>\n</ul>\n\n<p>Normcore sriracha ennui godard lo-fi. Migas whatever drinking bitters kinfolk.</p>\n\n	0	t	2020-11-17 14:29:41.305032	f	0	0	1	t	0	\N	\N	t	the-wealth-of-nations-ad-totam-62j	\N	0	 The Wealth of Nations Ad totam	2020-11-25 14:06:34.879675	7	0	\N	\N	\N	0	\N	\N	\N
22	f	f	f	\N	---\ntitle:  The Heart Is Deceitful Above All Things Error beatae\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/5.png\ntags: discuss, productivity, computerscience, security\n---\n\nFlannel post-ironic carry hashtag iphone tilde ethical. Pug small batch fanny pack shoreditch bitters xoxo lo-fi.\n###### Optio\nSustainable food truck deep v mixtape quinoa. Vinegar synth gastropub migas ramps trust fund. Master brooklyn humblebrag retro yolo.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, productivity, computerscience, security	--- !ruby/struct:Articles::CachedEntity\nname: Dee McGlynn MD\nusername: md_mcglynn_dee\nslug: md_mcglynn_dee\nprofile_image_90: "/uploads/user/profile_image/3/9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png"\nprofile_image_url: "/uploads/user/profile_image/3/9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png"\n	Dee McGlynn MD	md_mcglynn_dee	\N	{}	\N	0	\N	1	2020-11-17 14:29:41.233579	\N	Flannel post-ironic carry hashtag iphone tilde ethical. Pug small batch fanny pack shoreditch bitters...	\N	t	5	5	\N	t	1605623381	\N	0	en	\N	2020-11-25 14:08:10.712657	\N	https://pigment.github.io/fake-logos/logos/medium/color/5.png	#dddddd	3	0	0	0	\N	\N	0	63d592a4c061ae3e6b554e9381bb2f13953cfab6dab75e5b3ecd2b82d379062a339ee06ce468cad14101c33be6bae70613934319ff1a66663f443f3b	/md_mcglynn_dee/the-heart-is-deceitful-above-all-things-error-beatae-426h	0	0	0	<p>Flannel post-ironic carry hashtag iphone tilde ethical. Pug small batch fanny pack shoreditch bitters xoxo lo-fi.</p>\n\n<h6>\n  <a name="optio" href="#optio" class="anchor">\n  </a>\n  Optio\n</h6>\n\n<p>Sustainable food truck deep v mixtape quinoa. Vinegar synth gastropub migas ramps trust fund. Master brooklyn humblebrag retro yolo.</p>\n\n	0	t	2020-11-17 14:29:41.220731	f	0	0	1	t	0	\N	\N	t	the-heart-is-deceitful-above-all-things-error-beatae-426h	\N	0	 The Heart Is Deceitful Above All Things Error beatae	2020-11-25 14:08:10.712657	3	0	\N	\N	\N	0	\N	\N	\N
9	f	f	f	\N	---\ntitle:  The Curious Incident of the Dog in the Night-Time Mollitia quod\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/2.png\ntags: linux, discuss, beginners\n---\n\nEtsy wes anderson taxidermy polaroid goth. Carry quinoa mustache banh mi letterpress actually etsy hammock.\n0. Suscipit. \n1. Pariatur. \n2. Ut. \n3. Aperiam. \n4. Et. \n5. Enim. \n6. Laboriosam. \n\nDrinking mixtape skateboard. Fashion axe beard church-key letterpress.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	linux, discuss, beginners	--- !ruby/struct:Articles::CachedEntity\nname: Jacob Lehner\nusername: lehner_jacob\nslug: lehner_jacob\nprofile_image_90: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\nprofile_image_url: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\n	Jacob Lehner	lehner_jacob	\N	{}	\N	0	\N	1	2020-11-17 14:29:40.209695	\N	Etsy wes anderson taxidermy polaroid goth. Carry quinoa mustache banh mi letterpress actually etsy ha...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-25 14:06:24.536514	\N	https://pigment.github.io/fake-logos/logos/medium/color/2.png	#dddddd	2	0	0	0	\N	\N	0	182e61130396945fc07fce88cd62fbbaba235b0198243708c1948e1ef067826454f82c3cc9dc3cd8f63ef278ee68659164f4380eb54ae538c7bc38ef	/lehner_jacob/the-curious-incident-of-the-dog-in-the-night-time-mollitia-quod-120b	0	0	0	<p>Etsy wes anderson taxidermy polaroid goth. Carry quinoa mustache banh mi letterpress actually etsy hammock.</p>\n\n<ol>\n<li>Suscipit. </li>\n<li>Pariatur. </li>\n<li>Ut. </li>\n<li>Aperiam. </li>\n<li>Et. </li>\n<li>Enim. </li>\n<li>Laboriosam. </li>\n</ol>\n\n<p>Drinking mixtape skateboard. Fashion axe beard church-key letterpress.</p>\n\n	0	t	2020-11-17 14:29:40.199697	f	0	0	1	t	0	\N	\N	t	the-curious-incident-of-the-dog-in-the-night-time-mollitia-quod-120b	\N	0	 The Curious Incident of the Dog in the Night-Time Mollitia quod	2020-11-25 14:06:24.536514	6	0	\N	\N	\N	0	\N	\N	\N
21	f	f	f	\N	---\ntitle:  The Yellow Meads of Asphodel Atque laudantium\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/1.png\ntags: java, computerscience, discuss\n---\n\nIphone waistcoat aesthetic franzen pinterest church-key chia. Lomo sartorial marfa bushwick. Waistcoat raw denim kombucha kitsch quinoa celiac bushwick. Pour-over kinfolk diy pug messenger bag tote bag.\n`Non.`\nPop-up photo booth chartreuse. Hammock twee quinoa. Godard food truck quinoa post-ironic sartorial. +1 migas craft beer pop-up cred put a bird on it vinyl vhs.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	java, computerscience, discuss	--- !ruby/struct:Articles::CachedEntity\nname: Tora Lesch\nusername: tora_lesch\nslug: tora_lesch\nprofile_image_90: "/uploads/user/profile_image/2/2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png"\nprofile_image_url: "/uploads/user/profile_image/2/2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png"\n	Tora Lesch	tora_lesch	\N	{}	\N	0	\N	4	2020-11-17 14:29:41.153359	\N	Iphone waistcoat aesthetic franzen pinterest church-key chia. Lomo sartorial marfa bushwick. Waistcoa...	\N	t	5	5	\N	t	1605623381	\N	0	\N	\N	2020-11-25 14:07:17.518445	\N	https://pigment.github.io/fake-logos/logos/medium/color/1.png	#dddddd	3	0	0	0	\N	\N	0	3b542f16506af08883180970cd314057719e40670e77766f513b19d790c4a8ea6f8d35c6f4651bcbb3d087f03f58e9047df663dfc7dc5f2003ad8abe	/tora_lesch/the-yellow-meads-of-asphodel-atque-laudantium-5fij	0	0	0	<p>Iphone waistcoat aesthetic franzen pinterest church-key chia. Lomo sartorial marfa bushwick. Waistcoat raw denim kombucha kitsch quinoa celiac bushwick. Pour-over kinfolk diy pug messenger bag tote bag.<br>\n<code>Non.</code><br>\nPop-up photo booth chartreuse. Hammock twee quinoa. Godard food truck quinoa post-ironic sartorial. +1 migas craft beer pop-up cred put a bird on it vinyl vhs.</p>\n\n	0	t	2020-11-17 14:29:41.144143	f	0	0	1	t	0	\N	\N	t	the-yellow-meads-of-asphodel-atque-laudantium-5fij	\N	0	 The Yellow Meads of Asphodel Atque laudantium	2020-11-25 14:07:17.518445	2	0	\N	\N	\N	0	\N	\N	\N
26	f	f	f	\N	---\ntitle: Welcome Thread - v0\npublished: true\ndescription: Introduce yourself to the community!\ntags: welcome\n---\n\nHey there! Welcome to DEV(local)!\n\nLeave a comment below to introduce yourself to the community!✌️\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	welcome	--- !ruby/struct:Articles::CachedEntity\nname: Kasey Rolfson\nusername: rolfsonkasey\nslug: rolfsonkasey\nprofile_image_90: "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"\nprofile_image_url: "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"\n	Kasey Rolfson	rolfsonkasey	\N	{}	\N	0	\N	0	2020-11-17 14:29:43.777506	\N	Introduce yourself to the community!	\N	t	5	5	\N	f	1605623383	\N	0	en	\N	2020-11-17 14:29:43.766609	\N	\N	#dddddd	2	0	0	0	\N	\N	1	0eef6460a7d4d1cc9862864ac823c10fe728449c311030d846d6c3b61e5d296082df3e58ac2bd8ed4b9db3782dea1e2d3ff585f756024d3a91c777c2	/rolfsonkasey/welcome-thread-v0-4cm2	0	0	0	<p>Hey there! Welcome to DEV(local)!</p>\n\n<p>Leave a comment below to introduce yourself to the community!✌️</p>\n\n	0	t	2020-11-17 14:29:43.766609	f	0	0	1	t	0	\N	\N	t	welcome-thread-v0-4cm2	\N	0	Welcome Thread - v0	2020-11-17 14:29:55.018037	1	0	\N	\N	\N	0	\N	\N	\N
30	f	f	f	\N	testtt post description	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N		--- !ruby/struct:Articles::CachedEntity\nname: MuzzamilMujahid\nusername: muzzamil219\nslug: muzzamil219\nprofile_image_90: https://res.cloudinary.com/Optional/image/fetch/s--SsxbauSi--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://thepracticaldev.s3.amazonaws.com/i/99mvlsfu5tfj9m7ku25d.png\nprofile_image_url: \n	MuzzamilMujahid	muzzamil219	\N	{}	\N	0	\N	0	2021-01-03 16:50:22.599356	\N	testtt post description	\N	t	5	5	\N	f	1609692622	\N	0	\N	\N	2021-01-03 16:50:22.590024	\N	\N	#dddddd	1	0	0	0	\N	\N	0	afa3f36280ef561554b2f54484ac9de1ea4706471bb437b9bda5bae1b8db3aeb61ca2acd506495976a0b6a81370a768abc84d56bdd0c85680c19753e	/muzzamil219/testtt-54cj	0	0	0	<p>testtt post description</p>\n\n	0	t	2021-01-04 11:45:10.268464	f	0	0	1	t	0	\N	\N	t	testtt-54cj	\N	0	testtt	2021-01-03 16:50:22.599356	24	0	\N	\N	\N	0	\N	\N	\N
5	f	f	f	\N	---\ntitle:  The Sun Also Rises Labore eos\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/7.png\ntags: java, beginners, productivity\n---\n\nCronut butcher before they sold out cold-pressed leggings etsy wolf diy. Five dollar toast intelligentsia brooklyn muggle magic.\n`Ad.`\nWes anderson jean shorts everyday intelligentsia marfa paleo drinking cardigan. Cred +1 kogi trust fund brunch cornhole roof quinoa. Hashtag ramps freegan.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	java, beginners, productivity	--- !ruby/struct:Articles::CachedEntity\nname: Esteban Marvin\nusername: estebanmarvin\nslug: estebanmarvin\nprofile_image_90: "/uploads/user/profile_image/9/75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png"\nprofile_image_url: "/uploads/user/profile_image/9/75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png"\n	Esteban Marvin	estebanmarvin	\N	{}	\N	0	\N	0	2020-11-17 14:29:39.884005	\N	Cronut butcher before they sold out cold-pressed leggings etsy wolf diy. Five dollar toast intelligen...	\N	t	5	5	\N	t	1605623379	\N	0	en	\N	2020-11-17 14:29:39.873572	\N	https://pigment.github.io/fake-logos/logos/medium/color/7.png	#dddddd	1	0	0	0	\N	\N	0	d56737f2dc0abeff1ad3c79d3ddfeeb78928f41720cdae03f592a4311b853e878fd5502b71d80bd0b966f28a0c09e619a879223f031eaa92015ae17e	/estebanmarvin/the-sun-also-rises-labore-eos-5ea6	0	0	0	<p>Cronut butcher before they sold out cold-pressed leggings etsy wolf diy. Five dollar toast intelligentsia brooklyn muggle magic.<br>\n<code>Ad.</code><br>\nWes anderson jean shorts everyday intelligentsia marfa paleo drinking cardigan. Cred +1 kogi trust fund brunch cornhole roof quinoa. Hashtag ramps freegan.</p>\n\n	0	t	2020-11-17 14:29:39.873572	f	0	0	1	t	0	\N	\N	t	the-sun-also-rises-labore-eos-5ea6	\N	0	 The Sun Also Rises Labore eos	2020-11-17 14:29:53.96603	9	0	\N	\N	\N	0	\N	\N	\N
12	f	f	f	\N	---\ntitle:  Death Be Not Proud Omnis consequuntur\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/10.png\ntags: java, javascript, beginners\n---\n\nBeard cray ennui muggle magic wayfarers. Listicle aesthetic hella pabst diy ennui chia. Banjo viral brunch scenester irony squid photo booth. Authentic swag raw denim.\n# Occaecati\nPop-up bushwick distillery. Taxidermy everyday cronut kombucha small batch quinoa godard literally.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	java, javascript, beginners	--- !ruby/struct:Articles::CachedEntity\nname: Esteban Marvin\nusername: estebanmarvin\nslug: estebanmarvin\nprofile_image_90: "/uploads/user/profile_image/9/75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png"\nprofile_image_url: "/uploads/user/profile_image/9/75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png"\n	Esteban Marvin	estebanmarvin	\N	{}	\N	0	\N	0	2020-11-17 14:29:40.450376	\N	Beard cray ennui muggle magic wayfarers. Listicle aesthetic hella pabst diy ennui chia. Banjo viral b...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-17 14:29:40.441255	\N	https://pigment.github.io/fake-logos/logos/medium/color/10.png	#dddddd	3	0	0	0	\N	\N	0	e3da9a9b4b3c8605c38ff154347aacbc00d60f918449633899da0a28cf3e63cb0e1d46874c4f135278f26e4b9ca79f224aaaee428be66930e83c4528	/estebanmarvin/death-be-not-proud-omnis-consequuntur-4gf0	0	0	0	<p>Beard cray ennui muggle magic wayfarers. Listicle aesthetic hella pabst diy ennui chia. Banjo viral brunch scenester irony squid photo booth. Authentic swag raw denim.</p>\n\n<h1>\n  <a name="occaecati" href="#occaecati" class="anchor">\n  </a>\n  Occaecati\n</h1>\n\n<p>Pop-up bushwick distillery. Taxidermy everyday cronut kombucha small batch quinoa godard literally.</p>\n\n	0	t	2020-11-17 14:29:40.441255	f	0	1	1	t	0	\N	\N	t	death-be-not-proud-omnis-consequuntur-4gf0	\N	0	 Death Be Not Proud Omnis consequuntur	2020-11-17 14:29:54.325669	9	0	\N	\N	\N	0	\N	\N	\N
15	f	f	f	\N	---\ntitle:  Eyeless in Gaza Quia dolorem\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/10.png\ntags: productivity, computerscience, go\n---\n\nHeirloom bushwick letterpress food truck godard. Pickled franzen muggle magic forage 90's mumblecore dreamcatcher artisan. Kale chips crucifix xoxo brunch. Park chia viral chillwave twee brooklyn diy artisan.\nPerferendis aut eveniet. ~Et~ deserunt dicta. Ex autem cupiditate.\nOffal flexitarian mixtape small batch chillwave vinyl. Meditation tilde fanny pack hella selvage. Bespoke tousled mlkshk knausgaard ethical dreamcatcher. Kickstarter disrupt carry fixie selfies vinyl poutine.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	productivity, computerscience, go	--- !ruby/struct:Articles::CachedEntity\nname: Jacob Lehner\nusername: lehner_jacob\nslug: lehner_jacob\nprofile_image_90: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\nprofile_image_url: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\n	Jacob Lehner	lehner_jacob	\N	{}	\N	0	\N	1	2020-11-17 14:29:40.681425	\N	Heirloom bushwick letterpress food truck godard. Pickled franzen muggle magic forage 90's mumblecore...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-25 14:07:07.620161	\N	https://pigment.github.io/fake-logos/logos/medium/color/10.png	#dddddd	4	0	0	0	\N	\N	0	25a881a2876ca0529c0db2b2e455978c7bca01394650cb67d29f6e3fc619f3aa53eb5df373492c99a825c37a007686a2084af7a9d99216d4373f3e02	/lehner_jacob/eyeless-in-gaza-quia-dolorem-3l0f	0	0	0	<p>Heirloom bushwick letterpress food truck godard. Pickled franzen muggle magic forage 90's mumblecore dreamcatcher artisan. Kale chips crucifix xoxo brunch. Park chia viral chillwave twee brooklyn diy artisan.<br>\nPerferendis aut eveniet. ~Et~ deserunt dicta. Ex autem cupiditate.<br>\nOffal flexitarian mixtape small batch chillwave vinyl. Meditation tilde fanny pack hella selvage. Bespoke tousled mlkshk knausgaard ethical dreamcatcher. Kickstarter disrupt carry fixie selfies vinyl poutine.</p>\n\n	0	t	2020-11-17 14:29:40.672666	f	0	0	1	t	0	\N	\N	t	eyeless-in-gaza-quia-dolorem-3l0f	\N	0	 Eyeless in Gaza Quia dolorem	2020-11-25 14:07:07.620161	6	0	\N	\N	\N	0	\N	\N	\N
6	f	f	f	\N	---\ntitle:  Absalom, Absalom! Esse explicabo\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/9.png\ntags: linux, webdev, java\n---\n\nPork belly skateboard everyday irony. Cray thundercats letterpress everyday. Vinyl yuccie 8-bit.\n### Optio\nQui veniam deserunt. Dolor id placeat. Quidem assumenda labore.\nsed | quis | deserunt\n---- | ---- | ----\nlaborum | commodi | fuga\nculpa | cumque | voluptatem\nMicrodosing green juice vinyl health cold-pressed lo-fi banh mi distillery. Poutine pour-over pbr&b normcore seitan mlkshk. Forage thundercats cornhole echo. Venmo marfa normcore paleo gluten-free humblebrag.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	linux, webdev, java	--- !ruby/struct:Articles::CachedEntity\nname: Kasey Rolfson\nusername: rolfsonkasey\nslug: rolfsonkasey\nprofile_image_90: "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"\nprofile_image_url: "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"\n	Kasey Rolfson	rolfsonkasey	\N	{}	\N	0	\N	0	2020-11-17 14:29:39.964122	\N	Pork belly skateboard everyday irony. Cray thundercats letterpress everyday. Vinyl yuccie 8-bit....	\N	t	5	5	\N	t	1605623379	\N	0	\N	\N	2020-11-17 14:29:39.952958	\N	https://pigment.github.io/fake-logos/logos/medium/color/9.png	#dddddd	1	0	0	0	\N	\N	0	ed3a85e6a6b963beedc45581a3bab47ad1c48b8ac110c40d3998036c37020e075725fdd950b22185c3308a9e8c48fb7198831f401eb42b9731ae1d1d	/rolfsonkasey/absalom-absalom-esse-explicabo-5h47	0	0	0	<p>Pork belly skateboard everyday irony. Cray thundercats letterpress everyday. Vinyl yuccie 8-bit.</p>\n\n<h3>\n  <a name="optio" href="#optio" class="anchor">\n  </a>\n  Optio\n</h3>\n\n<p>Qui veniam deserunt. Dolor id placeat. Quidem assumenda labore.<br>\nsed | quis | deserunt<br>\n---- | ---- | ----<br>\nlaborum | commodi | fuga<br>\nculpa | cumque | voluptatem<br>\nMicrodosing green juice vinyl health cold-pressed lo-fi banh mi distillery. Poutine pour-over pbr&amp;b normcore seitan mlkshk. Forage thundercats cornhole echo. Venmo marfa normcore paleo gluten-free humblebrag.</p>\n\n	0	t	2020-11-17 14:29:39.952958	f	0	0	1	t	0	\N	\N	t	absalom-absalom-esse-explicabo-5h47	\N	0	 Absalom, Absalom! Esse explicabo	2020-11-17 14:29:54.015346	1	0	\N	\N	\N	0	\N	\N	\N
1	f	f	f	\N	---\ntitle:  East of Eden Illo soluta\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/10.png\ntags: discuss, python, security, webdev\n---\n\nKitsch pabst yuccie cleanse plaid polaroid phlogiston. Deep v lomo dreamcatcher yr. Cronut ennui knausgaard. Pork belly church-key pitchfork.\n* Iure. \n* Ut. \n* Dolores. \n* Iure. \n* Odit. \n* Quibusdam. \n* Odio. \n* Non. \n* Quaerat. \n\nLeggings fingerstache wayfarers. Beard organic photo booth pour-over ramps irony. Park pinterest beard celiac actually pug ramps hammock.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, python, security, webdev	--- !ruby/struct:Articles::CachedEntity\nname: Tressie Cremin\nusername: cremintressie\nslug: cremintressie\nprofile_image_90: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\nprofile_image_url: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\n	Tressie Cremin	cremintressie	\N	{}	\N	0	\N	2	2020-11-17 14:29:39.506434	\N	Kitsch pabst yuccie cleanse plaid polaroid phlogiston. Deep v lomo dreamcatcher yr. Cronut ennui knau...	\N	t	5	5	\N	t	1605623379	\N	0	\N	\N	2020-11-25 14:07:22.78438	\N	https://pigment.github.io/fake-logos/logos/medium/color/10.png	#dddddd	1	0	0	0	\N	\N	0	eb2da6d65c0df29cb8e9797e20ac3ac30cc8e6c8ca8d04cfdda05228d4ced6141ad1132c6026d4f299628a752a23fe80d3e33c9b191173f392496ee6	/cremintressie/east-of-eden-illo-soluta-480c	0	0	0	<p>Kitsch pabst yuccie cleanse plaid polaroid phlogiston. Deep v lomo dreamcatcher yr. Cronut ennui knausgaard. Pork belly church-key pitchfork.</p>\n\n<ul>\n<li>Iure. </li>\n<li>Ut. </li>\n<li>Dolores. </li>\n<li>Iure. </li>\n<li>Odit. </li>\n<li>Quibusdam. </li>\n<li>Odio. </li>\n<li>Non. </li>\n<li>Quaerat. </li>\n</ul>\n\n<p>Leggings fingerstache wayfarers. Beard organic photo booth pour-over ramps irony. Park pinterest beard celiac actually pug ramps hammock.</p>\n\n	0	t	2020-11-17 14:29:39.432046	f	0	0	1	t	0	\N	\N	t	east-of-eden-illo-soluta-480c	\N	0	 East of Eden Illo soluta	2020-11-25 14:07:22.78438	10	0	\N	\N	\N	0	\N	\N	\N
3	f	f	f	\N	---\ntitle:  Waiting for the Barbarians Vitae dolorem\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/4.png\ntags: java, career, webdev\n---\n\nPour-over kitsch slow-carb. Brooklyn wayfarers seitan distillery small batch. Meditation portland jean shorts food truck wes anderson pork belly.\n* Officiis. \n* Sed. \n* Unde. \n* Eveniet. \n* Accusamus. \n\nCarry portland brunch. Leggings cronut yuccie.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	java, career, webdev	--- !ruby/struct:Articles::CachedEntity\nname: Jeromy Schimmel\nusername: schimmeljeromy\nslug: schimmeljeromy\nprofile_image_90: "/uploads/user/profile_image/7/fc3554c2-3141-4ec7-a899-d39c289a0d06.png"\nprofile_image_url: "/uploads/user/profile_image/7/fc3554c2-3141-4ec7-a899-d39c289a0d06.png"\n	Jeromy Schimmel	schimmeljeromy	\N	{}	\N	0	\N	2	2020-11-17 14:29:39.723656	\N	Pour-over kitsch slow-carb. Brooklyn wayfarers seitan distillery small batch. Meditation portland jea...	\N	t	5	5	\N	t	1605623379	\N	0	en	\N	2020-11-25 14:07:07.621962	\N	https://pigment.github.io/fake-logos/logos/medium/color/4.png	#dddddd	1	0	0	0	\N	\N	0	1c45d9095352bbe03df996f31ce2a124f077c2ec3c10a3b97ada95f98a8a1c30604c2e9577c01883a37c6f7b07b1f1595e1781d4dada413a8ca34144	/schimmeljeromy/waiting-for-the-barbarians-vitae-dolorem-41lo	0	0	0	<p>Pour-over kitsch slow-carb. Brooklyn wayfarers seitan distillery small batch. Meditation portland jean shorts food truck wes anderson pork belly.</p>\n\n<ul>\n<li>Officiis. </li>\n<li>Sed. </li>\n<li>Unde. </li>\n<li>Eveniet. </li>\n<li>Accusamus. </li>\n</ul>\n\n<p>Carry portland brunch. Leggings cronut yuccie.</p>\n\n	0	t	2020-11-17 14:29:39.713043	f	0	0	1	t	0	\N	\N	t	waiting-for-the-barbarians-vitae-dolorem-41lo	\N	0	 Waiting for the Barbarians Vitae dolorem	2020-11-25 14:07:07.621962	7	0	\N	\N	\N	0	\N	\N	\N
17	f	f	f	\N	---\ntitle:  Terrible Swift Sword Excepturi non\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/3.png\ntags: discuss, python, security\n---\n\nStumptown echo yolo gluten-free leggings art party selfies. Park drinking mumblecore thundercats quinoa.\n# Minus\nPhlogiston mixtape synth shoreditch artisan 8-bit pickled fashion axe. Single-origin coffee bushwick listicle master letterpress 90's gentrify.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, python, security	--- !ruby/struct:Articles::CachedEntity\nname: Gov. Guadalupe Hackett\nusername: guadalupehackettgov\nslug: guadalupehackettgov\nprofile_image_90: "/uploads/user/profile_image/5/63c914c9-9793-4b24-a6ec-1c1c1b4d453a.png"\nprofile_image_url: "/uploads/user/profile_image/5/63c914c9-9793-4b24-a6ec-1c1c1b4d453a.png"\n	Gov. Guadalupe Hackett	guadalupehackettgov	\N	{}	\N	0	\N	0	2020-11-17 14:29:40.844829	\N	Stumptown echo yolo gluten-free leggings art party selfies. Park drinking mumblecore thundercats quin...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-17 14:29:40.834311	\N	https://pigment.github.io/fake-logos/logos/medium/color/3.png	#dddddd	1	0	0	0	\N	\N	0	47fa211e3e2a72ce094e4cbd56d4d1f6609cb1ac843db6fb9e6e340ac3d9c7b6615af6c595d8074dcac6aeb6c4512ad2366eb8d70a128997b62d328b	/guadalupehackettgov/terrible-swift-sword-excepturi-non-53mh	0	0	0	<p>Stumptown echo yolo gluten-free leggings art party selfies. Park drinking mumblecore thundercats quinoa.</p>\n\n<h1>\n  <a name="minus" href="#minus" class="anchor">\n  </a>\n  Minus\n</h1>\n\n<p>Phlogiston mixtape synth shoreditch artisan 8-bit pickled fashion axe. Single-origin coffee bushwick listicle master letterpress 90's gentrify.</p>\n\n	0	t	2020-11-17 14:29:40.834311	f	0	0	1	t	0	\N	\N	t	terrible-swift-sword-excepturi-non-53mh	\N	0	 Terrible Swift Sword Excepturi non	2020-11-17 14:29:54.577018	5	0	\N	\N	\N	0	\N	\N	\N
10	f	f	f	\N	---\ntitle:  The Far-Distant Oxus Quo dolorem\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/8.png\ntags: discuss, git, linux, career\n---\n\nSartorial beard lomo etsy trust fund cleanse listicle williamsburg. Flannel leggings ennui chia keffiyeh skateboard organic fingerstache. Bespoke aesthetic listicle mixtape cardigan umami blue bottle. Actually health portland stumptown typewriter paleo wes anderson kinfolk.\n# Quidem\nDeleniti eum enim. Exercitationem qui dolore. Repellendus assumenda velit.\n##### Est\nUt assumenda eligendi. Perferendis ipsum ab. Sint delectus temporibus.\n## Eum\nNormcore celiac bicycle rights gentrify disrupt plaid street small batch. Tote bag truffaut +1 gluten-free umami. Flannel blue bottle taxidermy banjo selfies. Irony normcore freegan.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	discuss, git, linux, career	--- !ruby/struct:Articles::CachedEntity\nname: Laveta Shanahan\nusername: shanahan_laveta\nslug: shanahan_laveta\nprofile_image_90: "/uploads/user/profile_image/4/8a0bc7f7-5387-45cb-8030-1a0020924ac9.png"\nprofile_image_url: "/uploads/user/profile_image/4/8a0bc7f7-5387-45cb-8030-1a0020924ac9.png"\n	Laveta Shanahan	shanahan_laveta	\N	{}	\N	0	\N	4	2020-11-17 14:29:40.291115	\N	Sartorial beard lomo etsy trust fund cleanse listicle williamsburg. Flannel leggings ennui chia keffi...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-25 14:08:22.509092	\N	https://pigment.github.io/fake-logos/logos/medium/color/8.png	#dddddd	2	0	0	0	\N	\N	0	8536adf0a22efc9a0178fe41471bdd17251ca40c84db16017a6573c762cd8f1813266ade1f4c88ab51b862430dfc1d0b6a9a9d84ea47ef424510e859	/shanahan_laveta/the-far-distant-oxus-quo-dolorem-1l64	0	0	0	<p>Sartorial beard lomo etsy trust fund cleanse listicle williamsburg. Flannel leggings ennui chia keffiyeh skateboard organic fingerstache. Bespoke aesthetic listicle mixtape cardigan umami blue bottle. Actually health portland stumptown typewriter paleo wes anderson kinfolk.</p>\n\n<h1>\n  <a name="quidem" href="#quidem" class="anchor">\n  </a>\n  Quidem\n</h1>\n\n<p>Deleniti eum enim. Exercitationem qui dolore. Repellendus assumenda velit.</p>\n\n<h5>\n  <a name="est" href="#est" class="anchor">\n  </a>\n  Est\n</h5>\n\n<p>Ut assumenda eligendi. Perferendis ipsum ab. Sint delectus temporibus.</p>\n\n<h2>\n  <a name="eum" href="#eum" class="anchor">\n  </a>\n  Eum\n</h2>\n\n<p>Normcore celiac bicycle rights gentrify disrupt plaid street small batch. Tote bag truffaut +1 gluten-free umami. Flannel blue bottle taxidermy banjo selfies. Irony normcore freegan.</p>\n\n	0	t	2020-11-17 14:29:40.280751	f	0	0	1	t	0	\N	\N	t	the-far-distant-oxus-quo-dolorem-1l64	\N	0	 The Far-Distant Oxus Quo dolorem	2020-11-25 14:08:22.509092	4	0	\N	\N	\N	0	\N	\N	\N
14	f	f	f	\N	---\ntitle:  In a Glass Darkly Qui soluta\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/4.png\ntags: git, python, security\n---\n\nLomo blog banh mi cliche godard jean shorts. Pickled typewriter gentrify marfa loko hammock yuccie pitchfork. Portland franzen selfies vegan narwhal authentic.\n* Autem. \n* Eaque. \n* Ad. \n* Molestiae. \n* Sint. \n* Quaerat. \n* Vel. \n* Velit. \n* Rerum. \n\nYr mixtape gluten-free celiac distillery. Keytar freegan pug locavore lumbersexual cliche keffiyeh. Venmo synth semiotics marfa waistcoat listicle typewriter ennui. Fingerstache selfies paleo godard pour-over disrupt vegan.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	git, python, security	--- !ruby/struct:Articles::CachedEntity\nname: Jacob Lehner\nusername: lehner_jacob\nslug: lehner_jacob\nprofile_image_90: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\nprofile_image_url: "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"\n	Jacob Lehner	lehner_jacob	\N	{}	\N	0	\N	1	2020-11-17 14:29:40.608876	\N	Lomo blog banh mi cliche godard jean shorts. Pickled typewriter gentrify marfa loko hammock yuccie pi...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-25 14:06:24.547336	\N	https://pigment.github.io/fake-logos/logos/medium/color/4.png	#dddddd	3	0	0	0	\N	\N	0	dec91f9cb144cdce57dfc04d9b302ac2e63e85ddcef155a4fc0a1d261afcf04dbb07a3bb7542c87548605647e39ccd99b0bfe68074c459b99f1a19b3	/lehner_jacob/in-a-glass-darkly-qui-soluta-4pfp	0	0	0	<p>Lomo blog banh mi cliche godard jean shorts. Pickled typewriter gentrify marfa loko hammock yuccie pitchfork. Portland franzen selfies vegan narwhal authentic.</p>\n\n<ul>\n<li>Autem. </li>\n<li>Eaque. </li>\n<li>Ad. </li>\n<li>Molestiae. </li>\n<li>Sint. </li>\n<li>Quaerat. </li>\n<li>Vel. </li>\n<li>Velit. </li>\n<li>Rerum. </li>\n</ul>\n\n<p>Yr mixtape gluten-free celiac distillery. Keytar freegan pug locavore lumbersexual cliche keffiyeh. Venmo synth semiotics marfa waistcoat listicle typewriter ennui. Fingerstache selfies paleo godard pour-over disrupt vegan.</p>\n\n	0	t	2020-11-17 14:29:40.598557	f	0	0	1	t	0	\N	\N	t	in-a-glass-darkly-qui-soluta-4pfp	\N	0	 In a Glass Darkly Qui soluta	2020-11-25 14:06:24.547336	6	0	\N	\N	\N	0	\N	\N	\N
18	f	f	f	\N	---\ntitle:  Tender Is the Night Est quia\npublished: true\ncover_image: https://pigment.github.io/fake-logos/logos/medium/color/1.png\ntags: go, git, career\n---\n\nSingle-origin coffee chia street humblebrag bicycle rights. Squid gastropub meh etsy tofu hella meditation master.\n0. Aspernatur. \n1. Est. \n2. Perferendis. \n\nWolf waistcoat put a bird on it banjo sartorial jean shorts. Lumbersexual sartorial pork belly chia pour-over marfa slow-carb cornhole. Gluten-free vice aesthetic irony artisan park. Meditation brooklyn seitan narwhal etsy hella.\n	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	go, git, career	--- !ruby/struct:Articles::CachedEntity\nname: Tressie Cremin\nusername: cremintressie\nslug: cremintressie\nprofile_image_90: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\nprofile_image_url: "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"\n	Tressie Cremin	cremintressie	\N	{}	\N	0	\N	4	2020-11-17 14:29:40.920555	\N	Single-origin coffee chia street humblebrag bicycle rights. Squid gastropub meh etsy tofu hella medit...	\N	t	5	5	\N	t	1605623380	\N	0	\N	\N	2020-11-25 14:06:48.304108	\N	https://pigment.github.io/fake-logos/logos/medium/color/1.png	#dddddd	3	0	0	0	\N	\N	0	318dbc1a47677677609f29e47d2ee30ae1aed477902e2d95fd1d4f8ac9faa6cccfabd015ab79725a60dbea1ef9243e5f38214bf6dc2f762866ee0b4f	/cremintressie/tender-is-the-night-est-quia-2k6j	0	0	0	<p>Single-origin coffee chia street humblebrag bicycle rights. Squid gastropub meh etsy tofu hella meditation master.</p>\n\n<ol>\n<li>Aspernatur. </li>\n<li>Est. </li>\n<li>Perferendis. </li>\n</ol>\n\n<p>Wolf waistcoat put a bird on it banjo sartorial jean shorts. Lumbersexual sartorial pork belly chia pour-over marfa slow-carb cornhole. Gluten-free vice aesthetic irony artisan park. Meditation brooklyn seitan narwhal etsy hella.</p>\n\n	0	t	2020-11-17 14:29:40.911213	f	0	0	1	t	0	\N	\N	t	tender-is-the-night-est-quia-2k6j	\N	0	 Tender Is the Night Est quia	2020-11-25 14:06:48.304108	10	0	\N	\N	\N	0	\N	\N	\N
29	f	f	f	\N	asdadadadadad	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	test	--- !ruby/struct:Articles::CachedEntity\nname: Muzzamil123\nusername: muzzamil123\nslug: muzzamil123\nprofile_image_90: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\nprofile_image_url: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\n	Muzzamil123	muzzamil123	\N	{}	\N	0	\N	0	2020-12-20 09:10:49.646694	\N	asdadadadadad	\N	t	5	5	\N	f	1608455449	\N	346169	\N	\N	2020-12-20 09:10:49.642148	\N	\N	#dddddd	3	0	0	0	\N	\N	0	0c709341e9d46fd4a3475b5387b5be72c2da4928bda014cb878420fa03e8b267485201a9f9a157911c5135fb77fcaac9da326c9770d74e20c427c3bc	/muzzamil123/testing-25b4	0	0	0	<p>asdadadadadad</p>\n\n	0	t	2020-12-20 09:10:49.642148	f	0	0	1	t	0	\N	\N	t	testing-25b4	\N	0	testing	2020-12-20 09:10:49.646694	12	0	\N	\N	\N	0	\N	\N	\N
27	f	f	f	\N	testing description here 	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	test	--- !ruby/struct:Articles::CachedEntity\nname: Muzzamil123\nusername: muzzamil123\nslug: muzzamil123\nprofile_image_90: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\nprofile_image_url: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\n	Muzzamil123	muzzamil123	\N	{}	\N	0	\N	0	2020-12-02 12:43:40.275721	\N	testing description here	2020-12-02 12:44:03.626148	t	5	5	\N	f	1606913020	\N	344627	\N	\N	2020-12-02 12:43:40.270765	\N	\N	#dddddd	1	0	0	0	\N	\N	0	eaa3318a3af43523a364c18952e6df4f8183be6013ea26a8cf2ba95c88f158afef0914a739a725a0041ef8a32594f3e865ae047ee77ce85d802476f3	/muzzamil123/test-post-1eln	0	0	0	<p>testing description here </p>\n\n	0	t	2020-12-02 12:43:40.270765	f	0	0	1	t	0	\N	\N	t	test-post-1eln	\N	0	Test Post	2020-12-02 12:44:03.655574	12	0	\N	\N	\N	0	\N	\N	\N
28	f	f	f	\N	test \n{% youtube tb_WGzpNErs %} 	{"boosted_additional_tags": "", "boosted_dev_digest_email": false, "boosted_additional_articles": false}	\N	test	--- !ruby/struct:Articles::CachedEntity\nname: Muzzamil123\nusername: muzzamil123\nslug: muzzamil123\nprofile_image_90: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\nprofile_image_url: "/uploads/user/profile_image/12/9b9563f4-e646-40e1-bdec-b6a25270a1ec.png"\n	Muzzamil123	muzzamil123	\N	{}	\N	0	\N	0	2020-12-03 11:36:49.722937	\N	test	\N	t	5	5	\N	f	1606995409	\N	344709	\N	\N	2020-12-03 11:36:49.7164	\N	\N	#dddddd	2	0	0	0	\N	\N	8	73dd680284fc11b9e483a09ba3de7f8b39d17b6892e2c8de2f58e0dc621b7a3327538e860d04d42eeba614872ce2f700902119c1bb5810c8c926db3c	/muzzamil123/test-hg8	0	0	0	<p>test <br>\n<iframe width="710" height="399" src="https://www.youtube.com/embed/tb_WGzpNErs" allowfullscreen loading="lazy">\n</iframe>\n </p>\n\n	0	t	2020-12-03 11:36:49.7164	f	0	0	1	t	0	\N	\N	t	test-hg8	\N	0	test	2020-12-03 11:36:49.722937	12	0	\N	\N	\N	0	\N	\N	\N
\.


--
-- Data for Name: artist_applications; Type: TABLE DATA; Schema: public; Owner: forem_latest
--

COPY public.artist_applications (id, first_name, last_name, date_of_birth, email, telephone, location_id, composer_id, industry_id, song_language_id, genre_id, commission_accepted, sell_tracks, sell_campaigns, spotify_url, soundcloud_url, itunes_url, facebook_url, twitter_url, website_url, accept_terms, created_at, updated_at, status, user_id) FROM stdin;
1	Muzzamil	Mujahid	2020-12-02	pihov48469@1092df.com	163172683123	1	3	3	2	1	t	t	t			http://www.xyz.com				\N	2020-12-29 16:47:39.990473	2020-12-30 15:13:31.684888	t	\N
2	Muzzamil	Mujahid	\N	muzamil.mujahid11@gmail.com		167	1	1	1	1	t	t	t							\N	2021-01-01 16:27:50.371467	2021-01-01 16:27:50.371467	f	\N
3			\N			1	1	1	1	1	f	f	f							\N	2021-01-03 13:56:55.790578	2021-01-03 13:56:55.790578	f	\N
4	Muzzamil	Mujahid	2021-01-03	mj@jm.com	8888675309	167	1	1	1	1	t	t	t							\N	2021-01-03 14:02:27.356551	2021-01-03 14:02:27.829453	t	\N
5	Muzzamil	Mujahid	2021-01-03	ok@ok.com	0302471547212	167	1	1	1	1	t	f	f							\N	2021-01-03 14:13:12.650268	2021-01-03 14:13:13.037309	t	\N
6	Muzzamil	Mujahid	2021-01-03	uh@hu.com	03025434231	167	1	1	1	1	f	f	f							\N	2021-01-03 14:36:10.128642	2021-01-03 14:36:10.487878	t	\N
7	Muzzamil	Mujahid	2021-01-01	qw@qw.com	8888675309	167	1	1	1	1	f	f	f							\N	2021-01-03 14:44:19.40914	2021-01-03 14:44:19.850343	t	\N
8	Muzzamil	Mujahid	2021-01-03	rr@rr.com	8888675309	167	1	1	1	1	f	f	f							\N	2021-01-03 14:54:36.117109	2021-01-03 14:54:36.117109	f	\N
9	Muzzamil	Mujahid	2021-01-03	yy@yy.com	8888675309	167	1	1	1	1	f	f	f							\N	2021-01-03 14:57:15.134959	2021-01-03 14:57:15.427271	t	\N
10	Muzzamil	Mujahid	2021-01-13	muzamil.mujahid11@gmail.commmm	8888675309	167	1	1	1	1	f	f	f							\N	2021-01-05 12:11:56.429784	2021-01-05 12:11:58.505223	t	\N
11	Muzzamil	Mujahid	2021-01-04	mkmkm@kmkm.com	8888675309	167	1	1	1	1	f	f	f							\N	2021-01-05 12:34:56.190732	2021-01-05 12:34:57.630785	t	\N
12	Muzzamil	Mujahid	2021-01-04	muzamil.mujahid11@gmail.comasassaas	8888675309	167	1	1	1	1	f	f	f							\N	2021-01-05 12:42:18.378	2021-01-05 12:42:19.909689	t	\N
13	Muzzamil	Mujahid	2021-01-08	muzamil.mujahid11@gmail.comjkasnkjdaskj	8888675309	167	1	1	1	1	t	t	t							\N	2021-01-08 11:55:21.879124	2021-01-08 11:55:23.778665	t	29
14	Muzzamil	Mujahid	2021-01-08	ghgh@ghgh.com	8888675309	167	1	1	1	1	t	t	t							\N	2021-01-08 12:54:18.344626	2021-01-08 12:54:20.00805	f	30
15	Muzzamil	Mujahid	2021-01-09	muj@test.com	8888675309	167	1	1	1	1	t	t	t		http://soundcloud.com					\N	2021-01-09 13:28:20.316102	2021-01-09 13:28:21.973156	f	31
\.


--
-- Data for Name: audios; Type: TABLE DATA; Schema: public; Owner: forem_latest
--

COPY public.audios (id, name, link, user_id, created_at, updated_at, status, music_release_id, slug) FROM stdin;
1	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 14:31:16.286704	2020-12-21 14:31:16.286704	f	\N	\N
2	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 14:35:12.005873	2020-12-21 14:35:12.005873	f	\N	\N
3	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 14:41:38.210778	2020-12-21 14:41:38.210778	f	\N	\N
4	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 14:48:26.983025	2020-12-21 14:48:26.983025	f	\N	\N
5	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 14:50:46.186966	2020-12-21 14:50:46.186966	f	\N	\N
6	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:08:19.539356	2020-12-21 15:08:19.539356	f	\N	\N
7	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:08:20.15789	2020-12-21 15:08:20.15789	f	\N	\N
8	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:11:26.229628	2020-12-21 15:11:26.229628	f	\N	\N
9	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:11:26.262362	2020-12-21 15:11:26.262362	f	\N	\N
10	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:11:26.899584	2020-12-21 15:11:26.899584	f	\N	\N
11	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:12:34.643531	2020-12-21 15:12:34.643531	f	\N	\N
12	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:12:34.960281	2020-12-21 15:12:34.960281	f	\N	\N
13	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:17:26.07414	2020-12-21 15:17:26.07414	f	\N	\N
14	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:19:27.519914	2020-12-21 15:19:27.519914	f	\N	\N
15	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:20:15.07971	2020-12-21 15:20:15.07971	f	\N	\N
16	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:20:26.252189	2020-12-21 15:20:26.252189	f	\N	\N
17	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-21 15:21:18.989309	2020-12-22 12:41:16.309472	t	\N	\N
18	\N	/audio/audio-upload.mp3	12	2020-12-23 14:35:49.450633	2020-12-23 14:35:49.450633	f	\N	\N
19	\N	/audio/audio-upload.mp3	12	2020-12-23 14:36:33.095144	2020-12-23 14:36:33.095144	f	\N	\N
20	\N	/audio/audio-upload.mp3	12	2020-12-23 14:37:41.96163	2020-12-23 14:37:41.96163	f	\N	\N
21	\N	/audio/audio-upload.mp3	12	2020-12-23 14:45:03.974301	2020-12-23 14:45:03.974301	f	\N	\N
22	\N	/audio/audio-upload.mp3	12	2020-12-23 14:45:48.468223	2020-12-23 14:45:48.468223	f	\N	\N
23	\N	/audio/audio-upload.mp3	12	2020-12-23 14:47:14.033845	2020-12-23 14:47:14.033845	f	\N	\N
24	\N	/audio/audio-upload.mp3	12	2020-12-23 14:50:47.452206	2020-12-23 14:50:47.452206	f	\N	\N
25	\N	/audio/audio-upload.mp3	12	2020-12-23 14:53:22.680118	2020-12-23 14:53:22.680118	f	\N	\N
26	\N	/audio/audio-upload.mp3	12	2020-12-23 14:54:22.708039	2020-12-23 14:54:22.708039	f	\N	\N
27	\N	/audio/audio-upload.mp3	12	2020-12-23 14:55:00.52748	2020-12-23 14:55:00.52748	f	\N	\N
28	\N	/audio/audio-upload.mp3	12	2020-12-23 14:55:14.166958	2020-12-23 14:55:14.166958	f	\N	\N
29	\N	/audio/audio-upload.mp3	12	2020-12-23 14:55:40.71813	2020-12-23 14:55:40.71813	f	\N	\N
30	\N	/audio/audio-upload.mp3	12	2020-12-23 14:56:51.136737	2020-12-23 14:56:51.136737	f	\N	\N
31	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-27 21:14:05.690286	2020-12-27 21:14:05.690286	f	\N	\N
32	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-27 21:17:18.536112	2020-12-27 21:17:18.536112	f	\N	\N
33	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-27 23:20:02.738044	2020-12-27 23:20:02.738044	f	\N	\N
34	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-27 23:21:21.805775	2020-12-27 23:21:21.805775	f	\N	\N
35	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-27 23:23:09.660069	2020-12-27 23:23:09.660069	f	\N	\N
36	Qawal	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-28 14:11:24.000881	2020-12-28 14:48:15.792013	t	3	qawalll
37	kmkmkmkkmkmk	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	12	2020-12-28 14:51:47.618991	2020-12-28 14:52:35.090827	t	2	kmk
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.audit_logs (id, category, created_at, data, roles, slug, updated_at, user_id) FROM stdin;
1	moderator.audit.log	2020-11-30 11:33:22.077657	{"id": "12", "user": {"new_note": "testing purposes", "add_credits": "60"}, "action": "update", "locale": null, "_method": "patch", "controller": "admin/users"}	{super_admin,admin,single_resource_admin}	update	2020-11-30 11:33:22.077657	12
2	moderator.audit.log	2021-01-07 16:07:52.334974	{"id": "28", "action": "full_delete", "locale": null, "controller": "admin/users"}	{super_admin,admin,single_resource_admin,customer}	full_delete	2021-01-07 16:07:52.334974	12
3	moderator.audit.log	2021-01-07 16:11:26.508764	{"id": "28", "action": "full_delete", "locale": null, "controller": "admin/users"}	{super_admin,admin,single_resource_admin,customer}	full_delete	2021-01-07 16:11:26.508764	12
4	moderator.audit.log	2021-01-07 16:12:17.463821	{"id": "28", "action": "full_delete", "locale": null, "controller": "admin/users"}	{super_admin,admin,single_resource_admin,customer}	full_delete	2021-01-07 16:12:17.463821	12
5	moderator.audit.log	2021-01-07 16:12:57.411802	{"id": "28", "action": "full_delete", "locale": null, "controller": "admin/users"}	{super_admin,admin,single_resource_admin,customer}	full_delete	2021-01-07 16:12:57.411802	12
\.


--
-- Data for Name: badge_achievements; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.badge_achievements (id, badge_id, created_at, rewarder_id, rewarding_context_message, rewarding_context_message_markdown, updated_at, user_id) FROM stdin;
1	2	2020-11-17 14:29:44.406451	\N	\n<code>Dicta.\n</code>\n\n\n    Enter fullscreen mode\n    \n\n\n    Exit fullscreen mode\n    \n\n\n\n\n\n\n\n\n	```ruby\nDicta.\n```	2020-11-17 14:29:44.406451	2
2	2	2020-11-17 14:29:44.503282	\N	\n  <a name="aut" href="#aut">\n  </a>\n  Aut\n\n\nSuscipit molestias molestiae. Saepe ut voluptates. Excepturi est incidunt.\n<code>Aut.</code>\n\n	#### Aut\nSuscipit molestias molestiae. Saepe ut voluptates. Excepturi est incidunt.\n`Aut.`	2020-11-17 14:29:44.503282	1
3	2	2020-11-17 14:29:44.577157	\N	\n<code>Soluta.\n</code>\n\n\n    Enter fullscreen mode\n    \n\n\n    Exit fullscreen mode\n    \n\n\n\n\n\n\n\n\n	```ruby\nSoluta.\n```	2020-11-17 14:29:44.577157	9
4	4	2020-11-17 14:29:44.665149	\N	\n\n\net\nitaque\neos\n\n\n\n\nomnis\ndicta\nmaiores\n\n\nvoluptas\ndignissimos\nnostrum\n\n\n\n\n	et | itaque | eos\n---- | ---- | ----\nomnis | dicta | maiores\nvoluptas | dignissimos | nostrum	2020-11-17 14:29:44.665149	4
5	4	2020-11-17 14:29:44.724908	\N	\n  <a name="id" href="#id">\n  </a>\n  Id\n\n\n	##### Id	2020-11-17 14:29:44.724908	3
6	4	2020-11-17 14:29:44.929073	\N	\n  <a name="aut" href="#aut">\n  </a>\n  Aut\n\n\n	###### Aut	2020-11-17 14:29:44.929073	10
7	4	2020-11-17 14:29:44.987317	\N	\n  <a name="eum" href="#eum">\n  </a>\n  Eum\n\n\nEveniet ea unde. Dolorem voluptatum vel. Qui sint odit.\n\n\n  <a name="qui" href="#qui">\n  </a>\n  Qui\n\n\n	###### Eum\nEveniet ea unde. Dolorem voluptatum vel. Qui sint odit.\n# Qui	2020-11-17 14:29:44.987317	11
8	5	2020-11-17 14:29:45.047433	\N	\n\n\nfacilis\nmolestiae\nprovident\n\n\n\n\nalias\nconsequatur\nfuga\n\n\net\nmolestias\nvoluptatem\n\n\n\n\n	facilis | molestiae | provident\n---- | ---- | ----\nalias | consequatur | fuga\net | molestias | voluptatem	2020-11-17 14:29:45.047433	6
9	3	2020-11-17 14:29:45.105311	\N	\nEos. \nAutem. \nAd. \nAlias. \n\n\n	* Eos. \n* Autem. \n* Ad. \n* Alias. \n	2020-11-17 14:29:45.105311	5
10	1	2020-11-17 14:29:45.16301	\N	\n  <a name="quis" href="#quis">\n  </a>\n  Quis\n\n\n	# Quis	2020-11-17 14:29:45.16301	8
\.


--
-- Data for Name: badges; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.badges (id, badge_image, created_at, description, slug, title, updated_at) FROM stdin;
1	38.png	2020-11-17 14:29:43.98446	Et molestiae ea reiciendis.	quis-62	quis 62	2020-11-17 14:29:43.98446
2	21.png	2020-11-17 14:29:44.079209	Voluptatem nobis voluptatem nihil.	fugit-93	fugit 93	2020-11-17 14:29:44.079209
3	28.png	2020-11-17 14:29:44.177581	Qui qui maxime cumque.	sed-27	sed 27	2020-11-17 14:29:44.177581
4	9.png	2020-11-17 14:29:44.265319	Ad minus soluta accusantium.	magni-82	magni 82	2020-11-17 14:29:44.265319
5	30.png	2020-11-17 14:29:44.367226	Fuga veniam officiis qui.	doloribus-77	doloribus 77	2020-11-17 14:29:44.367226
\.


--
-- Data for Name: banished_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.banished_users (id, banished_by_id, created_at, updated_at, username) FROM stdin;
\.


--
-- Data for Name: blazer_audits; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blazer_audits (id, created_at, data_source, query_id, statement, user_id) FROM stdin;
\.


--
-- Data for Name: blazer_checks; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blazer_checks (id, check_type, created_at, creator_id, emails, last_run_at, message, query_id, schedule, slack_channels, state, updated_at) FROM stdin;
\.


--
-- Data for Name: blazer_dashboard_queries; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blazer_dashboard_queries (id, created_at, dashboard_id, "position", query_id, updated_at) FROM stdin;
\.


--
-- Data for Name: blazer_dashboards; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blazer_dashboards (id, created_at, creator_id, name, updated_at) FROM stdin;
\.


--
-- Data for Name: blazer_queries; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blazer_queries (id, created_at, creator_id, data_source, description, name, statement, updated_at) FROM stdin;
\.


--
-- Data for Name: broadcasts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.broadcasts (id, active, active_status_updated_at, banner_style, body_markdown, broadcastable_id, broadcastable_type, created_at, processed_html, title, type_of, updated_at) FROM stdin;
1	t	2020-11-17 14:29:43.696566	\N	\N	\N	Welcome	2020-11-17 14:29:43.696607	Welcome to DEV! 👋 I'm Sloan, the community mascot and I'm here to help get you started. Let's begin by <a href='/settings'>setting up your profile</a>!	Welcome Notification: set_up_profile	Welcome	2020-11-17 14:29:53.623017
2	t	2020-11-17 14:29:43.703303	\N	\N	\N	Welcome	2020-11-17 14:29:43.703324	Sloan here again! 👋 DEV is a friendly community. Why not introduce yourself by leaving a comment in <a href='/welcome'>the welcome thread</a>!	Welcome Notification: welcome_thread	Welcome	2020-11-17 14:29:53.626951
3	t	2020-11-17 14:29:43.708838	\N	\N	\N	Welcome	2020-11-17 14:29:43.708858	You're on a roll! 🎉 Do you have a Twitter account? Consider <a href='/settings'>connecting it</a> so we can @mention you if we share your post via our Twitter account <a href='https://twitter.com/thePracticalDev'>@thePracticalDev</a>.	Welcome Notification: twitter_connect	Welcome	2020-11-17 14:29:53.6308
4	t	2020-11-17 14:29:43.718083	\N	\N	\N	Welcome	2020-11-17 14:29:43.718121	You're on a roll! 🎉  Do you have a Facebook account? Consider <a href='/settings'>connecting it</a>.	Welcome Notification: facebook_connect	Welcome	2020-11-17 14:29:53.634469
5	t	2020-11-17 14:29:43.723535	\N	\N	\N	Welcome	2020-11-17 14:29:43.723553	You're on a roll! 🎉  Do you have a GitHub account? Consider <a href='/settings'>connecting it</a> so you can pin any of your repos to your profile.	Welcome Notification: github_connect	Welcome	2020-11-17 14:29:53.638137
6	t	2020-11-17 14:29:43.72817	\N	\N	\N	Welcome	2020-11-17 14:29:43.728189	Hi, it's me again! 👋 Now that you're a part of the DEV community, let's focus on personalizing your content. You can start by <a href='/tags'>following some tags</a> to help customize your feed! 🎉	Welcome Notification: customize_feed	Welcome	2020-11-17 14:29:53.641809
7	t	2020-11-17 14:29:43.733089	\N	\N	\N	Welcome	2020-11-17 14:29:43.733105	Sloan here! 👋 Did you know that that you can customize your DEV experience? Try changing <a href='settings/ux'>your font and theme</a> and find the best style for you!	Welcome Notification: customize_experience	Welcome	2020-11-17 14:29:53.645491
8	t	2020-11-17 14:29:43.73804	\N	\N	\N	Welcome	2020-11-17 14:29:43.738058	Sloan here! 👋 I noticed that you haven't <a href='https://dev.to/t/discuss'>started a discussion</a> yet. Starting a discussion is easy to do; just click on 'Write a Post' in the sidebar of the tag page to get started!	Welcome Notification: start_discussion	Welcome	2020-11-17 14:29:53.649296
9	t	2020-11-17 14:29:43.742711	\N	\N	\N	Welcome	2020-11-17 14:29:43.742727	Sloan here! 👋 I noticed that you haven't <a href='https://dev.to/t/explainlikeimfive'>asked a question</a> yet. Asking a question is easy to do; just click on 'Write a Post' in the sidebar of the tag page to get started!	Welcome Notification: ask_question	Welcome	2020-11-17 14:29:53.652906
10	t	2020-11-17 14:29:43.747258	\N	\N	\N	Welcome	2020-11-17 14:29:43.747311	Sloan here! 👋 I noticed that you haven't <a href='https://dev.to/t/explainlikeimfive'>asked a question</a> or <a href='https://dev.to/t/discuss'>started a discussion</a> yet. It's easy to do both of these; just click on 'Write a Post' in the sidebar of the tag page to get started!	Welcome Notification: discuss_and_ask	Welcome	2020-11-17 14:29:53.656594
11	t	2020-11-17 14:29:43.752057	\N	\N	\N	Welcome	2020-11-17 14:29:43.752072	Sloan here, with one last tip! 👋 Have you downloaded the DEV mobile app yet? Consider <a href='https://dev.to/downloads'>downloading</a> it so you can access all of your favorite DEV content on the go!	Welcome Notification: download_app	Welcome	2020-11-17 14:29:53.660246
\.


--
-- Data for Name: buffer_updates; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.buffer_updates (id, approver_user_id, article_id, body_text, buffer_id_code, buffer_profile_id_code, buffer_response, composer_user_id, created_at, social_service_name, status, tag_id, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_channel_memberships; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.chat_channel_memberships (id, chat_channel_id, created_at, has_unopened_messages, last_opened_at, role, show_global_badge_notification, status, updated_at, user_id) FROM stdin;
1	1	2020-11-17 14:29:38.456399	f	2017-01-01 05:00:00	mod	t	active	2020-11-17 14:29:38.456399	6
2	1	2020-11-17 14:29:38.484989	f	2017-01-01 05:00:00	member	t	active	2020-11-17 14:29:38.484989	5
3	1	2020-11-17 14:29:38.513837	f	2017-01-01 05:00:00	member	t	active	2020-11-17 14:29:38.513837	3
4	2	2020-11-17 14:29:38.542445	f	2017-01-01 05:00:00	mod	t	active	2020-11-17 14:29:38.542445	8
5	2	2020-11-17 14:29:38.582239	f	2017-01-01 05:00:00	member	t	active	2020-11-17 14:29:38.582239	9
6	2	2020-11-17 14:29:38.611189	f	2017-01-01 05:00:00	member	t	active	2020-11-17 14:29:38.611189	2
7	3	2020-11-17 14:29:38.64081	f	2017-01-01 05:00:00	mod	t	active	2020-11-17 14:29:38.64081	9
8	3	2020-11-17 14:29:38.672381	f	2017-01-01 05:00:00	member	t	active	2020-11-17 14:29:38.672381	1
9	3	2020-11-17 14:29:38.70284	f	2017-01-01 05:00:00	member	t	active	2020-11-17 14:29:38.70284	7
10	4	2020-12-02 14:02:01.997862	f	2017-01-01 05:00:00	mod	t	active	2020-12-02 14:02:01.997862	12
\.


--
-- Data for Name: chat_channels; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.chat_channels (id, channel_name, channel_type, created_at, description, discoverable, last_message_at, slug, status, updated_at) FROM stdin;
1	@org9645 private group chat	invite_only	2020-11-17 14:29:38.443234	\N	f	2020-11-10 14:29:38.434518	org9645-private-group-chat	active	2020-11-17 14:29:38.443234
2	@org9024 private group chat	invite_only	2020-11-17 14:29:38.537069	\N	f	2020-11-10 14:29:38.53598	org9024-private-group-chat	active	2020-11-17 14:29:38.537069
3	@org7530 private group chat	invite_only	2020-11-17 14:29:38.635187	\N	f	2020-11-10 14:29:38.633959	org7530-private-group-chat	active	2020-11-17 14:29:38.635187
4	@test-org private group chat	invite_only	2020-12-02 14:02:01.975696	\N	f	2020-11-25 14:02:01.964326	test-org-private-group-chat	active	2020-12-02 14:02:01.975696
\.


--
-- Data for Name: classified_listing_categories; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.classified_listing_categories (id, cost, created_at, name, rules, slug, social_preview_color, social_preview_description, updated_at) FROM stdin;
1	1	2020-11-17 14:29:45.37162	Conference CFP	Currently open for proposals, with link to form.	cfp	\N	\N	2020-11-17 14:29:45.37162
2	1	2020-11-17 14:29:45.37686	Education/Courses	Educational material and/or schools/bootcamps.	education	\N	\N	2020-11-17 14:29:45.37686
3	25	2020-11-17 14:29:45.381757	Job Listings	Companies offering employment right now.	jobs	\N	\N	2020-11-17 14:29:45.381757
4	1	2020-11-17 14:29:45.386502	Stuff for Sale	Personally owned physical items for sale.	forsale	\N	\N	2020-11-17 14:29:45.386502
5	1	2020-11-17 14:29:45.391552	Upcoming Events	In-person or online events with date included.	events	\N	\N	2020-11-17 14:29:45.391552
6	1	2020-11-17 14:29:45.398656	Miscellaneous	Must not fit in any other category.	misc	\N	\N	2020-11-17 14:29:45.398656
\.


--
-- Data for Name: classified_listing_endorsements; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.classified_listing_endorsements (id, approved, classified_listing_id, content, created_at, updated_at, user_id) FROM stdin;
1	f	12	Quam distinctio iure omnis.	2020-11-17 14:29:46.409753	2020-11-17 14:29:46.409753	7
2	f	4	Odit vero quaerat ullam.	2020-11-17 14:29:46.416172	2020-11-17 14:29:46.416172	11
3	f	11	Impedit rerum velit velit.	2020-11-17 14:29:46.421834	2020-11-17 14:29:46.421834	2
4	f	11	Laborum labore ea quas.	2020-11-17 14:29:46.427453	2020-11-17 14:29:46.427453	10
5	f	1	Natus est ea molestiae.	2020-11-17 14:29:46.434054	2020-11-17 14:29:46.434054	8
\.


--
-- Data for Name: classified_listings; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.classified_listings (id, body_markdown, bumped_at, cached_tag_list, classified_listing_category_id, contact_via_connect, created_at, expires_at, last_buffered, location, organization_id, originally_published_at, processed_html, published, slug, title, updated_at, user_id) FROM stdin;
1	```ruby\nId.\n```	2020-11-17 14:29:46.008795	security, discuss	1	t	2020-11-17 14:29:46.030329	\N	\N	Piperton	3	2020-11-17 14:29:46.030329	<pre class="highlight ruby"><code><span class="no">Id</span><span class="o">.</span>\n</code></pre>	t	odio-error-a-esse-4f2g	Odio error a esse.	2020-11-17 14:29:56.135824	1
2	`Explicabo.`	2020-11-17 14:29:46.060596	discuss, go	1	t	2020-11-17 14:29:46.067783	\N	\N	Veumtown	3	2020-11-17 14:29:46.067783	<p><code>Explicabo.</code></p>\n	t	nihil-sed-vero-eveniet-284e	Nihil sed vero eveniet.	2020-11-17 14:29:56.155533	1
3	###### Perferendis	2020-11-17 14:29:46.091305	career, welcome	2	t	2020-11-17 14:29:46.097478	\N	\N	Kingfurt	3	2020-11-17 14:29:46.097478	<h6>\n  <a href="#perferendis" class="anchor">\n  </a>\n  Perferendis\n</h6>\n	t	maiores-quod-assumenda-vero-f41	Maiores quod assumenda vero.	2020-11-17 14:29:56.174886	7
4	###### Ipsum	2020-11-17 14:29:46.118406	welcome, git	2	t	2020-11-17 14:29:46.124326	\N	\N	Lake Daneburgh	3	2020-11-17 14:29:46.124326	<h6>\n  <a href="#ipsum" class="anchor">\n  </a>\n  Ipsum\n</h6>\n	t	ipsum-commodi-omnis-nobis-ld6	Ipsum commodi omnis nobis.	2020-11-17 14:29:56.194451	7
5	Velit repudiandae ea. Voluptas *ea* vel. Sapiente perspiciatis aut.	2020-11-17 14:29:46.145703	career, welcome	3	t	2020-11-17 14:29:46.151624	\N	\N	Fernandoview	2	2020-11-17 14:29:46.151624	<p>Velit repudiandae ea. Voluptas <em>ea</em> vel. Sapiente perspiciatis aut.</p>\n	t	nisi-impedit-qui-mollitia-3aa5	Nisi impedit qui mollitia.	2020-11-17 14:29:56.213225	8
6	* Itaque. \n* Molestiae. \n* Repellendus. \n* Et. \n* Voluptatum. \n* Officia. \n* Ad. \n* Praesentium. \n* Reiciendis. \n	2020-11-17 14:29:46.175005	webdev, computerscience	3	t	2020-11-17 14:29:46.1879	\N	\N	South Elihaven	2	2020-11-17 14:29:46.1879	<ul>\n<li>Itaque. </li>\n<li>Molestiae. </li>\n<li>Repellendus. </li>\n<li>Et. </li>\n<li>Voluptatum. </li>\n<li>Officia. </li>\n<li>Ad. </li>\n<li>Praesentium. </li>\n<li>Reiciendis. </li>\n</ul>\n	t	fugiat-alias-tenetur-nihil-3pc0	Fugiat alias tenetur nihil.	2020-11-17 14:29:56.236554	8
7	Aliquam exercitationem et. Ut laboriosam nulla. *Esse* velit et.	2020-11-17 14:29:46.212377	webdev, java	4	t	2020-11-17 14:29:46.219567	\N	\N	Marshallfurt	\N	2020-11-17 14:29:46.219567	<p>Aliquam exercitationem et. Ut laboriosam nulla. <em>Esse</em> velit et.</p>\n	t	quibusdam-officiis-est-consequatur-2h96	Quibusdam officiis est consequatur.	2020-11-17 14:29:56.255247	4
8	0. Nostrum. \n1. Sed. \n2. Eum. \n3. Iure. \n4. Inventore. \n5. Vel. \n6. Veritatis. \n7. Voluptatibus. \n8. Consequatur. \n	2020-11-17 14:29:46.243325	beginners, javascript	4	t	2020-11-17 14:29:46.251127	\N	\N	West Genevie	\N	2020-11-17 14:29:46.251127	<ol>\n<li>Nostrum. </li>\n<li>Sed. </li>\n<li>Eum. </li>\n<li>Iure. </li>\n<li>Inventore. </li>\n<li>Vel. </li>\n<li>Veritatis. </li>\n<li>Voluptatibus. </li>\n<li>Consequatur. </li>\n</ol>\n	t	est-veniam-sed-voluptatibus-3i59	Est veniam sed voluptatibus.	2020-11-17 14:29:56.274095	4
9	```ruby\nExplicabo.\n```	2020-11-17 14:29:46.277637	java, discuss	5	t	2020-11-17 14:29:46.285033	\N	\N	Emileland	1	2020-11-17 14:29:46.285033	<pre class="highlight ruby"><code><span class="no">Explicabo</span><span class="o">.</span>\n</code></pre>	t	culpa-cupiditate-aperiam-officia-1b45	Culpa cupiditate aperiam officia.	2020-11-17 14:29:56.293439	5
10	0. Excepturi. \n1. Aperiam. \n	2020-11-17 14:29:46.307333	security, productivity	5	t	2020-11-17 14:29:46.313322	\N	\N	Adellfort	1	2020-11-17 14:29:46.313322	<ol>\n<li>Excepturi. </li>\n<li>Aperiam. </li>\n</ol>\n	t	velit-voluptatem-expedita-nobis-57m	Velit voluptatem expedita nobis.	2020-11-17 14:29:56.312448	5
11	```ruby\nVelit.\n```	2020-11-17 14:29:46.335419	go, java	6	t	2020-11-17 14:29:46.341617	\N	\N	Simonisberg	\N	2020-11-17 14:29:46.341617	<pre class="highlight ruby"><code><span class="no">Velit</span><span class="o">.</span>\n</code></pre>	t	est-perferendis-ut-similique-36nh	Est perferendis ut similique.	2020-11-17 14:29:56.335384	10
12	#### Consequatur	2020-11-17 14:29:46.364347	go, javascript	6	t	2020-11-17 14:29:46.370567	\N	\N	Leroyberg	\N	2020-11-17 14:29:46.370567	<h4>\n  <a href="#consequatur" class="anchor">\n  </a>\n  Consequatur\n</h4>\n	t	eveniet-repellendus-qui-a-302d	Eveniet repellendus qui a.	2020-11-17 14:29:56.362098	10
\.


--
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.collections (id, created_at, description, main_image, organization_id, published, slug, social_image, title, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.comments (id, ancestry, body_html, body_markdown, commentable_id, commentable_type, created_at, deleted, edited, edited_at, hidden_by_commentable_user, id_code, markdown_character_count, positive_reactions_count, processed_html, public_reactions_count, reactions_count, receive_notifications, score, spaminess_rating, updated_at, user_id) FROM stdin;
19	\N	\N	Next level chambray ennui butcher.	18	Article	2020-11-17 14:29:42.634196	f	f	\N	f	j	34	0	<p>Next level chambray ennui butcher.</p>\n\n	1	0	t	0	0	2020-11-25 14:05:54.700675	10
1	\N	\N	Cray artisan health tofu intelligentsia.	9	Article	2020-11-17 14:29:41.5533	f	f	\N	f	1	40	0	<p>Cray artisan health tofu intelligentsia.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:24.56664	8
16	\N	\N	Bushwick vice goth celiac. Disrupt cleanse meh truffaut ramps. Ethical meggings farm-to-table.	14	Article	2020-11-17 14:29:42.461799	f	f	\N	f	g	94	0	<p>Bushwick vice goth celiac. Disrupt cleanse meh truffaut ramps. Ethical meggings farm-to-table.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:24.576886	10
8	\N	\N	Mumblecore umami twee polaroid dreamcatcher. 90's vice swag ethical kitsch you probably haven't heard of them vhs art party. Tousled park typewriter fixie occupy heirloom wayfarers.	23	Article	2020-11-17 14:29:41.995084	f	f	\N	f	8	181	0	<p>Mumblecore umami twee polaroid dreamcatcher. 90's vice swag ethical kitsch you probably haven't heard of them vhs art party. Tousled park typewriter fixie occupy heirloom wayfarers.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:34.886373	1
17	\N	\N	Wayfarers chambray letterpress. Sustainable migas stumptown bushwick.	8	Article	2020-11-17 14:29:42.516444	f	f	\N	f	h	69	0	<p>Wayfarers chambray letterpress. Sustainable migas stumptown bushwick.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:34.88827	9
20	\N	\N	Literally green juice wayfarers diy vhs pour-over.	15	Article	2020-11-17 14:29:42.68967	f	f	\N	f	k	50	0	<p>Literally green juice wayfarers diy vhs pour-over.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:07.627844	6
21	\N	\N	Raw denim selfies taxidermy post-ironic humblebrag authentic echo. 8-bit diy austin cold-pressed. Chambray selvage normcore godard small batch kinfolk cardigan.	7	Article	2020-11-17 14:29:42.746194	f	f	\N	f	l	160	0	<p>Raw denim selfies taxidermy post-ironic humblebrag authentic echo. 8-bit diy austin cold-pressed. Chambray selvage normcore godard small batch kinfolk cardigan.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:13.961231	9
18	\N	\N	Green juice pabst waistcoat swag selfies 3 wolf moon.	8	Article	2020-11-17 14:29:42.573097	f	f	\N	f	i	53	0	<p>Green juice pabst waistcoat swag selfies 3 wolf moon.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:17.523599	8
12	\N	\N	Vhs selfies lumbersexual art party hoodie.	3	Article	2020-11-17 14:29:42.227289	f	f	\N	f	c	42	0	<p>Vhs selfies lumbersexual art party hoodie.</p>\n\n	1	0	t	0	0	2020-11-25 14:04:55.778108	6
5	\N	\N	Skateboard listicle craft beer meditation franzen photo booth.	18	Article	2020-11-17 14:29:41.817109	f	f	\N	f	5	62	0	<p>Skateboard listicle craft beer meditation franzen photo booth.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:24.528658	2
3	\N	\N	Typewriter helvetica muggle magic meh chia narwhal. Everyday narwhal organic. Twee cardigan flexitarian diy small batch franzen yuccie paleo.	21	Article	2020-11-17 14:29:41.702826	f	f	\N	f	3	141	0	<p>Typewriter helvetica muggle magic meh chia narwhal. Everyday narwhal organic. Twee cardigan flexitarian diy small batch franzen yuccie paleo.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:24.570772	6
4	\N	\N	Bicycle rights chambray loko gastropub. Craft beer gentrify keffiyeh. Salvia squid aesthetic meditation flannel pitchfork wolf gentrify.	18	Article	2020-11-17 14:29:41.759771	f	f	\N	f	4	136	0	<p>Bicycle rights chambray loko gastropub. Craft beer gentrify keffiyeh. Salvia squid aesthetic meditation flannel pitchfork wolf gentrify.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:48.309392	9
15	\N	\N	Health green juice locavore. Flannel microdosing shoreditch lumbersexual pitchfork swag. Authentic tattooed goth photo booth.	21	Article	2020-11-17 14:29:42.40135	f	f	\N	f	f	125	0	<p>Health green juice locavore. Flannel microdosing shoreditch lumbersexual pitchfork swag. Authentic tattooed goth photo booth.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:13.954521	2
23	\N	\N	Plaid try-hard austin authentic crucifix portland muggle magic. Chicharrones keytar keffiyeh quinoa fixie messenger bag.	11	Article	2020-11-17 14:29:42.864205	f	f	\N	f	n	120	0	<p>Plaid try-hard austin authentic crucifix portland muggle magic. Chicharrones keytar keffiyeh quinoa fixie messenger bag.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:13.986791	10
22	\N	\N	Health godard paleo normcore. Cronut actually helvetica wayfarers messenger bag hoodie asymmetrical. Viral irony pork belly gluten-free drinking humblebrag bicycle rights.	21	Article	2020-11-17 14:29:42.807939	f	f	\N	f	m	171	0	<p>Health godard paleo normcore. Cronut actually helvetica wayfarers messenger bag hoodie asymmetrical. Viral irony pork belly gluten-free drinking humblebrag bicycle rights.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:17.525661	10
9	\N	\N	Raw denim pop-up intelligentsia narwhal iphone. Trust fund semiotics hoodie.	1	Article	2020-11-17 14:29:42.057449	f	f	\N	f	9	76	0	<p>Raw denim pop-up intelligentsia narwhal iphone. Trust fund semiotics hoodie.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:22.788495	6
29	\N	\N	Blog flannel before they sold out. Direct trade vinegar taxidermy.	4	Article	2020-11-17 14:29:43.215653	f	f	\N	f	13	66	0	<p>Blog flannel before they sold out. Direct trade vinegar taxidermy.</p>\n\n	1	0	t	0	0	2020-11-25 14:04:10.731831	10
10	\N	\N	Farm-to-table plaid everyday meggings marfa wolf meditation bushwick. Lomo cornhole semiotics sriracha muggle magic skateboard bitters. Tacos health ennui yolo brunch chillwave deep v.	10	Article	2020-11-17 14:29:42.114465	f	f	\N	f	a	184	0	<p>Farm-to-table plaid everyday meggings marfa wolf meditation bushwick. Lomo cornhole semiotics sriracha muggle magic skateboard bitters. Tacos health ennui yolo brunch chillwave deep v.</p>\n\n	1	0	t	0	0	2020-11-25 14:04:39.502529	3
6	\N	\N	Bicycle rights 3 wolf moon austin occupy.	1	Article	2020-11-17 14:29:41.880439	f	f	\N	f	6	41	0	<p>Bicycle rights 3 wolf moon austin occupy.</p>\n\n	1	0	t	0	0	2020-11-25 14:05:48.115063	6
7	\N	\N	Bitters thundercats vice locavore pbr&b.	18	Article	2020-11-17 14:29:41.936825	f	f	\N	f	7	40	0	<p>Bitters thundercats vice locavore pbr&amp;b.</p>\n\n	1	0	t	0	0	2020-11-25 14:05:54.729072	10
2	\N	\N	Next level health forage you probably haven't heard of them echo leggings shabby chic chia. Fixie lumbersexual pickled kombucha art party. Celiac heirloom tacos.	10	Article	2020-11-17 14:29:41.635418	f	f	\N	f	2	161	0	<p>Next level health forage you probably haven't heard of them echo leggings shabby chic chia. Fixie lumbersexual pickled kombucha art party. Celiac heirloom tacos.</p>\n\n	1	0	t	0	0	2020-11-25 14:05:54.754738	10
11	\N	\N	Cleanse keytar listicle muggle magic. Trust fund hammock pickled 90's celiac before they sold out ennui mumblecore.	16	Article	2020-11-17 14:29:42.170334	f	f	\N	f	b	115	0	<p>Cleanse keytar listicle muggle magic. Trust fund hammock pickled 90's celiac before they sold out ennui mumblecore.</p>\n\n	1	0	t	0	0	2020-11-25 14:05:24.679434	11
24	\N	\N	Roof drinking waistcoat hammock keytar jean shorts chartreuse aesthetic. Meditation literally knausgaard bitters shoreditch etsy.	16	Article	2020-11-17 14:29:42.919355	f	f	\N	f	o	129	0	<p>Roof drinking waistcoat hammock keytar jean shorts chartreuse aesthetic. Meditation literally knausgaard bitters shoreditch etsy.</p>\n\n	1	0	t	0	0	2020-11-25 14:04:19.930345	1
28	\N	\N	Banjo cleanse umami schlitz five dollar toast cray. Schlitz crucifix viral mixtape jean shorts narwhal seitan tote bag.	10	Article	2020-11-17 14:29:43.158269	f	f	\N	f	12	119	0	<p>Banjo cleanse umami schlitz five dollar toast cray. Schlitz crucifix viral mixtape jean shorts narwhal seitan tote bag.</p>\n\n	1	0	t	0	0	2020-11-25 14:05:54.717906	7
30	\N	\N	Franzen ugh meh godard tattooed muggle magic. Bicycle rights godard mlkshk banh mi typewriter chillwave tumblr. Mustache hashtag mlkshk kickstarter ethical.	7	Article	2020-11-17 14:29:43.270985	f	f	\N	f	14	156	0	<p>Franzen ugh meh godard tattooed muggle magic. Bicycle rights godard mlkshk banh mi typewriter chillwave tumblr. Mustache hashtag mlkshk kickstarter ethical.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:00.826644	9
27	\N	\N	Keytar hoodie single-origin coffee vegan pour-over thundercats small batch. Xoxo scenester craft beer.	24	Article	2020-11-17 14:29:43.095479	f	f	\N	f	11	102	0	<p>Keytar hoodie single-origin coffee vegan pour-over thundercats small batch. Xoxo scenester craft beer.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:24.552683	5
14	\N	\N	Chicharrones keffiyeh kickstarter godard fixie hashtag twee xoxo. Park vhs hoodie hashtag muggle magic butcher chillwave yolo. Trust fund kale chips pickled you probably haven't heard of them fixie franzen.	21	Article	2020-11-17 14:29:42.342048	f	f	\N	f	e	206	0	<p>Chicharrones keffiyeh kickstarter godard fixie hashtag twee xoxo. Park vhs hoodie hashtag muggle magic butcher chillwave yolo. Trust fund kale chips pickled you probably haven't heard of them fixie franzen.</p>\n\n	1	0	t	0	0	2020-11-25 14:06:55.352455	9
26	\N	\N	Crucifix tilde vegan hella cred actually. Keffiyeh wayfarers cred fanny pack hammock brunch locavore.	3	Article	2020-11-17 14:29:43.03868	f	f	\N	f	10	101	0	<p>Crucifix tilde vegan hella cred actually. Keffiyeh wayfarers cred fanny pack hammock brunch locavore.</p>\n\n	1	0	t	0	0	2020-11-25 14:07:07.629358	5
13	\N	\N	Messenger bag mumblecore lo-fi flexitarian taxidermy selfies.	22	Article	2020-11-17 14:29:42.286342	f	f	\N	f	d	61	0	<p>Messenger bag mumblecore lo-fi flexitarian taxidermy selfies.</p>\n\n	1	0	t	0	0	2020-11-25 14:08:10.716728	10
25	\N	\N	Stumptown next level dreamcatcher franzen scenester photo booth cliche green juice. Muggle magic seitan cornhole try-hard microdosing irony.	10	Article	2020-11-17 14:29:42.981834	f	f	\N	f	p	140	0	<p>Stumptown next level dreamcatcher franzen scenester photo booth cliche green juice. Muggle magic seitan cornhole try-hard microdosing irony.</p>\n\n	1	0	t	0	0	2020-11-25 14:08:22.513095	3
\.


--
-- Data for Name: credits; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.credits (id, cost, created_at, organization_id, purchase_id, purchase_type, spent, spent_at, updated_at, user_id) FROM stdin;
1	0	2020-11-17 14:29:44.413257	\N	\N	\N	f	\N	2020-11-17 14:29:44.413257	2
2	0	2020-11-17 14:29:44.413257	\N	\N	\N	f	\N	2020-11-17 14:29:44.413257	2
3	0	2020-11-17 14:29:44.413257	\N	\N	\N	f	\N	2020-11-17 14:29:44.413257	2
4	0	2020-11-17 14:29:44.413257	\N	\N	\N	f	\N	2020-11-17 14:29:44.413257	2
5	0	2020-11-17 14:29:44.413257	\N	\N	\N	f	\N	2020-11-17 14:29:44.413257	2
6	0	2020-11-17 14:29:44.505747	\N	\N	\N	f	\N	2020-11-17 14:29:44.505747	1
7	0	2020-11-17 14:29:44.505747	\N	\N	\N	f	\N	2020-11-17 14:29:44.505747	1
8	0	2020-11-17 14:29:44.505747	\N	\N	\N	f	\N	2020-11-17 14:29:44.505747	1
9	0	2020-11-17 14:29:44.505747	\N	\N	\N	f	\N	2020-11-17 14:29:44.505747	1
10	0	2020-11-17 14:29:44.505747	\N	\N	\N	f	\N	2020-11-17 14:29:44.505747	1
11	0	2020-11-17 14:29:44.580891	\N	\N	\N	f	\N	2020-11-17 14:29:44.580891	9
12	0	2020-11-17 14:29:44.580891	\N	\N	\N	f	\N	2020-11-17 14:29:44.580891	9
13	0	2020-11-17 14:29:44.580891	\N	\N	\N	f	\N	2020-11-17 14:29:44.580891	9
14	0	2020-11-17 14:29:44.580891	\N	\N	\N	f	\N	2020-11-17 14:29:44.580891	9
15	0	2020-11-17 14:29:44.580891	\N	\N	\N	f	\N	2020-11-17 14:29:44.580891	9
16	0	2020-11-17 14:29:44.667621	\N	\N	\N	f	\N	2020-11-17 14:29:44.667621	4
17	0	2020-11-17 14:29:44.667621	\N	\N	\N	f	\N	2020-11-17 14:29:44.667621	4
18	0	2020-11-17 14:29:44.667621	\N	\N	\N	f	\N	2020-11-17 14:29:44.667621	4
19	0	2020-11-17 14:29:44.667621	\N	\N	\N	f	\N	2020-11-17 14:29:44.667621	4
20	0	2020-11-17 14:29:44.667621	\N	\N	\N	f	\N	2020-11-17 14:29:44.667621	4
21	0	2020-11-17 14:29:44.727448	\N	\N	\N	f	\N	2020-11-17 14:29:44.727448	3
22	0	2020-11-17 14:29:44.727448	\N	\N	\N	f	\N	2020-11-17 14:29:44.727448	3
23	0	2020-11-17 14:29:44.727448	\N	\N	\N	f	\N	2020-11-17 14:29:44.727448	3
24	0	2020-11-17 14:29:44.727448	\N	\N	\N	f	\N	2020-11-17 14:29:44.727448	3
25	0	2020-11-17 14:29:44.727448	\N	\N	\N	f	\N	2020-11-17 14:29:44.727448	3
26	0	2020-11-17 14:29:44.931495	\N	\N	\N	f	\N	2020-11-17 14:29:44.931495	10
27	0	2020-11-17 14:29:44.931495	\N	\N	\N	f	\N	2020-11-17 14:29:44.931495	10
28	0	2020-11-17 14:29:44.931495	\N	\N	\N	f	\N	2020-11-17 14:29:44.931495	10
29	0	2020-11-17 14:29:44.931495	\N	\N	\N	f	\N	2020-11-17 14:29:44.931495	10
30	0	2020-11-17 14:29:44.931495	\N	\N	\N	f	\N	2020-11-17 14:29:44.931495	10
31	0	2020-11-17 14:29:44.989716	\N	\N	\N	f	\N	2020-11-17 14:29:44.989716	11
32	0	2020-11-17 14:29:44.989716	\N	\N	\N	f	\N	2020-11-17 14:29:44.989716	11
33	0	2020-11-17 14:29:44.989716	\N	\N	\N	f	\N	2020-11-17 14:29:44.989716	11
34	0	2020-11-17 14:29:44.989716	\N	\N	\N	f	\N	2020-11-17 14:29:44.989716	11
35	0	2020-11-17 14:29:44.989716	\N	\N	\N	f	\N	2020-11-17 14:29:44.989716	11
36	0	2020-11-17 14:29:45.049813	\N	\N	\N	f	\N	2020-11-17 14:29:45.049813	6
37	0	2020-11-17 14:29:45.049813	\N	\N	\N	f	\N	2020-11-17 14:29:45.049813	6
38	0	2020-11-17 14:29:45.049813	\N	\N	\N	f	\N	2020-11-17 14:29:45.049813	6
39	0	2020-11-17 14:29:45.049813	\N	\N	\N	f	\N	2020-11-17 14:29:45.049813	6
40	0	2020-11-17 14:29:45.049813	\N	\N	\N	f	\N	2020-11-17 14:29:45.049813	6
41	0	2020-11-17 14:29:45.107712	\N	\N	\N	f	\N	2020-11-17 14:29:45.107712	5
42	0	2020-11-17 14:29:45.107712	\N	\N	\N	f	\N	2020-11-17 14:29:45.107712	5
43	0	2020-11-17 14:29:45.107712	\N	\N	\N	f	\N	2020-11-17 14:29:45.107712	5
44	0	2020-11-17 14:29:45.107712	\N	\N	\N	f	\N	2020-11-17 14:29:45.107712	5
45	0	2020-11-17 14:29:45.107712	\N	\N	\N	f	\N	2020-11-17 14:29:45.107712	5
46	0	2020-11-17 14:29:45.165246	\N	\N	\N	f	\N	2020-11-17 14:29:45.165246	8
47	0	2020-11-17 14:29:45.165246	\N	\N	\N	f	\N	2020-11-17 14:29:45.165246	8
48	0	2020-11-17 14:29:45.165246	\N	\N	\N	f	\N	2020-11-17 14:29:45.165246	8
49	0	2020-11-17 14:29:45.165246	\N	\N	\N	f	\N	2020-11-17 14:29:45.165246	8
50	0	2020-11-17 14:29:45.165246	\N	\N	\N	f	\N	2020-11-17 14:29:45.165246	8
51	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
52	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
53	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
54	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
55	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
56	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
57	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
58	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
59	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
60	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
61	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
62	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
63	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
64	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
65	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
66	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
67	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
68	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
69	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
70	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
71	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
72	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
73	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
74	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
75	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
76	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
77	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
78	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
79	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
80	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
81	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
82	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
83	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
84	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
85	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
86	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
87	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
88	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
89	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
90	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
91	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
92	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
93	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
94	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
95	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
96	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
97	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
98	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
99	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
100	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
101	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
102	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
103	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
104	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
105	0	2020-11-17 14:29:45.41498	\N	\N	\N	f	\N	2020-11-17 14:29:45.41498	9
106	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
107	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
108	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
109	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
110	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
111	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
112	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
113	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
114	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
115	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
116	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
117	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
118	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
119	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
120	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
121	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
122	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
123	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
124	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
125	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
126	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
127	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
128	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
129	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
130	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
131	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
132	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
133	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
134	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
135	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
136	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
137	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
138	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
139	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
140	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
141	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
142	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
143	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
144	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
145	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
146	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
147	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
148	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
149	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
150	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
151	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
152	0	2020-11-17 14:29:45.471881	\N	\N	\N	f	\N	2020-11-17 14:29:45.471881	1
153	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
154	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
155	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
156	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
157	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
158	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
159	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
160	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
161	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
162	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
163	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
164	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
165	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
166	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
167	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
168	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
169	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
170	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
171	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
172	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
173	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
174	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
175	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
176	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
177	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
178	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
179	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
180	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
181	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
182	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
183	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
184	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
185	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
186	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
187	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
188	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
189	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
190	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
191	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
192	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
193	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
194	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
195	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
196	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
197	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
198	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
199	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
200	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
201	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
202	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
203	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
204	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
205	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
206	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
207	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
208	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
209	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
210	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
211	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
212	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
213	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
214	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
215	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
216	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
217	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
218	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
219	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
220	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
221	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
222	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
223	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
224	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
225	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
226	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
227	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
228	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
229	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
230	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
231	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
232	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
233	0	2020-11-17 14:29:45.530242	\N	\N	\N	f	\N	2020-11-17 14:29:45.530242	7
234	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
235	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
236	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
237	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
238	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
239	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
240	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
241	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
242	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
243	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
244	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
245	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
246	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
247	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
248	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
249	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
250	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
251	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
252	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
253	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
254	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
255	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
256	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
257	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
258	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
259	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
260	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
261	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
262	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
263	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
264	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
265	0	2020-11-17 14:29:45.600074	\N	\N	\N	f	\N	2020-11-17 14:29:45.600074	8
266	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
267	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
268	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
269	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
270	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
271	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
272	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
273	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
274	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
275	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
276	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
277	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
278	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
279	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
280	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
281	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
282	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
283	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
284	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
285	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
286	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
287	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
288	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
289	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
290	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
291	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
292	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
293	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
294	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
295	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
296	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
297	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
298	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
299	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
300	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
301	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
302	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
303	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
304	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
305	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
306	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
307	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
308	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
309	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
310	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
311	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
312	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
313	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
314	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
315	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
316	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
317	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
318	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
319	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
320	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
321	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
322	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
323	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
324	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
325	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
326	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
327	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
328	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
329	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
330	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
331	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
332	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
333	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
334	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
335	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
336	0	2020-11-17 14:29:45.645948	\N	\N	\N	f	\N	2020-11-17 14:29:45.645948	4
337	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
338	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
339	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
340	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
341	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
342	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
343	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
344	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
345	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
346	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
347	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
348	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
349	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
350	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
351	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
352	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
353	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
354	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
355	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
356	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
357	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
358	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
359	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
360	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
361	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
362	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
363	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
364	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
365	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
366	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
367	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
368	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
369	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
370	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
371	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
372	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
373	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
374	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
375	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
376	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
377	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
378	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
379	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
380	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
381	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
382	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
383	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
384	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
385	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
386	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
387	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
388	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
389	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
390	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
391	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
392	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
393	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
394	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
395	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
396	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
397	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
398	0	2020-11-17 14:29:45.692697	\N	\N	\N	f	\N	2020-11-17 14:29:45.692697	5
399	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
400	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
401	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
402	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
403	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
404	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
405	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
406	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
407	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
408	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
409	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
410	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
411	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
412	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
413	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
414	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
415	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
416	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
417	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
418	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
419	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
420	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
421	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
422	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
423	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
424	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
425	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
426	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
427	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
428	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
429	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
430	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
431	0	2020-11-17 14:29:45.739367	\N	\N	\N	f	\N	2020-11-17 14:29:45.739367	10
432	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
433	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
434	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
435	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
436	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
437	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
438	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
439	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
440	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
441	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
442	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
443	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
444	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
445	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
446	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
447	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
448	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
449	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
450	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
451	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
452	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
453	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
454	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
455	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
456	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
457	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
458	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
459	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
460	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
461	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
462	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
463	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
464	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
465	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
466	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
467	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
468	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
469	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
470	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
471	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
472	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
473	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
474	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
475	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
476	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
477	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
478	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
479	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
480	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
481	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
482	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
483	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
484	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
485	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
486	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
487	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
488	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
489	0	2020-11-17 14:29:45.788937	\N	\N	\N	f	\N	2020-11-17 14:29:45.788937	2
490	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
491	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
492	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
493	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
494	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
495	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
496	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
497	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
498	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
499	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
500	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
501	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
502	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
503	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
504	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
505	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
506	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
507	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
508	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
509	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
510	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
511	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
512	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
513	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
514	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
515	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
516	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
517	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
518	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
519	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
520	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
521	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
522	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
523	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
524	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
525	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
526	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
527	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
528	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
529	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
530	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
531	0	2020-11-17 14:29:45.83581	\N	\N	\N	f	\N	2020-11-17 14:29:45.83581	6
532	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
533	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
534	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
535	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
536	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
537	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
538	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
539	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
540	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
541	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
542	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
543	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
544	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
545	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
546	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
547	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
548	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
549	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
550	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
551	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
552	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
553	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
554	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
555	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
556	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
557	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
558	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
559	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
560	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
561	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
562	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
563	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
564	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
565	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
566	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
567	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
568	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
569	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
570	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
571	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
572	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
573	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
574	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
575	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
576	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
577	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
578	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
579	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
580	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
581	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
582	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
583	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
584	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
585	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
586	0	2020-11-17 14:29:45.882766	\N	\N	\N	f	\N	2020-11-17 14:29:45.882766	11
587	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
588	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
589	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
590	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
591	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
592	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
593	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
594	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
595	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
596	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
597	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
598	0	2020-11-17 14:29:45.940105	\N	\N	\N	f	\N	2020-11-17 14:29:45.940105	3
599	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
600	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
601	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
602	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
603	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
604	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
605	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
606	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
607	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
608	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
609	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
610	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
611	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
612	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
613	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
614	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
615	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
616	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
617	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
618	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
619	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
620	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
621	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
622	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
623	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
624	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
625	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
626	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
627	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
628	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
629	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
630	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
631	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
632	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
633	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
634	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
635	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
636	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
637	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
638	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
639	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
640	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
641	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
642	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
643	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
644	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
645	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
646	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
647	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
648	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
649	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
650	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
651	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
652	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
653	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
654	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
655	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
656	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
657	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
658	0	2020-11-30 11:33:21.903635	\N	\N	\N	f	\N	2020-11-30 11:33:21.903635	12
\.


--
-- Data for Name: custom_profile_fields; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.custom_profile_fields (id, attribute_name, created_at, description, label, profile_id, updated_at) FROM stdin;
\.


--
-- Data for Name: data_update_scripts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.data_update_scripts (id, created_at, file_name, finished_at, run_at, status, updated_at) FROM stdin;
63	2020-11-17 14:29:47.088365	20200217131245_re_index_existing_articles_with_approved	2020-11-17 14:29:47.155252	2020-11-17 14:29:47.149558	2	2020-11-17 14:29:47.157238
29	2020-11-17 14:29:47.088365	20200217215802_index_listings_to_elasticsearch	2020-11-17 14:29:47.167532	2020-11-17 14:29:47.16118	2	2020-11-17 14:29:47.169831
11	2020-11-17 14:29:47.088365	20200226193303_backfill_column_for_broadcasts	2020-11-17 14:29:52.818426	2020-11-17 14:29:52.810472	2	2020-11-17 14:29:52.820677
17	2020-11-17 14:29:47.088365	20200305201627_index_users_to_elasticsearch	2020-11-17 14:29:52.827785	2020-11-17 14:29:52.822925	2	2020-11-17 14:29:52.82982
32	2020-11-17 14:29:47.088365	20200305201642_index_feed_content_to_elasticsearch	2020-11-17 14:29:52.839104	2020-11-17 14:29:52.833606	2	2020-11-17 14:29:52.841083
66	2020-11-17 14:29:47.088365	20200313123108_index_users_to_elasticsearch	2020-11-17 14:29:52.849971	2020-11-17 14:29:52.844672	2	2020-11-17 14:29:52.851996
64	2020-11-17 14:29:47.088365	20200326145114_re_index_feed_content_to_elasticsearch	2020-11-17 14:29:53.280056	2020-11-17 14:29:53.275098	2	2020-11-17 14:29:53.282084
53	2020-11-17 14:29:47.088365	20200406213152_re_index_users_to_elasticsearch	2020-11-17 14:29:53.291325	2020-11-17 14:29:53.28592	2	2020-11-17 14:29:53.294719
40	2020-11-17 14:29:47.088365	20200410152018_resync_elasticsearch_documents	2020-11-17 14:29:53.508588	2020-11-17 14:29:53.296961	2	2020-11-17 14:29:53.510799
46	2020-11-17 14:29:47.088365	20200415200651_index_reading_list_reactions	2020-11-17 14:29:53.518099	2020-11-17 14:29:53.513218	2	2020-11-17 14:29:53.520168
72	2020-11-17 14:29:47.088365	20200503134234_remove_github_issues	2020-11-17 14:29:53.535275	2020-11-17 14:29:53.523686	2	2020-11-17 14:29:53.537057
38	2020-11-17 14:29:47.088365	20200519142908_re_index_feed_content_and_users_to_elasticsearch	2020-11-17 14:29:53.572768	2020-11-17 14:29:53.549551	2	2020-11-17 14:29:53.574648
4	2020-11-17 14:29:47.088365	20200526181850_update_public_reaction_counts_again	2020-11-17 14:29:53.590716	2020-11-17 14:29:53.576955	2	2020-11-17 14:29:53.592751
50	2020-11-17 14:29:47.088365	20200530085153_backfill_broadcasts_timestamps	2020-11-17 14:29:53.601283	2020-11-17 14:29:53.594995	2	2020-11-17 14:29:53.603102
10	2020-11-17 14:29:47.088365	20200723070918_update_articles_cached_entities	2020-11-17 14:29:55.043923	2020-11-17 14:29:53.679406	2	2020-11-17 14:29:55.045855
43	2020-11-17 14:29:47.088365	20200729120730_remove_orphaned_ahoy_events	2020-11-17 14:29:55.052501	2020-11-17 14:29:55.047949	2	2020-11-17 14:29:55.054452
62	2020-11-17 14:29:47.088365	20200813072205_remove_orphaned_display_ad_events	2020-11-17 14:29:55.35038	2020-11-17 14:29:55.340596	2	2020-11-17 14:29:55.35293
39	2020-11-17 14:29:47.088365	20200818170410_remove_orphaned_poll_votes	2020-11-17 14:29:55.373289	2020-11-17 14:29:55.365557	2	2020-11-17 14:29:55.375436
31	2020-11-17 14:29:47.088365	20200818170433_remove_orphaned_poll_skips	2020-11-17 14:29:55.38421	2020-11-17 14:29:55.377899	2	2020-11-17 14:29:55.386375
48	2020-11-17 14:29:47.088365	20200818170505_remove_orphaned_poll_options	2020-11-17 14:29:55.394588	2020-11-17 14:29:55.388486	2	2020-11-17 14:29:55.396599
70	2020-11-17 14:29:47.088365	20200819025131_migrate_profile_data	2020-11-17 14:29:55.451906	2020-11-17 14:29:55.408892	2	2020-11-17 14:29:55.454087
12	2020-11-17 14:29:47.088365	20200820153340_insert_facebook_connect_broadcast_message	2020-11-17 14:29:55.464679	2020-11-17 14:29:55.457587	2	2020-11-17 14:29:55.466645
52	2020-11-17 14:29:47.088365	20200821103305_nullify_orphaned_collections_by_organization	2020-11-17 14:29:55.483927	2020-11-17 14:29:55.478314	2	2020-11-17 14:29:55.485818
65	2020-11-17 14:29:47.088365	20200821103405_remove_orphaned_credits_by_organization	2020-11-17 14:29:55.495239	2020-11-17 14:29:55.488831	2	2020-11-17 14:29:55.497169
42	2020-11-17 14:29:47.088365	20200821103718_remove_orphaned_display_ads_by_organization	2020-11-17 14:29:55.504828	2020-11-17 14:29:55.499575	2	2020-11-17 14:29:55.506615
55	2020-11-17 14:29:47.088365	20200821103834_remove_orphaned_listings_by_organization	2020-11-17 14:29:55.515637	2020-11-17 14:29:55.509898	2	2020-11-17 14:29:55.517539
24	2020-11-17 14:29:47.088365	20200822082229_remove_orphaned_notifications_by_organization	2020-11-17 14:29:55.528787	2020-11-17 14:29:55.520847	2	2020-11-17 14:29:55.531187
71	2020-11-17 14:29:47.088365	20200825095512_nullify_orphaned_comments_by_article	2020-11-17 14:29:55.562261	2020-11-17 14:29:55.556937	2	2020-11-17 14:29:55.564158
23	2020-11-17 14:29:47.088365	20200825103119_remove_orphaned_profile_pins_by_article	2020-11-17 14:29:55.593104	2020-11-17 14:29:55.58755	2	2020-11-17 14:29:55.595264
18	2020-11-17 14:29:47.088365	20200825103244_remove_orphaned_rating_votes_by_article	2020-11-17 14:29:55.602809	2020-11-17 14:29:55.597284	2	2020-11-17 14:29:55.60535
45	2020-11-17 14:29:47.088365	20200826075937_migrate_profile_field_groups	2020-11-17 14:29:55.612378	2020-11-17 14:29:55.607506	2	2020-11-17 14:29:55.614233
59	2020-11-17 14:29:47.088365	20200826092816_remove_orphaned_notes_by_user	2020-11-17 14:29:55.624969	2020-11-17 14:29:55.61842	2	2020-11-17 14:29:55.626985
68	2020-11-17 14:29:47.088365	20200826140317_remove_orphaned_articles_by_user	2020-11-17 14:29:55.64461	2020-11-17 14:29:55.639303	2	2020-11-17 14:29:55.646504
22	2020-11-17 14:29:47.088365	20200826140924_remove_orphaned_credits_by_user	2020-11-17 14:29:55.666108	2020-11-17 14:29:55.659377	2	2020-11-17 14:29:55.668116
27	2020-11-17 14:29:47.088365	20200826141015_remove_orphaned_github_repos_by_user	2020-11-17 14:29:55.676363	2020-11-17 14:29:55.67046	2	2020-11-17 14:29:55.679563
16	2020-11-17 14:29:47.088365	20200826141105_remove_orphaned_mentions_by_user	2020-11-17 14:29:55.688548	2020-11-17 14:29:55.682299	2	2020-11-17 14:29:55.690485
6	2020-11-17 14:29:47.088365	20200826141145_remove_orphaned_organization_memberships_by_user	2020-11-17 14:29:55.697995	2020-11-17 14:29:55.692501	2	2020-11-17 14:29:55.700502
56	2020-11-17 14:29:47.088365	20200826141550_nullify_orphaned_rating_votes_by_user	2020-11-17 14:29:55.718617	2020-11-17 14:29:55.712639	2	2020-11-17 14:29:55.720783
28	2020-11-17 14:29:47.088365	20200826141652_remove_orphaned_reactions_by_user	2020-11-17 14:29:55.729373	2020-11-17 14:29:55.722968	2	2020-11-17 14:29:55.731381
67	2020-11-17 14:29:47.088365	20200901085230_remove_draft_articles_with_duplicate_canonical_url	2020-11-17 14:29:56.007057	2020-11-17 14:29:55.993286	2	2020-11-17 14:29:56.010176
7	2020-11-17 14:29:47.088365	20200901194251_reindex_reading_list_reactions	2020-11-17 14:29:56.019404	2020-11-17 14:29:56.013987	2	2020-11-17 14:29:56.021685
19	2020-11-17 14:29:47.088365	20200904141057_cleanup_articles_with_invalid_feed_source_url	2020-11-17 14:29:56.04705	2020-11-17 14:29:56.038521	2	2020-11-17 14:29:56.049077
15	2020-11-17 14:29:47.088365	20200910135958_remove_draft_articles_with_duplicate_user_id_title_body_markdown	2020-11-17 14:29:56.057363	2020-11-17 14:29:56.051313	2	2020-11-17 14:29:56.059391
25	2020-11-17 14:29:47.088365	20200910140109_cleanup_published_articles_with_duplicate_user_id_title_body_markdown	2020-11-17 14:29:56.070337	2020-11-17 14:29:56.06159	2	2020-11-17 14:29:56.072277
58	2020-11-17 14:29:47.088365	20200911045602_reindex_articles_with_videos	2020-11-17 14:29:56.08071	2020-11-17 14:29:56.07428	2	2020-11-17 14:29:56.08273
61	2020-11-17 14:29:47.088365	20200914042434_reindex_users_for_profiles	2020-11-17 14:29:56.090132	2020-11-17 14:29:56.084925	2	2020-11-17 14:29:56.104014
5	2020-11-17 14:29:47.088365	20200916202343_backfill_co_author_ids_for_articles	2020-11-17 14:29:56.116933	2020-11-17 14:29:56.106393	2	2020-11-17 14:29:56.118989
69	2020-11-17 14:29:47.088365	20200917150808_nullify_orphaned_tags_by_mod_chat_channel_id	2020-11-17 14:29:56.394791	2020-11-17 14:29:56.388282	2	2020-11-17 14:29:56.397873
36	2020-11-17 14:29:47.088365	20200917150838_nullify_orphaned_feedback_messages_by_reporter_id	2020-11-17 14:29:56.406023	2020-11-17 14:29:56.400155	2	2020-11-17 14:29:56.407999
2	2020-11-17 14:29:47.088365	20200922065307_fix_dribbble_url_profile_field	2020-11-17 14:29:56.416065	2020-11-17 14:29:56.409941	2	2020-11-17 14:29:56.418057
20	2020-11-17 14:29:47.088365	20200924140813_remove_reaction_index_by_name	2020-11-17 14:29:56.484542	2020-11-17 14:29:56.430418	2	2020-11-17 14:29:56.487062
1	2020-11-17 14:29:47.088365	20201001173841_add_navigation_links	2020-11-17 14:29:56.524633	2020-11-17 14:29:56.489592	2	2020-11-17 14:29:56.526832
60	2020-11-17 14:29:47.088365	20201015190914_update_article_main_image_path	2020-11-17 14:29:56.55656	2020-11-17 14:29:56.551475	2	2020-11-17 14:29:56.558597
8	2020-11-17 14:29:47.088365	20201019163242_resave_articles_and_comments_for_imgproxy	2020-11-17 14:29:56.569242	2020-11-17 14:29:56.562525	2	2020-11-17 14:29:56.572208
35	2020-11-17 14:29:47.088365	20201019192035_backfill_registered_for_users	2020-11-17 14:29:56.581445	2020-11-17 14:29:56.574606	2	2020-11-17 14:29:56.583317
57	2020-11-17 14:29:47.088365	20201020215535_resave_articles_and_comments_for_imgproxy	2020-11-17 14:29:56.590536	2020-11-17 14:29:56.5853	2	2020-11-17 14:29:56.592547
26	2020-11-17 14:29:47.088365	20201030015634_make_tags_with_mods_supported	2020-11-17 14:29:56.623898	2020-11-17 14:29:56.617951	2	2020-11-17 14:29:56.625954
41	2020-11-17 14:29:47.088365	20201030134117_reindex_users_for_username_search	2020-11-17 14:29:56.641045	2020-11-17 14:29:56.628169	2	2020-11-17 14:29:56.643072
21	2020-11-17 14:29:47.088365	20201103050112_prepare_for_profile_column_drop	2020-11-17 14:29:56.902881	2020-11-17 14:29:56.645439	2	2020-11-17 14:29:56.90549
54	2020-11-17 14:29:47.088365	20200214171607_index_tags_to_elasticsearch	2020-11-17 14:29:47.138505	2020-11-17 14:29:47.131497	2	2020-11-17 14:29:47.140854
14	2020-11-17 14:29:47.088365	20200218195023_index_chat_channel_memberships_to_elasticsearch	2020-11-17 14:29:52.78209	2020-11-17 14:29:47.173229	2	2020-11-17 14:29:52.784404
3	2020-11-17 14:29:47.088365	20201013205258_resave_articles_and_comments_for_imgproxy	2020-11-17 14:29:56.536076	2020-11-17 14:29:56.530788	2	2020-11-17 14:29:56.538043
79	2020-11-17 14:29:47.088365	20200225114328_update_tags_social_preview_templates	2020-11-17 14:29:52.806544	2020-11-17 14:29:52.788327	2	2020-11-17 14:29:52.808556
33	2020-11-17 14:29:47.088365	20200324133751_update_tag_hotness_scores	2020-11-17 14:29:53.27092	2020-11-17 14:29:52.855168	2	2020-11-17 14:29:53.272922
51	2020-11-17 14:29:47.088365	20200518173504_update_public_reactions_count_from_positive_reactions_count	2020-11-17 14:29:53.544165	2020-11-17 14:29:53.539186	2	2020-11-17 14:29:53.546256
80	2020-11-17 14:29:47.088365	20200708163323_backfill_broadcastable_for_broadcasts	2020-11-17 14:29:53.66208	2020-11-17 14:29:53.605077	2	2020-11-17 14:29:53.66388
78	2020-11-17 14:29:47.088365	20201014184856_resave_users_for_imgproxy	2020-11-17 14:29:56.545944	2020-11-17 14:29:56.540982	2	2020-11-17 14:29:56.547973
76	2020-11-17 14:29:47.088365	20200715140848_backfill_user_registered_at	2020-11-17 14:29:53.675169	2020-11-17 14:29:53.665851	2	2020-11-17 14:29:53.67733
87	2020-11-17 14:29:47.088365	20200803142830_reindex_listing_search_column	2020-11-17 14:29:55.311823	2020-11-17 14:29:55.057894	2	2020-11-17 14:29:55.314282
37	2020-11-17 14:29:47.088365	20200805171911_clean_up_language_settings	2020-11-17 14:29:55.324022	2020-11-17 14:29:55.316738	2	2020-11-17 14:29:55.326047
83	2020-11-17 14:29:47.088365	20201022161311_backfill_user_registrations_in_registrations_controller_path	2020-11-17 14:29:56.603504	2020-11-17 14:29:56.596277	2	2020-11-17 14:29:56.605332
85	2020-11-17 14:29:47.088365	20200810083831_remove_orphaned_ahoy_rows	2020-11-17 14:29:55.335754	2020-11-17 14:29:55.32825	2	2020-11-17 14:29:55.338091
13	2020-11-17 14:29:47.088365	20201026155851_resave_to_bust_cache_for_imgproxy	2020-11-17 14:29:56.612506	2020-11-17 14:29:56.607655	2	2020-11-17 14:29:56.614845
86	2020-11-17 14:29:47.088365	20200818103028_nullify_orphaned_by_article_html_variant_trials	2020-11-17 14:29:55.36123	2020-11-17 14:29:55.355243	2	2020-11-17 14:29:55.36332
47	2020-11-17 14:29:47.088365	20200818170523_remove_orphaned_polls	2020-11-17 14:29:55.404093	2020-11-17 14:29:55.398679	2	2020-11-17 14:29:55.405991
9	2020-11-17 14:29:47.088365	20200821103125_nullify_orphaned_articles_by_organization	2020-11-17 14:29:55.474103	2020-11-17 14:29:55.468652	2	2020-11-17 14:29:55.476291
74	2020-11-17 14:29:47.088365	20200822083050_remove_orphaned_sponsorships_by_organization	2020-11-17 14:29:55.542584	2020-11-17 14:29:55.53433	2	2020-11-17 14:29:55.544806
88	2020-11-17 14:29:47.088365	20200825095213_remove_orphaned_buffer_updates_by_article	2020-11-17 14:29:55.552716	2020-11-17 14:29:55.546928	2	2020-11-17 14:29:55.554849
77	2020-11-17 14:29:47.088365	20200825102635_remove_orphaned_notification_subscriptions_by_article	2020-11-17 14:29:55.573394	2020-11-17 14:29:55.567336	2	2020-11-17 14:29:55.575392
49	2020-11-17 14:29:47.088365	20200825102956_remove_orphaned_notifications_by_article	2020-11-17 14:29:55.582872	2020-11-17 14:29:55.57753	2	2020-11-17 14:29:55.585125
84	2020-11-17 14:29:47.088365	20200826133748_nullify_orphaned_tweets_by_user	2020-11-17 14:29:55.63454	2020-11-17 14:29:55.629137	2	2020-11-17 14:29:55.636929
30	2020-11-17 14:29:47.088365	20200826140754_remove_orphaned_collections_by_user	2020-11-17 14:29:55.655181	2020-11-17 14:29:55.649326	2	2020-11-17 14:29:55.657182
34	2020-11-17 14:29:47.088365	20200826141447_nullify_orphaned_page_views_by_user	2020-11-17 14:29:55.708495	2020-11-17 14:29:55.702688	2	2020-11-17 14:29:55.710482
81	2020-11-17 14:29:47.088365	20200901040521_create_profile_fields	2020-11-17 14:29:55.989231	2020-11-17 14:29:55.733829	2	2020-11-17 14:29:55.991175
44	2020-11-17 14:29:47.088365	20200904132553_remove_draft_articles_with_duplicate_feed_source_url	2020-11-17 14:29:56.034418	2020-11-17 14:29:56.02649	2	2020-11-17 14:29:56.036411
75	2020-11-17 14:29:47.088365	20200917115821_backfill_listing_published_date	2020-11-17 14:29:56.373668	2020-11-17 14:29:56.120942	2	2020-11-17 14:29:56.375609
73	2020-11-17 14:29:47.088365	20200917135847_nullify_orphan_rows_from_buffer_updates_by_composer_user_id	2020-11-17 14:29:56.384039	2020-11-17 14:29:56.377797	2	2020-11-17 14:29:56.386138
82	2020-11-17 14:29:47.088365	20200922072907_backfill_profile_skills_languages	2020-11-17 14:29:56.426476	2020-11-17 14:29:56.420097	2	2020-11-17 14:29:56.428393
\.


--
-- Data for Name: display_ad_events; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.display_ad_events (id, category, context_type, created_at, display_ad_id, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: display_ads; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.display_ads (id, approved, body_markdown, clicks_count, created_at, impressions_count, organization_id, placement_area, processed_html, published, success_rate, updated_at) FROM stdin;
\.


--
-- Data for Name: email_authorizations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.email_authorizations (id, confirmation_token, created_at, json_data, type_of, updated_at, user_id, verified_at) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.events (id, category, cover_image, created_at, description_html, description_markdown, ends_at, host_name, live_now, location_name, location_url, profile_image, published, slug, starts_at, title, updated_at) FROM stdin;
\.


--
-- Data for Name: feedback_messages; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.feedback_messages (id, affected_id, category, created_at, feedback_type, message, offender_id, reported_url, reporter_id, status, updated_at) FROM stdin;
1	\N	spam	2020-11-17 14:29:45.239006	spam	Iure aliquid et non.	\N	\N	11	Open	2020-11-17 14:29:45.239006
2	\N	harassment	2020-11-17 14:29:45.2436	abuse-reports	Vero in minus qui.	\N	example.com	1	Open	2020-11-17 14:29:45.2436
\.


--
-- Data for Name: field_test_events; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.field_test_events (id, created_at, field_test_membership_id, name) FROM stdin;
\.


--
-- Data for Name: field_test_memberships; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.field_test_memberships (id, converted, created_at, experiment, participant_id, participant_type, variant) FROM stdin;
\.


--
-- Data for Name: flipper_features; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.flipper_features (id, created_at, key, updated_at) FROM stdin;
\.


--
-- Data for Name: flipper_gates; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.flipper_gates (id, created_at, feature_key, key, updated_at, value) FROM stdin;
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.follows (id, blocked, created_at, followable_id, followable_type, follower_id, follower_type, points, subscription_status, updated_at) FROM stdin;
\.


--
-- Data for Name: github_issues; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.github_issues (id, category, created_at, issue_serialized, processed_html, updated_at, url) FROM stdin;
\.


--
-- Data for Name: github_repos; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.github_repos (id, additional_note, bytes_size, created_at, description, featured, fork, github_id_code, info_hash, language, name, priority, stargazers_count, updated_at, url, user_id, watchers_count) FROM stdin;
\.


--
-- Data for Name: html_variant_successes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.html_variant_successes (id, article_id, created_at, html_variant_id, updated_at) FROM stdin;
\.


--
-- Data for Name: html_variant_trials; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.html_variant_trials (id, article_id, created_at, html_variant_id, updated_at) FROM stdin;
\.


--
-- Data for Name: html_variants; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.html_variants (id, approved, created_at, "group", html, name, published, success_rate, target_tag, updated_at, user_id) FROM stdin;
1	t	2020-11-17 14:29:43.855609	badge_landing_page	261	56	t	0	\N	2020-11-17 14:29:43.855609	1
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.identities (id, auth_data_dump, created_at, provider, secret, token, uid, updated_at, user_id) FROM stdin;
1	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: rolfsonkasey\n	2020-11-17 14:29:35.805462	twitter	0	0	0	2020-11-17 14:29:35.805462	1
2	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: tora_lesch\n	2020-11-17 14:29:36.076115	twitter	1	1	1	2020-11-17 14:29:36.076115	2
3	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: md_mcglynn_dee\n	2020-11-17 14:29:36.361915	twitter	2	2	2	2020-11-17 14:29:36.361915	3
4	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: shanahan_laveta\n	2020-11-17 14:29:36.658896	twitter	3	3	3	2020-11-17 14:29:36.658896	4
5	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: guadalupehackettgov\n	2020-11-17 14:29:36.967312	twitter	4	4	4	2020-11-17 14:29:36.967312	5
6	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: lehner_jacob\n	2020-11-17 14:29:37.253793	twitter	5	5	5	2020-11-17 14:29:37.253793	6
7	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: schimmeljeromy\n	2020-11-17 14:29:37.538431	twitter	6	6	6	2020-11-17 14:29:37.538431	7
8	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: pablowiegand\n	2020-11-17 14:29:37.836954	twitter	7	7	7	2020-11-17 14:29:37.836954	8
9	---\nextra:\n  raw_info:\n    lang: en\ninfo:\n  nickname: estebanmarvin\n	2020-11-17 14:29:38.134086	twitter	8	8	8	2020-11-17 14:29:38.134086	9
12	--- !ruby/hash:OmniAuth::AuthHash\nprovider: google_oauth2\nuid: '105304001062384698631'\ninfo: !ruby/hash:OmniAuth::AuthHash::InfoHash\n  name: Muzammil Mujahid\n  email: muzammilmujahid18@gmail.com\n  unverified_email: muzammilmujahid18@gmail.com\n  email_verified: true\n  first_name: Muzammil\n  last_name: Mujahid\n  image: https://lh3.googleusercontent.com/-zdD3dLXsLLk/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclQDNwiAlrwDYRNlaopOmbvhLd30g/s96-c/photo.jpg\ncredentials: !ruby/hash:OmniAuth::AuthHash\n  token: ya29.a0AfH6SMCDcJoaB3IOb4zSeSTTF7xcsn-2P77xvtJ4xG4gQ2fYIWsvIX2LY2CIO_Mw7X0cOV9iy4gfhI-FQA4gP1nuXeleI3IUGHB4ASlqQ2JCk75iIe1nYNGyr3IzolCjx_sYFmoSEo5a3c8uYjaGCQlr8H7p4cN1MRISzPvf-Qg\n  refresh_token: 1//03f8DlQkew50ZCgYIARAAGAMSNwF-L9IrEhUdVuacrhDSpor0qFYBUGAoU2tv0laH_uzYFSrHpKzZyrOIMpEbiW8I4IWnfzPfqEw\n  expires_at: 1608395931\n  expires: true\nextra: !ruby/hash:OmniAuth::AuthHash\n  id_token: eyJhbGciOiJSUzI1NiIsImtpZCI6ImUxOTdiZjJlODdiZDE5MDU1NzVmOWI2ZTVlYjQyNmVkYTVkNTc0ZTMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NzU2ODY3NjU2ODEtODMwbmVpcmRjcjVnZzRzMGJjYnJ2Z3FmMXZzc3QwOW4uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5NzU2ODY3NjU2ODEtODMwbmVpcmRjcjVnZzRzMGJjYnJ2Z3FmMXZzc3QwOW4uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDUzMDQwMDEwNjIzODQ2OTg2MzEiLCJlbWFpbCI6Im11emFtbWlsbXVqYWhpZDE4QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiVVdPeXhweFRPTERaX29LZ202YkN3ZyIsIm5hbWUiOiJNdXphbW1pbCBNdWphaGlkIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS8temREM2RMWHNMTGsvQUFBQUFBQUFBQUkvQUFBQUFBQUFBQUEvQU1adXVjbFFETndpQWxyd0RZUk5sYW9wT21idmhMZDMwZy9zOTYtYy9waG90by5qcGciLCJnaXZlbl9uYW1lIjoiTXV6YW1taWwiLCJmYW1pbHlfbmFtZSI6Ik11amFoaWQiLCJsb2NhbGUiOiJlbi1HQiIsImlhdCI6MTYwODM5MjMzMiwiZXhwIjoxNjA4Mzk1OTMyfQ.ZmJ6bQEWEh6XxDf9Okjeaiq9kV36ApMn_nAqcZGWzBFYA4vV5i8ofF4ECQ_sq9LZVdNPvdldfZStwa3wU_MHQnHdlppizv0UYgaqYENw99RuMA6AFOWUuSrR3rXqC_YpiDgkxoOXImuXczUcOCZCj7RfrJikEy0T6kYUD2nnF_f3p5FMA0mAJXAgt6ouKINrOuoOry89qmKnZGtZrteARTD305U5wmCVu_8q7puojmx4udOVEy-K0kRfzTmvHJXfUXqwfErVmktRFFVZKusK5zvW47PQCMv406QrfwBmFcmDXC0tRi9TR2PRZ48DH2cwOxP7SpN2gLWzFVT_-HqBbg\n  id_info: !ruby/hash:OmniAuth::AuthHash\n    iss: https://accounts.google.com\n    azp: 975686765681-830neirdcr5gg4s0bcbrvgqf1vsst09n.apps.googleusercontent.com\n    aud: 975686765681-830neirdcr5gg4s0bcbrvgqf1vsst09n.apps.googleusercontent.com\n    sub: '105304001062384698631'\n    email: muzammilmujahid18@gmail.com\n    email_verified: true\n    at_hash: UWOyxpxTOLDZ_oKgm6bCwg\n    name: Muzammil Mujahid\n    picture: https://lh3.googleusercontent.com/-zdD3dLXsLLk/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclQDNwiAlrwDYRNlaopOmbvhLd30g/s96-c/photo.jpg\n    given_name: Muzammil\n    family_name: Mujahid\n    locale: en-GB\n    iat: 1608392332\n    exp: 1608395932\n  raw_info: !ruby/hash:OmniAuth::AuthHash\n    sub: '105304001062384698631'\n    name: Muzammil Mujahid\n    given_name: Muzammil\n    family_name: Mujahid\n    picture: https://lh3.googleusercontent.com/-zdD3dLXsLLk/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclQDNwiAlrwDYRNlaopOmbvhLd30g/s96-c/photo.jpg\n    email: muzammilmujahid18@gmail.com\n    email_verified: true\n    locale: en-GB\n	2020-12-19 15:38:58.165997	google	\N	ya29.a0AfH6SMCDcJoaB3IOb4zSeSTTF7xcsn-2P77xvtJ4xG4gQ2fYIWsvIX2LY2CIO_Mw7X0cOV9iy4gfhI-FQA4gP1nuXeleI3IUGHB4ASlqQ2JCk75iIe1nYNGyr3IzolCjx_sYFmoSEo5a3c8uYjaGCQlr8H7p4cN1MRISzPvf-Qg	105304001062384698631	2020-12-19 15:38:58.165997	15
13	--- !ruby/hash:OmniAuth::AuthHash\nprovider: google_oauth2\nuid: '114655380834935248162'\ninfo: !ruby/hash:OmniAuth::AuthHash::InfoHash\n  name: Muzzamil Mujahid\n  email: muzamil.mujahid111@gmail.com\n  unverified_email: muzamil.mujahid111@gmail.com\n  email_verified: true\n  first_name: Muzzamil\n  last_name: Mujahid\n  image: https://lh3.googleusercontent.com/-RYl6ngVqTxo/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuckLFImXuR2SruqTnYQLawKVni1muQ/s96-c/photo.jpg\ncredentials: !ruby/hash:OmniAuth::AuthHash\n  token: ya29.a0AfH6SMA8JV11SeBS1idAUGKpCM8mauC7iPqgmKGi0LqEUagZ4Zuu4zbDh3GGVsiOx0dY7VmDAQuoG3SxbiWRMqg92JPK_E1hm6QDzyPM6GHL8T3tZtpkJNP_evF64045gNlDXeJYXk4vFk6wp3g8k8ToEghwMUb3F1y2g_6iUcA\n  refresh_token: 1//03sD5kpAs6hSzCgYIARAAGAMSNwF-L9Irk7znDEDDj-2F0DB2ErwcDFD-56D8e8sMy_y-p6BVuDZPEKNL4811nvlRs7gZqaQgTak\n  expires_at: 1608396626\n  expires: true\nextra: !ruby/hash:OmniAuth::AuthHash\n  id_token: eyJhbGciOiJSUzI1NiIsImtpZCI6ImUxOTdiZjJlODdiZDE5MDU1NzVmOWI2ZTVlYjQyNmVkYTVkNTc0ZTMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5NzU2ODY3NjU2ODEtODMwbmVpcmRjcjVnZzRzMGJjYnJ2Z3FmMXZzc3QwOW4uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5NzU2ODY3NjU2ODEtODMwbmVpcmRjcjVnZzRzMGJjYnJ2Z3FmMXZzc3QwOW4uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTQ2NTUzODA4MzQ5MzUyNDgxNjIiLCJlbWFpbCI6Im11emFtaWwubXVqYWhpZDExMUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6InlpdXk1QkY0Vkc3WERCbzJYeGx0TEEiLCJuYW1lIjoiTXV6emFtaWwgTXVqYWhpZCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLVJZbDZuZ1ZxVHhvL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUFBL0FNWnV1Y2tMRkltWHVSMlNydXFUbllRTGF3S1ZuaTFtdVEvczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6Ik11enphbWlsIiwiZmFtaWx5X25hbWUiOiJNdWphaGlkIiwibG9jYWxlIjoiZW4tR0IiLCJpYXQiOjE2MDgzOTMwMjcsImV4cCI6MTYwODM5NjYyN30.QjwOBoH2HrYqRi1BY_-DqSmH-tgtoEZM8KpRcixby7CvBF7RQasqCBWAMvylTCv1vRRDlPo_LMjF_H4msZwoJykcJtDk37DulmNYTYqf5olwJxDQ2HEhahTyxV1pnBkEzyrT4fCfiiPoR0hhDz-pu4y91F0gg_V0MgSLcUJBHxJGSKEnOY4KOKyEz-vuMv3w9zCmQ0Pn3k9Yl8K60RUCGGi1-NdH9h0KMT77jMW91Q9uHGmibUcX_pMi3Ei7Zf7yVgbY4gaDWzSPjnczaeS5IaMUMDSKPd-lDkKTSP_Z3Z7AkkqiML5fuxoGz8mH3eMWvnbRLE1gfCUfYkcIKR2IbA\n  id_info: !ruby/hash:OmniAuth::AuthHash\n    iss: https://accounts.google.com\n    azp: 975686765681-830neirdcr5gg4s0bcbrvgqf1vsst09n.apps.googleusercontent.com\n    aud: 975686765681-830neirdcr5gg4s0bcbrvgqf1vsst09n.apps.googleusercontent.com\n    sub: '114655380834935248162'\n    email: muzamil.mujahid111@gmail.com\n    email_verified: true\n    at_hash: yiuy5BF4VG7XDBo2XxltLA\n    name: Muzzamil Mujahid\n    picture: https://lh3.googleusercontent.com/-RYl6ngVqTxo/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuckLFImXuR2SruqTnYQLawKVni1muQ/s96-c/photo.jpg\n    given_name: Muzzamil\n    family_name: Mujahid\n    locale: en-GB\n    iat: 1608393027\n    exp: 1608396627\n  raw_info: !ruby/hash:OmniAuth::AuthHash\n    sub: '114655380834935248162'\n    name: Muzzamil Mujahid\n    given_name: Muzzamil\n    family_name: Mujahid\n    picture: https://lh3.googleusercontent.com/-RYl6ngVqTxo/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuckLFImXuR2SruqTnYQLawKVni1muQ/s96-c/photo.jpg\n    email: muzamil.mujahid111@gmail.com\n    email_verified: true\n    locale: en-GB\n	2020-12-19 15:50:29.295163	google	\N	ya29.a0AfH6SMA8JV11SeBS1idAUGKpCM8mauC7iPqgmKGi0LqEUagZ4Zuu4zbDh3GGVsiOx0dY7VmDAQuoG3SxbiWRMqg92JPK_E1hm6QDzyPM6GHL8T3tZtpkJNP_evF64045gNlDXeJYXk4vFk6wp3g8k8ToEghwMUb3F1y2g_6iUcA	114655380834935248162	2020-12-19 15:50:29.295163	16
10	--- !ruby/hash:OmniAuth::AuthHash\nprovider: github\nuid: '39006845'\ninfo: !ruby/hash:OmniAuth::AuthHash::InfoHash\n  nickname: Muzzamil123\n  email: muzamil.mujahid11@gmail.com\n  name: \n  image: https://avatars3.githubusercontent.com/u/39006845?v=4\n  urls: !ruby/hash:OmniAuth::AuthHash\n    GitHub: https://github.com/Muzzamil123\n    Blog: ''\ncredentials: !ruby/hash:OmniAuth::AuthHash\n  token: 05d0649fc3548ff52272d749a77551e1ba27050b\n  expires: false\nextra: !ruby/hash:OmniAuth::AuthHash\n  raw_info: !ruby/hash:OmniAuth::AuthHash\n    login: Muzzamil123\n    id: 39006845\n    node_id: MDQ6VXNlcjM5MDA2ODQ1\n    avatar_url: https://avatars3.githubusercontent.com/u/39006845?v=4\n    gravatar_id: ''\n    url: https://api.github.com/users/Muzzamil123\n    html_url: https://github.com/Muzzamil123\n    followers_url: https://api.github.com/users/Muzzamil123/followers\n    following_url: https://api.github.com/users/Muzzamil123/following{/other_user}\n    gists_url: https://api.github.com/users/Muzzamil123/gists{/gist_id}\n    starred_url: https://api.github.com/users/Muzzamil123/starred{/owner}{/repo}\n    subscriptions_url: https://api.github.com/users/Muzzamil123/subscriptions\n    organizations_url: https://api.github.com/users/Muzzamil123/orgs\n    repos_url: https://api.github.com/users/Muzzamil123/repos\n    events_url: https://api.github.com/users/Muzzamil123/events{/privacy}\n    received_events_url: https://api.github.com/users/Muzzamil123/received_events\n    type: User\n    site_admin: false\n    name: \n    company: \n    blog: ''\n    location: \n    email: \n    hireable: \n    bio: Software Engineer\n    twitter_username: \n    public_repos: 7\n    public_gists: 0\n    followers: 1\n    following: 1\n    created_at: '2018-05-05T13:24:51Z'\n    updated_at: '2021-01-13T21:00:15Z'\n  all_emails: !ruby/array:Hashie::Array\n  - !ruby/hash:OmniAuth::AuthHash\n    email: muzamil.mujahid11@gmail.com\n    primary: true\n    verified: true\n    visibility: private\n  - !ruby/hash:OmniAuth::AuthHash\n    email: 39006845+Muzzamil123@users.noreply.github.com\n    primary: false\n    verified: true\n    visibility: \n  - !ruby/hash:OmniAuth::AuthHash\n    email: muzamil.mujahid@techcreatix.com\n    primary: false\n    verified: false\n    visibility: \n  scope: user:email\n	2020-11-25 13:48:33.260685	github	\N	05d0649fc3548ff52272d749a77551e1ba27050b	39006845	2021-01-14 12:16:58.738821	12
\.


--
-- Data for Name: mentions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.mentions (id, created_at, mentionable_id, mentionable_type, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.messages (id, chat_action, chat_channel_id, created_at, edited_at, message_html, message_markdown, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: music_releases; Type: TABLE DATA; Schema: public; Owner: forem_latest
--

COPY public.music_releases (id, title, description, slug, image, pattern_image, main_color_hex, published, status_notice, user_id, created_at, updated_at) FROM stdin;
1	Music Release title	Music release description	musicrelease	76d92895-0df9-4c27-a661-76639266e40f.png	65b54906-c34d-4a2a-aa63-6a21298cd84d.png	ff00ff	\N	\N	12	2020-12-27 19:57:22.186016	2020-12-27 19:57:22.186016
2	Music Release 2	Music release description 2	musicrelease2	47ae04e0-bdf2-4fd5-84c7-601af0d0193a.png	a2d97b2a-8fc5-4758-b759-fc3be8a9bb21.png	ff00ff	t	\N	12	2020-12-27 20:15:56.882186	2020-12-27 21:20:14.351009
3	Music Release 3	Music release 3	musicrelease3	24e0f3b5-3a41-4bfe-b44d-2cdd0723bbfc.png	\N	ff00ff	t	\N	12	2020-12-27 21:23:00.811099	2020-12-27 21:23:15.969326
4	Music Release title newwww	music release description	musicreleasedes	44b1947a-7be7-4c00-9b0d-e945ae6bb400.png	\N	ff00ff	t	\N	12	2020-12-27 23:18:46.053676	2020-12-27 23:19:03.37229
5	Music Release title	md	mkamskdasd	1431f722-d14e-40ad-91f6-3f30a65aa6fe.png	\N	ff00ff	\N	\N	19	2021-01-01 14:48:03.629144	2021-01-01 14:48:03.629144
6	Music Release title	mdf	aiosdoaisd	0050e1d5-f24e-43ff-a53d-741cb7fbe836.png	\N	ff00ff	t	\N	19	2021-01-01 14:48:39.951701	2021-01-01 14:49:51.040968
7	Music Release title	sasad	djsksc	c5509a7a-1c67-4c79-a2c3-ff39a105e049.png	\N	ff00ff	t	\N	30	2021-01-08 12:57:13.910509	2021-01-08 12:58:07.61928
\.


--
-- Data for Name: music_tracks; Type: TABLE DATA; Schema: public; Owner: forem_latest
--

COPY public.music_tracks (id, title, summary, body, slug, guid, image, media_url, published_at, music_release_id, created_at, updated_at) FROM stdin;
1	M Music Track 1	\N	\N	m-music-track-1	<guid>5a0c8bb5-e336-458e-8967-bf15bc485ac6</guid>	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	2020-12-27 21:17:18.565955	3	2020-12-27 21:17:18.573703	2020-12-27 21:24:12.371448
3	M Musiccsdcs	\N	\N	mmusicnewss	<guid>e2aa50e6-c9e0-42dd-a2fd-28adbda32021</guid>	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	\N	4	2020-12-27 23:23:09.703382	2020-12-28 14:04:27.39227
4	Qawal	\N	\N	qawal	<guid>0a4a5f8f-8784-491e-a662-7c0f0db153ad</guid>	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	2020-12-28 14:11:24.018743	3	2020-12-28 14:11:24.031329	2020-12-28 14:11:24.031329
5	Audiossssss	\N	\N	audiossss	<guid>ec83cf46-698e-4a61-bd2c-6369058a3ba3</guid>	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	2020-12-28 14:49:40.599878	2	2020-12-28 14:49:40.605972	2020-12-28 14:49:40.605972
6	kmkmkmkkmkmk	\N	\N	kmk	<guid>a992ee74-4704-4a95-ab06-d6be8a0681d9</guid>	\N	https://studioappbucket.s3.amazonaws.com/audio/audio-upload.mp3	2020-12-28 14:51:47.639511	2	2020-12-28 14:51:47.646539	2020-12-28 14:52:30.852138
\.


--
-- Data for Name: navigation_links; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.navigation_links (id, created_at, display_only_when_signed_in, icon, name, "position", updated_at, url) FROM stdin;
2	2020-11-17 14:29:46.903095	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g class="nc-icon-wrapper">\n        <path fill="#FFD983" d="M36 4H14a4 4 0 00-4 4v24H8a4 4 0 000 8h24a4 4 0 004-4V12a4 4 0 000-8z"/>\n        <path fill="#E39F3D" d="M12 14h24v-2H14l-2-1z"/>\n        <path fill="#FFE8B6" d="M14 4a4 4 0 00-4 4v24.555A3.955 3.955 0 008 32a4 4 0 104 4V11.445c.59.344 1.268.555 2 .555a4 4 0 000-8z"/>\n        <path fill="#C1694F" d="M16 8a2 2 0 11-4.001-.001A2 2 0 0116 8m-6 28a2 2 0 11-4.001-.001A2 2 0 0110 36m24-17a1 1 0 01-1 1H15a1 1 0 010-2h18a1 1 0 011 1m0 4a1 1 0 01-1 1H15a1 1 0 110-2h18a1 1 0 011 1m0 4a1 1 0 01-1 1H15a1 1 0 110-2h18a1 1 0 011 1m0 4a1 1 0 01-1 1H15a1 1 0 110-2h18a1 1 0 011 1"/>\n    </g>\n</svg>\n	Listings	1	2020-11-17 14:29:46.903095	http://localhost:3000/listings
3	2020-11-17 14:29:46.916674	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g class="nc-icon-wrapper">\n        <path fill="#292F33" d="M10 19h24v2H10zm15 15c0 2.208-.792 4-3 4-2.209 0-3-1.792-3-4s.791-2 3-2c2.208 0 3-.208 3 2z"/>\n        <path fill="#66757F" d="M22 35c-6.627 0-10 1.343-10 3v2h20v-2c0-1.657-3.373-3-10-3z"/>\n        <path fill="#99AAB5" d="M22 4a9 9 0 00-9 9v7h18v-7a9 9 0 00-9-9z"/>\n        <g fill="#292F33" transform="translate(4 4)">\n            <circle cx="15.5" cy="2.5" r="1.5"/>\n            <circle cx="20.5" cy="2.5" r="1.5"/>\n            <circle cx="17.5" cy="6.5" r="1.5"/>\n            <circle cx="22.5" cy="6.5" r="1.5"/>\n            <circle cx="12.5" cy="6.5" r="1.5"/>\n            <circle cx="15.5" cy="10.5" r="1.5"/>\n            <circle cx="10.5" cy="10.5" r="1.5"/>\n            <circle cx="20.5" cy="10.5" r="1.5"/>\n            <circle cx="25.5" cy="10.5" r="1.5"/>\n            <circle cx="17.5" cy="14.5" r="1.5"/>\n            <circle cx="22.5" cy="14.5" r="1.5"/>\n            <circle cx="12.5" cy="14.5" r="1.5"/>\n        </g>\n        <path fill="#66757F" d="M13 19.062V21c0 4.971 4.029 9 9 9s9-4.029 9-9v-1.938H13z"/>\n        <path fill="#66757F" d="M34 18a1 1 0 00-1 1v2c0 6.074-4.925 11-11 11s-11-4.926-11-11v-2a1 1 0 00-2 0v2c0 7.18 5.82 13 13 13s13-5.82 13-13v-2a1 1 0 00-1-1z"/>\n    </g>\n</svg>\n	Podcasts	2	2020-11-17 14:29:46.916674	http://localhost:3000/pod
4	2020-11-17 14:29:46.927951	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g transform="translate(4 4)">\n        <path fill="#31373D" d="M34.074 18l-4.832 3H28v-4c0-.088-.02-.169-.026-.256C31.436 15.864 34 12.735 34 9a8 8 0 00-16.001 0c0 1.463.412 2.822 1.099 4H14.92c.047-.328.08-.66.08-1a7 7 0 10-14 0 6.995 6.995 0 004 6.317V29a4 4 0 004 4h15a4 4 0 004-4v-3h1.242l4.832 3H35V18h-.926zM28.727 3.977a5.713 5.713 0 012.984 4.961L28.18 8.35a2.276 2.276 0 00-.583-.982l1.13-3.391zm-.9 6.342l3.552.592a5.713 5.713 0 01-4.214 3.669 3.985 3.985 0 00-1.392-1.148l.625-2.19a2.425 2.425 0 001.429-.923zM26 3.285c.282 0 .557.027.828.067l-1.131 3.392c-.404.054-.772.21-1.081.446L21.42 5.592A5.703 5.703 0 0126 3.285zM20.285 9c0-.563.085-1.106.236-1.62l3.194 1.597-.002.023c0 .657.313 1.245.771 1.662L23.816 13h-1.871a5.665 5.665 0 01-1.66-4zm-9.088-.385A4.64 4.64 0 0112.667 12c0 .344-.043.677-.113 1H10.1c.145-.304.233-.641.233-1a2.32 2.32 0 00-.392-1.292l1.256-2.093zM8 7.333c.519 0 1.01.105 1.476.261L8.22 9.688c-.073-.007-.145-.022-.22-.022a2.32 2.32 0 00-1.292.392L4.615 8.803A4.64 4.64 0 018 7.333zM3.333 12c0-.519.105-1.01.261-1.477l2.095 1.257c-.007.073-.022.144-.022.22 0 .75.36 1.41.91 1.837a3.987 3.987 0 00-1.353 1.895C4.083 14.881 3.333 13.533 3.333 12z"/>\n        <circle fill="#8899A6" cx="24" cy="19" r="2"/>\n        <circle fill="#8899A6" cx="9" cy="19" r="2"/>\n        <path fill="#8899A6" d="M24 27a2 2 0 00-2-2H11a2 2 0 00-2 2v6a2 2 0 002 2h11a2 2 0 002-2v-6z"/>\n    </g>\n</svg>\n	Videos	3	2020-11-17 14:29:46.927951	http://localhost:3000/videos
5	2020-11-17 14:29:46.938133	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g class="nc-icon-wrapper">\n        <path fill="#FFD983" d="M36.017 24.181L21.345 9.746C20.687 9.087 19.823 9 18.96 9H8.883C7.029 9 6 10.029 6 11.883v10.082c0 .861.089 1.723.746 2.38L21.3 39.017a3.287 3.287 0 004.688 0l10.059-10.088c1.31-1.312 1.28-3.438-.03-4.748zm-23.596-8.76a1.497 1.497 0 11-2.118-2.117 1.497 1.497 0 012.118 2.117z"/>\n        <path fill="#D99E82" d="M13.952 11.772a3.66 3.66 0 00-5.179 0 3.663 3.663 0 105.18 5.18 3.664 3.664 0 00-.001-5.18zm-1.53 3.65a1.499 1.499 0 11-2.119-2.12 1.499 1.499 0 012.119 2.12z"/>\n        <path fill="#C1694F" d="M12.507 14.501a1 1 0 11-1.415-1.414l8.485-8.485a1 1 0 111.415 1.414l-8.485 8.485z"/>\n    </g>\n</svg>\n	Tags	4	2020-11-17 14:29:46.938133	http://localhost:3000/tags
6	2020-11-17 14:29:46.948642	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g class="nc-icon-wrapper">\n        <path fill="#FFDB5E" d="M38.956 21.916c0-.503-.12-.975-.321-1.404-1.341-4.326-7.619-4.01-16.549-4.221-1.493-.035-.639-1.798-.115-5.668.341-2.517-1.282-6.382-4.01-6.382-4.498 0-.171 3.548-4.148 12.322-2.125 4.688-6.875 2.062-6.875 6.771v10.719c0 1.833.18 3.595 2.758 3.885 2.499.281 1.937 2.062 5.542 2.062h18.044a3.337 3.337 0 003.333-3.334c0-.762-.267-1.456-.698-2.018 1.02-.571 1.72-1.649 1.72-2.899 0-.76-.266-1.454-.696-2.015 1.023-.57 1.725-1.649 1.725-2.901 0-.909-.368-1.733-.961-2.336a3.311 3.311 0 001.251-2.581z"/>\n        <path fill="#EE9547" d="M27.02 25.249h8.604c1.17 0 2.268-.626 2.866-1.633a.876.876 0 00-1.506-.892 1.588 1.588 0 01-1.361.775h-8.81c-.873 0-1.583-.71-1.583-1.583s.71-1.583 1.583-1.583H32.7a.875.875 0 000-1.75h-5.888a3.337 3.337 0 00-3.333 3.333c0 1.025.475 1.932 1.205 2.544a3.32 3.32 0 00-.998 2.373c0 1.028.478 1.938 1.212 2.549a3.318 3.318 0 00.419 5.08 3.305 3.305 0 00-.852 2.204 3.337 3.337 0 003.333 3.333h5.484a3.35 3.35 0 002.867-1.632.875.875 0 00-1.504-.894 1.594 1.594 0 01-1.363.776h-5.484c-.873 0-1.583-.71-1.583-1.583s.71-1.583 1.583-1.583h6.506a3.35 3.35 0 002.867-1.633.875.875 0 10-1.504-.894 1.572 1.572 0 01-1.363.777h-7.063a1.585 1.585 0 010-3.167h8.091a3.35 3.35 0 002.867-1.632.875.875 0 00-1.504-.894 1.573 1.573 0 01-1.363.776H27.02a1.585 1.585 0 010-3.167z"/>\n    </g>\n</svg>\n	Code of Conduct	5	2020-11-17 14:29:46.948642	http://localhost:3000/code-of-conduct
7	2020-11-17 14:29:46.958828	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g class="nc-icon-wrapper">\n        <path fill="#FFD983" d="M33 15.06c0 6.439-5 7.439-5 13.44 0 3.098-3.123 3.359-5.5 3.359-2.053 0-6.586-.779-6.586-3.361C15.914 22.5 11 21.5 11 15.06c0-6.031 5.285-10.92 11.083-10.92C27.883 4.14 33 9.029 33 15.06z"/>\n        <path fill="#CCD6DD" d="M26.167 36.5c0 .828-2.234 2.5-4.167 2.5-1.933 0-4.167-1.672-4.167-2.5 0-.828 2.233-.5 4.167-.5 1.933 0 4.167-.328 4.167.5z"/>\n        <path fill="#FFCC4D" d="M26.707 14.293a.999.999 0 00-1.414 0L22 17.586l-3.293-3.293a1 1 0 10-1.414 1.414L21 19.414V30a1 1 0 102 0V19.414l3.707-3.707a.999.999 0 000-1.414z"/>\n        <path fill="#99AAB5" d="M28 35a2 2 0 01-2 2h-8a2 2 0 01-2-2v-6h12v6z"/>\n        <path fill="#CCD6DD" d="M15.999 36a1 1 0 01-.163-1.986l12-2a.994.994 0 011.15.822.999.999 0 01-.822 1.15l-12 2a.927.927 0 01-.165.014zm0-4a1 1 0 01-.163-1.986l12-2a.995.995 0 011.15.822.999.999 0 01-.822 1.15l-12 2a.927.927 0 01-.165.014z"/>\n    </g>\n</svg>\n	FAQ	6	2020-11-17 14:29:46.958828	http://localhost:3000/faq
8	2020-11-17 14:29:46.969114	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g class="nc-icon-wrapper">\n        <path fill="#F4900C" d="M15 4a8 8 0 00-8 8v8h2v-8a6 6 0 0112 0v8h2v-8a8 8 0 00-8-8z"/>\n        <path fill="#DD2E44" d="M5 12l2 2 2-2 2 2 2-2 2 2 2-2 2 2 2-2 2 2 2-2v23H5z"/>\n        <path fill="#FFCC4D" d="M29 9a8 8 0 00-8 8v8h2v-8a6 6 0 0112 0v8h2v-8a8 8 0 00-8-8z"/>\n        <path fill="#744EAA" d="M19 17l2 2 2-2 2 2 2-2 2 2 2-2 2 2 2-2 2 2 2-2v23H19z"/>\n    </g>\n</svg>\n	DEV Shop	7	2020-11-17 14:29:46.969114	https://shop.dev.to/
9	2020-11-17 14:29:46.979836	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <path fill="#DD2E44" d="M39.885 15.833c0-5.45-4.418-9.868-9.867-9.868-3.308 0-6.227 1.633-8.018 4.129-1.791-2.496-4.71-4.129-8.017-4.129-5.45 0-9.868 4.417-9.868 9.868 0 .772.098 1.52.266 2.241C5.751 26.587 15.216 35.568 22 38.034c6.783-2.466 16.249-11.447 17.617-19.959.17-.721.268-1.469.268-2.242z"/>\n</svg>\n	Sponsors	8	2020-11-17 14:29:46.979836	http://localhost:3000/sponsors
10	2020-11-17 14:29:47.009425	f	<svg viewBox="0 0 235 234" xmlns="http://www.w3.org/2000/svg" class="rainbow-logo" preserveAspectRatio="xMinYMin meet">\n    <g fill="none" fill-rule="evenodd">\n        <path fill="#88AEDC" d="M234.04 175.67l-75.69 58.28h47.18L234.04 212z"/>\n        <path d="M234.04 140.06l-121.93 93.89h.02l121.91-93.87zM133.25.95L.04 103.51v.02L133.27.95z"/>\n        <path fill="#F58F8E" fill-rule="nonzero" d="M.04.95v30.16L39.21.95z"/>\n        <path fill="#FEE18A" fill-rule="nonzero" d="M39.21.95L.04 31.11v35.9L85.84.95z"/>\n        <path fill="#F3F095" fill-rule="nonzero" d="M85.84.95L.04 67.01v36.5L133.25.95z"/>\n        <path fill="#55C1AE" fill-rule="nonzero" d="M133.27.95L.04 103.53v35.59L179.49.95z"/>\n        <path fill="#F7B3CE" fill-rule="nonzero" d="M234.04.95h-7.37L.04 175.45v35.93l234-180.18z"/>\n        <path fill="#88AEDC" fill-rule="nonzero" d="M179.49.95L.04 139.12v36.33L226.67.95z"/>\n        <path fill="#F58F8E" fill-rule="nonzero" d="M234.04 31.2L.04 211.38v22.57h18.03l215.97-166.3z"/>\n        <path fill="#FEE18A" fill-rule="nonzero" d="M234.04 67.65L18.07 233.95H64.7l169.34-130.39z"/>\n        <path fill="#F3F095" fill-rule="nonzero" d="M234.04 103.56L64.7 233.95h47.41l121.93-93.89z"/>\n        <path fill="#55C1AE" fill-rule="nonzero" d="M234.04 140.08l-121.91 93.87h46.22l75.69-58.28z"/>\n        <path fill="#F7B3CE" fill-rule="nonzero" d="M234.04 212l-28.51 21.95h28.51z"/>\n        <path d="M65.237 77.75c4.514.95 7.774 2.8 11.135 6.3 3.059 3.2 4.965 6.85 5.767 10.95.652 3.45.652 40.55 0 44.05-1.705 9.1-9.479 16.2-19.109 17.45-2.006.25-8.727.5-14.845.5H37V77h12.438c8.828 0 13.342.2 15.8.75zM51.545 117v25.6l5.166-.2c4.464-.15 5.417-.35 7.423-1.5 3.912-2.3 3.962-2.45 3.962-24.2 0-21.2 0-21.2-3.661-23.6-1.806-1.2-2.558-1.35-7.473-1.55l-5.417-.15V117zm79.245-32.75v7.25h-25.58v18h15.549V124H105.21l.1 9.1.15 9.15 12.69.15 12.638.1V157h-14.795c-16.451 0-19.009-.3-21.617-2.6-3.661-3.2-3.46-1.15-3.611-36.3-.1-21.9.05-32.25.401-33.65.702-2.6 3.661-5.8 6.27-6.7 1.554-.55 5.466-.7 17.704-.75h15.648v7.25zm31.647 20.85c3.712 14.25 6.821 25.6 6.922 25.25.15-.35 3.31-12.4 7.071-26.85l6.872-26.25 7.824-.15c5.918-.1 7.874.05 7.874.5s-17.354 66.2-18.357 69.5c-.702 2.3-4.463 7-6.57 8.25-2.658 1.5-6.57 1.75-8.978.5-2.156-1.1-5.015-4.4-6.47-7.5-.902-1.9-15.648-56-19.058-70l-.352-1.35h7.825c7.673 0 7.874 0 8.275 1.1.2.65 3.41 12.8 7.122 27z" fill="#FFF"/>\n    </g>\n</svg>\n	About	9	2020-11-17 14:29:47.009425	http://localhost:3000/about
11	2020-11-17 14:29:47.015744	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g transform="translate(4 4)">\n        <circle fill="#FFCC4D" cx="18" cy="18" r="18"/>\n        <path fill="#664500" d="M27.335 23.629a.501.501 0 00-.635-.029c-.039.029-3.922 2.9-8.7 2.9-4.766 0-8.662-2.871-8.7-2.9a.5.5 0 10-.729.657C8.7 24.472 11.788 29.5 18 29.5s9.301-5.028 9.429-5.243a.499.499 0 00-.094-.628z"/>\n        <path fill="#65471B" d="M18 26.591c-.148 0-.291-.011-.438-.016v4.516h.875v-4.517c-.145.005-.289.017-.437.017z"/>\n        <path fill="#FFF" d="M22 26c.016-.004-1.45.378-2.446.486-.366.042-.737.076-1.117.089v4.517H20c1.1 0 2-.9 2-2V26zm-8 0c-.016-.004 1.45.378 2.446.486.366.042.737.076 1.117.089v4.517H16c-1.1 0-2-.9-2-2V26z"/>\n        <path fill="#65471B" d="M27.335 23.629a.501.501 0 00-.635-.029c-.03.022-2.259 1.668-5.411 2.47-.443.113-1.864.43-3.286.431-1.424 0-2.849-.318-3.292-.431-3.152-.802-5.381-2.448-5.411-2.47a.501.501 0 00-.729.657c.097.162 1.885 3.067 5.429 4.481v-1.829c-.016-.004 1.45.378 2.446.486.366.042.737.076 1.117.089.146.005.289.016.437.016.148 0 .291-.011.438-.016.38-.013.751-.046 1.117-.089.996-.108 2.462-.49 2.446-.486v1.829c3.544-1.414 5.332-4.319 5.429-4.481a.5.5 0 00-.095-.628zm-.711-9.605c0 1.714-.938 3.104-2.096 3.104-1.157 0-2.096-1.39-2.096-3.104s.938-3.104 2.096-3.104c1.158 0 2.096 1.39 2.096 3.104zm-17.167 0c0 1.714.938 3.104 2.096 3.104 1.157 0 2.096-1.39 2.096-3.104s-.938-3.104-2.096-3.104c-1.158 0-2.096 1.39-2.096 3.104z"/>\n        <path fill="#292F33" d="M34.808 9.627c-.171-.166-1.267.274-2.376-.291-2.288-1.166-8.07-2.291-11.834.376-.403.285-2.087.333-2.558.313-.471.021-2.155-.027-2.558-.313-3.763-2.667-9.545-1.542-11.833-.376-1.109.565-2.205.125-2.376.291-.247.239-.247 1.196.001 1.436.246.239 1.477.515 1.722 1.232.247.718.249 4.958 2.213 6.424 1.839 1.372 6.129 1.785 8.848.238 2.372-1.349 2.289-4.189 2.724-5.881.155-.603.592-.907 1.26-.907s1.105.304 1.26.907c.435 1.691.351 4.532 2.724 5.881 2.719 1.546 7.009 1.133 8.847-.238 1.965-1.465 1.967-5.706 2.213-6.424.245-.717 1.476-.994 1.722-1.232.248-.24.249-1.197.001-1.436zm-20.194 3.65c-.077 1.105-.274 3.227-1.597 3.98-.811.462-1.868.743-2.974.743h-.001c-1.225 0-2.923-.347-3.587-.842-.83-.619-1.146-3.167-1.265-4.12-.076-.607-.28-2.09.388-2.318 1.06-.361 2.539-.643 4.052-.643.693 0 3.021.043 4.155.741 1.005.617.872 1.851.829 2.459zm16.278-.253c-.119.954-.435 3.515-1.265 4.134-.664.495-2.362.842-3.587.842h-.001c-1.107 0-2.163-.281-2.975-.743-1.323-.752-1.52-2.861-1.597-3.966-.042-.608-.176-1.851.829-2.468 1.135-.698 3.462-.746 4.155-.746 1.513 0 2.991.277 4.052.638.668.228.465 1.702.389 2.309z"/>\n    </g>\n</svg>\n	Privacy Policy	10	2020-11-17 14:29:47.015744	http://localhost:3000/privacy
12	2020-11-17 14:29:47.021154	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g transform="translate(4 4)">\n        <ellipse fill="#F5F8FA" cx="8.828" cy="18" rx="7.953" ry="13.281"/>\n        <path fill="#E1E8ED" d="M8.828 32.031C3.948 32.031.125 25.868.125 18S3.948 3.969 8.828 3.969 17.531 10.132 17.531 18s-3.823 14.031-8.703 14.031zm0-26.562C4.856 5.469 1.625 11.09 1.625 18s3.231 12.531 7.203 12.531S16.031 24.91 16.031 18 12.8 5.469 8.828 5.469z"/>\n        <circle fill="#8899A6" cx="6.594" cy="18" r="4.96"/>\n        <circle fill="#292F33" cx="6.594" cy="18" r="3.565"/>\n        <circle fill="#F5F8FA" cx="7.911" cy="15.443" r="1.426"/>\n        <ellipse fill="#F5F8FA" cx="27.234" cy="18" rx="7.953" ry="13.281"/>\n        <path fill="#E1E8ED" d="M27.234 32.031c-4.88 0-8.703-6.163-8.703-14.031s3.823-14.031 8.703-14.031S35.938 10.132 35.938 18s-3.824 14.031-8.704 14.031zm0-26.562c-3.972 0-7.203 5.622-7.203 12.531 0 6.91 3.231 12.531 7.203 12.531S34.438 24.91 34.438 18 31.206 5.469 27.234 5.469z"/>\n        <circle fill="#8899A6" cx="25" cy="18" r="4.96"/>\n        <circle fill="#292F33" cx="25" cy="18" r="3.565"/>\n        <circle fill="#F5F8FA" cx="26.317" cy="15.443" r="1.426"/>\n    </g>\n</svg>\n	Terms of use	11	2020-11-17 14:29:47.021154	http://localhost:3000/terms
13	2020-11-17 14:29:47.026097	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\n    <g class="nc-icon-wrapper">\n        <path fill="#FFAC33" d="M38.724 33.656c-1.239-.01-1.241 1.205-1.241 1.205H22.5c-5.246 0-9.5-4.254-9.5-9.5s4.254-9.5 9.5-9.5 9.5 4.254 9.5 9.5c0 3.062-1.6 5.897-3.852 7.633h5.434C35.022 30.849 36 28.139 36 25.361c0-7.456-6.045-13.5-13.5-13.5-7.456 0-13.5 6.044-13.5 13.5 0 7.455 6.044 13.5 13.5 13.5h14.982s-.003 1.127 1.241 1.139c1.238.012 1.228-1.245 1.228-1.245l.014-3.821s.001-1.267-1.241-1.278zM9 18.26a16.047 16.047 0 014-4.739V13c0-5 5-7 5-8s-1-1-1-1H5C4 4 4 5 4 5c0 1 5 3.333 5 7.69v5.57z"/>\n        <path fill="#BE1931" d="M17.091 33.166a9.487 9.487 0 01-4.045-8.72l-3.977-.461c-.046.452-.069.911-.069 1.376 0 4.573 2.28 8.608 5.76 11.051l2.331-3.246z"/>\n        <path fill="#BE1931" d="M10 29.924s-5.188-.812-5 1 5-1 5-1zm0 .312s-4.125 2.688-2.938 3.75S10 30.236 10 30.236z"/>\n    </g>\n</svg>\n	Contact	12	2020-11-17 14:29:47.026097	http://localhost:3000/contact
1	2020-11-17 14:29:46.892181	f	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" width="24" height="24">\r\n    <g class="nc-icon-wrapper">\r\n        <path fill="#67757F" d="M39 24c0 2.209-1.791 2-4 2H9c-2.209 0-4 .209-4-2l2-12c.125-1.917 1.791-4 4-4h22c2.209 0 3.791 2.208 4 4l2 12z"/>\r\n        <path fill="#CCD6DD" d="M32 17a2 2 0 01-2 2H14a2 2 0 01-2-2V9a2 2 0 012-2h16a2 2 0 012 2v8z"/>\r\n        <path fill="#E1E8ED" d="M34 21a2 2 0 01-2 2H12a2 2 0 01-2-2v-8a2 2 0 012-2h20a2 2 0 012 2v8z"/>\r\n        <path fill="#F5F8FA" d="M36 25a2 2 0 01-2 2H10a2 2 0 01-2-2v-8a2 2 0 012-2h24a2 2 0 012 2v8z"/>\r\n        <path fill="#9AAAB4" d="M39 35a4 4 0 01-4 4H9a4 4 0 01-4-4V24a4 4 0 014-4h26a4 4 0 014 4v11z"/>\r\n        <path fill="#67757F" d="M18 16zm0 0z"/>\r\n        <path fill="#FCAB40" d="M26 5h-5a2 2 0 00-2 2v1h4a2 2 0 012 2h1a2 2 0 002-2V7a2 2 0 00-2-2z"/>\r\n        <path fill="#5DADEC" d="M22 9h-5a2 2 0 00-2 2v1h4a2 2 0 012 2h1a2 2 0 002-2v-1a2 2 0 00-2-2z"/>\r\n        <path fill="#E75A70" d="M20 16a2 2 0 01-2 2h-5a2 2 0 01-2-2v-1a2 2 0 012-2h5a2 2 0 012 2v1z"/>\r\n        <path fill="#67757F" d="M29 32a2 2 0 01-2 2H17a2 2 0 01-2-2v-5a2 2 0 012-2h10a2 2 0 012 2v5zm-11-4z"/>\r\n        <path fill="#E1E8ED" d="M27 31a1 1 0 01-1 1h-8a1 1 0 01-1-1v-3a1 1 0 011-1h8a1 1 0 011 1v3z"/>\r\n    </g>\r\n</svg>\r\n	Reading List	0	2020-12-26 10:27:53.741511	http://localhost:3000/music_releases
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.notes (id, author_id, content, created_at, noteable_id, noteable_type, reason, updated_at) FROM stdin;
1	12	testing purposes	2020-11-30 11:33:22.053407	12	User	misc_note	2020-11-30 11:33:22.053407
\.


--
-- Data for Name: notification_subscriptions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.notification_subscriptions (id, config, created_at, notifiable_id, notifiable_type, updated_at, user_id) FROM stdin;
1	all_comments	2020-12-02 12:43:40.447898	27	Article	2020-12-02 12:43:40.447898	12
2	all_comments	2020-12-03 11:36:49.92557	28	Article	2020-12-03 11:36:49.92557	12
3	all_comments	2020-12-20 09:10:49.75892	29	Article	2020-12-20 09:10:49.75892	12
4	all_comments	2021-01-03 16:50:22.801302	30	Article	2021-01-03 16:50:22.801302	24
5	all_comments	2021-01-03 16:53:52.691564	31	Article	2021-01-03 16:53:52.691564	24
6	all_comments	2021-01-04 11:45:26.366853	32	Article	2021-01-04 11:45:26.366853	12
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.notifications (id, action, created_at, json_data, notifiable_id, notifiable_type, notified_at, organization_id, read, updated_at, user_id) FROM stdin;
1	Moderation	2020-11-25 13:54:56.716098	{"user": {"id": 1, "name": "Kasey Rolfson", "path": "/rolfsonkasey", "class": {"name": "User"}, "username": "rolfsonkasey", "created_at": "2020-11-17T14:29:35.461Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"}, "comment": {"id": 1, "path": "/pablowiegand/comment/1", "class": {"name": "Comment"}, "depth": 0, "ancestry": null, "ancestors": [], "created_at": "2020-11-17T14:29:41.553Z", "updated_at": "2020-11-17T14:29:41.568Z", "commentable": {"id": 9, "path": "/lehner_jacob/the-curious-incident-of-the-dog-in-the-night-time-mollitia-quod-120b", "class": {"name": "Article"}, "title": " The Curious Incident of the Dog in the Night-Time Mollitia quod"}, "processed_html": "<p>Cray artisan health tofu intelligentsia.</p>\\n\\n"}}	1	Comment	2020-11-25 13:54:56.716163	\N	f	2020-11-25 13:54:56.716098	7
2	Moderation	2020-11-25 13:54:56.733573	{"user": {"id": 1, "name": "Kasey Rolfson", "path": "/rolfsonkasey", "class": {"name": "User"}, "username": "rolfsonkasey", "created_at": "2020-11-17T14:29:35.461Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"}, "comment": {"id": 1, "path": "/pablowiegand/comment/1", "class": {"name": "Comment"}, "depth": 0, "ancestry": null, "ancestors": [], "created_at": "2020-11-17T14:29:41.553Z", "updated_at": "2020-11-17T14:29:41.568Z", "commentable": {"id": 9, "path": "/lehner_jacob/the-curious-incident-of-the-dog-in-the-night-time-mollitia-quod-120b", "class": {"name": "Article"}, "title": " The Curious Incident of the Dog in the Night-Time Mollitia quod"}, "processed_html": "<p>Cray artisan health tofu intelligentsia.</p>\\n\\n"}}	1	Comment	2020-11-25 13:54:56.7336	\N	f	2020-11-25 13:54:56.733573	1
3	Moderation	2020-11-25 13:54:56.790299	{"user": {"id": 1, "name": "Kasey Rolfson", "path": "/rolfsonkasey", "class": {"name": "User"}, "username": "rolfsonkasey", "created_at": "2020-11-17T14:29:35.461Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"}, "comment": {"id": 2, "path": "/cremintressie/comment/2", "class": {"name": "Comment"}, "depth": 0, "ancestry": null, "ancestors": [], "created_at": "2020-11-17T14:29:41.635Z", "updated_at": "2020-11-17T14:29:41.647Z", "commentable": {"id": 10, "path": "/shanahan_laveta/the-far-distant-oxus-quo-dolorem-1l64", "class": {"name": "Article"}, "title": " The Far-Distant Oxus Quo dolorem"}, "processed_html": "<p>Next level health forage you probably haven't heard of them echo leggings shabby chic chia. Fixie lumbersexual pickled kombucha art party. Celiac heirloom tacos.</p>\\n\\n"}}	2	Comment	2020-11-25 13:54:56.790329	\N	f	2020-11-25 13:54:56.790299	2
4	Moderation	2020-11-25 13:54:56.800831	{"user": {"id": 1, "name": "Kasey Rolfson", "path": "/rolfsonkasey", "class": {"name": "User"}, "username": "rolfsonkasey", "created_at": "2020-11-17T14:29:35.461Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"}, "comment": {"id": 2, "path": "/cremintressie/comment/2", "class": {"name": "Comment"}, "depth": 0, "ancestry": null, "ancestors": [], "created_at": "2020-11-17T14:29:41.635Z", "updated_at": "2020-11-17T14:29:41.647Z", "commentable": {"id": 10, "path": "/shanahan_laveta/the-far-distant-oxus-quo-dolorem-1l64", "class": {"name": "Article"}, "title": " The Far-Distant Oxus Quo dolorem"}, "processed_html": "<p>Next level health forage you probably haven't heard of them echo leggings shabby chic chia. Fixie lumbersexual pickled kombucha art party. Celiac heirloom tacos.</p>\\n\\n"}}	2	Comment	2020-11-25 13:54:56.800855	\N	f	2020-11-25 13:54:56.800831	4
5	\N	2020-11-25 13:54:58.291419	{"user": {"id": 2, "name": "Tora Lesch", "path": "/tora_lesch", "class": {"name": "User"}, "username": "tora_lesch", "created_at": "2020-11-17T14:29:36.017Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/2/2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png"}, "badge_achievement": {"badge": {"title": "fugit 93", "description": "Voluptatem nobis voluptatem nihil.", "badge_image_url": "/uploads/badge/badge_image/2/21.png"}, "badge_id": 2, "rewarding_context_message": "\\n<code>Dicta.\\n</code>\\n\\n\\n    Enter fullscreen mode\\n    \\n\\n\\n    Exit fullscreen mode\\n    \\n\\n\\n\\n\\n\\n\\n\\n\\n"}}	1	BadgeAchievement	2020-11-25 13:54:58.291449	\N	f	2020-11-25 13:54:58.291419	2
6	\N	2020-11-25 13:55:00.088449	{"user": {"id": 4, "name": "Laveta Shanahan", "path": "/shanahan_laveta", "class": {"name": "User"}, "username": "shanahan_laveta", "created_at": "2020-11-17T14:29:36.583Z", "comments_count": 0, "profile_image_90": "/uploads/user/profile_image/4/8a0bc7f7-5387-45cb-8030-1a0020924ac9.png"}, "badge_achievement": {"badge": {"title": "magni 82", "description": "Ad minus soluta accusantium.", "badge_image_url": "/uploads/badge/badge_image/4/9.png"}, "badge_id": 4, "rewarding_context_message": "\\n\\n\\net\\nitaque\\neos\\n\\n\\n\\n\\nomnis\\ndicta\\nmaiores\\n\\n\\nvoluptas\\ndignissimos\\nnostrum\\n\\n\\n\\n\\n"}}	4	BadgeAchievement	2020-11-25 13:55:00.088479	\N	f	2020-11-25 13:55:00.088449	4
7	\N	2020-11-25 13:55:01.865145	{"user": {"id": 10, "name": "Tressie Cremin", "path": "/cremintressie", "class": {"name": "User"}, "username": "cremintressie", "created_at": "2020-11-17T14:29:38.351Z", "comments_count": 8, "profile_image_90": "/uploads/user/profile_image/10/eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png"}, "badge_achievement": {"badge": {"title": "magni 82", "description": "Ad minus soluta accusantium.", "badge_image_url": "/uploads/badge/badge_image/4/9.png"}, "badge_id": 4, "rewarding_context_message": "\\n  <a name=\\"aut\\" href=\\"#aut\\">\\n  </a>\\n  Aut\\n\\n\\n"}}	6	BadgeAchievement	2020-11-25 13:55:01.865178	\N	f	2020-11-25 13:55:01.865145	10
8	\N	2020-11-25 13:55:01.914008	{"user": {"id": 11, "name": "Admin McAdmin", "path": "/admin_mcadmin", "class": {"name": "User"}, "username": "admin_mcadmin", "created_at": "2020-11-17T14:29:38.868Z", "comments_count": 1, "profile_image_90": "/uploads/user/profile_image/11/b4e2aee0-d2d9-4c06-960a-d2d17dec7b10.png"}, "badge_achievement": {"badge": {"title": "magni 82", "description": "Ad minus soluta accusantium.", "badge_image_url": "/uploads/badge/badge_image/4/9.png"}, "badge_id": 4, "rewarding_context_message": "\\n  <a name=\\"eum\\" href=\\"#eum\\">\\n  </a>\\n  Eum\\n\\n\\nEveniet ea unde. Dolorem voluptatum vel. Qui sint odit.\\n\\n\\n  <a name=\\"qui\\" href=\\"#qui\\">\\n  </a>\\n  Qui\\n\\n\\n"}}	7	BadgeAchievement	2020-11-25 13:55:01.914053	\N	f	2020-11-25 13:55:01.914008	11
9	\N	2020-11-25 13:55:02.674838	{"user": {"id": 6, "name": "Jacob Lehner", "path": "/lehner_jacob", "class": {"name": "User"}, "username": "lehner_jacob", "created_at": "2020-11-17T14:29:37.195Z", "comments_count": 5, "profile_image_90": "/uploads/user/profile_image/6/8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png"}, "badge_achievement": {"badge": {"title": "doloribus 77", "description": "Fuga veniam officiis qui.", "badge_image_url": "/uploads/badge/badge_image/5/30.png"}, "badge_id": 5, "rewarding_context_message": "\\n\\n\\nfacilis\\nmolestiae\\nprovident\\n\\n\\n\\n\\nalias\\nconsequatur\\nfuga\\n\\n\\net\\nmolestias\\nvoluptatem\\n\\n\\n\\n\\n"}}	8	BadgeAchievement	2020-11-25 13:55:02.674872	\N	f	2020-11-25 13:55:02.674838	6
10	\N	2020-11-25 13:55:03.371839	{"user": {"id": 5, "name": "Gov. Guadalupe Hackett", "path": "/guadalupehackettgov", "class": {"name": "User"}, "username": "guadalupehackettgov", "created_at": "2020-11-17T14:29:36.911Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/5/63c914c9-9793-4b24-a6ec-1c1c1b4d453a.png"}, "badge_achievement": {"badge": {"title": "sed 27", "description": "Qui qui maxime cumque.", "badge_image_url": "/uploads/badge/badge_image/3/28.png"}, "badge_id": 3, "rewarding_context_message": "\\nEos. \\nAutem. \\nAd. \\nAlias. \\n\\n\\n"}}	9	BadgeAchievement	2020-11-25 13:55:03.371869	\N	f	2020-11-25 13:55:03.371839	5
11	\N	2020-11-25 13:55:03.692666	{"user": {"id": 8, "name": "Pablo Wiegand", "path": "/pablowiegand", "class": {"name": "User"}, "username": "pablowiegand", "created_at": "2020-11-17T14:29:37.765Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/8/6f0f13f0-2744-45e1-b8bf-ee4621a0b9ec.png"}, "badge_achievement": {"badge": {"title": "quis 62", "description": "Et molestiae ea reiciendis.", "badge_image_url": "/uploads/badge/badge_image/1/38.png"}, "badge_id": 1, "rewarding_context_message": "\\n  <a name=\\"quis\\" href=\\"#quis\\">\\n  </a>\\n  Quis\\n\\n\\n"}}	10	BadgeAchievement	2020-11-25 13:55:03.692698	\N	f	2020-11-25 13:55:03.692666	8
12	\N	2020-11-25 13:55:15.714714	{"user": {"id": 9, "name": "Esteban Marvin", "path": "/estebanmarvin", "class": {"name": "User"}, "username": "estebanmarvin", "created_at": "2020-11-17T14:29:38.099Z", "comments_count": 5, "profile_image_90": "/uploads/user/profile_image/9/75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png"}, "badge_achievement": {"badge": {"title": "fugit 93", "description": "Voluptatem nobis voluptatem nihil.", "badge_image_url": "/uploads/badge/badge_image/2/21.png"}, "badge_id": 2, "rewarding_context_message": "\\n<code>Soluta.\\n</code>\\n\\n\\n    Enter fullscreen mode\\n    \\n\\n\\n    Exit fullscreen mode\\n    \\n\\n\\n\\n\\n\\n\\n\\n\\n"}}	3	BadgeAchievement	2020-11-25 13:55:15.714761	\N	f	2020-11-25 13:55:15.714714	9
13	\N	2020-11-25 13:55:25.253626	{"user": {"id": 3, "name": "Dee McGlynn MD", "path": "/md_mcglynn_dee", "class": {"name": "User"}, "username": "md_mcglynn_dee", "created_at": "2020-11-17T14:29:36.297Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/3/9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png"}, "badge_achievement": {"badge": {"title": "magni 82", "description": "Ad minus soluta accusantium.", "badge_image_url": "/uploads/badge/badge_image/4/9.png"}, "badge_id": 4, "rewarding_context_message": "\\n  <a name=\\"id\\" href=\\"#id\\">\\n  </a>\\n  Id\\n\\n\\n"}}	5	BadgeAchievement	2020-11-25 13:55:25.253655	\N	f	2020-11-25 13:55:25.253626	3
14	\N	2020-11-25 13:55:28.126821	{"user": {"id": 1, "name": "Kasey Rolfson", "path": "/rolfsonkasey", "class": {"name": "User"}, "username": "rolfsonkasey", "created_at": "2020-11-17T14:29:35.461Z", "comments_count": 2, "profile_image_90": "/uploads/user/profile_image/1/8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png"}, "badge_achievement": {"badge": {"title": "fugit 93", "description": "Voluptatem nobis voluptatem nihil.", "badge_image_url": "/uploads/badge/badge_image/2/21.png"}, "badge_id": 2, "rewarding_context_message": "\\n  <a name=\\"aut\\" href=\\"#aut\\">\\n  </a>\\n  Aut\\n\\n\\nSuscipit molestias molestiae. Saepe ut voluptates. Excepturi est incidunt.\\n<code>Aut.</code>\\n\\n"}}	2	BadgeAchievement	2020-11-25 13:55:28.12685	\N	f	2020-11-25 13:55:28.126821	1
\.


--
-- Data for Name: oauth_access_grants; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.oauth_access_grants (id, application_id, created_at, expires_in, redirect_uri, resource_owner_id, revoked_at, scopes, token) FROM stdin;
\.


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.oauth_access_tokens (id, application_id, created_at, expires_in, previous_refresh_token, refresh_token, resource_owner_id, revoked_at, scopes, token) FROM stdin;
\.


--
-- Data for Name: oauth_applications; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.oauth_applications (id, confidential, created_at, name, redirect_uri, scopes, secret, uid, updated_at) FROM stdin;
\.


--
-- Data for Name: organization_memberships; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.organization_memberships (id, created_at, organization_id, type_of_user, updated_at, user_id, user_title) FROM stdin;
1	2020-11-17 14:29:38.412461	1	admin	2020-11-17 14:29:38.412461	6	\N
2	2020-11-17 14:29:38.476564	1	member	2020-11-17 14:29:38.476564	5	\N
3	2020-11-17 14:29:38.505225	1	member	2020-11-17 14:29:38.505225	3	\N
4	2020-11-17 14:29:38.53175	2	admin	2020-11-17 14:29:38.53175	8	\N
5	2020-11-17 14:29:38.573184	2	member	2020-11-17 14:29:38.573184	9	\N
6	2020-11-17 14:29:38.602485	2	member	2020-11-17 14:29:38.602485	2	\N
7	2020-11-17 14:29:38.629727	3	admin	2020-11-17 14:29:38.629727	9	\N
8	2020-11-17 14:29:38.664239	3	member	2020-11-17 14:29:38.664239	1	\N
9	2020-11-17 14:29:38.69417	3	member	2020-11-17 14:29:38.69417	7	\N
10	2020-12-02 14:02:01.945844	4	admin	2020-12-02 14:02:01.945844	12	\N
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.organizations (id, articles_count, bg_color_hex, company_size, created_at, credits_count, cta_body_markdown, cta_button_text, cta_button_url, cta_processed_html, dark_nav_image, email, github_username, last_article_at, location, name, nav_image, old_old_slug, old_slug, profile_image, profile_updated_at, proof, secret, slug, spent_credits_count, story, summary, tag_line, tech_stack, text_color_hex, twitter_username, unspent_credits_count, updated_at, url, processed_story_html) FROM stdin;
1	0	#b67d87	\N	2020-11-17 14:29:31.801508	0	\N	\N	\N	\N	\N	\N	org1821	2017-01-01 05:00:00	\N	Raviga Capital Management	\N	\N	\N	08a7e7b5-5e52-4394-8dae-7342f88659fd.png	2017-01-01 05:00:00	\N	92539ee52f73d4c069496a9d667476bb7626905cb3a6e3d30ce62b901c83cfe443c2bde0aab88d777be6068e50bd4ccb0fb9	org9645	0	\N	streamline customized markets	\N	\N	#d56d41	org8977	0	2020-11-17 14:29:31.801508	http://littel-lebsack.org/reinaldo.hickle	\N
2	0	#5744e7	\N	2020-11-17 14:29:32.780353	0	\N	\N	\N	\N	\N	\N	org780	2017-01-01 05:00:00	\N	Endframe	\N	\N	\N	125420bb-4c79-43a4-bcd9-2c003c8765a8.png	2017-01-01 05:00:00	\N	ba9e79dfa64863d6fd0b13fc573b1ab6c382bcd3cf300a7fed01115c6619ac836f28936f256d96fbb094bf77919cfd3b3b28	org9024	0	\N	productize interactive vortals	\N	\N	#b92606	org8882	0	2020-11-17 14:29:32.780353	http://wisoky.net/bunny	\N
3	0	#7b3a41	\N	2020-11-17 14:29:34.079124	0	\N	\N	\N	\N	\N	\N	org1524	2017-01-01 05:00:00	\N	Coleman-Blair	\N	\N	\N	92fcf645-4c2c-4686-8034-a316606fba1f.png	2017-01-01 05:00:00	\N	cb3e0035e91a88b39ce27b0750d2dccfb42c5ff52704b9241f7764e9338197899e21b576680fdbdf2fdf84a2e403fb543097	org7530	0	\N	strategize killer methodologies	\N	\N	#920551	org9406	0	2020-11-17 14:29:34.079124	http://dibbert.io/emmie	\N
4	0	#000000		2020-12-02 14:02:01.908305	0	test youtube link\r\n{% youtube tb_WGzpNErs %}			<p>test youtube link<br>\n{% youtube tb_WGzpNErs %}</p>\n	\N		github123	2017-01-01 05:00:00		Test Organization	\N	\N	\N	32930470-c8e8-4629-8561-b8e9cf98e7a6.png	2020-12-03 12:31:51.457274	test	b6d9fcb478d88b44476b7573eda2ac1d154dfc0d598ad3859d52f05f4bfbd5276de98469c1946a2c698a9dfe7d3fc9e60f88	test-org	0	test youtube link\r\n{% youtube tb_WGzpNErs %}	hello summary			#000000	twitter123	0	2020-12-03 12:31:51.474325	https://testurl123333.com	<p>test youtube link<br>\n<iframe width="710" height="399" src="https://www.youtube.com/embed/tb_WGzpNErs" allowfullscreen loading="lazy">\n</iframe>\n</p>\n\n
\.


--
-- Data for Name: page_views; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.page_views (id, article_id, counts_for_number_of_views, created_at, domain, path, referrer, time_tracked_in_seconds, updated_at, user_agent, user_id) FROM stdin;
1	2	1	2020-12-02 12:39:29.004549	\N			15	2020-12-02 12:39:29.004549	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
2	2	1	2020-12-02 12:42:14.610093	\N			30	2020-12-02 12:42:14.610093	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
3	27	1	2020-12-02 12:43:42.996892	\N	/new	http://localhost:3000/new	15	2020-12-02 12:43:42.996892	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
4	27	1	2020-12-02 12:44:06.099847	\N	/muzzamil123/test-post-1eln/edit	http://localhost:3000/muzzamil123/test-post-1eln/edit	15	2020-12-02 12:44:06.099847	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
5	2	1	2020-12-02 12:44:12.506972	\N	/muzzamil123/test-post-1eln/edit	http://localhost:3000/muzzamil123/test-post-1eln/edit	15	2020-12-02 12:44:12.506972	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
9	28	1	2020-12-03 13:23:16.404442	\N			60	2020-12-03 13:23:16.404442	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
10	28	1	2020-12-03 13:24:06.677479	\N			15	2020-12-03 13:24:06.677479	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
7	28	1	2020-12-03 11:58:08.218945	\N	/new	http://localhost:3000/new	1170	2020-12-03 11:58:08.218945	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
27	32	1	2021-01-14 12:22:02.740087	\N	/admin	http://localhost:3000/admin	120	2021-01-14 12:22:02.740087	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
22	29	1	2021-01-07 12:23:35.76285	\N			195	2021-01-07 12:23:35.76285	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
23	25	1	2021-01-14 12:19:00.91531	\N	/admin	http://localhost:3000/admin	15	2021-01-14 12:19:00.91531	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
24	32	1	2021-01-14 12:19:06.207512	\N	/admin	http://localhost:3000/admin	30	2021-01-14 12:19:06.207512	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
25	8	1	2021-01-14 12:20:23.592582	\N	/admin	http://localhost:3000/admin	90	2021-01-14 12:20:23.592582	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
6	28	1	2020-12-03 11:36:52.50129	\N	/new	http://localhost:3000/new	1275	2020-12-03 11:36:52.50129	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
11	28	1	2020-12-03 13:24:15.517563	\N			1800	2020-12-03 13:24:15.517563	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
12	4	1	2020-12-03 14:38:50.884037	\N			15	2020-12-03 14:38:50.884037	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
13	19	1	2020-12-03 14:39:03.876154	\N			15	2020-12-03 14:39:03.876154	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
14	29	1	2020-12-20 09:10:52.361156	\N	/new	http://localhost:3000/new	15	2020-12-20 09:10:52.361156	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
15	26	1	2020-12-20 10:03:37.007806	\N	/admin/welcome	http://localhost:3000/admin/welcome	15	2020-12-20 10:03:37.007806	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
16	30	1	2021-01-03 16:50:25.349768	\N	/new	http://localhost:3000/new	15	2021-01-03 16:50:25.349768	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	24
17	31	1	2021-01-03 16:53:55.212866	\N	/new	http://localhost:3000/new	15	2021-01-03 16:53:55.212866	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	24
18	31	1	2021-01-03 16:54:18.137293	\N	/new	http://localhost:3000/new	15	2021-01-03 16:54:18.137293	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	24
19	32	1	2021-01-04 11:45:29.020244	\N	/new	http://localhost:3000/new	15	2021-01-04 11:45:29.020244	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
8	28	1	2020-12-03 12:43:28.84991	\N			1770	2020-12-03 12:43:28.84991	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
20	25	1	2021-01-07 12:11:09.790867	\N			15	2021-01-07 12:11:09.790867	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
21	25	1	2021-01-07 12:11:40.774728	\N			15	2021-01-07 12:11:40.774728	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
26	28	1	2021-01-14 12:21:51.725137	\N	/admin	http://localhost:3000/admin	30	2021-01-14 12:21:51.725137	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
29	28	1	2021-01-14 12:23:07.322049	\N			15	2021-01-14 12:23:07.322049	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
28	32	1	2021-01-14 12:23:01.813342	\N			30	2021-01-14 12:23:01.813342	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
30	32	1	2021-01-14 12:23:17.138887	\N			15	2021-01-14 12:23:17.138887	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
31	32	1	2021-01-14 12:23:45.002396	\N			15	2021-01-14 12:23:45.002396	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
32	8	1	2021-01-14 12:24:36.655907	\N			15	2021-01-14 12:24:36.655907	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
33	8	1	2021-01-14 12:24:55.454429	\N			15	2021-01-14 12:24:55.454429	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36	12
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.pages (id, body_html, body_json, body_markdown, created_at, description, is_top_level_path, processed_html, slug, social_image, template, title, updated_at) FROM stdin;
1	\N	\N	* Soluta. \n	2020-11-17 14:29:46.460129	Growth is limited by that necessity which is present in the least amount. And, naturally, the least favorable condition controls the growth rate.	f	<ul>\n<li>Soluta. </li>\n</ul>\n\n	illum_officiis	\N	full_within_layout	Connecting the port won't do anything, we need to copy the cross-platform ftp card!	2020-11-17 14:29:46.460129
2	\N	\N	# Qui	2020-11-17 14:29:46.481248	In shield fighting, one moves fast on defense, slow on attack. Attack has the sole purpose of tricking the opponent into a misstep, setting him up for the attack sinister. The shield turns the fast blow, admits the slow kindjal!	f	<h1>\n  <a name="qui" href="#qui" class="anchor">\n  </a>\n  Qui\n</h1>\n\n	vel-accusantium	\N	full_within_layout	Quantifying the sensor won't do anything, we need to hack the optical thx matrix!	2020-11-17 14:29:46.481248
3	\N	\N	# Iste\nVoluptatem et doloremque. Et commodi aut. Eligendi officia saepe.\n##### Dolores	2020-11-17 14:29:46.50547	And you, my son, are you one who gives or one who takes?	f	<h1>\n  <a name="iste" href="#iste" class="anchor">\n  </a>\n  Iste\n</h1>\n\n<p>Voluptatem et doloremque. Et commodi aut. Eligendi officia saepe.</p>\n\n<h5>\n  <a name="dolores" href="#dolores" class="anchor">\n  </a>\n  Dolores\n</h5>\n\n	dolorem_est	\N	full_within_layout	If we back up the microchip, we can get to the SAS monitor through the bluetooth SSL microchip!	2020-11-17 14:29:46.50547
4	\N	\N	autem | nesciunt | consequatur\n---- | ---- | ----\nad | ut | et\nfacilis | saepe | adipisci	2020-11-17 14:29:46.525385	The Guild... they're fighting me in the mental vaults. They're behind everything. They fear the one who will come, who will know more, who will see more. The Guild is behind everything. It's not finished yet. I'm not formed.	f	<div class="table-wrapper-paragraph"><table>\n<thead>\n<tr>\n<th>autem</th>\n<th>nesciunt</th>\n<th>consequatur</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>ad</td>\n<td>ut</td>\n<td>et</td>\n</tr>\n<tr>\n<td>facilis</td>\n<td>saepe</td>\n<td>adipisci</td>\n</tr>\n</tbody>\n</table></div>\n\n	officia_reprehenderit	\N	contained	Use the back-end EXE sensor, then you can navigate the mobile array!	2020-11-17 14:29:46.525385
5	\N	\N	omnis | ut | eos\n---- | ---- | ----\net | ut | est\nesse | aliquid | iure	2020-11-17 14:29:46.545666	A human can control his instincts. Your instinct will be to draw your hand out of the box. You do, you die.	f	<div class="table-wrapper-paragraph"><table>\n<thead>\n<tr>\n<th>omnis</th>\n<th>ut</th>\n<th>eos</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>et</td>\n<td>ut</td>\n<td>est</td>\n</tr>\n<tr>\n<td>esse</td>\n<td>aliquid</td>\n<td>iure</td>\n</tr>\n</tbody>\n</table></div>\n\n	quisquam-voluptas	\N	full_within_layout	We need to input the mobile AI hard drive!	2020-11-17 14:29:46.545666
\.


--
-- Data for Name: payment_providers; Type: TABLE DATA; Schema: public; Owner: forem_latest
--

COPY public.payment_providers (id, external_id, access_token, refresh_token, descriptor, user_id, created_at, updated_at) FROM stdin;
14	acct_1I4S1kQUGi3AIkcJ	sk_test_51I4S1kQUGi3AIkcJOCrFCvhJaD4XLuN1uQ9dra9ZnWHyzsM6I5eUnnPKBWGQ3PrhH6UaRQvTC7p3gkyh0TXsMbGq00gLIur9dx	rt_IfneX47CIsCg2EaMV8KfuCx10orLtT115A1Evp555wBlv1cC	\N	19	2020-12-31 14:20:53.787988	2020-12-31 14:22:28.299081
15	\N	\N	\N	\N	31	2021-01-09 13:36:23.341213	2021-01-09 13:36:23.341213
\.


--
-- Data for Name: podcast_episodes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.podcast_episodes (id, any_comments_hidden, body, comments_count, created_at, duration_in_seconds, guid, https, image, itunes_url, media_url, podcast_id, processed_html, published_at, quote, reachable, reactions_count, slug, social_image, status_notice, subtitle, summary, title, updated_at, website_url) FROM stdin;
3	f	So you're excited about that next app you're about to build. You can visualize the APIs with the smooth scalability taking to the mobile apps. You can see how, finally, this time, you'll get deployment right and it'll be pure continuous delivery out of GitHub with zero downtime.	0	2020-11-26 12:16:32.547748	\N	<guid>ebebbc9b-0753-4ef9-92da-89d4790d3fb2</guid>	t	\N	\N	https://talkpython.fm/episodes/download/292/pythonic-identity-auth-in-python-ecosystem.mp3	8	<p>So you're excited about that next app you're about to build. You can visualize the APIs with the smooth scalability taking to the mobile apps. You can see how, finally, this time, you'll get deployment right and it'll be pure continuous delivery out of GitHub with zero downtime.</p>	2020-11-26 00:00:00	\N	t	0	292-pythonic-identity-auth-in-python-ecosystem	\N	\N		So you're excited about that next app you're about to build. You can visualize the APIs with the smooth scalability taking to the mobile apps. You can see how, finally, this time, you'll get deployment right and it'll be pure continuous delivery out of GitHub with zero downtime.	#292 Pythonic identity (auth in Python ecosystem)	2020-11-26 12:16:34.876519	https://talkpython.fm/episodes/show/292/pythonic-identity-auth-in-python-ecosystem
1	f	NASA's Jet Propulsion Laboratory (JPL)'s primary function is the construction and operation of planetary robotic spacecraft, though it also conducts Earth- orbit and astronomy missions. It is also responsible for operating NASA's Deep Space Network.	0	2020-11-26 12:16:32.895656	\N	<guid>2e42453c-eb70-499c-94f8-38156f39b2f5</guid>	t	\N	\N	https://talkpython.fm/episodes/download/286/python-and-ml-at-nasa-jet-propulsion-laboratory-jpl.mp3	8	<p>NASA's Jet Propulsion Laboratory (JPL)'s primary function is the construction and operation of planetary robotic spacecraft, though it also conducts Earth- orbit and astronomy missions. It is also responsible for operating NASA's Deep Space Network.</p>	2020-10-16 00:00:00	\N	t	0	286-python-and-ml-at-nasa-jet-propulsion-laboratory-jpl	\N	\N		NASA's Jet Propulsion Laboratory (JPL)'s primary function is the construction and operation of planetary robotic spacecraft, though it also conducts Earth- orbit and astronomy missions. It is also responsible for operating NASA's Deep Space Network.	#286 Python and ML at NASA Jet Propulsion Laboratory (JPL)	2020-11-26 12:16:34.887993	https://talkpython.fm/episodes/show/286/python-and-ml-at-nasa-jet-propulsion-laboratory-jpl
4	f	As Python 3 has eclipsed the old constrains of Python 2 and web frameworks that adopted them, we have seen a big jump in new frameworks appearing on the scene taking full advantage of things like type hints, async and await, and more.	0	2020-11-26 12:16:32.924496	\N	<guid>d08bde64-090e-4112-8f9e-d9088668e4d8</guid>	t	\N	\N	https://talkpython.fm/episodes/download/284/modern-and-fast-apis-with-fastapi.mp3	8	<p>As Python 3 has eclipsed the old constrains of Python 2 and web frameworks that adopted them, we have seen a big jump in new frameworks appearing on the scene taking full advantage of things like type hints, async and await, and more.</p>	2020-10-04 00:00:00	\N	t	0	284-modern-and-fast-apis-with-fastapi	\N	\N		As Python 3 has eclipsed the old constrains of Python 2 and web frameworks that adopted them, we have seen a big jump in new frameworks appearing on the scene taking full advantage of things like type hints, async and await, and more.	#284 Modern and fast APIs with FastAPI	2020-11-26 12:16:34.892091	https://talkpython.fm/episodes/show/284/modern-and-fast-apis-with-fastapi
9	f	Excel is one of the most used and most empowering piece of software out there. But that doesn't make it a good fit for every data processing need. And when you outgrow Excel, a really good option for a next step is Python and the data science tech stack: Pandas, Jupyter, and friends.	0	2020-11-26 12:16:32.870795	\N	<guid>088a2aba-c925-4966-be73-2fef56030d95</guid>	t	\N	\N	https://talkpython.fm/episodes/download/288/10-tips-to-move-from-excel-to-python.mp3	8	<p>Excel is one of the most used and most empowering piece of software out there. But that doesn't make it a good fit for every data processing need. And when you outgrow Excel, a really good option for a next step is Python and the data science tech stack: Pandas, Jupyter, and friends.</p>	2020-10-31 00:00:00	\N	t	0	288-10-tips-to-move-from-excel-to-python	\N	\N		Excel is one of the most used and most empowering piece of software out there. But that doesn't make it a good fit for every data processing need. And when you outgrow Excel, a really good option for a next step is Python and the data science tech stack: Pandas, Jupyter, and friends.	#288 10 tips to move from Excel to Python	2020-11-26 12:16:35.045771	https://talkpython.fm/episodes/show/288/10-tips-to-move-from-excel-to-python
13	f	If there has ever been a time in history that journalism is needed to shine a light on what's happening in the world, it's now. Would it surprise you to hear that Python and machine learning are playing an increasingly important role in discovering and bringing us the news? On this episode, you'll meet Carolyn Stansky, a journalist and developer who's been researching this intersection.	0	2020-11-26 12:16:34.99492	\N	<guid>c53300a8-339e-4190-922b-47e28fc8b070</guid>	t	\N	\N	https://talkpython.fm/episodes/download/280/python-and-ai-in-journalism.mp3	8	<p>If there has ever been a time in history that journalism is needed to shine a light on what's happening in the world, it's now. Would it surprise you to hear that Python and machine learning are playing an increasingly important role in discovering and bringing us the news? On this episode, you'll meet Carolyn Stansky, a journalist and developer who's been researching this intersection.</p>	2020-09-05 00:00:00	\N	t	0	280-python-and-ai-in-journalism	\N	\N		If there has ever been a time in history that journalism is needed to shine a light on what's happening in the world, it's now. Would it surprise you to hear that Python and machine learning are playing an increasingly important role in discovering and bringing us the news? On this episode, you'll meet Carolyn Stansky, a journalist and developer who's been researching this intersection.	#280 Python and AI in Journalism	2020-11-26 12:16:36.787522	https://talkpython.fm/episodes/show/280/python-and-ai-in-journalism
25	f	Do you write tests for your code? You probably should. And most of the time, pytest is the industry standard these days. But pytest can be much more than what you get from just installing it as a tool.	0	2020-11-26 12:16:37.263461	\N	<guid>d2840c59-ecb2-47aa-801b-e22ad502a7ad</guid>	t	\N	\N	https://talkpython.fm/episodes/download/267/15-amazing-pytest-plugins.mp3	8	<p>Do you write tests for your code? You probably should. And most of the time, pytest is the industry standard these days. But pytest can be much more than what you get from just installing it as a tool.</p>	2020-06-06 00:00:00	\N	t	0	267-15-amazing-pytest-plugins	\N	\N		Do you write tests for your code? You probably should. And most of the time, pytest is the industry standard these days. But pytest can be much more than what you get from just installing it as a tool.	#267 15 amazing pytest plugins	2020-11-26 12:16:41.298408	https://talkpython.fm/episodes/show/267/15-amazing-pytest-plugins
5	f	Are you a data scientist looking to branch out on your own and start something new? Maybe you're just looking for a way to work with those exciting libraries that aren't yet in play at the day job. Rather than putting everything on the line, quitting your job, and hoping things work out, maybe you should start with a side-hustle.	0	2020-11-26 12:16:32.849239	\N	<guid>fc40dc84-15bc-4367-a900-e4ca28278616</guid>	t	\N	\N	https://talkpython.fm/episodes/download/290/side-hustles-for-data-scientists.mp3	8	<p>Are you a data scientist looking to branch out on your own and start something new? Maybe you're just looking for a way to work with those exciting libraries that aren't yet in play at the day job. Rather than putting everything on the line, quitting your job, and hoping things work out, maybe you should start with a side-hustle.</p>	2020-11-13 00:00:00	\N	t	0	290-side-hustles-for-data-scientists	\N	\N		Are you a data scientist looking to branch out on your own and start something new? Maybe you're just looking for a way to work with those exciting libraries that aren't yet in play at the day job. Rather than putting everything on the line, quitting your job, and hoping things work out, maybe you should start with a side-hustle.	#290 Side Hustles for Data Scientists	2020-11-26 12:16:34.902406	https://talkpython.fm/episodes/show/290/side-hustles-for-data-scientists
8	f	If you're into data science, you've probably heard about Dask. It's a package that feels like familiar APIs such as Numpy, Pandas, and Scikit-Learn. Yet it can scale that computation across CPU cores on your local machine all the way to distributed grid-based computing in large clusters.	0	2020-11-26 12:16:32.909674	\N	<guid>5a27efbe-837f-43c0-a1d3-a0ae6bd795c1</guid>	t	\N	\N	https://talkpython.fm/episodes/download/285/dask-as-a-platform-service-with-coiled.mp3	8	<p>If you're into data science, you've probably heard about Dask. It's a package that feels like familiar APIs such as Numpy, Pandas, and Scikit-Learn. Yet it can scale that computation across CPU cores on your local machine all the way to distributed grid-based computing in large clusters.</p>	2020-10-09 00:00:00	\N	t	0	285-dask-as-a-platform-service-with-coiled	\N	\N		If you're into data science, you've probably heard about Dask. It's a package that feels like familiar APIs such as Numpy, Pandas, and Scikit-Learn. Yet it can scale that computation across CPU cores on your local machine all the way to distributed grid-based computing in large clusters.	#285 Dask as a Platform Service with Coiled	2020-11-26 12:16:35.065352	https://talkpython.fm/episodes/show/285/dask-as-a-platform-service-with-coiled
11	f	I love to bring you stories of Python being used in amazing places outside the traditional tech silos of pure web development and data science. On this episode, you'll meet Robert "Kane" Replogle, who works on the simulation and test software at Richard Childress Racing. The NASCAR team that just finished #1 and 2 in at the Texas Motor Speedway.	0	2020-11-26 12:16:34.990612	\N	<guid>83a2d674-80d5-47ed-bdb2-07b9ef0d8927</guid>	t	\N	\N	https://talkpython.fm/episodes/download/281/python-in-car-racing.mp3	8	<p>I love to bring you stories of Python being used in amazing places outside the traditional tech silos of pure web development and data science. On this episode, you'll meet Robert "Kane" Replogle, who works on the simulation and test software at Richard Childress Racing. The NASCAR team that just finished #1 and 2 in at the Texas Motor Speedway.</p>	2020-09-09 00:00:00	\N	t	0	281-python-in-car-racing	\N	\N		I love to bring you stories of Python being used in amazing places outside the traditional tech silos of pure web development and data science. On this episode, you'll meet Robert "Kane" Replogle, who works on the simulation and test software at Richard Childress Racing. The NASCAR team that just finished #1 and 2 in at the Texas Motor Speedway.	#281 Python in Car Racing	2020-11-26 12:16:36.772192	https://talkpython.fm/episodes/show/281/python-in-car-racing
23	f	Time is a simple thing, right? And working with it in Python is great. You just import datetime and then (somewhat oddly) use the datetime class from that module.	0	2020-11-26 12:16:36.836583	\N	<guid>0ec463af-7389-4d43-a908-3861143562c4</guid>	t	\N	\N	https://talkpython.fm/episodes/download/271/unlock-the-mysteries-of-time-pythons-datetime-that-is.mp3	8	<p>Time is a simple thing, right? And working with it in Python is great. You just import datetime and then (somewhat oddly) use the datetime class from that module.</p>	2020-07-04 00:00:00	\N	t	0	271-unlock-the-mysteries-of-time-python-s-datetime-that-is	\N	\N		Time is a simple thing, right? And working with it in Python is great. You just import datetime and then (somewhat oddly) use the datetime class from that module.	#271 Unlock the mysteries of time, Python's datetime that is!	2020-11-26 12:16:40.590845	https://talkpython.fm/episodes/show/271/unlock-the-mysteries-of-time-pythons-datetime-that-is
24	f	Are you using interactive notebooks for your data exploration or day-to-day programming? What environment do you use? Was it Jupyter and now you've made the move to JupyterLab? That's a great choice. But did you know there are more environments out there to choose from and compare? Have you heard of Callisto or Iodide? How about CoCalc or PolyNote? That's just the tip of the iceberg!	0	2020-11-26 12:16:36.896668	\N	<guid>b98f65e7-3605-4fc2-a5cb-442b863d0a36</guid>	t	\N	\N	https://talkpython.fm/episodes/download/268/analyzing-dozens-of-notebook-environments.mp3	8	<p>Are you using interactive notebooks for your data exploration or day-to-day programming? What environment do you use? Was it Jupyter and now you've made the move to JupyterLab? That's a great choice. But did you know there are more environments out there to choose from and compare? Have you heard of Callisto or Iodide? How about CoCalc or PolyNote? That's just the tip of the iceberg!</p>	2020-06-13 00:00:00	\N	t	0	268-analyzing-dozens-of-notebook-environments	\N	\N		Are you using interactive notebooks for your data exploration or day-to-day programming? What environment do you use? Was it Jupyter and now you've made the move to JupyterLab? That's a great choice. But did you know there are more environments out there to choose from and compare? Have you heard of Callisto or Iodide? How about CoCalc or PolyNote? That's just the tip of the iceberg!	#268 Analyzing dozens of notebook environments	2020-11-26 12:16:40.748776	https://talkpython.fm/episodes/show/268/analyzing-dozens-of-notebook-environments
2	f	We know our unit tests should be relatively independent from other parts of the system. For example, running a test shouldn't generally call a credit card possessing API and talk to a database when your goal is just to test the argument validation.	0	2020-11-26 12:16:32.886814	\N	<guid>1f88487c-01a6-4a2e-9e72-d950459def85</guid>	t	\N	\N	https://talkpython.fm/episodes/download/287/testing-without-dependencies-mocking-in-python.mp3	8	<p>We know our unit tests should be relatively independent from other parts of the system. For example, running a test shouldn't generally call a credit card possessing API and talk to a database when your goal is just to test the argument validation.</p>	2020-10-21 00:00:00	\N	t	0	287-testing-without-dependencies-mocking-in-python	\N	\N		We know our unit tests should be relatively independent from other parts of the system. For example, running a test shouldn't generally call a credit card possessing API and talk to a database when your goal is just to test the argument validation.	#287 Testing without dependencies, mocking in Python	2020-11-26 12:16:34.904849	https://talkpython.fm/episodes/show/287/testing-without-dependencies-mocking-in-python
10	f	Web scraping is pulling the HTML of a website down and parsing useful data out of it. The use-cases for this type of functionality are endless. Have a bunch of data on governmental sites that are only listed online in HTML without a download? There's an API for that! Do you want to keep abreast of what your competitors are featuring on their site? There's an API for that. Need alerts for changes on a website, for example enrollment is now open at your college and you want to be first to get in and avoid the 8am Monday morning course slot? There's an API for that.	0	2020-11-26 12:16:33.078652	\N	<guid>e70d2450-826c-43da-85c3-e3f38b17e501</guid>	t	\N	\N	https://talkpython.fm/episodes/download/283/web-scraping-the-2020-edition.mp3	8	<p>Web scraping is pulling the HTML of a website down and parsing useful data out of it. The use-cases for this type of functionality are endless. Have a bunch of data on governmental sites that are only listed online in HTML without a download? There's an API for that! Do you want to keep abreast of what your competitors are featuring on their site? There's an API for that. Need alerts for changes on a website, for example enrollment is now open at your college and you want to be first to get in and avoid the 8am Monday morning course slot? There's an API for that.</p>	2020-09-23 00:00:00	\N	t	0	283-web-scraping-the-2020-edition	\N	\N		Web scraping is pulling the HTML of a website down and parsing useful data out of it. The use-cases for this type of functionality are endless. Have a bunch of data on governmental sites that are only listed online in HTML without a download? There's an API for that! Do you want to keep abreast of what your competitors are featuring on their site? There's an API for that. Need alerts for changes on a website, for example enrollment is now open at your college and you want to be first to get in and avoid the 8am Monday morning course slot? There's an API for that.	#283 Web scraping, the 2020 edition	2020-11-26 12:16:35.054451	https://talkpython.fm/episodes/show/283/web-scraping-the-2020-edition
12	f	Python is quick and easy to learn. And yet, there is a massive gap between knowing the common aspects of the language (loops, variables, functions, and so on) and how to write a well-factored application using modern tools and libraries. That's where learning Python is a never-ending journey.	0	2020-11-26 12:16:34.997422	\N	<guid>744c41cc-4b57-4df8-82d4-adc0e7cda2e8</guid>	t	\N	\N	https://talkpython.fm/episodes/download/279/modern-python-developers-toolkit.mp3	8	<p>Python is quick and easy to learn. And yet, there is a massive gap between knowing the common aspects of the language (loops, variables, functions, and so on) and how to write a well-factored application using modern tools and libraries. That's where learning Python is a never-ending journey.</p>	2020-08-29 00:00:00	\N	t	0	279-modern-python-developer-s-toolkit	\N	\N		Python is quick and easy to learn. And yet, there is a massive gap between knowing the common aspects of the language (loops, variables, functions, and so on) and how to write a well-factored application using modern tools and libraries. That's where learning Python is a never-ending journey.	#279 Modern Python Developer's Toolkit	2020-11-26 12:16:36.767477	https://talkpython.fm/episodes/show/279/modern-python-developers-toolkit
19	f	We recently covered 10 tips that every Flask developer should know. But we left out a pretty big group in the Python web space: Django developers! And this one is for you. I invited Bob Belderbos, who's been running his SaaS business on Python and Django for several years now, to share his tips and tricks.	0	2020-11-26 12:16:35.107321	\N	<guid>1e7f93b7-5960-418c-84ad-41cec782ed98</guid>	t	\N	\N	https://talkpython.fm/episodes/download/277/10-tips-every-django-developer-should-know.mp3	8	<p>We recently covered 10 tips that every Flask developer should know. But we left out a pretty big group in the Python web space: Django developers! And this one is for you. I invited Bob Belderbos, who's been running his SaaS business on Python and Django for several years now, to share his tips and tricks.</p>	2020-08-10 00:00:00	\N	t	0	277-10-tips-every-django-developer-should-know	\N	\N		We recently covered 10 tips that every Flask developer should know. But we left out a pretty big group in the Python web space: Django developers! And this one is for you. I invited Bob Belderbos, who's been running his SaaS business on Python and Django for several years now, to share his tips and tricks.	#277 10 tips every Django developer should know	2020-11-26 12:16:38.049984	https://talkpython.fm/episodes/show/277/10-tips-every-django-developer-should-know
6	f	When I saw the headline "Machine learning algorithm confirms 50 new exoplanets in historic first" I knew the Python angle of this story had to be told! And that's how this episode was born. Join David Armstrong and Jev Gamper as they tell us how they use Python and machine learning to discover not 1, but 50 new exoplanets in pre-existing Keplar satellite data.	0	2020-11-26 12:16:32.861485	\N	<guid>8cd803fe-7bd9-4945-9abb-ea67829a103d</guid>	t	\N	\N	https://talkpython.fm/episodes/download/289/discovering-exoplanets-with-python.mp3	8	<p>When I saw the headline "Machine learning algorithm confirms 50 new exoplanets in historic first" I knew the Python angle of this story had to be told! And that's how this episode was born. Join David Armstrong and Jev Gamper as they tell us how they use Python and machine learning to discover not 1, but 50 new exoplanets in pre-existing Keplar satellite data.</p>	2020-11-09 00:00:00	\N	t	0	289-discovering-exoplanets-with-python	\N	\N		When I saw the headline "Machine learning algorithm confirms 50 new exoplanets in historic first" I knew the Python angle of this story had to be told! And that's how this episode was born. Join David Armstrong and Jev Gamper as they tell us how they use Python and machine learning to discover not 1, but 50 new exoplanets in pre-existing Keplar satellite data.	#289 Discovering exoplanets with Python	2020-11-26 12:16:34.994537	https://talkpython.fm/episodes/show/289/discovering-exoplanets-with-python
7	f	Do you have a scientific system that needs optimization or solving? Our guest, on this episode, Clark Petri is here to tell us all about pyomo. This is a library that can solve all sorts of cool problems, linear programming, nonlinear equations, and many other things you can throw at it.	0	2020-11-26 12:16:32.562959	\N	<guid>a821e743-d4e3-4eb8-a48d-79de1676a367</guid>	t	\N	\N	https://talkpython.fm/episodes/download/291/operational-resilience-with-pyomo.mp3	8	<p>Do you have a scientific system that needs optimization or solving? Our guest, on this episode, Clark Petri is here to tell us all about pyomo. This is a library that can solve all sorts of cool problems, linear programming, nonlinear equations, and many other things you can throw at it.</p>	2020-11-22 00:00:00	\N	t	0	291-operational-resilience-with-pyomo	\N	\N		Do you have a scientific system that needs optimization or solving? Our guest, on this episode, Clark Petri is here to tell us all about pyomo. This is a library that can solve all sorts of cool problems, linear programming, nonlinear equations, and many other things you can throw at it.	#291 Operational Resilience with Pyomo	2020-11-26 12:16:35.04922	https://talkpython.fm/episodes/show/291/operational-resilience-with-pyomo
14	f	If there is one message I've been pushing across all of the Talk Python episodes, it's that programming is a superpower. Rather than all of us abandoning what we're interested in and becoming CS majors, we can take our passion or expertise and 10x it with a little programming skill.	0	2020-11-26 12:16:34.996494	\N	<guid>fbff036d-1d7c-445b-9b64-f5a3dcccfc67</guid>	t	\N	\N	https://talkpython.fm/episodes/download/278/teach-kids-python-with-real-programming-and-fun-games-at-code-combat.mp3	8	<p>If there is one message I've been pushing across all of the Talk Python episodes, it's that programming is a superpower. Rather than all of us abandoning what we're interested in and becoming CS majors, we can take our passion or expertise and 10x it with a little programming skill.</p>	2020-08-21 00:00:00	\N	t	0	278-teach-kids-python-with-real-programming-and-fun-games-at-code-combat	\N	\N		If there is one message I've been pushing across all of the Talk Python episodes, it's that programming is a superpower. Rather than all of us abandoning what we're interested in and becoming CS majors, we can take our passion or expertise and 10x it with a little programming skill.	#278 Teach kids Python with real programming and fun games at Code Combat	2020-11-26 12:16:36.790949	https://talkpython.fm/episodes/show/278/teach-kids-python-with-real-programming-and-fun-games-at-code-combat
20	f	Do you write data science code? Do you struggle loading large amounts of data or wonder what parts of your code use the maximum amount of memory? Maybe you just want to require smaller compute resources (servers, RAM, and so on).	0	2020-11-26 12:16:35.119756	\N	<guid>70fb730a-68de-4978-b793-aa88cbb6f61e</guid>	t	\N	\N	https://talkpython.fm/episodes/download/274/profiling-data-science-code-with-fil.mp3	8	<p>Do you write data science code? Do you struggle loading large amounts of data or wonder what parts of your code use the maximum amount of memory? Maybe you just want to require smaller compute resources (servers, RAM, and so on).</p>	2020-07-24 00:00:00	\N	t	0	274-profiling-data-science-code-with-fil	\N	\N		Do you write data science code? Do you struggle loading large amounts of data or wonder what parts of your code use the maximum amount of memory? Maybe you just want to require smaller compute resources (servers, RAM, and so on).	#274 Profiling data science code with FIL	2020-11-26 12:16:38.133523	https://talkpython.fm/episodes/show/274/profiling-data-science-code-with-fil
21	f	The toolchain for modern data science can be intimidating. How do you choose between all the data visualization libraries out there? How about creating interactive web apps from those analyses? On this episode, we dive into a project that attempts to bring the whole story together: HoloViz.	0	2020-11-26 12:16:36.840912	\N	<guid>579525ba-eb30-4649-902e-3f3873f073fe</guid>	t	\N	\N	https://talkpython.fm/episodes/download/269/holoviz-a-suite-of-tools-for-python-visualization.mp3	8	<p>The toolchain for modern data science can be intimidating. How do you choose between all the data visualization libraries out there? How about creating interactive web apps from those analyses? On this episode, we dive into a project that attempts to bring the whole story together: HoloViz.</p>	2020-06-19 00:00:00	\N	t	0	269-holoviz-a-suite-of-tools-for-python-visualization	\N	\N		The toolchain for modern data science can be intimidating. How do you choose between all the data visualization libraries out there? How about creating interactive web apps from those analyses? On this episode, we dive into a project that attempts to bring the whole story together: HoloViz.	#269 HoloViz - a suite of tools for Python visualization	2020-11-26 12:16:39.918157	https://talkpython.fm/episodes/show/269/holoviz-a-suite-of-tools-for-python-visualization
26	f	On this episode, we are going to weave a thread through three different areas of Python programming that at first seem unlikely to have much in common. Yet, the core will be the same throughout. I think this is a cool lesson to learn as you get deeper into programming and a great story to highlight it.	0	2020-11-26 12:16:36.840167	\N	<guid>4c635ce1-4e4a-468e-b355-833618553ed4</guid>	t	\N	\N	https://talkpython.fm/episodes/download/270/python-in-supply-chains-oil-rigs-rockets-and-lettuce.mp3	8	<p>On this episode, we are going to weave a thread through three different areas of Python programming that at first seem unlikely to have much in common. Yet, the core will be the same throughout. I think this is a cool lesson to learn as you get deeper into programming and a great story to highlight it.</p>	2020-06-25 00:00:00	\N	t	0	270-python-in-supply-chains-oil-rigs-rockets-and-lettuce	\N	\N		On this episode, we are going to weave a thread through three different areas of Python programming that at first seem unlikely to have much in common. Yet, the core will be the same throughout. I think this is a cool lesson to learn as you get deeper into programming and a great story to highlight it.	#270 Python in supply chains: oil rigs, rockets, and lettuce	2020-11-26 12:16:42.490607	https://talkpython.fm/episodes/show/270/python-in-supply-chains-oil-rigs-rockets-and-lettuce
15	f	Everyone in the Python space is familiar with Notebooks these days. One of the original notebook environments was SageMath. Created by William Stein, and collaborators, it began as an open-source, Python-based, computational environment focused on mathematicians.	0	2020-11-26 12:16:35.122774	\N	<guid>881daaa4-cb51-4c26-9620-6350e0a376f5</guid>	t	\N	\N	https://talkpython.fm/episodes/download/273/cocalc-a-fully-colloborative-notebook-development-environment.mp3	8	<p>Everyone in the Python space is familiar with Notebooks these days. One of the original notebook environments was SageMath. Created by William Stein, and collaborators, it began as an open-source, Python-based, computational environment focused on mathematicians.</p>	2020-07-18 00:00:00	\N	t	0	273-cocalc-a-fully-colloborative-notebook-development-environment	\N	\N		Everyone in the Python space is familiar with Notebooks these days. One of the original notebook environments was SageMath. Created by William Stein, and collaborators, it began as an open-source, Python-based, computational environment focused on mathematicians.	#273 CoCalc: A fully colloborative notebook development environment	2020-11-26 12:16:36.881346	https://talkpython.fm/episodes/show/273/cocalc-a-fully-colloborative-notebook-development-environment
16	f	Do you obsess about writing your code just the right way before you get started? Maybe you have some ugly code on your hands and you need to make it better. Either way, refactoring could be your ticket to happier days! On this episode, we'll talk through a powerful example of iteratively refactoring some code until we eventually turn our ugly duckling into a Pythonic beauty.	0	2020-11-26 12:16:35.11802	\N	<guid>d433fdca-afad-4220-9a8f-21cd4b677184</guid>	t	\N	\N	https://talkpython.fm/episodes/download/275/beautiful-pythonic-refactorings.mp3	8	<p>Do you obsess about writing your code just the right way before you get started? Maybe you have some ugly code on your hands and you need to make it better. Either way, refactoring could be your ticket to happier days! On this episode, we'll talk through a powerful example of iteratively refactoring some code until we eventually turn our ugly duckling into a Pythonic beauty.</p>	2020-08-01 00:00:00	\N	t	0	275-beautiful-pythonic-refactorings	\N	\N		Do you obsess about writing your code just the right way before you get started? Maybe you have some ugly code on your hands and you need to make it better. Either way, refactoring could be your ticket to happier days! On this episode, we'll talk through a powerful example of iteratively refactoring some code until we eventually turn our ugly duckling into a Pythonic beauty.	#275 Beautiful Pythonic Refactorings	2020-11-26 12:16:37.240184	https://talkpython.fm/episodes/show/275/beautiful-pythonic-refactorings
17	f	We're back with another GeekOut episode. Richard Campbell, a developer and podcaster who also dives deep into science and tech topics, is back for our second GeekOut episode. Last time we geeked out about the real science and progress around a moon base. This time it's why is there life on Earth, where could it be or have been in the solar system, and beyond.	0	2020-11-26 12:16:35.121233	\N	<guid>2f974cb0-8847-46a2-a6cb-c73daed45ca8</guid>	t	\N	\N	https://talkpython.fm/episodes/download/276/geekout-life-in-the-solar-system-and-beyond.mp3	8	<p>We're back with another GeekOut episode. Richard Campbell, a developer and podcaster who also dives deep into science and tech topics, is back for our second GeekOut episode. Last time we geeked out about the real science and progress around a moon base. This time it's why is there life on Earth, where could it be or have been in the solar system, and beyond.</p>	2020-08-06 00:00:00	\N	t	0	276-geekout-life-in-the-solar-system-and-beyond	\N	\N		We're back with another GeekOut episode. Richard Campbell, a developer and podcaster who also dives deep into science and tech topics, is back for our second GeekOut episode. Last time we geeked out about the real science and progress around a moon base. This time it's why is there life on Earth, where could it be or have been in the solar system, and beyond.	#276 Geekout: Life in the solar system and beyond	2020-11-26 12:16:37.754813	https://talkpython.fm/episodes/show/276/geekout-life-in-the-solar-system-and-beyond
18	f	Git hook scripts are useful for identifying simple issues before committing your code. Hooks run on every commit to automatically point out issues in code such as trailing whitespace and debug statements. By pointing these issues out before code review, this allows a code reviewer to focus on the architecture of a change while not wasting time with trivial style nitpicks.	0	2020-11-26 12:16:34.972121	\N	<guid>1b73475e-1f64-4dd3-bab9-bf39fa22796e</guid>	t	\N	\N	https://talkpython.fm/episodes/download/282/pre-commit-framework.mp3	8	<p>Git hook scripts are useful for identifying simple issues before committing your code. Hooks run on every commit to automatically point out issues in code such as trailing whitespace and debug statements. By pointing these issues out before code review, this allows a code reviewer to focus on the architecture of a change while not wasting time with trivial style nitpicks.</p>	2020-09-17 00:00:00	\N	t	0	282-pre-commit-framework	\N	\N		Git hook scripts are useful for identifying simple issues before committing your code. Hooks run on every commit to automatically point out issues in code such as trailing whitespace and debug statements. By pointing these issues out before code review, this allows a code reviewer to focus on the architecture of a change while not wasting time with trivial style nitpicks.	#282 pre-commit framework	2020-11-26 12:16:37.944805	https://talkpython.fm/episodes/show/282/pre-commit-framework
22	f	Python is one of the primary languages for IoT devices. With runtimes such as CircuitPython and MicroPython, they are ideal for the really small IoT chips. Maybe you've heard of the Circuit Playground Express, BBC micro:bit, or the fancy Adafruit CLUE. They aren't too expensive (ranging from $25 to $50 each). But for large groups such as classrooms, this can be a lot of money. Moreover, getting your hands on these devices can sometimes be tricky as well.	0	2020-11-26 12:16:36.833952	\N	<guid>99044d9d-4bcb-458e-8a41-ea7634d8905a</guid>	t	\N	\N	https://talkpython.fm/episodes/download/272/no-iot-things-in-hand-simulate-them-with-device-simulator-express.mp3	8	<p>Python is one of the primary languages for IoT devices. With runtimes such as CircuitPython and MicroPython, they are ideal for the really small IoT chips. Maybe you've heard of the Circuit Playground Express, BBC micro:bit, or the fancy Adafruit CLUE. They aren't too expensive (ranging from $25 to $50 each). But for large groups such as classrooms, this can be a lot of money. Moreover, getting your hands on these devices can sometimes be tricky as well.</p>	2020-07-12 00:00:00	\N	t	0	272-no-iot-things-in-hand-simulate-them-with-device-simulator-express	\N	\N		Python is one of the primary languages for IoT devices. With runtimes such as CircuitPython and MicroPython, they are ideal for the really small IoT chips. Maybe you've heard of the Circuit Playground Express, BBC micro:bit, or the fancy Adafruit CLUE. They aren't too expensive (ranging from $25 to $50 each). But for large groups such as classrooms, this can be a lot of money. Moreover, getting your hands on these devices can sometimes be tricky as well.	#272 No IoT things in hand? Simulate them with Device Simulator Express	2020-11-26 12:16:40.413482	https://talkpython.fm/episodes/show/272/no-iot-things-in-hand-simulate-them-with-device-simulator-express
27	f	\N	0	2020-12-27 23:10:41.675056	\N	<guid>asdasdasdasdads</guid>	t	\N	\N	https://talkpython.fm/episodes/download/270/python-in-supply-chains-oil-rigs-rockets-and-lettuce.mp3asd	12	\N	\N	\N	t	0	asdasdasd	\N	\N	\N	\N	test	2020-12-27 23:10:41.675056	\N
29	f	Geography is the study of places and the relationships between people and their environments. Often we think of maps, but maps are static. GIS gets interesting when you realize that we're studying and visualizing data flowing through these locations and communities.	0	2020-12-28 00:05:08.713486	\N	<guid>1bff8adf-02d7-4a4f-8c7c-a26bbf32b803</guid>	t	\N	\N	https://talkpython.fm/episodes/download/295/gis-python.mp3	8	<p>Geography is the study of places and the relationships between people and their environments. Often we think of maps, but maps are static. GIS gets interesting when you realize that we're studying and visualizing data flowing through these locations and communities.</p>	2020-12-18 00:00:00	\N	t	0	295-gis-python	\N	\N		Geography is the study of places and the relationships between people and their environments. Often we think of maps, but maps are static. GIS gets interesting when you realize that we're studying and visualizing data flowing through these locations and communities.	#295 GIS + Python	2020-12-28 00:05:10.554488	https://talkpython.fm/episodes/show/295/gis-python
28	f	As software developers, we live in a world of uncertainty and flux. Do you need to build a new web app? Well maybe using Django makes the most sense if you've been doing it for a long time. There is Flask, but it's more mix and match being a microframework. But you've also heard that async and await are game changers and FastAPI might be the right choice.	0	2020-12-28 00:05:08.803741	\N	<guid>bf8967c2-2460-4e7d-bbd7-ddf9405d3e0f</guid>	t	\N	\N	https://talkpython.fm/episodes/download/293/learning-how-to-learn-as-a-developer.mp3	8	<p>As software developers, we live in a world of uncertainty and flux. Do you need to build a new web app? Well maybe using Django makes the most sense if you've been doing it for a long time. There is Flask, but it's more mix and match being a microframework. But you've also heard that async and await are game changers and FastAPI might be the right choice.</p>	2020-12-01 00:00:00	\N	t	0	293-learning-how-to-learn-as-a-developer	\N	\N		As software developers, we live in a world of uncertainty and flux. Do you need to build a new web app? Well maybe using Django makes the most sense if you've been doing it for a long time. There is Flask, but it's more mix and match being a microframework. But you've also heard that async and await are game changers and FastAPI might be the right choice.	#293 Learning how to learn as a developer	2020-12-28 00:05:08.803741	https://talkpython.fm/episodes/show/293/learning-how-to-learn-as-a-developer
31	f	Quick: Name the 3 most advanced engineering organizations you can think of? Maybe an aerospace company such as SpaceX or Boeing come to mind. Maybe you thought of CERN and the LHC. But in terms of bespoke engineering capabilities, you should certainly put the F1 racing teams on your list.	0	2020-12-28 00:05:08.64142	\N	<guid>deec0698-0cc3-4195-840c-5185560bfe4d</guid>	t	\N	\N	https://talkpython.fm/episodes/download/296/python-in-f1-racing.mp3	12	<p>Quick: Name the 3 most advanced engineering organizations you can think of? Maybe an aerospace company such as SpaceX or Boeing come to mind. Maybe you thought of CERN and the LHC. But in terms of bespoke engineering capabilities, you should certainly put the F1 racing teams on your list.</p>	2020-12-23 00:00:00	\N	t	0	296-python-in-f1-racing	\N	\N		Quick: Name the 3 most advanced engineering organizations you can think of? Maybe an aerospace company such as SpaceX or Boeing come to mind. Maybe you thought of CERN and the LHC. But in terms of bespoke engineering capabilities, you should certainly put the F1 racing teams on your list.	#296 Python in F1 racing	2020-12-28 00:05:08.64142	https://talkpython.fm/episodes/show/296/python-in-f1-racing
30	f	When we think about accounts and security, we often think about identity (logging in and proving who you are). But for many applications, especially internal apps at large organizations, that's just step one. The next step is what can you do and what can you not do.	0	2020-12-28 00:05:08.805143	\N	<guid>ba596b9f-0314-44a9-aec6-a440927c9447</guid>	t	\N	\N	https://talkpython.fm/episodes/download/294/oso-authorizes-python.mp3	12	<p>When we think about accounts and security, we often think about identity (logging in and proving who you are). But for many applications, especially internal apps at large organizations, that's just step one. The next step is what can you do and what can you not do.</p>	2020-12-07 00:00:00	\N	t	0	294-oso-authorizes-python	\N	\N		When we think about accounts and security, we often think about identity (logging in and proving who you are). But for many applications, especially internal apps at large organizations, that's just step one. The next step is what can you do and what can you not do.	#294 oso authorizes Python	2020-12-28 00:05:08.805143	https://talkpython.fm/episodes/show/294/oso-authorizes-python
\.


--
-- Data for Name: podcasts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.podcasts (id, android_url, created_at, creator_id, description, feed_url, image, itunes_url, main_color_hex, overcast_url, pattern_image, published, reachable, slug, soundcloud_url, status_notice, title, twitter_username, "unique_website_url?", updated_at, website_url, user_id) FROM stdin;
11		2020-12-24 11:20:54.208236	12	testing podcast description		603540e4-bf94-4e98-9594-5d138ac6bfcf.png		ff00ff		\N	t	f	test-podcast-latest		Podcast's feed_url is not reachable	Testing Podcast		t	2020-12-24 11:23:08.427587		\N
12		2020-12-27 23:07:05.402613	12	testttt	https://talkpython.fm/episodes/rss/sad	14cbf324-f86c-4e56-b221-0c3828ab1f42.png		ff00ff		\N	t	t	asdasdasdsad			Test Podcasttttttt		t	2020-12-27 23:07:18.002716		\N
8	https://subscribeonandroid.com/talkpython.fm/episodes/rss	2020-11-26 11:41:49.256372	\N	Test podcast description	https://talkpython.fm/episodes/rss	2df2b6fe-38da-4096-bc64-89b08c09c3e1.jpg		181a1c	https://overcast.fm/itunes979020229/talk-python-to-me	\N	t	t	talkpython			Test podcast latest	TalkPython	t	2020-11-26 11:41:49.256372		\N
\.


--
-- Data for Name: poll_options; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.poll_options (id, created_at, markdown, poll_id, poll_votes_count, processed_html, updated_at) FROM stdin;
\.


--
-- Data for Name: poll_skips; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.poll_skips (id, created_at, poll_id, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: poll_votes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.poll_votes (id, created_at, poll_id, poll_option_id, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.polls (id, article_id, created_at, poll_options_count, poll_skips_count, poll_votes_count, prompt_html, prompt_markdown, updated_at) FROM stdin;
\.


--
-- Data for Name: profile_field_groups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.profile_field_groups (id, created_at, description, name, updated_at) FROM stdin;
1	2020-11-17 14:29:46.570337	\N	Basic	2020-11-17 14:29:46.570337
2	2020-11-17 14:29:46.619325	\N	Links	2020-11-17 14:29:46.619325
3	2020-11-17 14:29:46.692482	\N	Work	2020-11-17 14:29:46.692482
4	2020-11-17 14:29:46.736443	\N	Coding	2020-11-17 14:29:46.736443
5	2020-11-17 14:29:46.780418	\N	Branding	2020-11-17 14:29:46.780418
\.


--
-- Data for Name: profile_fields; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.profile_fields (id, attribute_name, created_at, description, display_area, input_type, label, placeholder_text, profile_field_group_id, show_in_onboarding, updated_at) FROM stdin;
1	display_email_on_profile	2020-11-17 14:29:46.583641	\N	1	2	Display email on profile	\N	1	f	2020-11-17 14:29:46.583641
2	name	2020-11-17 14:29:46.588803	\N	1	0	Name	John Doe	1	f	2020-11-17 14:29:46.588803
3	website_url	2020-11-17 14:29:46.596158	\N	1	0	Website URL	https://yoursite.com	1	f	2020-11-17 14:29:46.596158
4	summary	2020-11-17 14:29:46.607663	\N	1	1	Summary	A short bio...	1	f	2020-11-17 14:29:46.607663
5	location	2020-11-17 14:29:46.612964	\N	1	0	Location	Halifax, Nova Scotia	1	f	2020-11-17 14:29:46.612964
6	facebook_url	2020-11-17 14:29:46.62437	\N	1	0	Facebook URL	https://facebook.com/...	2	f	2020-11-17 14:29:46.62437
7	youtube_url	2020-11-17 14:29:46.62941	\N	1	0	Youtube URL	https://www.youtube.com/channel/...	2	f	2020-11-17 14:29:46.62941
8	stack_overflow_url	2020-11-17 14:29:46.63482	\N	1	0	StackOverflow URL	https://stackoverflow.com/users/...	2	f	2020-11-17 14:29:46.63482
9	linked_in_url	2020-11-17 14:29:46.640059	\N	1	0	LinkedIn URL	https://www.linkedin.com/in/...	2	f	2020-11-17 14:29:46.640059
10	behance_url	2020-11-17 14:29:46.648162	\N	1	0	Behance URL	https://www.behance.net/...	2	f	2020-11-17 14:29:46.648162
11	dribbble_url	2020-11-17 14:29:46.656633	\N	1	0	Dribbble URL	https://dribbble.com/...	2	f	2020-11-17 14:29:46.656633
12	medium_url	2020-11-17 14:29:46.662621	\N	1	0	Medium URL	https://medium.com/@...	2	f	2020-11-17 14:29:46.662621
13	git_lab_url	2020-11-17 14:29:46.668076	\N	1	0	GitLab URL	https://gitlab.com/...	2	f	2020-11-17 14:29:46.668076
14	instagram_url	2020-11-17 14:29:46.673963	\N	1	0	Instagram URL	https://www.instagram.com/...	2	f	2020-11-17 14:29:46.673963
15	mastodon_url	2020-11-17 14:29:46.679196	\N	1	0	Mastodon URL	https://...	2	f	2020-11-17 14:29:46.679196
16	twitch_url	2020-11-17 14:29:46.684532	\N	1	0	Twitch URL	https://www.twitch.tv/...	2	f	2020-11-17 14:29:46.684532
17	education	2020-11-17 14:29:46.697823	\N	1	0	Education	\N	3	f	2020-11-17 14:29:46.697823
18	employer_name	2020-11-17 14:29:46.702871	\N	1	0	Employer name	Acme Inc.	3	f	2020-11-17 14:29:46.702871
19	employer_url	2020-11-17 14:29:46.708153	\N	1	0	Employer URL	https://dev.com	3	f	2020-11-17 14:29:46.708153
20	employment_title	2020-11-17 14:29:46.713089	\N	1	0	Employment title	Junior Frontend Engineer	3	f	2020-11-17 14:29:46.713089
21	looking_for_work	2020-11-17 14:29:46.717839	\N	1	2	Looking for work	\N	3	f	2020-11-17 14:29:46.717839
22	display_looking_for_work_on_profile	2020-11-17 14:29:46.723368	\N	1	2	Display "looking for work" on profile	\N	3	f	2020-11-17 14:29:46.723368
23	recruiters_can_contact_me_about_job_opportunities	2020-11-17 14:29:46.728477	\N	1	2	Recruiters can contact me about job opportunities	\N	3	f	2020-11-17 14:29:46.728477
24	brand_color1	2020-11-17 14:29:46.79032	Used for backgrounds, borders etc.	1	3	Brand color 1	#000000	5	f	2020-11-17 14:29:46.79032
25	brand_color2	2020-11-17 14:29:46.80013	Used for texts (usually put on Brand color 1).	1	3	Brand color 2	#000000	5	f	2020-11-17 14:29:46.80013
26	skills_languages	2020-11-17 14:29:55.9553	What tools and languages are you most experienced with? Are you specialized or more of a generalist?	1	1	Skills/Languages	\N	4	f	2020-11-17 14:29:55.9553
27	currently_learning	2020-11-17 14:29:55.964909	What are you learning right now? What are the new tools and languages you're picking up right now?	1	1	Currently learning	\N	4	f	2020-11-17 14:29:55.964909
28	currently_hacking_on	2020-11-17 14:29:55.970873	What projects are currently occupying most of your time?	1	1	Currently hacking on	\N	4	f	2020-11-17 14:29:55.970873
29	available_for	2020-11-17 14:29:55.977105	What kinds of collaborations or discussions are you available for? What's a good reason to say Hey! to you these days?	1	1	Available for	\N	4	f	2020-11-17 14:29:55.977105
\.


--
-- Data for Name: profile_pins; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.profile_pins (id, created_at, pinnable_id, pinnable_type, profile_id, profile_type, updated_at) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.profiles (id, created_at, data, updated_at, user_id) FROM stdin;
1	2020-11-17 14:29:35.649558	{"name": "Kasey Rolfson", "summary": "Velit cum dolorum. Perferendis et sit. Velit voluptas quos. Assumenda et rerum. Quas sed necessitatibus. Quibusdam vel vitae. Est libero inventore. Ducimus voluptatibus alias. Cupiditate est ea. Dol.", "website_url": "http://douglas-walter.io/carlos.bayer", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.800141	1
2	2020-11-17 14:29:36.049318	{"name": "Tora Lesch", "summary": "Qui doloremque voluptatem. Perspiciatis quis deleniti. Et voluptatem distinctio. Delectus aliquam sit. Eius cupiditate nam. Occaecati error ab. Facilis reprehenderit quo. Ut non et. Eos commodi vel..", "website_url": "http://lemke-spencer.name/maribeth", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.811393	2
3	2020-11-17 14:29:36.331761	{"name": "Dee McGlynn MD", "summary": "Culpa in officiis. Odio laudantium omnis. Occaecati voluptates quibusdam. Voluptas magnam dolores. Explicabo quisquam qui. Consequatur ab alias. Et nostrum dolorum. Rerum aliquam saepe. Asperiores q.", "website_url": "http://murray.io/darcy", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.820299	3
4	2020-11-17 14:29:36.631475	{"name": "Laveta Shanahan", "summary": "Voluptatem officia officiis. Pariatur alias laudantium. Neque iure placeat. Sunt iusto voluptas. Ratione dolore corporis. Ratione sequi sapiente. Ipsam reiciendis suscipit. Quo eos placeat. Sit unde.", "website_url": "http://ward.com/pauletta.littel", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.831896	4
5	2020-11-17 14:29:36.941053	{"name": "Gov. Guadalupe Hackett", "summary": "Perspiciatis vero esse. Qui repellendus non. Qui esse voluptatem. Totam ut praesentium. Deleniti qui ea. Voluptatum voluptatibus et. Quo minus aut. Id consectetur quia. Id illo occaecati. Natus quia.", "website_url": "http://glover.net/craig_berge", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.843197	5
6	2020-11-17 14:29:37.229248	{"name": "Jacob Lehner", "summary": "In ullam aliquid. Eius minima quis. Perspiciatis unde architecto. Quas iste officiis. Fuga repellendus provident. Ut aliquid delectus. Eum quia et. Adipisci saepe et. Ea perferendis nostrum. Autem e.", "website_url": "http://conroy.co/maricruz", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.852426	6
7	2020-11-17 14:29:37.509858	{"name": "Jeromy Schimmel", "summary": "Nemo nesciunt quasi. Sint fugiat et. Voluptas exercitationem numquam. Dolor nihil autem. Distinctio totam facilis. Consequatur beatae iusto. Ipsam necessitatibus unde. Et excepturi aut. Fugit laudan.", "website_url": "http://osinski.info/columbus_hermiston", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.860444	7
8	2020-11-17 14:29:37.80767	{"name": "Pablo Wiegand", "summary": "Ut est non. Qui saepe debitis. Voluptatum cum sed. Dolore facilis ut. Voluptatem nostrum vel. Non et aut. Ratione et atque. Consequatur quam dolorum. Facere et consequatur. Minus recusandae atque. E.", "website_url": "http://pollich.biz/antionette.zemlak", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.868563	8
9	2020-11-17 14:29:38.128909	{"name": "Esteban Marvin", "summary": "Iure minima voluptates. Sed iure numquam. Consequatur eaque vel. Soluta animi sed. Sapiente impedit quisquam. Odit quia modi. Quidem voluptatem totam. Et ipsa recusandae. Doloribus sed quia. Velit v.", "website_url": "http://tillman-langosh.info/lacy", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.87668	9
10	2020-11-17 14:29:38.383588	{"name": "Tressie Cremin", "summary": "Nam voluptas esse. Consequatur tempore doloribus. Quis neque aut. Autem ea maxime. Velit dolore placeat. Debitis quam assumenda. Qui repellat similique. Ut doloribus facere. Veniam aut voluptatem. P.", "website_url": "http://jast.io/elayne.hansen", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.891159	10
11	2020-11-17 14:29:38.906952	{"name": "Admin McAdmin", "summary": "Sunt consequatur fugiat. Debitis excepturi ut. Recusandae adipisci consequatur. Cupiditate error amet. Veritatis amet numquam. Numquam inventore voluptates. Sed consequatur et. Assumenda beatae quia.", "website_url": "http://gleichner.biz/bertha", "looking_for_work": false, "custom_attributes": "{}", "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-17 14:29:56.90001	11
12	2020-11-25 13:48:33.389557	{"name": "Muzzamil123", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-11-25 13:48:33.389557	12
14	2020-12-19 15:38:58.31106	{"name": "Muzammil Mujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-12-19 15:38:58.31106	15
15	2020-12-19 15:50:29.414543	{"name": "Muzzamil Mujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-12-19 15:50:29.414543	16
18	2020-12-30 15:13:31.680035	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2020-12-30 15:13:31.680035	19
19	2021-01-03 14:02:27.800958	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-03 14:02:27.800958	20
20	2021-01-03 14:13:12.994697	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-03 14:13:12.994697	21
21	2021-01-03 14:36:10.379567	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-03 14:36:10.379567	22
22	2021-01-03 14:44:19.766012	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-03 14:44:19.766012	23
23	2021-01-03 14:57:15.352437	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": "", "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": "", "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-03 16:27:56.073841	24
24	2021-01-05 12:11:58.301267	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-05 12:11:58.301267	25
25	2021-01-05 12:34:57.569436	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-05 12:34:57.569436	26
26	2021-01-05 12:42:19.837365	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-05 12:42:19.837365	27
28	2021-01-08 11:55:23.670732	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-08 11:55:23.670732	29
29	2021-01-08 12:54:19.887111	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-08 12:54:19.887111	30
30	2021-01-09 13:28:21.832084	{"name": "MuzzamilMujahid", "summary": null, "location": null, "education": null, "medium_url": null, "twitch_url": null, "behance_url": null, "git_lab_url": null, "website_url": null, "youtube_url": null, "brand_color1": null, "brand_color2": null, "dribbble_url": null, "employer_url": null, "facebook_url": null, "mastodon_url": null, "available_for": null, "employer_name": null, "instagram_url": null, "linked_in_url": null, "employment_title": null, "looking_for_work": false, "skills_languages": null, "custom_attributes": "{}", "currently_learning": null, "stack_overflow_url": null, "currently_hacking_on": null, "display_email_on_profile": false, "display_looking_for_work_on_profile": false, "recruiters_can_contact_me_about_job_opportunities": false}	2021-01-09 13:28:21.832084	31
\.


--
-- Data for Name: rating_votes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.rating_votes (id, article_id, context, created_at, "group", rating, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: reactions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.reactions (id, category, created_at, points, reactable_id, reactable_type, status, updated_at, user_id) FROM stdin;
1	vomit	2020-11-17 14:29:45.271699	-25	11	User	valid	2020-11-17 14:29:45.271699	1
2	vomit	2020-11-17 14:29:45.302213	-50	12	Article	valid	2020-11-17 14:29:45.302213	1
3	vomit	2020-11-17 14:29:45.323781	-50	4	Article	valid	2020-11-17 14:29:45.323781	1
4	vomit	2020-11-17 14:29:45.345144	-50	16	Article	valid	2020-11-17 14:29:45.345144	1
5	like	2020-11-25 13:54:55.22658	1	5	Comment	valid	2020-11-25 13:54:55.22658	2
6	like	2020-11-25 13:54:55.227544	1	2	Comment	valid	2020-11-25 13:54:55.227544	10
7	like	2020-11-25 13:54:55.228351	1	4	Comment	valid	2020-11-25 13:54:55.228351	9
8	like	2020-11-25 13:54:55.230062	1	3	Comment	valid	2020-11-25 13:54:55.230062	6
9	like	2020-11-25 13:54:55.233901	1	1	Comment	valid	2020-11-25 13:54:55.233901	8
10	like	2020-11-25 13:54:55.333629	1	9	Comment	valid	2020-11-25 13:54:55.333629	6
11	like	2020-11-25 13:54:55.338094	1	8	Comment	valid	2020-11-25 13:54:55.338094	1
12	like	2020-11-25 13:54:55.342259	1	10	Comment	valid	2020-11-25 13:54:55.342259	3
13	like	2020-11-25 13:54:55.34439	1	6	Comment	valid	2020-11-25 13:54:55.34439	6
14	like	2020-11-25 13:54:55.363312	1	7	Comment	valid	2020-11-25 13:54:55.363312	10
15	like	2020-11-25 13:54:55.407449	1	11	Comment	valid	2020-11-25 13:54:55.407449	11
16	like	2020-11-25 13:54:55.423663	1	12	Comment	valid	2020-11-25 13:54:55.423663	6
17	like	2020-11-25 13:54:55.440675	1	14	Comment	valid	2020-11-25 13:54:55.440675	9
18	like	2020-11-25 13:54:55.466254	1	13	Comment	valid	2020-11-25 13:54:55.466254	10
19	like	2020-11-25 13:54:55.489878	1	16	Comment	valid	2020-11-25 13:54:55.489878	10
20	like	2020-11-25 13:54:55.501048	1	15	Comment	valid	2020-11-25 13:54:55.501048	2
21	like	2020-11-25 13:54:55.518391	1	18	Comment	valid	2020-11-25 13:54:55.518391	8
22	like	2020-11-25 13:54:55.542055	1	17	Comment	valid	2020-11-25 13:54:55.542055	9
23	like	2020-11-25 13:54:55.566999	1	19	Comment	valid	2020-11-25 13:54:55.566999	10
24	like	2020-11-25 13:54:55.592662	1	21	Comment	valid	2020-11-25 13:54:55.592662	9
25	like	2020-11-25 13:54:55.6021	1	20	Comment	valid	2020-11-25 13:54:55.6021	6
26	like	2020-11-25 13:54:55.644484	1	22	Comment	valid	2020-11-25 13:54:55.644484	10
27	like	2020-11-25 13:54:55.647369	1	23	Comment	valid	2020-11-25 13:54:55.647369	10
28	like	2020-11-25 13:54:55.67599	1	24	Comment	valid	2020-11-25 13:54:55.67599	1
29	like	2020-11-25 13:54:55.695516	1	25	Comment	valid	2020-11-25 13:54:55.695516	3
30	like	2020-11-25 13:54:55.697819	1	26	Comment	valid	2020-11-25 13:54:55.697819	5
31	like	2020-11-25 13:54:55.737621	1	27	Comment	valid	2020-11-25 13:54:55.737621	5
32	like	2020-11-25 13:54:55.749726	1	28	Comment	valid	2020-11-25 13:54:55.749726	7
33	like	2020-11-25 13:54:55.801337	1	30	Comment	valid	2020-11-25 13:54:55.801337	9
34	like	2020-11-25 13:54:55.813788	1	29	Comment	valid	2020-11-25 13:54:55.813788	10
\.


--
-- Data for Name: response_templates; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.response_templates (id, content, content_type, created_at, title, type_of, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.roles (id, created_at, name, resource_id, resource_type, updated_at) FROM stdin;
1	2020-11-17 14:29:35.658404	trusted	\N	\N	2020-11-17 14:29:35.658404
2	2020-11-17 14:29:36.335324	workshop_pass	\N	\N	2020-11-17 14:29:36.335324
3	2020-11-17 14:29:37.810836	chatroom_beta_tester	\N	\N	2020-11-17 14:29:37.810836
4	2020-11-17 14:29:38.910416	super_admin	\N	\N	2020-11-17 14:29:38.910416
5	2020-11-17 14:29:38.943331	single_resource_admin	\N	Config	2020-11-17 14:29:38.943331
6	2020-11-25 13:49:15.172978	admin	\N	\N	2020-11-25 13:49:15.172978
7	2020-11-25 13:49:21.897751	single_resource_admin	\N	\N	2020-11-25 13:49:21.897751
8	2020-12-31 14:43:22.090055	customer	\N	\N	2020-12-31 14:43:22.090055
9	2021-01-03 14:36:10.388242	applicant	\N	\N	2021-01-03 14:36:10.388242
10	2021-01-04 11:45:10.437482	artist	\N	\N	2021-01-04 11:45:10.437482
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.schema_migrations (version) FROM stdin;
20201114151157
20151224175814
20151224180956
20151226205806
20151231095411
20151231102537
20160101145545
20160101170140
20160104220657
20160104221355
20160104222032
20160104223954
20160104225041
20160105211934
20160111153315
20160115190444
20160120012230
20160124203153
20160124205229
20160125202948
20160126145035
20160126152212
20160128215217
20160129154529
20160131213109
20160131213110
20160131213111
20160131213112
20160131213113
20160131234917
20160201001953
20160201002243
20160201012919
20160201014516
20160202211114
20160202214951
20160203005540
20160203011021
20160203233256
20160206011647
20160211170239
20160214023247
20160226193243
20160304000325
20160304010353
20160304011144
20160309155009
20160310024038
20160317190829
20160317190838
20160318195259
20160322214055
20160323233659
20160324231938
20160329004330
20160401203746
20160418001613
20160428002923
20160503004547
20160505014825
20160510022025
20160517144259
20160517144335
20160518202957
20160525190703
20160525192526
20160602140503
20160610135858
20160610145259
20160610155109
20160703135819
20160713202608
20160726230520
20160801212954
20160809182110
20160810191937
20160819025830
20160905190604
20160908145640
20160908151357
20160926154138
20160926164412
20161013195522
20161018201530
20161124212209
20161208193428
20161211234357
20161212161130
20161213212554
20161216165302
20161219173922
20161223053926
20161226180959
20161228210927
20161229054605
20170105141344
20170110154028
20170110170105
20170119193031
20170127194840
20170206214820
20170206220334
20170208152018
20170209164016
20170213183337
20170216145500
20170228174838
20170302152930
20170303171502
20170303180353
20170309162937
20170310003608
20170317171912
20170325040822
20170330184420
20170330222954
20170403135236
20170411145225
20170502162438
20170505210243
20170517172352
20170521154826
20170523210349
20170524160535
20170531150807
20170531151548
20170602152759
20170607191629
20170610142132
20170613193616
20170615172623
20170615172941
20170616191722
20170619151747
20170620145442
20170620212740
20170622191911
20170626211738
20170627205501
20170706212815
20170711195143
20170717214026
20170718150429
20170718174233
20170719184042
20170719211212
20170725171619
20170727002902
20170727153841
20170802204604
20170804193835
20170809182148
20170821154300
20170828165505
20170829164950
20170829190632
20170831180005
20170831200650
20170905170750
20170912012249
20170920160022
20170921205230
20170921221837
20171002180944
20171002195852
20171003191547
20171003222833
20171004025750
20171012215224
20171013180013
20171019152130
20171019215638
20171020160338
20171024171916
20171024193812
20171026214850
20171030214855
20171103165851
20171104014225
20171106203902
20171110215815
20171110223810
20171116191214
20171116203319
20171204171217
20171229192205
20180103183451
20180107004333
20180110012012
20180111170406
20180115221125
20180130192627
20180131183322
20180202171402
20180208210732
20180209174729
20180210161930
20180212153228
20180213165354
20180303210932
20180304151124
20180316143921
20180316164921
20180316174324
20180321170500
20180328194237
20180328194253
20180427160903
20180502152520
20180502152621
20180502160428
20180502174301
20180502213919
20180507191509
20180508165244
20180508170132
20180508200948
20180516173047
20180516184437
20180522195341
20180531194107
20180601145801
20180601195848
20180603160906
20180604200603
20180606155327
20180608195204
20180609191539
20180612214259
20180622173538
20180624230435
20180629201047
20180703142743
20180705194536
20180707162348
20180713180709
20180716182629
20180728201801
20180806142338
20180816165158
20180821204032
20180824191849
20180826174411
20180905013458
20180924201325
20180924204406
20180928161837
20180930015157
20181001225906
20181003173949
20181005180705
20181005200827
20181008174839
20181010204910
20181016181008
20181019195746
20181020195949
20181020195954
20181026112019
20181026214021
20181111040732
20181116223239
20181117145537
20181120170350
20181127173004
20181129222416
20181130224531
20181219215401
20181227192353
20190109212351
20190115155656
20190121172642
20190121191754
20190129173611
20190129190135
20190206164319
20190206222055
20190216185753
20190227163543
20190227163803
20190305221008
20190306082543
20190315151829
20190315222044
20190318223433
20190326085046
20190327090030
20190329103059
20190401100844
20190401100850
20190401193017
20190401213605
20190402224426
20190404102732
20190405190915
20190409123750
20190410124957
20190412093614
20190415194929
20190417171019
20190417171020
20190420000607
20190425210432
20190430123156
20190501141654
20190501180125
20190501191830
20190502165056
20190504015859
20190504131412
20190521190118
20190524214445
20190525233909
20190525233918
20190525233934
20190531085252
20190531094609
20190531094926
20190603190201
20190606202826
20190607110030
20190611102309
20190611102923
20190611144112
20190611195955
20190612095748
20190612095959
20190612174127
20190614093041
20190616024727
20190616053854
20190617101811
20190617102149
20190619153428
20190624093012
20190625143841
20190626022355
20190626221336
20190628123548
20190702194019
20190703003817
20190704082551
20190704091636
20190704105143
20190705111810
20190705114625
20190708105607
20190709192214
20190710081915
20190711070019
20190711093610
20190713213412
20190713225409
20190717220437
20190717224405
20190723094834
20190801083510
20190801132654
20190818191954
20190819104106
20190822162434
20190827163358
20190906193806
20190910153845
20190918104106
20190925171050
20190925193205
20191016135034
20191025185619
20191025202354
20191031131016
20191106095242
20191106102826
20191108153914
20191203114809
20191203160028
20191203171558
20191210144342
20191215145706
20191220120243
20191223202251
20191226202114
20191227113154
20191227114543
20200106074859
20200117135558
20200117135902
20200119214529
20200120053525
20200125204226
20200205225813
20200211192415
20200212164359
20200213182938
20200221170905
20200221184007
20200222164815
20200224153122
20200225104037
20200226081611
20200226192145
20200226205549
20200226210111
20200227214321
20200303222558
20200304164719
20200304220534
20200308144606
20200311170959
20200324113133
20200324170819
20200326110404
20200326111645
20200329103305
20200331155903
20200403203054
20200405103927
20200407081312
20200407083405
20200407083732
20200407084807
20200407090218
20200407090914
20200407091449
20200409043946
20200409050122
20200411085952
20200412194408
20200420130910
20200426124118
20200427094852
20200427233631
20200501032629
20200504075409
20200511224704
20200514212601
20200515085746
20200519220213
20200520091835
20200520092247
20200520092613
20200520092938
20200520092951
20200521103848
20200521103911
20200521103935
20200521103952
20200521153435
20200525115740
20200525120420
20200525120642
20200525125611
20200526144234
20200526145731
20200526151431
20200526151807
20200527161505
20200530084533
20200601121243
20200602174329
20200604133925
20200605170430
20200605183117
20200608175130
20200609191943
20200609192545
20200609195523
20200612140153
20200615213003
20200616200005
20200617014320
20200617014509
20200617183058
20200618212422
20200702143618
20200706184804
20200707170245
20200707173316
20200707173524
20200710174257
20200712150048
20200716125857
20200717203432
20200717220654
20200719205123
20200720143134
20200720213710
20200721213341
20200723180841
20200723203155
20200725215546
20200726215928
20200727052235
20200727163200
20200731033002
20200731041554
20200803193841
20200804035648
20200805050048
20200805100552
20200805102249
20200806052718
20200806193438
20200809200631
20200811044202
20200813031851
20200813042118
20200814142425
20200814142648
20200817205048
20200818101637
20200818101700
20200818163445
20200818163834
20200818202007
20200819162917
20200820055018
20200820093731
20200820093752
20200821035520
20200822092853
20200826072259
20200826072722
20200826131359
20200826132009
20200826132639
20200827073520
20200828032013
20200828045600
20200901084210
20200902132326
20200902204028
20200904040009
20200904151734
20200910155145
20200910205316
20200911140318
20200914143753
20200914144033
20200914144157
20200914145500
20200917114525
20200917141134
20200917141154
20200917154147
20200917154234
20200917154256
20200917154306
20200918200231
20200921160153
20201001154006
20201002102257
20201002102303
20201002104711
20201005181510
20201007085440
20201007091041
20201009040438
20201017160628
20201019012200
20201203121012
20201218142127
20201219150656
20201221134837
20201222122505
20201222144913
20201226072927
20201226073623
20201228140656
20201228144621
20201229115421
20201229162123
20201230134000
20201230141728
20201230143901
20201230143950
20201230152630
20201231130930
20210103132057
20210107135511
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: forem_latest
--

COPY public.services (id, name, price, currency, artist_application_id, user_id, created_at, updated_at) FROM stdin;
64	birthday	0	USD	10	25	2021-01-05 12:11:56.456997	2021-01-05 12:11:58.497072
65	religion	0	USD	10	25	2021-01-05 12:11:56.458573	2021-01-05 12:11:58.50052
4	treat	0	USD	2	\N	2021-01-01 16:27:50.377875	2021-01-01 16:27:50.377875
5	anniversary	0	USD	2	\N	2021-01-01 16:27:50.382103	2021-01-01 16:27:50.382103
6	ceremony	0	USD	2	\N	2021-01-01 16:27:50.383527	2021-01-01 16:27:50.383527
7		0	USD	3	\N	2021-01-03 13:56:55.801669	2021-01-03 13:56:55.801669
8		0	USD	3	\N	2021-01-03 13:56:55.807823	2021-01-03 13:56:55.807823
9		0	USD	3	\N	2021-01-03 13:56:55.809442	2021-01-03 13:56:55.809442
10		0	USD	3	\N	2021-01-03 13:56:55.810986	2021-01-03 13:56:55.810986
11		0	USD	3	\N	2021-01-03 13:56:55.812526	2021-01-03 13:56:55.812526
12		0	USD	3	\N	2021-01-03 13:56:55.814015	2021-01-03 13:56:55.814015
13		0	USD	3	\N	2021-01-03 13:56:55.815503	2021-01-03 13:56:55.815503
14	treat	0	USD	4	20	2021-01-03 14:02:27.35971	2021-01-03 14:02:27.808775
15		0	USD	4	20	2021-01-03 14:02:27.361444	2021-01-03 14:02:27.811588
16		0	USD	4	20	2021-01-03 14:02:27.362839	2021-01-03 14:02:27.814433
17		0	USD	4	20	2021-01-03 14:02:27.36413	2021-01-03 14:02:27.817494
18		0	USD	4	20	2021-01-03 14:02:27.365432	2021-01-03 14:02:27.820787
19		0	USD	4	20	2021-01-03 14:02:27.366915	2021-01-03 14:02:27.823836
20		0	USD	4	20	2021-01-03 14:02:27.368574	2021-01-03 14:02:27.826632
21		0	USD	5	21	2021-01-03 14:13:12.653462	2021-01-03 14:13:13.014393
22		0	USD	5	21	2021-01-03 14:13:12.655383	2021-01-03 14:13:13.01836
23		0	USD	5	21	2021-01-03 14:13:12.656785	2021-01-03 14:13:13.02164
24		0	USD	5	21	2021-01-03 14:13:12.658638	2021-01-03 14:13:13.024944
25		0	USD	5	21	2021-01-03 14:13:12.66156	2021-01-03 14:13:13.028254
26		0	USD	5	21	2021-01-03 14:13:12.663368	2021-01-03 14:13:13.031218
27		0	USD	5	21	2021-01-03 14:13:12.664995	2021-01-03 14:13:13.034352
28		0	USD	6	22	2021-01-03 14:36:10.131581	2021-01-03 14:36:10.462445
29		0	USD	6	22	2021-01-03 14:36:10.133422	2021-01-03 14:36:10.465993
30		0	USD	6	22	2021-01-03 14:36:10.135163	2021-01-03 14:36:10.46958
31	anniversary	0	USD	6	22	2021-01-03 14:36:10.136879	2021-01-03 14:36:10.47298
32		0	USD	6	22	2021-01-03 14:36:10.138433	2021-01-03 14:36:10.47661
33		0	USD	6	22	2021-01-03 14:36:10.139817	2021-01-03 14:36:10.480167
34		0	USD	6	22	2021-01-03 14:36:10.141175	2021-01-03 14:36:10.483716
35		0	USD	7	23	2021-01-03 14:44:19.412776	2021-01-03 14:44:19.812039
36		0	USD	7	23	2021-01-03 14:44:19.414719	2021-01-03 14:44:19.815019
37		0	USD	7	23	2021-01-03 14:44:19.416381	2021-01-03 14:44:19.817876
38		0	USD	7	23	2021-01-03 14:44:19.417908	2021-01-03 14:44:19.820604
39		0	USD	7	23	2021-01-03 14:44:19.419371	2021-01-03 14:44:19.823092
40		0	USD	7	23	2021-01-03 14:44:19.420867	2021-01-03 14:44:19.825805
41		0	USD	7	23	2021-01-03 14:44:19.422388	2021-01-03 14:44:19.828741
42	treat	0	USD	8	\N	2021-01-03 14:54:36.143493	2021-01-03 14:54:36.143493
43	wedding	0	USD	8	\N	2021-01-03 14:54:36.147576	2021-01-03 14:54:36.147576
44	family	0	USD	8	\N	2021-01-03 14:54:36.149987	2021-01-03 14:54:36.149987
45	party	0	USD	8	\N	2021-01-03 14:54:36.152077	2021-01-03 14:54:36.152077
46	anniversary	0	USD	8	\N	2021-01-03 14:54:36.153851	2021-01-03 14:54:36.153851
47	ceremony	0	USD	8	\N	2021-01-03 14:54:36.155608	2021-01-03 14:54:36.155608
48	birthday	0	USD	8	\N	2021-01-03 14:54:36.157377	2021-01-03 14:54:36.157377
49	religion	0	USD	8	\N	2021-01-03 14:54:36.159057	2021-01-03 14:54:36.159057
54	anniversary	0	USD	9	24	2021-01-03 14:57:15.145031	2021-01-03 14:57:15.414446
55	ceremony	0	USD	9	24	2021-01-03 14:57:15.146749	2021-01-03 14:57:15.417641
56	birthday	0	USD	9	24	2021-01-03 14:57:15.148371	2021-01-03 14:57:15.420867
57	religion	0	USD	9	24	2021-01-03 14:57:15.149866	2021-01-03 14:57:15.423994
50	treat	100	USD	9	24	2021-01-03 14:57:15.137997	2021-01-03 16:45:28.395358
51	wedding	200	USD	9	24	2021-01-03 14:57:15.139748	2021-01-03 16:45:53.914289
52	family	700	USD	9	24	2021-01-03 14:57:15.141243	2021-01-03 16:47:52.499353
53	party	800	USD	9	24	2021-01-03 14:57:15.143102	2021-01-03 16:49:06.180092
58	treat	0	USD	10	25	2021-01-05 12:11:56.441449	2021-01-05 12:11:58.472763
59	wedding	0	USD	10	25	2021-01-05 12:11:56.449075	2021-01-05 12:11:58.477039
60	family	0	USD	10	25	2021-01-05 12:11:56.450547	2021-01-05 12:11:58.48038
61	party	0	USD	10	25	2021-01-05 12:11:56.45188	2021-01-05 12:11:58.483882
62	anniversary	0	USD	10	25	2021-01-05 12:11:56.453127	2021-01-05 12:11:58.488317
63	ceremony	0	USD	10	25	2021-01-05 12:11:56.45484	2021-01-05 12:11:58.492945
66	treat	0	USD	11	26	2021-01-05 12:34:56.193733	2021-01-05 12:34:57.608128
67	wedding	0	USD	11	26	2021-01-05 12:34:56.195463	2021-01-05 12:34:57.611393
68	family	0	USD	11	26	2021-01-05 12:34:56.196755	2021-01-05 12:34:57.614283
69	party	0	USD	11	26	2021-01-05 12:34:56.197962	2021-01-05 12:34:57.616846
70	anniversary	0	USD	11	26	2021-01-05 12:34:56.19919	2021-01-05 12:34:57.619608
71	ceremony	0	USD	11	26	2021-01-05 12:34:56.200395	2021-01-05 12:34:57.622229
72	birthday	0	USD	11	26	2021-01-05 12:34:56.20163	2021-01-05 12:34:57.624848
73	religion	0	USD	11	26	2021-01-05 12:34:56.202952	2021-01-05 12:34:57.627797
74	treat	0	USD	12	27	2021-01-05 12:42:18.381045	2021-01-05 12:42:19.889021
75	wedding	0	USD	12	27	2021-01-05 12:42:18.382856	2021-01-05 12:42:19.891777
76	family	0	USD	12	27	2021-01-05 12:42:18.384419	2021-01-05 12:42:19.89435
77	party	0	USD	12	27	2021-01-05 12:42:18.386149	2021-01-05 12:42:19.89689
78	anniversary	0	USD	12	27	2021-01-05 12:42:18.38783	2021-01-05 12:42:19.899463
79	ceremony	0	USD	12	27	2021-01-05 12:42:18.389203	2021-01-05 12:42:19.902106
80	birthday	0	USD	12	27	2021-01-05 12:42:18.390572	2021-01-05 12:42:19.9046
81	religion	0	USD	12	27	2021-01-05 12:42:18.391853	2021-01-05 12:42:19.907127
83	wedding	0	USD	13	29	2021-01-08 11:55:21.894416	2021-01-08 11:55:23.757013
84	family	0	USD	13	29	2021-01-08 11:55:21.896407	2021-01-08 11:55:23.760123
85	party	0	USD	13	29	2021-01-08 11:55:21.897853	2021-01-08 11:55:23.763158
86	anniversary	0	USD	13	29	2021-01-08 11:55:21.899254	2021-01-08 11:55:23.766099
87	ceremony	0	USD	13	29	2021-01-08 11:55:21.900654	2021-01-08 11:55:23.768525
88	birthday	0	USD	13	29	2021-01-08 11:55:21.902048	2021-01-08 11:55:23.771135
82	treat	0	USD	13	29	2021-01-08 11:55:21.888793	2021-01-08 11:55:23.753459
89	religion	0	USD	13	29	2021-01-08 11:55:21.90362	2021-01-08 11:55:23.773995
90	treat	0	USD	14	30	2021-01-08 12:54:18.349077	2021-01-08 12:54:19.952104
91	wedding	0	USD	14	30	2021-01-08 12:54:18.350886	2021-01-08 12:54:19.955347
92	family	0	USD	14	30	2021-01-08 12:54:18.352464	2021-01-08 12:54:19.958634
93	party	0	USD	14	30	2021-01-08 12:54:18.353935	2021-01-08 12:54:19.961992
94	anniversary	0	USD	14	30	2021-01-08 12:54:18.355356	2021-01-08 12:54:19.965212
95	ceremony	0	USD	14	30	2021-01-08 12:54:18.356799	2021-01-08 12:54:19.968357
96	birthday	0	USD	14	30	2021-01-08 12:54:18.358442	2021-01-08 12:54:19.971496
97	religion	0	USD	14	30	2021-01-08 12:54:18.360373	2021-01-08 12:54:20.001019
98	treat	0	USD	15	31	2021-01-09 13:28:20.320995	2021-01-09 13:28:21.936802
99	wedding	0	USD	15	31	2021-01-09 13:28:20.326421	2021-01-09 13:28:21.94019
100	family	0	USD	15	31	2021-01-09 13:28:20.328616	2021-01-09 13:28:21.943401
101	party	0	USD	15	31	2021-01-09 13:28:20.330165	2021-01-09 13:28:21.946449
102	anniversary	0	USD	15	31	2021-01-09 13:28:20.331557	2021-01-09 13:28:21.958961
103	ceremony	0	USD	15	31	2021-01-09 13:28:20.33302	2021-01-09 13:28:21.962191
104	birthday	0	USD	15	31	2021-01-09 13:28:20.334467	2021-01-09 13:28:21.965142
105	religion	0	USD	15	31	2021-01-09 13:28:20.335943	2021-01-09 13:28:21.968217
\.


--
-- Data for Name: site_configs; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.site_configs (id, created_at, updated_at, value, var) FROM stdin;
1	2020-11-17 14:29:30.674514	2020-11-17 14:29:30.674514	--- true\n	public
2	2020-11-17 14:29:30.680806	2020-11-17 14:29:30.680806	--- false\n	waiting_on_first_user
3	2020-11-17 14:29:56.976999	2020-11-17 14:29:56.976999	--- 584da562991b5dcbfbc2\n	health_check_token
4	2020-11-25 13:35:49.409368	2020-11-25 13:35:49.409368	--- e24a5ce0c89dec9521a1\n	github_key
5	2020-11-25 13:36:44.722028	2020-11-25 13:46:51.449498	--- 06c3f9ee53d10e711d10f48f7d605c09b85bde1a\n	github_secret
6	2020-11-25 14:06:16.201772	2020-11-25 14:06:16.201772	--- DEV(local)\n	community_name
7	2020-11-25 14:06:16.207249	2020-11-25 14:06:16.207249	--- dev test description\n	community_description
8	2020-11-25 14:06:16.211057	2020-11-25 14:06:16.211057	---\n- tested\n- test\n	suggested_tags
9	2020-11-25 14:06:16.214752	2020-11-25 14:06:16.214752	---\n- jess\n- peter\n	suggested_users
11	2020-12-19 12:14:14.081776	2020-12-19 12:14:14.081776	--- 975686765681-830neirdcr5gg4s0bcbrvgqf1vsst09n.apps.googleusercontent.com\n	google_key
12	2020-12-19 12:14:41.475977	2020-12-19 12:14:41.475977	--- iHXgx3j5kE7-6TJW5hYr8jNQ\n	google_secret
13	2020-12-20 10:12:19.762728	2020-12-20 10:12:19.762728	--- true\n	enable_video_upload
14	2020-12-30 15:39:45.190786	2020-12-30 15:39:45.190786	--- pk_test_Q0I81SBimBKm33VjGnH0L8vy\n	stripe_publishable_key
15	2020-12-30 15:40:20.104157	2020-12-30 15:40:20.104157	--- sk_test_DG6IidSl6hWeRzr5eoDkcmEP\n	stripe_api_key
16	2020-12-31 13:47:04.108627	2020-12-31 13:47:04.108627	--- ca_EtbrqluruqbOXWm37dKsl3RcnWMBf5h9\n	connect_key
18	2021-01-14 12:18:34.701133	2021-01-14 12:18:34.701133	--- basic\n	feed_strategy
19	2021-01-14 12:18:34.705585	2021-01-14 12:18:34.705585	--- sans_serif\n	default_font
20	2021-01-14 12:18:34.713774	2021-01-14 12:18:34.713774	--- "#3b49df"\n	primary_brand_color_hex
21	2021-01-14 12:18:34.718936	2021-01-14 12:18:34.718936	--- 0\n	tag_feed_minimum_score
22	2021-01-14 12:18:34.723725	2021-01-14 12:18:34.723725	--- 0\n	home_feed_minimum_score
17	2021-01-14 12:18:34.694237	2021-01-14 12:26:47.477817	--- rich\n	feed_style
10	2020-11-25 14:06:16.221651	2021-01-14 12:26:47.525725	--- !ruby/object:ActiveSupport::TimeWithZone\nutc: &1 2021-01-14 12:26:47.524064000 Z\nzone: !ruby/object:ActiveSupport::TimeZone\n  name: Etc/UTC\ntime: *1\n	admin_action_taken_at
\.


--
-- Data for Name: sponsorships; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.sponsorships (id, blurb_html, created_at, expires_at, featured_number, instructions, instructions_updated_at, level, organization_id, sponsorable_id, sponsorable_type, status, tagline, updated_at, url, user_id) FROM stdin;
1	If we generate the bus, we can get to the EXE firewall through the haptic AGP feed!	2020-11-17 14:29:46.837006	\N	0	\N	\N	silver	1	\N	\N	none	\N	2020-11-17 14:29:46.837006	\N	5
2	I'll quantify the wireless FTP feed, that should transmitter the CSS transmitter!	2020-11-17 14:29:46.84553	\N	0	\N	\N	silver	2	\N	\N	none	\N	2020-11-17 14:29:46.84553	\N	3
3	Transmitting the panel won't do anything, we need to parse the neural adp panel!	2020-11-17 14:29:46.860642	\N	0	\N	\N	silver	3	\N	\N	none	\N	2020-11-17 14:29:46.860642	\N	7
\.


--
-- Data for Name: tag_adjustments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.tag_adjustments (id, adjustment_type, article_id, created_at, reason_for_adjustment, status, tag_id, tag_name, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.taggings (id, context, created_at, tag_id, taggable_id, taggable_type, tagger_id, tagger_type) FROM stdin;
1	tags	2020-11-17 14:29:39.528914	13	1	Article	\N	\N
2	tags	2020-11-17 14:29:39.535856	10	1	Article	\N	\N
3	tags	2020-11-17 14:29:39.541695	11	1	Article	\N	\N
4	tags	2020-11-17 14:29:39.547193	12	1	Article	\N	\N
5	tags	2020-11-17 14:29:39.654191	6	2	Article	\N	\N
6	tags	2020-11-17 14:29:39.659857	13	2	Article	\N	\N
7	tags	2020-11-17 14:29:39.665499	2	2	Article	\N	\N
8	tags	2020-11-17 14:29:39.734131	6	3	Article	\N	\N
9	tags	2020-11-17 14:29:39.740402	2	3	Article	\N	\N
10	tags	2020-11-17 14:29:39.745515	12	3	Article	\N	\N
11	tags	2020-11-17 14:29:39.806837	13	4	Article	\N	\N
12	tags	2020-11-17 14:29:39.812366	3	4	Article	\N	\N
13	tags	2020-11-17 14:29:39.817942	12	4	Article	\N	\N
14	tags	2020-11-17 14:29:39.82338	11	4	Article	\N	\N
15	tags	2020-11-17 14:29:39.893778	6	5	Article	\N	\N
16	tags	2020-11-17 14:29:39.899371	1	5	Article	\N	\N
17	tags	2020-11-17 14:29:39.904835	9	5	Article	\N	\N
18	tags	2020-11-17 14:29:39.973862	8	6	Article	\N	\N
19	tags	2020-11-17 14:29:39.980187	12	6	Article	\N	\N
20	tags	2020-11-17 14:29:39.986112	6	6	Article	\N	\N
21	tags	2020-11-17 14:29:40.054792	13	7	Article	\N	\N
22	tags	2020-11-17 14:29:40.060399	10	7	Article	\N	\N
23	tags	2020-11-17 14:29:40.066094	12	7	Article	\N	\N
24	tags	2020-11-17 14:29:40.071636	1	7	Article	\N	\N
25	tags	2020-11-17 14:29:40.142434	10	8	Article	\N	\N
26	tags	2020-11-17 14:29:40.148142	7	8	Article	\N	\N
27	tags	2020-11-17 14:29:40.153792	2	8	Article	\N	\N
28	tags	2020-11-17 14:29:40.219149	8	9	Article	\N	\N
29	tags	2020-11-17 14:29:40.224482	13	9	Article	\N	\N
30	tags	2020-11-17 14:29:40.230012	1	9	Article	\N	\N
31	tags	2020-11-17 14:29:40.301387	13	10	Article	\N	\N
32	tags	2020-11-17 14:29:40.307414	4	10	Article	\N	\N
33	tags	2020-11-17 14:29:40.313061	8	10	Article	\N	\N
34	tags	2020-11-17 14:29:40.318851	2	10	Article	\N	\N
35	tags	2020-11-17 14:29:40.385319	9	11	Article	\N	\N
36	tags	2020-11-17 14:29:40.39088	13	11	Article	\N	\N
37	tags	2020-11-17 14:29:40.396453	5	11	Article	\N	\N
38	tags	2020-11-17 14:29:40.459856	6	12	Article	\N	\N
39	tags	2020-11-17 14:29:40.465453	7	12	Article	\N	\N
40	tags	2020-11-17 14:29:40.470948	1	12	Article	\N	\N
41	tags	2020-11-17 14:29:40.537754	13	13	Article	\N	\N
42	tags	2020-11-17 14:29:40.543213	8	13	Article	\N	\N
43	tags	2020-11-17 14:29:40.548765	10	13	Article	\N	\N
44	tags	2020-11-17 14:29:40.618497	4	14	Article	\N	\N
45	tags	2020-11-17 14:29:40.623867	10	14	Article	\N	\N
46	tags	2020-11-17 14:29:40.629304	11	14	Article	\N	\N
47	tags	2020-11-17 14:29:40.690713	9	15	Article	\N	\N
48	tags	2020-11-17 14:29:40.696102	3	15	Article	\N	\N
49	tags	2020-11-17 14:29:40.701453	5	15	Article	\N	\N
50	tags	2020-11-17 14:29:40.767937	13	16	Article	\N	\N
51	tags	2020-11-17 14:29:40.773432	10	16	Article	\N	\N
52	tags	2020-11-17 14:29:40.779032	6	16	Article	\N	\N
53	tags	2020-11-17 14:29:40.788965	3	16	Article	\N	\N
54	tags	2020-11-17 14:29:40.854998	13	17	Article	\N	\N
55	tags	2020-11-17 14:29:40.860592	10	17	Article	\N	\N
56	tags	2020-11-17 14:29:40.86631	11	17	Article	\N	\N
57	tags	2020-11-17 14:29:40.929946	5	18	Article	\N	\N
58	tags	2020-11-17 14:29:40.935302	4	18	Article	\N	\N
59	tags	2020-11-17 14:29:40.940758	2	18	Article	\N	\N
60	tags	2020-11-17 14:29:41.004445	13	19	Article	\N	\N
61	tags	2020-11-17 14:29:41.014212	3	19	Article	\N	\N
62	tags	2020-11-17 14:29:41.019815	9	19	Article	\N	\N
63	tags	2020-11-17 14:29:41.025304	12	19	Article	\N	\N
64	tags	2020-11-17 14:29:41.089886	9	20	Article	\N	\N
65	tags	2020-11-17 14:29:41.095668	5	20	Article	\N	\N
66	tags	2020-11-17 14:29:41.101373	3	20	Article	\N	\N
67	tags	2020-11-17 14:29:41.163073	6	21	Article	\N	\N
68	tags	2020-11-17 14:29:41.16857	3	21	Article	\N	\N
69	tags	2020-11-17 14:29:41.174179	13	21	Article	\N	\N
70	tags	2020-11-17 14:29:41.242833	13	22	Article	\N	\N
71	tags	2020-11-17 14:29:41.248154	9	22	Article	\N	\N
72	tags	2020-11-17 14:29:41.253447	3	22	Article	\N	\N
73	tags	2020-11-17 14:29:41.259123	11	22	Article	\N	\N
74	tags	2020-11-17 14:29:41.324825	5	23	Article	\N	\N
75	tags	2020-11-17 14:29:41.330579	12	23	Article	\N	\N
76	tags	2020-11-17 14:29:41.335918	3	23	Article	\N	\N
77	tags	2020-11-17 14:29:41.400607	13	24	Article	\N	\N
78	tags	2020-11-17 14:29:41.406203	2	24	Article	\N	\N
79	tags	2020-11-17 14:29:41.411685	3	24	Article	\N	\N
80	tags	2020-11-17 14:29:41.479054	13	25	Article	\N	\N
81	tags	2020-11-17 14:29:41.48452	7	25	Article	\N	\N
82	tags	2020-11-17 14:29:41.490015	9	25	Article	\N	\N
83	tags	2020-11-17 14:29:41.495576	3	25	Article	\N	\N
84	tags	2020-11-17 14:29:43.79288	14	26	Article	\N	\N
85	tags	2020-11-17 14:29:46.03989	11	1	Listing	\N	\N
86	tags	2020-11-17 14:29:46.04849	13	1	Listing	\N	\N
87	tags	2020-11-17 14:29:46.075801	13	2	Listing	\N	\N
88	tags	2020-11-17 14:29:46.081839	5	2	Listing	\N	\N
89	tags	2020-11-17 14:29:46.104772	2	3	Listing	\N	\N
90	tags	2020-11-17 14:29:46.110023	14	3	Listing	\N	\N
91	tags	2020-11-17 14:29:46.131398	14	4	Listing	\N	\N
92	tags	2020-11-17 14:29:46.136611	4	4	Listing	\N	\N
93	tags	2020-11-17 14:29:46.15878	2	5	Listing	\N	\N
94	tags	2020-11-17 14:29:46.163992	14	5	Listing	\N	\N
95	tags	2020-11-17 14:29:46.195808	12	6	Listing	\N	\N
96	tags	2020-11-17 14:29:46.201348	3	6	Listing	\N	\N
97	tags	2020-11-17 14:29:46.226996	12	7	Listing	\N	\N
98	tags	2020-11-17 14:29:46.232552	6	7	Listing	\N	\N
99	tags	2020-11-17 14:29:46.258779	1	8	Listing	\N	\N
100	tags	2020-11-17 14:29:46.264352	7	8	Listing	\N	\N
101	tags	2020-11-17 14:29:46.292621	6	9	Listing	\N	\N
102	tags	2020-11-17 14:29:46.298138	13	9	Listing	\N	\N
103	tags	2020-11-17 14:29:46.320841	11	10	Listing	\N	\N
104	tags	2020-11-17 14:29:46.326225	9	10	Listing	\N	\N
105	tags	2020-11-17 14:29:46.34915	5	11	Listing	\N	\N
106	tags	2020-11-17 14:29:46.354507	6	11	Listing	\N	\N
107	tags	2020-11-17 14:29:46.378178	5	12	Listing	\N	\N
108	tags	2020-11-17 14:29:46.388351	7	12	Listing	\N	\N
109	tags	2020-12-02 12:43:40.320455	15	27	Article	\N	\N
110	tags	2020-12-03 11:36:49.761122	15	28	Article	\N	\N
111	tags	2020-12-20 09:10:49.679567	15	29	Article	\N	\N
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.tags (id, alias_for, badge_id, bg_color_hex, buffer_profile_id_code, category, created_at, hotness_score, keywords_for_search, mod_chat_channel_id, name, pretty_name, profile_image, requires_approval, rules_html, rules_markdown, short_summary, social_image, social_preview_template, submission_template, supported, taggings_count, text_color_hex, updated_at, wiki_body_html, wiki_body_markdown) FROM stdin;
1	\N	\N	#8dd13d	\N	uncategorized	2020-11-17 14:29:39.032107	68	\N	\N	beginners	\N	\N	f	\N	\N	\N	\N	article	\N	t	5	#f1f422	2020-11-17 14:29:52.971405	\N	\N
2	\N	\N	#97ff65	\N	uncategorized	2020-11-17 14:29:39.064409	229	\N	\N	career	\N	\N	f	\N	\N	\N	\N	article	\N	t	8	#a1b090	2020-11-17 14:29:52.999507	\N	\N
3	\N	\N	#04633e	\N	uncategorized	2020-11-17 14:29:39.086478	243	\N	\N	computerscience	\N	\N	f	\N	\N	\N	\N	article	\N	t	11	#e214b8	2020-11-17 14:29:53.02108	\N	\N
4	\N	\N	#b803f9	\N	uncategorized	2020-11-17 14:29:39.105526	142	\N	\N	git	\N	\N	f	\N	\N	\N	\N	article	\N	t	4	#cb6dcf	2020-11-17 14:29:53.039589	\N	\N
5	\N	\N	#81b96b	\N	uncategorized	2020-11-17 14:29:39.125775	132	\N	\N	go	\N	\N	f	\N	\N	\N	\N	article	\N	t	8	#8176f4	2020-11-17 14:29:53.057815	\N	\N
6	\N	\N	#c702f0	\N	uncategorized	2020-11-17 14:29:39.148151	154	\N	\N	java	\N	\N	f	\N	\N	\N	\N	article	\N	t	10	#bfcf2e	2020-11-17 14:29:53.077329	\N	\N
7	\N	\N	#ba5ec6	\N	uncategorized	2020-11-17 14:29:39.166842	42	\N	\N	javascript	\N	\N	f	\N	\N	\N	\N	article	\N	t	5	#1a1083	2020-11-17 14:29:53.096988	\N	\N
8	\N	\N	#7c9a30	\N	uncategorized	2020-11-17 14:29:39.189729	87	\N	\N	linux	\N	\N	f	\N	\N	\N	\N	article	\N	t	4	#b441db	2020-11-17 14:29:53.124546	\N	\N
9	\N	\N	#ed07e6	\N	uncategorized	2020-11-17 14:29:39.207955	80	\N	\N	productivity	\N	\N	f	\N	\N	\N	\N	article	\N	t	8	#0190d2	2020-11-17 14:29:53.145277	\N	\N
10	\N	\N	#cf3bd5	\N	uncategorized	2020-11-17 14:29:39.227153	168	\N	\N	python	\N	\N	f	\N	\N	\N	\N	article	\N	t	7	#4fbac5	2020-11-17 14:29:53.165598	\N	\N
11	\N	\N	#9213f1	\N	uncategorized	2020-11-17 14:29:39.247742	99	\N	\N	security	\N	\N	f	\N	\N	\N	\N	article	\N	t	7	#9c8394	2020-11-17 14:29:53.186343	\N	\N
12	\N	\N	#5a6a1d	\N	uncategorized	2020-11-17 14:29:39.272199	164	\N	\N	webdev	\N	\N	f	\N	\N	\N	\N	article	\N	t	9	#56a1e4	2020-11-17 14:29:53.206979	\N	\N
13	\N	\N	\N	\N	uncategorized	2020-11-17 14:29:39.515361	446	\N	\N	discuss	\N	\N	f	\N	\N	\N	\N	article	\N	f	18	\N	2020-11-17 14:29:53.229062	\N	\N
14	\N	\N	\N	\N	uncategorized	2020-11-17 14:29:43.78528	4	\N	\N	welcome	\N	\N	f	\N	\N	\N	\N	article	\N	f	4	\N	2020-11-17 14:29:53.252949	\N	\N
15	\N	\N	\N	\N	uncategorized	2020-12-02 12:43:40.305505	0	\N	\N	test	\N	\N	f	\N	\N	\N	\N	article	\N	f	3	\N	2020-12-02 12:43:40.305505	\N	\N
\.


--
-- Data for Name: tweets; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.tweets (id, created_at, extended_entities_serialized, favorite_count, full_fetched_object_serialized, hashtags_serialized, in_reply_to_status_id_code, in_reply_to_user_id_code, in_reply_to_username, is_quote_status, last_fetched_at, media_serialized, mentioned_usernames_serialized, profile_image, quoted_tweet_id_code, retweet_count, source, text, tweeted_at, twitter_id_code, twitter_name, twitter_uid, twitter_user_followers_count, twitter_user_following_count, twitter_username, updated_at, urls_serialized, user_id, user_is_verified) FROM stdin;
\.


--
-- Data for Name: user_blocks; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_blocks (id, blocked_id, blocker_id, config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_documents; Type: TABLE DATA; Schema: public; Owner: forem_latest
--

COPY public.user_documents (id, government_id, card_last_4, exp_year, exp_month, cvc, iban_number, ethereum_address, bitcoin_address, user_id, created_at, updated_at, status, bank_account) FROM stdin;
\.


--
-- Data for Name: user_subscriptions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.user_subscriptions (id, author_id, created_at, subscriber_email, subscriber_id, updated_at, user_subscription_sourceable_id, user_subscription_sourceable_type) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, articles_count, available_for, badge_achievements_count, behance_url, bg_color_hex, blocked_by_count, blocking_others_count, checked_code_of_conduct, checked_terms_and_conditions, comments_count, config_font, config_navbar, config_theme, confirmation_sent_at, confirmation_token, confirmed_at, contact_consent, created_at, credits_count, current_sign_in_at, current_sign_in_ip, currently_hacking_on, currently_learning, display_announcements, display_sponsors, dribbble_url, editor_version, education, email, email_badge_notifications, email_comment_notifications, email_community_mod_newsletter, email_connect_messages, email_digest_periodic, email_follower_notifications, email_membership_newsletter, email_mention_notifications, email_newsletter, email_public, email_tag_mod_newsletter, email_unread_notifications, employer_name, employer_url, employment_title, encrypted_password, experience_level, export_requested, exported_at, facebook_created_at, facebook_url, facebook_username, failed_attempts, feed_admin_publish_permission, feed_fetched_at, feed_mark_canonical, feed_referential_link, feed_url, following_orgs_count, following_tags_count, following_users_count, github_created_at, github_repos_updated_at, github_username, gitlab_url, inbox_guidelines, inbox_type, instagram_url, invitation_accepted_at, invitation_created_at, invitation_limit, invitation_sent_at, invitation_token, invitations_count, invited_by_id, invited_by_type, language_settings, last_article_at, last_comment_at, last_followed_at, last_moderation_notification, last_notification_activity, last_onboarding_page, last_reacted_at, last_sign_in_at, last_sign_in_ip, linkedin_url, location, locked_at, looking_for_work, looking_for_work_publicly, mastodon_url, medium_url, mobile_comment_notifications, mod_roundrobin_notifications, monthly_dues, mostly_work_with, name, old_old_username, old_username, onboarding_package_requested, organization_info_updated_at, payment_pointer, permit_adjacent_sponsors, profile_image, profile_updated_at, rating_votes_count, reaction_notifications, reactions_count, registered, registered_at, remember_created_at, remember_token, reputation_modifier, reset_password_sent_at, reset_password_token, saw_onboarding, score, secret, sign_in_count, signup_cta_variant, spent_credits_count, stackoverflow_url, stripe_id_code, subscribed_to_user_subscriptions_count, summary, text_color_hex, twitch_url, twitter_created_at, twitter_followers_count, twitter_following_count, twitter_username, unconfirmed_email, unlock_token, unspent_credits_count, updated_at, username, website_url, welcome_notifications, workshop_expiration, youtube_url, google_created_at, google_url, google_username, first_name, last_name, date_of_birth, telephone, location_id, composer_id, industry_id, song_language_id, genre_id, commission_accepted, sell_tracks, sell_campaigns, spotify_url, soundcloud_url, itunes_url, twitter_url, is_verified) FROM stdin;
9	3	\N	1	\N	\N	0	0	f	f	5	default	default	default	\N	\N	2020-11-17 14:29:37.841371	f	2020-11-17 14:29:38.099402	60	\N	\N	\N	\N	t	t	\N	v1	\N	marvin+esteban@bashirian.info	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$tD/d/R2559rAE5nCJyT9oeACx8H92bXSlMF1v13VhkC2U.iV/SYUm	\N	f	\N	\N	\N	\N	1	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:40.447644	2020-11-25 14:07:13.956299	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Esteban Marvin	\N	\N	f	2020-11-17 14:29:38.630887	\N	t	75e93db5-4354-4fbb-99cd-02dd4c6eca6b.png	2017-01-01 05:00:00	0	t	5	t	2020-11-17 14:29:37.841376	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Iure minima voluptates. Sed iure numquam. Consequatur eaque vel. Soluta animi sed. Sapiente impedit quisquam. Odit quia modi. Quidem voluptatem totam. Et ipsa recusandae. Doloribus sed quia. Velit v.	\N	\N	\N	\N	\N	esteban.marvin	\N	\N	60	2020-11-25 14:07:13.956299	estebanmarvin	http://tillman-langosh.info/lacy	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
4	3	\N	1	\N	\N	0	0	f	f	0	default	default	default	\N	\N	2020-11-17 14:29:36.365849	f	2020-11-17 14:29:36.583157	76	\N	\N	\N	\N	t	t	\N	v1	\N	shanahan+laveta@fritsch.net	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$5TonmKqG9vho8ea6574FWOepYd8NSyyjSLzhD3I67Jy90VjqjZeFK	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:41.387786	2017-01-01 05:00:00	\N	2020-11-25 13:54:56.803433	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Laveta Shanahan	\N	\N	f	\N	\N	t	8a0bc7f7-5387-45cb-8030-1a0020924ac9.png	2017-01-01 05:00:00	0	t	0	t	2020-11-17 14:29:36.365854	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Voluptatem officia officiis. Pariatur alias laudantium. Neque iure placeat. Sunt iusto voluptas. Ratione dolore corporis. Ratione sequi sapiente. Ipsam reiciendis suscipit. Quo eos placeat. Sit unde.	\N	\N	\N	\N	\N	shanahan_laveta	\N	\N	76	2020-11-17 14:29:45.656421	shanahan_laveta	http://ward.com/pauletta.littel	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
1	2	\N	1	\N	\N	0	0	f	f	2	default	default	default	\N	\N	2020-11-17 14:29:34.098382	f	2020-11-17 14:29:35.461949	52	\N	\N	\N	\N	t	t	\N	v1	\N	rolfson+kasey@muller-koepp.co	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$J1zRLjnJtaPvJ5M9WbilyuJjF3Dja1zfpT06RQOjbxSTE6k.jw/CK	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:43.773615	2020-11-25 14:06:34.883122	\N	2020-11-25 13:54:56.751252	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Kasey Rolfson	\N	\N	f	2020-11-17 14:29:38.665482	\N	t	8fa08354-7f06-4241-bd2a-03f3f25eb0b8.png	2017-01-01 05:00:00	0	t	6	t	2020-11-17 14:29:34.098389	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Velit cum dolorum. Perferendis et sit. Velit voluptas quos. Assumenda et rerum. Quas sed necessitatibus. Quibusdam vel vitae. Est libero inventore. Ducimus voluptatibus alias. Cupiditate est ea. Dol.	\N	\N	\N	\N	\N	rolfson.kasey	\N	\N	52	2020-11-25 14:06:34.883122	rolfsonkasey	http://douglas-walter.io/carlos.bayer	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
3	3	\N	1	\N	\N	0	0	f	f	2	default	default	default	\N	\N	2020-11-17 14:29:36.080369	f	2020-11-17 14:29:36.297959	17	\N	\N	\N	\N	t	t	\N	v1	\N	mcglynn+md+dee@altenwerth-reichel.net	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$Ua30HMxHxW7YqBBj5GkeiewYvpNunEs.Uo3wOO1CqxrS3S1vNA81S	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:41.230935	2020-11-25 14:08:22.511043	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Dee McGlynn MD	\N	\N	f	2020-11-17 14:29:38.506627	\N	t	9db8ccf6-cacc-403f-afc6-eaf8a3c32972.png	2017-01-01 05:00:00	0	t	2	t	2020-11-17 14:29:36.080376	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Culpa in officiis. Odio laudantium omnis. Occaecati voluptates quibusdam. Voluptas magnam dolores. Explicabo quisquam qui. Consequatur ab alias. Et nostrum dolorum. Rerum aliquam saepe. Asperiores q.	\N	\N	\N	\N	\N	md_mcglynn_dee	\N	\N	17	2020-11-25 14:08:22.511043	md_mcglynn_dee	http://murray.io/darcy	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
7	2	\N	0	\N	\N	0	0	f	f	1	default	default	default	\N	\N	2020-11-17 14:29:37.258414	f	2020-11-17 14:29:37.478909	81	\N	\N	\N	\N	t	t	\N	v1	\N	jeromy+schimmel@heaney-hartmann.net	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$hCUh5jUUuGiLgz.nWF0.BOFgxe99XU.OtPrIodaL1HNdOhjdLcYgm	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:41.312279	2020-11-25 14:05:54.712265	\N	2020-11-25 13:54:56.723722	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Jeromy Schimmel	\N	\N	f	2020-11-17 14:29:38.695613	\N	t	fc3554c2-3141-4ec7-a899-d39c289a0d06.png	2017-01-01 05:00:00	0	t	1	t	2020-11-17 14:29:37.258418	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Nemo nesciunt quasi. Sint fugiat et. Voluptas exercitationem numquam. Dolor nihil autem. Distinctio totam facilis. Consequatur beatae iusto. Ipsam necessitatibus unde. Et excepturi aut. Fugit laudan.	\N	\N	\N	\N	\N	schimmel.jeromy	\N	\N	81	2020-11-25 14:05:54.712265	schimmeljeromy	http://osinski.info/columbus_hermiston	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
2	3	\N	1	\N	\N	0	0	f	f	2	default	default	default	\N	\N	2020-11-17 14:29:35.81039	f	2020-11-17 14:29:36.017315	63	\N	\N	\N	\N	t	t	\N	v1	\N	lesch+tora@collier.net	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$WFFuPYokK9aEhdZde9clJeLnzeLXKE0.1WogsO7VEgwSv1H0L4R8m	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:41.150564	2020-11-25 14:07:13.945433	\N	2020-11-25 13:54:56.79334	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Tora Lesch	\N	\N	f	2020-11-17 14:29:38.60382	\N	t	2e7f5935-4e4a-4305-9c0b-de9b2c2a7e44.png	2017-01-01 05:00:00	0	t	2	t	2020-11-17 14:29:35.810398	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Qui doloremque voluptatem. Perspiciatis quis deleniti. Et voluptatem distinctio. Delectus aliquam sit. Eius cupiditate nam. Occaecati error ab. Facilis reprehenderit quo. Ut non et. Eos commodi vel..	\N	\N	\N	\N	\N	tora_lesch	\N	\N	63	2020-11-25 14:07:13.945433	tora_lesch	http://lemke-spencer.name/maribeth	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
11	0	\N	1	\N	\N	0	0	f	f	1	default	default	default	\N	\N	2020-11-17 14:29:38.719075	f	2020-11-17 14:29:38.868714	60	\N	\N	\N	\N	t	t	\N	v1	\N	admin@forem.local	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$fc2BNgoVsuCRnh5Tv.LrmOpvYE6zcZwC9JweXJG.urHzSmrnoiHnu	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": null}	2017-01-01 05:00:00	2020-11-25 14:05:24.677294	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Admin McAdmin	\N	\N	f	\N	\N	t	b4e2aee0-d2d9-4c06-960a-d2d17dec7b10.png	2017-01-01 05:00:00	0	t	2	t	2020-11-17 14:29:38.868714	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Sunt consequatur fugiat. Debitis excepturi ut. Recusandae adipisci consequatur. Cupiditate error amet. Veritatis amet numquam. Numquam inventore voluptates. Sed consequatur et. Assumenda beatae quia.	\N	\N	\N	\N	\N	\N	\N	\N	60	2020-11-25 14:05:24.677294	admin_mcadmin	http://gleichner.biz/bertha	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
5	1	\N	1	\N	\N	0	0	f	f	2	default	default	default	\N	\N	2020-11-17 14:29:36.663694	f	2020-11-17 14:29:36.911481	67	\N	\N	\N	\N	t	t	\N	v1	\N	hackett+gov+guadalupe@larkin.info	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$zZK0rY.4aA5aGYhqIm5ss.jwHdaAwk8Nzbr7orVvwhD8IJVx5CK86	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:40.841664	2020-11-25 14:07:07.626113	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Gov. Guadalupe Hackett	\N	\N	f	2020-11-17 14:29:38.477878	\N	t	63c914c9-9793-4b24-a6ec-1c1c1b4d453a.png	2017-01-01 05:00:00	0	t	2	t	2020-11-17 14:29:36.663699	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Perspiciatis vero esse. Qui repellendus non. Qui esse voluptatem. Totam ut praesentium. Deleniti qui ea. Voluptatum voluptatibus et. Quo minus aut. Id consectetur quia. Id illo occaecati. Natus quia.	\N	\N	\N	\N	\N	guadalupe.hackett.gov	\N	\N	67	2020-11-25 14:07:07.626113	guadalupehackettgov	http://glover.net/craig_berge	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
6	4	\N	1	\N	\N	0	0	f	f	5	default	default	default	\N	\N	2020-11-17 14:29:36.971264	f	2020-11-17 14:29:37.195655	47	\N	\N	\N	\N	t	t	\N	v1	\N	jacob+lehner@lowe-marvin.org	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$XPojhMNq8AUH6sKiBTLBs.Jk2iJW4ffnCY/Qx8ONr6Ty.XTcds29y	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:40.678509	2020-11-25 14:07:22.786407	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Jacob Lehner	\N	\N	f	2020-11-17 14:29:38.414878	\N	t	8b0f03f6-aa5f-4ef9-b148-610a5fcf549a.png	2017-01-01 05:00:00	0	t	5	t	2020-11-17 14:29:36.971269	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	In ullam aliquid. Eius minima quis. Perspiciatis unde architecto. Quas iste officiis. Fuga repellendus provident. Ut aliquid delectus. Eum quia et. Adipisci saepe et. Ea perferendis nostrum. Autem e.	\N	\N	\N	\N	\N	lehner_jacob	\N	\N	47	2020-11-25 14:07:22.786407	lehner_jacob	http://conroy.co/maricruz	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
10	4	\N	1	\N	\N	0	0	f	f	8	default	default	default	\N	\N	2020-11-17 14:29:38.138154	f	2020-11-17 14:29:38.351337	38	\N	\N	\N	\N	t	t	\N	v1	\N	cremin+tressie@yundt.biz	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$A.LXnxsVcOkJDWqqe7SnbOg7DNemLOhVchmaMobxhhwADOkHk12aW	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": null}	2020-11-17 14:29:41.466781	2020-11-25 14:08:10.714602	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Tressie Cremin	\N	\N	f	\N	\N	t	eb645af5-10c1-4c22-a81d-5b5a9c52d34f.png	2017-01-01 05:00:00	0	t	8	t	2020-11-17 14:29:38.138159	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Nam voluptas esse. Consequatur tempore doloribus. Quis neque aut. Autem ea maxime. Velit dolore placeat. Debitis quam assumenda. Qui repellat similique. Ut doloribus facere. Veniam aut voluptatem. P.	\N	\N	\N	\N	\N	cremin.tressie	\N	\N	38	2020-11-25 14:08:10.714602	cremintressie	http://jast.io/elayne.hansen	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
27	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2021-01-05 12:42:18.465025	eixRomLBnUGJkAz2_U_z	2021-01-07 13:15:34.061829	f	2021-01-05 12:42:18.464691	0	\N	\N	\N	\N	t	t	\N	v2	\N	muzamil.mujahid11@gmail.comasassaas	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$J9kx5TSIq9icBREyinIaGuU9WFUOjnd0tpEzEL1Tc2NQJvoQdvIWy	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2017-01-01 05:00:00	0	t	0	t	2021-01-05 12:42:18.443989	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-07 13:19:06.536671	muzzamil934	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	f	f	f					f
12	4	\N	0	\N	\N	0	0	t	t	0	sans_serif	default	default	2020-11-25 13:48:33.201242	sRxd34YbNf9ee6YGJ78x	2021-01-14 12:16:58.745788	f	2020-11-25 13:48:33.200973	60	\N	\N	\N	\N	t	t	\N	v2	\N	muzamil.mujahid11@gmail.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$zeUEbz2h15zO0NMSE8WrZ.p0W9eZrfrbMEPJ/I5ZXcLXCJBIJVbhu	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	2018-05-05 13:24:51	2017-01-01 05:00:00	Muzzamil123	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": null}	2021-01-04 11:45:26.232089	2017-01-01 05:00:00	2020-12-27 22:12:15.848596	2017-01-01 05:00:00	\N	v2: email preferences form	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Muzzamil123	\N	\N	f	2020-12-02 14:02:01.948329	\N	t	9b9563f4-e646-40e1-bdec-b6a25270a1ec.png	2021-01-14 12:27:14.538217	0	t	0	t	2020-11-25 13:48:32.996013	2021-01-14 12:16:58.738154	SEEeh3WiVyyyVubzw78m	1	\N	\N	t	0	\N	0	navbar_basic	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	60	2021-01-14 12:27:14.538217	muzzamil123	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
30	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2021-01-08 12:54:18.453482	73d5qx3q_WqznSBt7iU8	\N	f	2021-01-08 12:54:18.452933	0	\N	\N	\N	\N	t	t	\N	v2	\N	ghgh@ghgh.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$GqHfgdiStCTIKTtCQ46OP.8CdT0T8Fvn4UQi1cQp.Pva8qNulCffG	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2017-01-01 05:00:00	0	t	0	t	2021-01-08 12:54:18.411609	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-09 13:03:51.31958	muzzamil428	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	t	t	t					f
31	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2021-01-09 13:28:20.428961	1GSUaDBs8PgcSf62E7XF	\N	f	2021-01-09 13:28:20.428509	0	\N	\N	\N	\N	t	t	\N	v2	\N	muj@test.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$ywpsxI4kEPVZEgavS1WJZOdxlKkz/o5uwMn8fSSL3K9h8Ql8m9S8O	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2017-01-01 05:00:00	0	t	0	t	2021-01-09 13:28:20.405848	2021-01-09 13:28:23.304873	Dk-Rj2CZv_XTSEH3-yAL	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-09 13:28:23.305375	muzzamil997	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	t	t	t		http://soundcloud.com			f
8	1	\N	1	\N	\N	0	0	f	f	2	default	default	default	\N	\N	2020-11-17 14:29:37.54554	f	2020-11-17 14:29:37.765558	37	\N	\N	\N	\N	t	t	\N	v1	\N	wiegand+pablo@kuhic.io	t	f	f	t	f	f	f	t	f	f	f	t	\N	\N	\N	$2a$10$uStmlZE5DbSEP99csdpcwOadVbXxeAU2w5ffapLz7oGrzQzRrl0YW	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": "en"}	2020-11-17 14:29:40.991513	2020-11-25 14:07:17.520203	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Pablo Wiegand	\N	\N	f	2020-11-17 14:29:38.53297	\N	t	6f0f13f0-2744-45e1-b8bf-ee4621a0b9ec.png	2017-01-01 05:00:00	0	t	2	t	2020-11-17 14:29:37.545548	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	Ut est non. Qui saepe debitis. Voluptatum cum sed. Dolore facilis ut. Voluptatem nostrum vel. Non et aut. Ratione et atque. Consequatur quam dolorum. Facere et consequatur. Minus recusandae atque. E.	\N	\N	\N	\N	\N	pablo.wiegand	\N	\N	37	2020-11-25 14:07:17.520203	pablowiegand	http://pollich.biz/antionette.zemlak	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
16	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2020-12-19 15:50:29.24302	njvzhFbVzqHGbha8JbG8	2020-12-19 15:50:29.300121	f	2020-12-19 15:50:29.242706	0	\N	\N	\N	\N	t	t	\N	v2	\N	muzamil.mujahid111@gmail.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$QAeArqfWl5Jy70hifnQQde/BjuR4BjB/SE7ghYv3vnSidJHcNcpmC	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": null}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	v2: follow tags page	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Muzzamil Mujahid	\N	\N	f	\N	\N	t	44f59cd3-d00f-4988-85b1-e8f6ccc0015a.jpg	2020-12-19 15:50:34.664221	0	t	0	t	2020-12-19 15:50:29.029112	\N	\N	1	\N	\N	t	0	\N	0	navbar_basic	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2020-12-19 15:50:42.880072	muzamilmujahid111gmailcom	\N	t	\N	\N	2020-12-19 15:50:28.611284		muzamil.mujahid111@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
23	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	\N	\N	2021-01-03 14:44:19.582712	f	2021-01-03 14:44:19.644464	0	\N	\N	\N	\N	t	t	\N	v2	\N	qw@qw.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$VkfSuk5S0uBUpIFgqQx/9u5J8NxhpxXMK7.Meg5oFFohZAmAeefHi	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2017-01-01 05:00:00	0	t	0	t	2021-01-03 14:44:19.582622	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-03 14:54:08.800597	muzzamil376	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	f	f	f					f
22	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	\N	\N	2021-01-03 14:36:10.191748	f	2021-01-03 14:36:10.249071	0	\N	\N	\N	\N	t	t	\N	v2	\N	uh@hu.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$RA7e4rL4jflW1fzinw8LqOMp7rijhy6oOLzwVSp/fZ6CNiV0NH8MK	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	v2: follow users page	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2021-01-03 14:38:06.451246	0	t	0	t	2021-01-03 14:36:10.191637	2021-01-03 14:36:45.242523	Kdv5-KwN_2zvHyzSYNse	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-03 14:38:06.457028	muzzamil238	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	03025434231	167	1	1	1	1	f	f	f					f
15	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2020-12-19 15:38:58.074548	fEkzp2tfn5xPjHRYxEAQ	2020-12-19 15:38:58.172064	f	2020-12-19 15:38:58.074096	0	\N	\N	\N	\N	t	t	\N	v2	\N	muzammilmujahid18@gmail.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$R3voJQLjO84twtntuteHiun3ly4DEjy2JMdCJruIOzg9wcBvQxYRG	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"], "estimated_default_language": null}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	v2: follow tags page	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	Muzammil Mujahid	\N	\N	f	\N	\N	t	43cb759a-756f-4207-8c64-022a28ef290c.jpg	2020-12-19 15:39:02.673844	0	t	0	t	2020-12-19 15:38:57.882316	\N	\N	1	\N	\N	t	0	\N	0	navbar_basic	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2020-12-19 15:39:17.456108	muzammilmujahid18gmailcom	\N	t	\N	\N	2020-12-19 15:38:54.347792		muzammilmujahid18@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	t
19	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2020-12-30 15:13:30.351286	oBXRWVwsV_WR7EcykEdV	2020-12-31 14:26:48.248756	f	2020-12-30 15:13:30.351194	0	\N	\N	\N	\N	t	t	\N	v2	\N	pihov48469@1092df.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$PwsA1WGoVxKYGcjBxO66UOotsWSI26lnLVvbcOcjpZErUbs5KbKR2	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	v2: follow users page	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2020-12-31 14:29:28.403091	0	t	0	t	2020-12-30 15:13:30.34004	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-01 16:23:47.267474	muzzamil40	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	163172683123	1	3	3	2	1	t	t	t			http://www.xyz.com		t
21	0	\N	0	\N	\N	0	0	f	f	0	default	default	default	\N	\N	2021-01-03 14:13:12.716063	f	2021-01-03 14:13:12.769466	0	\N	\N	\N	\N	t	t	\N	v2	\N	ok@ok.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$yYGd3z9..3gu4qJZq28Uxux4N7vLK5x/WP1CD0lYJDTGz/becWDJ2	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	v2: intro, code of conduct, terms & conditions	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2021-01-03 14:24:07.525025	0	t	0	t	2021-01-03 14:13:12.715973	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-03 14:35:15.551823	muzzamil765	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	0302471547212	167	1	1	1	1	t	f	f					f
20	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	\N	\N	2021-01-03 14:02:27.535552	f	2021-01-03 14:02:27.641062	0	\N	\N	\N	\N	t	t	\N	v2	\N	mj@jm.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$JsmwuFKZBlC4Vlo/0Guuxu3.CL4LpicKcsS.FMF2..fRJqPx7xD1i	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	v2: personal info form	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2021-01-03 14:12:26.232007	0	t	0	t	2021-01-03 14:02:27.535461	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-03 14:12:35.547428	muzzamil323	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	t	t	t					f
24	2	\N	0	\N	\N	0	0	t	t	0	default	default	default	\N	\N	2021-01-03 14:57:15.200236	f	2021-01-03 14:57:15.232334	0	\N	\N	\N	\N	t	t	\N	v2	\N	yy@yy.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$gda2xZmFeKQ4CpuXrDBvGOIWy4/Zr6GfbsXpzvUee6659zaOn3fVG	\N	f	\N	\N		\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2021-01-03 16:53:52.60323	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2021-01-03 16:27:56.076943	0	t	0	t	2021-01-03 14:57:15.200155	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-04 11:45:10.122493	muzzamil219		t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	1	1	1	1	1	t	f	f		http://soundcloud.com			t
25	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2021-01-05 12:11:56.759157	ZTJE28CMqzZ5UZFszbxj	\N	f	2021-01-05 12:11:56.758747	0	\N	\N	\N	\N	t	t	\N	v2	\N	muzamil.mujahid11@gmail.commmm	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$fPjT4Kw.vFWGnyFZUBWGJOZ44y59F5021Pg9AscgYJyvBFLUeF.Z.	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2017-01-01 05:00:00	0	t	0	t	2021-01-05 12:11:56.627439	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-05 12:18:11.45422	muzzamil958	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	f	f	f					f
26	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2021-01-05 12:34:56.266526	Lz6RGzshirHsxzFNRLcx	\N	f	2021-01-05 12:34:56.266445	0	\N	\N	\N	\N	t	t	\N	v2	\N	mkmkm@kmkm.com	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$fFMqTymAVZKAZdNTZu6Tn.0f5SG6yt6y1DOn8bw026.Gpsw.CgArK	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2017-01-01 05:00:00	0	t	0	t	2021-01-05 12:34:56.254234	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-05 12:40:04.951994	muzzamil489	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	f	f	f					f
29	0	\N	0	\N	\N	0	0	t	t	0	default	default	default	2021-01-08 11:55:22.181882	iesvPwmtETeHxgp6_22J	\N	f	2021-01-08 11:55:22.181546	0	\N	\N	\N	\N	t	t	\N	v2	\N	muzamil.mujahid11@gmail.comjkasnkjdaskj	t	t	f	t	f	t	f	t	f	f	f	t	\N	\N	\N	$2a$10$jeQl/RCNICevnw69OupCD.nXLni9K6Qo0nYfNxi1r39Cn6qcqIK1K	\N	f	\N	\N	\N	\N	0	t	2017-01-01 05:00:00	f	t	\N	0	0	0	\N	2017-01-01 05:00:00	\N	\N	\N	private	\N	\N	\N	\N	\N	\N	0	\N	\N	{"preferred_languages": ["en"]}	2017-01-01 05:00:00	2017-01-01 05:00:00	\N	2017-01-01 05:00:00	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	t	t	0	\N	MuzzamilMujahid	\N	\N	f	\N	\N	t	\N	2017-01-01 05:00:00	0	t	0	t	2021-01-08 11:55:22.090282	\N	\N	1	\N	\N	t	0	\N	0	\N	0	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2021-01-08 11:55:38.788701	muzzamil459	\N	t	\N	\N	\N	\N	\N	Muzzamil	Mujahid	\N	8888675309	167	1	1	1	1	t	t	t					f
\.


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users_roles (role_id, user_id) FROM stdin;
1	1
1	2
2	3
1	4
2	5
2	6
1	7
3	8
4	11
5	11
4	12
6	12
7	12
8	12
9	22
9	23
10	24
9	25
9	26
9	27
9	29
9	30
9	31
\.


--
-- Data for Name: webhook_endpoints; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.webhook_endpoints (id, created_at, events, oauth_application_id, source, target_url, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: welcome_notifications; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.welcome_notifications (id, created_at, updated_at) FROM stdin;
\.


--
-- Name: ahoy_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.ahoy_events_id_seq', 37, true);


--
-- Name: ahoy_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.ahoy_messages_id_seq', 33, true);


--
-- Name: ahoy_visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.ahoy_visits_id_seq', 1, true);


--
-- Name: announcements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.announcements_id_seq', 1, false);


--
-- Name: api_secrets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.api_secrets_id_seq', 1, false);


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.articles_id_seq', 32, true);


--
-- Name: artist_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forem_latest
--

SELECT pg_catalog.setval('public.artist_applications_id_seq', 15, true);


--
-- Name: audios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forem_latest
--

SELECT pg_catalog.setval('public.audios_id_seq', 37, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 5, true);


--
-- Name: badge_achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.badge_achievements_id_seq', 10, true);


--
-- Name: badges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.badges_id_seq', 5, true);


--
-- Name: banished_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.banished_users_id_seq', 1, false);


--
-- Name: blazer_audits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.blazer_audits_id_seq', 1, false);


--
-- Name: blazer_checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.blazer_checks_id_seq', 1, false);


--
-- Name: blazer_dashboard_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.blazer_dashboard_queries_id_seq', 1, false);


--
-- Name: blazer_dashboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.blazer_dashboards_id_seq', 1, false);


--
-- Name: blazer_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.blazer_queries_id_seq', 1, false);


--
-- Name: broadcasts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.broadcasts_id_seq', 11, true);


--
-- Name: buffer_updates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.buffer_updates_id_seq', 1, false);


--
-- Name: chat_channel_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.chat_channel_memberships_id_seq', 10, true);


--
-- Name: chat_channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.chat_channels_id_seq', 4, true);


--
-- Name: classified_listing_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.classified_listing_categories_id_seq', 6, true);


--
-- Name: classified_listing_endorsements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.classified_listing_endorsements_id_seq', 5, true);


--
-- Name: classified_listings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.classified_listings_id_seq', 12, true);


--
-- Name: collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.collections_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.comments_id_seq', 30, true);


--
-- Name: credits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.credits_id_seq', 658, true);


--
-- Name: custom_profile_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.custom_profile_fields_id_seq', 1, false);


--
-- Name: data_update_scripts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.data_update_scripts_id_seq', 88, true);


--
-- Name: display_ad_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.display_ad_events_id_seq', 1, false);


--
-- Name: display_ads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.display_ads_id_seq', 1, false);


--
-- Name: email_authorizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.email_authorizations_id_seq', 1, false);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.events_id_seq', 1, false);


--
-- Name: feedback_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.feedback_messages_id_seq', 2, true);


--
-- Name: field_test_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.field_test_events_id_seq', 1, false);


--
-- Name: field_test_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.field_test_memberships_id_seq', 1, false);


--
-- Name: flipper_features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.flipper_features_id_seq', 1, false);


--
-- Name: flipper_gates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.flipper_gates_id_seq', 1, false);


--
-- Name: follows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.follows_id_seq', 1, true);


--
-- Name: github_issues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.github_issues_id_seq', 1, false);


--
-- Name: github_repos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.github_repos_id_seq', 1, false);


--
-- Name: html_variant_successes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.html_variant_successes_id_seq', 1, false);


--
-- Name: html_variant_trials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.html_variant_trials_id_seq', 1, false);


--
-- Name: html_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.html_variants_id_seq', 1, true);


--
-- Name: identities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.identities_id_seq', 14, true);


--
-- Name: mentions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.mentions_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: music_releases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forem_latest
--

SELECT pg_catalog.setval('public.music_releases_id_seq', 7, true);


--
-- Name: music_tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forem_latest
--

SELECT pg_catalog.setval('public.music_tracks_id_seq', 6, true);


--
-- Name: navigation_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.navigation_links_id_seq', 13, true);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, true);


--
-- Name: notification_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.notification_subscriptions_id_seq', 6, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.notifications_id_seq', 14, true);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.oauth_access_grants_id_seq', 1, false);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.oauth_access_tokens_id_seq', 1, false);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.oauth_applications_id_seq', 1, false);


--
-- Name: organization_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.organization_memberships_id_seq', 10, true);


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.organizations_id_seq', 4, true);


--
-- Name: page_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.page_views_id_seq', 33, true);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.pages_id_seq', 5, true);


--
-- Name: payment_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forem_latest
--

SELECT pg_catalog.setval('public.payment_providers_id_seq', 15, true);


--
-- Name: podcast_episodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.podcast_episodes_id_seq', 35, true);


--
-- Name: podcasts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.podcasts_id_seq', 12, true);


--
-- Name: poll_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.poll_options_id_seq', 1, false);


--
-- Name: poll_skips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.poll_skips_id_seq', 1, false);


--
-- Name: poll_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.poll_votes_id_seq', 1, false);


--
-- Name: polls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.polls_id_seq', 1, false);


--
-- Name: profile_field_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.profile_field_groups_id_seq', 5, true);


--
-- Name: profile_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.profile_fields_id_seq', 29, true);


--
-- Name: profile_pins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.profile_pins_id_seq', 1, false);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.profiles_id_seq', 30, true);


--
-- Name: rating_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.rating_votes_id_seq', 1, false);


--
-- Name: reactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.reactions_id_seq', 34, true);


--
-- Name: response_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.response_templates_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.roles_id_seq', 10, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forem_latest
--

SELECT pg_catalog.setval('public.services_id_seq', 105, true);


--
-- Name: site_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.site_configs_id_seq', 22, true);


--
-- Name: sponsorships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.sponsorships_id_seq', 3, true);


--
-- Name: tag_adjustments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.tag_adjustments_id_seq', 1, false);


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.taggings_id_seq', 111, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.tags_id_seq', 15, true);


--
-- Name: tweets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.tweets_id_seq', 1, false);


--
-- Name: user_blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.user_blocks_id_seq', 1, false);


--
-- Name: user_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forem_latest
--

SELECT pg_catalog.setval('public.user_documents_id_seq', 1, false);


--
-- Name: user_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.user_subscriptions_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 31, true);


--
-- Name: webhook_endpoints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.webhook_endpoints_id_seq', 1, false);


--
-- Name: welcome_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.welcome_notifications_id_seq', 1, false);


--
-- Name: ahoy_events ahoy_events_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_events
    ADD CONSTRAINT ahoy_events_pkey PRIMARY KEY (id);


--
-- Name: ahoy_messages ahoy_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_messages
    ADD CONSTRAINT ahoy_messages_pkey PRIMARY KEY (id);


--
-- Name: ahoy_visits ahoy_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_visits
    ADD CONSTRAINT ahoy_visits_pkey PRIMARY KEY (id);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: api_secrets api_secrets_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.api_secrets
    ADD CONSTRAINT api_secrets_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: artist_applications artist_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.artist_applications
    ADD CONSTRAINT artist_applications_pkey PRIMARY KEY (id);


--
-- Name: audios audios_pkey; Type: CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.audios
    ADD CONSTRAINT audios_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: badge_achievements badge_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.badge_achievements
    ADD CONSTRAINT badge_achievements_pkey PRIMARY KEY (id);


--
-- Name: badges badges_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.badges
    ADD CONSTRAINT badges_pkey PRIMARY KEY (id);


--
-- Name: banished_users banished_users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.banished_users
    ADD CONSTRAINT banished_users_pkey PRIMARY KEY (id);


--
-- Name: blazer_audits blazer_audits_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_audits
    ADD CONSTRAINT blazer_audits_pkey PRIMARY KEY (id);


--
-- Name: blazer_checks blazer_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_checks
    ADD CONSTRAINT blazer_checks_pkey PRIMARY KEY (id);


--
-- Name: blazer_dashboard_queries blazer_dashboard_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_dashboard_queries
    ADD CONSTRAINT blazer_dashboard_queries_pkey PRIMARY KEY (id);


--
-- Name: blazer_dashboards blazer_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_dashboards
    ADD CONSTRAINT blazer_dashboards_pkey PRIMARY KEY (id);


--
-- Name: blazer_queries blazer_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blazer_queries
    ADD CONSTRAINT blazer_queries_pkey PRIMARY KEY (id);


--
-- Name: broadcasts broadcasts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_pkey PRIMARY KEY (id);


--
-- Name: buffer_updates buffer_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.buffer_updates
    ADD CONSTRAINT buffer_updates_pkey PRIMARY KEY (id);


--
-- Name: chat_channel_memberships chat_channel_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.chat_channel_memberships
    ADD CONSTRAINT chat_channel_memberships_pkey PRIMARY KEY (id);


--
-- Name: chat_channels chat_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.chat_channels
    ADD CONSTRAINT chat_channels_pkey PRIMARY KEY (id);


--
-- Name: classified_listing_categories classified_listing_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listing_categories
    ADD CONSTRAINT classified_listing_categories_pkey PRIMARY KEY (id);


--
-- Name: classified_listing_endorsements classified_listing_endorsements_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listing_endorsements
    ADD CONSTRAINT classified_listing_endorsements_pkey PRIMARY KEY (id);


--
-- Name: classified_listings classified_listings_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listings
    ADD CONSTRAINT classified_listings_pkey PRIMARY KEY (id);


--
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: credits credits_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT credits_pkey PRIMARY KEY (id);


--
-- Name: custom_profile_fields custom_profile_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.custom_profile_fields
    ADD CONSTRAINT custom_profile_fields_pkey PRIMARY KEY (id);


--
-- Name: data_update_scripts data_update_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.data_update_scripts
    ADD CONSTRAINT data_update_scripts_pkey PRIMARY KEY (id);


--
-- Name: display_ad_events display_ad_events_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.display_ad_events
    ADD CONSTRAINT display_ad_events_pkey PRIMARY KEY (id);


--
-- Name: display_ads display_ads_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.display_ads
    ADD CONSTRAINT display_ads_pkey PRIMARY KEY (id);


--
-- Name: email_authorizations email_authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.email_authorizations
    ADD CONSTRAINT email_authorizations_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: feedback_messages feedback_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.feedback_messages
    ADD CONSTRAINT feedback_messages_pkey PRIMARY KEY (id);


--
-- Name: field_test_events field_test_events_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field_test_events
    ADD CONSTRAINT field_test_events_pkey PRIMARY KEY (id);


--
-- Name: field_test_memberships field_test_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field_test_memberships
    ADD CONSTRAINT field_test_memberships_pkey PRIMARY KEY (id);


--
-- Name: flipper_features flipper_features_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.flipper_features
    ADD CONSTRAINT flipper_features_pkey PRIMARY KEY (id);


--
-- Name: flipper_gates flipper_gates_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.flipper_gates
    ADD CONSTRAINT flipper_gates_pkey PRIMARY KEY (id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: github_issues github_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.github_issues
    ADD CONSTRAINT github_issues_pkey PRIMARY KEY (id);


--
-- Name: github_repos github_repos_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.github_repos
    ADD CONSTRAINT github_repos_pkey PRIMARY KEY (id);


--
-- Name: html_variant_successes html_variant_successes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_successes
    ADD CONSTRAINT html_variant_successes_pkey PRIMARY KEY (id);


--
-- Name: html_variant_trials html_variant_trials_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_trials
    ADD CONSTRAINT html_variant_trials_pkey PRIMARY KEY (id);


--
-- Name: html_variants html_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variants
    ADD CONSTRAINT html_variants_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: mentions mentions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.mentions
    ADD CONSTRAINT mentions_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: music_releases music_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.music_releases
    ADD CONSTRAINT music_releases_pkey PRIMARY KEY (id);


--
-- Name: music_tracks music_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.music_tracks
    ADD CONSTRAINT music_tracks_pkey PRIMARY KEY (id);


--
-- Name: navigation_links navigation_links_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.navigation_links
    ADD CONSTRAINT navigation_links_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notification_subscriptions notification_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notification_subscriptions
    ADD CONSTRAINT notification_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: organization_memberships organization_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.organization_memberships
    ADD CONSTRAINT organization_memberships_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: page_views page_views_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.page_views
    ADD CONSTRAINT page_views_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: payment_providers payment_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.payment_providers
    ADD CONSTRAINT payment_providers_pkey PRIMARY KEY (id);


--
-- Name: podcast_episodes podcast_episodes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.podcast_episodes
    ADD CONSTRAINT podcast_episodes_pkey PRIMARY KEY (id);


--
-- Name: podcasts podcasts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT podcasts_pkey PRIMARY KEY (id);


--
-- Name: poll_options poll_options_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_options
    ADD CONSTRAINT poll_options_pkey PRIMARY KEY (id);


--
-- Name: poll_skips poll_skips_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_skips
    ADD CONSTRAINT poll_skips_pkey PRIMARY KEY (id);


--
-- Name: poll_votes poll_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT poll_votes_pkey PRIMARY KEY (id);


--
-- Name: polls polls_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_pkey PRIMARY KEY (id);


--
-- Name: profile_field_groups profile_field_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profile_field_groups
    ADD CONSTRAINT profile_field_groups_pkey PRIMARY KEY (id);


--
-- Name: profile_fields profile_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profile_fields
    ADD CONSTRAINT profile_fields_pkey PRIMARY KEY (id);


--
-- Name: profile_pins profile_pins_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profile_pins
    ADD CONSTRAINT profile_pins_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: rating_votes rating_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.rating_votes
    ADD CONSTRAINT rating_votes_pkey PRIMARY KEY (id);


--
-- Name: reactions reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_pkey PRIMARY KEY (id);


--
-- Name: response_templates response_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.response_templates
    ADD CONSTRAINT response_templates_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: site_configs site_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.site_configs
    ADD CONSTRAINT site_configs_pkey PRIMARY KEY (id);


--
-- Name: sponsorships sponsorships_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.sponsorships
    ADD CONSTRAINT sponsorships_pkey PRIMARY KEY (id);


--
-- Name: tag_adjustments tag_adjustments_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag_adjustments
    ADD CONSTRAINT tag_adjustments_pkey PRIMARY KEY (id);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tweets tweets_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tweets
    ADD CONSTRAINT tweets_pkey PRIMARY KEY (id);


--
-- Name: user_blocks user_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_blocks
    ADD CONSTRAINT user_blocks_pkey PRIMARY KEY (id);


--
-- Name: user_documents user_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.user_documents
    ADD CONSTRAINT user_documents_pkey PRIMARY KEY (id);


--
-- Name: user_subscriptions user_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT user_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webhook_endpoints webhook_endpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.webhook_endpoints
    ADD CONSTRAINT webhook_endpoints_pkey PRIMARY KEY (id);


--
-- Name: welcome_notifications welcome_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.welcome_notifications
    ADD CONSTRAINT welcome_notifications_pkey PRIMARY KEY (id);


--
-- Name: fk_followables; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_followables ON public.follows USING btree (followable_id, followable_type);


--
-- Name: fk_follows; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_follows ON public.follows USING btree (follower_id, follower_type);


--
-- Name: idx_notification_subs_on_user_id_notifiable_type_notifiable_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_notification_subs_on_user_id_notifiable_type_notifiable_id ON public.notification_subscriptions USING btree (user_id, notifiable_type, notifiable_id);


--
-- Name: idx_pins_on_pinnable_id_profile_id_profile_type_pinnable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_pins_on_pinnable_id_profile_id_profile_type_pinnable_type ON public.profile_pins USING btree (pinnable_id, profile_id, profile_type, pinnable_type);


--
-- Name: idx_response_templates_on_content_user_id_type_of_content_type; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX idx_response_templates_on_content_user_id_type_of_content_type ON public.response_templates USING btree (content, user_id, type_of, content_type);


--
-- Name: index_ahoy_events_on_name_and_time; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_events_on_name_and_time ON public.ahoy_events USING btree (name, "time");


--
-- Name: index_ahoy_events_on_properties; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_events_on_properties ON public.ahoy_events USING gin (properties jsonb_path_ops);


--
-- Name: index_ahoy_events_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_events_on_user_id ON public.ahoy_events USING btree (user_id);


--
-- Name: index_ahoy_events_on_visit_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_events_on_visit_id ON public.ahoy_events USING btree (visit_id);


--
-- Name: index_ahoy_messages_on_to; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_messages_on_to ON public.ahoy_messages USING btree ("to");


--
-- Name: index_ahoy_messages_on_token; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_messages_on_token ON public.ahoy_messages USING btree (token);


--
-- Name: index_ahoy_messages_on_user_id_and_mailer; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_messages_on_user_id_and_mailer ON public.ahoy_messages USING btree (user_id, mailer);


--
-- Name: index_ahoy_messages_on_user_id_and_user_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_messages_on_user_id_and_user_type ON public.ahoy_messages USING btree (user_id, user_type);


--
-- Name: index_ahoy_visits_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_ahoy_visits_on_user_id ON public.ahoy_visits USING btree (user_id);


--
-- Name: index_ahoy_visits_on_visit_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_ahoy_visits_on_visit_token ON public.ahoy_visits USING btree (visit_token);


--
-- Name: index_api_secrets_on_secret; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_api_secrets_on_secret ON public.api_secrets USING btree (secret);


--
-- Name: index_api_secrets_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_api_secrets_on_user_id ON public.api_secrets USING btree (user_id);


--
-- Name: index_articles_on_boost_states; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_boost_states ON public.articles USING gin (boost_states);


--
-- Name: index_articles_on_canonical_url; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_articles_on_canonical_url ON public.articles USING btree (canonical_url);


--
-- Name: index_articles_on_comment_score; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_comment_score ON public.articles USING btree (comment_score);


--
-- Name: index_articles_on_featured_number; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_featured_number ON public.articles USING btree (featured_number);


--
-- Name: index_articles_on_feed_source_url; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_articles_on_feed_source_url ON public.articles USING btree (feed_source_url);


--
-- Name: index_articles_on_hotness_score; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_hotness_score ON public.articles USING btree (hotness_score);


--
-- Name: index_articles_on_path; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_path ON public.articles USING btree (path);


--
-- Name: index_articles_on_public_reactions_count; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_public_reactions_count ON public.articles USING btree (public_reactions_count DESC);


--
-- Name: index_articles_on_published; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_published ON public.articles USING btree (published);


--
-- Name: index_articles_on_published_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_published_at ON public.articles USING btree (published_at);


--
-- Name: index_articles_on_slug_and_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_articles_on_slug_and_user_id ON public.articles USING btree (slug, user_id);


--
-- Name: index_articles_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_articles_on_user_id ON public.articles USING btree (user_id);


--
-- Name: index_articles_on_user_id_and_title_and_digest_body_markdown; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_articles_on_user_id_and_title_and_digest_body_markdown ON public.articles USING btree (user_id, title, public.digest(body_markdown, 'sha512'::text));


--
-- Name: index_audios_on_user_id; Type: INDEX; Schema: public; Owner: forem_latest
--

CREATE INDEX index_audios_on_user_id ON public.audios USING btree (user_id);


--
-- Name: index_audit_logs_on_data; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_audit_logs_on_data ON public.audit_logs USING gin (data);


--
-- Name: index_audit_logs_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_audit_logs_on_user_id ON public.audit_logs USING btree (user_id);


--
-- Name: index_badge_achievements_on_badge_id_and_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_badge_achievements_on_badge_id_and_user_id ON public.badge_achievements USING btree (badge_id, user_id);


--
-- Name: index_badge_achievements_on_user_id_and_badge_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_badge_achievements_on_user_id_and_badge_id ON public.badge_achievements USING btree (user_id, badge_id);


--
-- Name: index_badges_on_slug; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_badges_on_slug ON public.badges USING btree (slug);


--
-- Name: index_badges_on_title; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_badges_on_title ON public.badges USING btree (title);


--
-- Name: index_banished_users_on_banished_by_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_banished_users_on_banished_by_id ON public.banished_users USING btree (banished_by_id);


--
-- Name: index_banished_users_on_username; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_banished_users_on_username ON public.banished_users USING btree (username);


--
-- Name: index_blazer_audits_on_query_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_audits_on_query_id ON public.blazer_audits USING btree (query_id);


--
-- Name: index_blazer_audits_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_audits_on_user_id ON public.blazer_audits USING btree (user_id);


--
-- Name: index_blazer_checks_on_creator_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_checks_on_creator_id ON public.blazer_checks USING btree (creator_id);


--
-- Name: index_blazer_checks_on_query_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_checks_on_query_id ON public.blazer_checks USING btree (query_id);


--
-- Name: index_blazer_dashboard_queries_on_dashboard_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_dashboard_queries_on_dashboard_id ON public.blazer_dashboard_queries USING btree (dashboard_id);


--
-- Name: index_blazer_dashboard_queries_on_query_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_dashboard_queries_on_query_id ON public.blazer_dashboard_queries USING btree (query_id);


--
-- Name: index_blazer_dashboards_on_creator_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_dashboards_on_creator_id ON public.blazer_dashboards USING btree (creator_id);


--
-- Name: index_blazer_queries_on_creator_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_blazer_queries_on_creator_id ON public.blazer_queries USING btree (creator_id);


--
-- Name: index_broadcasts_on_broadcastable_type_and_broadcastable_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_broadcasts_on_broadcastable_type_and_broadcastable_id ON public.broadcasts USING btree (broadcastable_type, broadcastable_id);


--
-- Name: index_broadcasts_on_title_and_type_of; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_broadcasts_on_title_and_type_of ON public.broadcasts USING btree (title, type_of);


--
-- Name: index_chat_channel_memberships_on_chat_channel_id_and_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_chat_channel_memberships_on_chat_channel_id_and_user_id ON public.chat_channel_memberships USING btree (chat_channel_id, user_id);


--
-- Name: index_chat_channel_memberships_on_user_id_and_chat_channel_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_chat_channel_memberships_on_user_id_and_chat_channel_id ON public.chat_channel_memberships USING btree (user_id, chat_channel_id);


--
-- Name: index_chat_channels_on_slug; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_chat_channels_on_slug ON public.chat_channels USING btree (slug);


--
-- Name: index_classified_listing_categories_on_name; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_classified_listing_categories_on_name ON public.classified_listing_categories USING btree (name);


--
-- Name: index_classified_listing_categories_on_slug; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_classified_listing_categories_on_slug ON public.classified_listing_categories USING btree (slug);


--
-- Name: index_classified_listing_endorsements_on_classified_listing_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_classified_listing_endorsements_on_classified_listing_id ON public.classified_listing_endorsements USING btree (classified_listing_id);


--
-- Name: index_classified_listing_endorsements_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_classified_listing_endorsements_on_user_id ON public.classified_listing_endorsements USING btree (user_id);


--
-- Name: index_classified_listings_on_classified_listing_category_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_classified_listings_on_classified_listing_category_id ON public.classified_listings USING btree (classified_listing_category_id);


--
-- Name: index_classified_listings_on_organization_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_classified_listings_on_organization_id ON public.classified_listings USING btree (organization_id);


--
-- Name: index_classified_listings_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_classified_listings_on_user_id ON public.classified_listings USING btree (user_id);


--
-- Name: index_collections_on_organization_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_collections_on_organization_id ON public.collections USING btree (organization_id);


--
-- Name: index_collections_on_slug_and_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_collections_on_slug_and_user_id ON public.collections USING btree (slug, user_id);


--
-- Name: index_collections_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_collections_on_user_id ON public.collections USING btree (user_id);


--
-- Name: index_comments_on_ancestry; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_comments_on_ancestry ON public.comments USING btree (ancestry);


--
-- Name: index_comments_on_body_markdown_user_ancestry_commentable; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_comments_on_body_markdown_user_ancestry_commentable ON public.comments USING btree (public.digest(body_markdown, 'sha512'::text), user_id, ancestry, commentable_id, commentable_type);


--
-- Name: index_comments_on_commentable_id_and_commentable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_comments_on_commentable_id_and_commentable_type ON public.comments USING btree (commentable_id, commentable_type);


--
-- Name: index_comments_on_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_comments_on_created_at ON public.comments USING btree (created_at);


--
-- Name: index_comments_on_score; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_comments_on_score ON public.comments USING btree (score);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_credits_on_purchase_id_and_purchase_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_credits_on_purchase_id_and_purchase_type ON public.credits USING btree (purchase_id, purchase_type);


--
-- Name: index_credits_on_spent; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_credits_on_spent ON public.credits USING btree (spent);


--
-- Name: index_custom_profile_fields_on_label_and_profile_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_custom_profile_fields_on_label_and_profile_id ON public.custom_profile_fields USING btree (label, profile_id);


--
-- Name: index_custom_profile_fields_on_profile_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_custom_profile_fields_on_profile_id ON public.custom_profile_fields USING btree (profile_id);


--
-- Name: index_data_update_scripts_on_file_name; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_data_update_scripts_on_file_name ON public.data_update_scripts USING btree (file_name);


--
-- Name: index_display_ad_events_on_display_ad_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_display_ad_events_on_display_ad_id ON public.display_ad_events USING btree (display_ad_id);


--
-- Name: index_display_ad_events_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_display_ad_events_on_user_id ON public.display_ad_events USING btree (user_id);


--
-- Name: index_email_authorizations_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_email_authorizations_on_user_id ON public.email_authorizations USING btree (user_id);


--
-- Name: index_feedback_messages_on_affected_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_feedback_messages_on_affected_id ON public.feedback_messages USING btree (affected_id);


--
-- Name: index_feedback_messages_on_offender_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_feedback_messages_on_offender_id ON public.feedback_messages USING btree (offender_id);


--
-- Name: index_feedback_messages_on_reporter_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_feedback_messages_on_reporter_id ON public.feedback_messages USING btree (reporter_id);


--
-- Name: index_field_test_events_on_field_test_membership_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_field_test_events_on_field_test_membership_id ON public.field_test_events USING btree (field_test_membership_id);


--
-- Name: index_field_test_memberships_on_experiment_and_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_field_test_memberships_on_experiment_and_created_at ON public.field_test_memberships USING btree (experiment, created_at);


--
-- Name: index_field_test_memberships_on_participant; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_field_test_memberships_on_participant ON public.field_test_memberships USING btree (participant_type, participant_id, experiment);


--
-- Name: index_flipper_features_on_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_flipper_features_on_key ON public.flipper_features USING btree (key);


--
-- Name: index_flipper_gates_on_feature_key_and_key_and_value; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_flipper_gates_on_feature_key_and_key_and_value ON public.flipper_gates USING btree (feature_key, key, value);


--
-- Name: index_follows_on_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_follows_on_created_at ON public.follows USING btree (created_at);


--
-- Name: index_follows_on_followable_and_follower; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_follows_on_followable_and_follower ON public.follows USING btree (followable_id, followable_type, follower_id, follower_type);


--
-- Name: index_github_issues_on_url; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_github_issues_on_url ON public.github_issues USING btree (url);


--
-- Name: index_github_repos_on_github_id_code; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_github_repos_on_github_id_code ON public.github_repos USING btree (github_id_code);


--
-- Name: index_github_repos_on_url; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_github_repos_on_url ON public.github_repos USING btree (url);


--
-- Name: index_html_variant_successes_on_html_variant_id_and_article_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_html_variant_successes_on_html_variant_id_and_article_id ON public.html_variant_successes USING btree (html_variant_id, article_id);


--
-- Name: index_html_variant_trials_on_html_variant_id_and_article_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_html_variant_trials_on_html_variant_id_and_article_id ON public.html_variant_trials USING btree (html_variant_id, article_id);


--
-- Name: index_html_variants_on_name; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_html_variants_on_name ON public.html_variants USING btree (name);


--
-- Name: index_identities_on_provider_and_uid; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_identities_on_provider_and_uid ON public.identities USING btree (provider, uid);


--
-- Name: index_identities_on_provider_and_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_identities_on_provider_and_user_id ON public.identities USING btree (provider, user_id);


--
-- Name: index_mentions_on_user_id_and_mentionable_id_mentionable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_mentions_on_user_id_and_mentionable_id_mentionable_type ON public.mentions USING btree (user_id, mentionable_id, mentionable_type);


--
-- Name: index_messages_on_chat_channel_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_messages_on_chat_channel_id ON public.messages USING btree (chat_channel_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_messages_on_user_id ON public.messages USING btree (user_id);


--
-- Name: index_music_releases_on_user_id; Type: INDEX; Schema: public; Owner: forem_latest
--

CREATE INDEX index_music_releases_on_user_id ON public.music_releases USING btree (user_id);


--
-- Name: index_music_tracks_on_music_release_id; Type: INDEX; Schema: public; Owner: forem_latest
--

CREATE INDEX index_music_tracks_on_music_release_id ON public.music_tracks USING btree (music_release_id);


--
-- Name: index_navigation_links_on_url_and_name; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_navigation_links_on_url_and_name ON public.navigation_links USING btree (url, name);


--
-- Name: index_notification_subscriptions_on_notifiable_and_config; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_notification_subscriptions_on_notifiable_and_config ON public.notification_subscriptions USING btree (notifiable_id, notifiable_type, config);


--
-- Name: index_notifications_on_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_notifications_on_created_at ON public.notifications USING btree (created_at);


--
-- Name: index_notifications_on_json_data; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_notifications_on_json_data ON public.notifications USING gin (json_data);


--
-- Name: index_notifications_on_notifiable_id_notifiable_type_and_action; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_notifications_on_notifiable_id_notifiable_type_and_action ON public.notifications USING btree (notifiable_id, notifiable_type, action);


--
-- Name: index_notifications_on_notifiable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_notifications_on_notifiable_type ON public.notifications USING btree (notifiable_type);


--
-- Name: index_notifications_on_notified_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_notifications_on_notified_at ON public.notifications USING btree (notified_at);


--
-- Name: index_notifications_on_org_notifiable_action_is_null; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_notifications_on_org_notifiable_action_is_null ON public.notifications USING btree (organization_id, notifiable_id, notifiable_type) WHERE (action IS NULL);


--
-- Name: index_notifications_on_org_notifiable_and_action_not_null; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_notifications_on_org_notifiable_and_action_not_null ON public.notifications USING btree (organization_id, notifiable_id, notifiable_type, action) WHERE (action IS NOT NULL);


--
-- Name: index_notifications_on_user_notifiable_action_is_null; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_notifications_on_user_notifiable_action_is_null ON public.notifications USING btree (user_id, notifiable_id, notifiable_type) WHERE (action IS NULL);


--
-- Name: index_notifications_on_user_notifiable_and_action_not_null; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_notifications_on_user_notifiable_and_action_not_null ON public.notifications USING btree (user_id, notifiable_id, notifiable_type, action) WHERE (action IS NOT NULL);


--
-- Name: index_notifications_user_id_organization_id_notifiable_action; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_notifications_user_id_organization_id_notifiable_action ON public.notifications USING btree (user_id, organization_id, notifiable_id, notifiable_type, action);


--
-- Name: index_oauth_access_grants_on_application_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_oauth_access_grants_on_application_id ON public.oauth_access_grants USING btree (application_id);


--
-- Name: index_oauth_access_grants_on_resource_owner_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_oauth_access_grants_on_resource_owner_id ON public.oauth_access_grants USING btree (resource_owner_id);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON public.oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_application_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_oauth_access_tokens_on_application_id ON public.oauth_access_tokens USING btree (application_id);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON public.oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON public.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON public.oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON public.oauth_applications USING btree (uid);


--
-- Name: index_on_user_subscription_sourcebable_type_and_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_on_user_subscription_sourcebable_type_and_id ON public.user_subscriptions USING btree (user_subscription_sourceable_type, user_subscription_sourceable_id);


--
-- Name: index_organization_memberships_on_user_id_and_organization_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_organization_memberships_on_user_id_and_organization_id ON public.organization_memberships USING btree (user_id, organization_id);


--
-- Name: index_organizations_on_secret; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_organizations_on_secret ON public.organizations USING btree (secret);


--
-- Name: index_organizations_on_slug; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_organizations_on_slug ON public.organizations USING btree (slug);


--
-- Name: index_page_views_on_article_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_page_views_on_article_id ON public.page_views USING btree (article_id);


--
-- Name: index_page_views_on_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_page_views_on_created_at ON public.page_views USING btree (created_at);


--
-- Name: index_page_views_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_page_views_on_user_id ON public.page_views USING btree (user_id);


--
-- Name: index_pages_on_slug; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_pages_on_slug ON public.pages USING btree (slug);


--
-- Name: index_payment_providers_on_user_id; Type: INDEX; Schema: public; Owner: forem_latest
--

CREATE INDEX index_payment_providers_on_user_id ON public.payment_providers USING btree (user_id);


--
-- Name: index_podcast_episodes_on_guid; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_podcast_episodes_on_guid ON public.podcast_episodes USING btree (guid);


--
-- Name: index_podcast_episodes_on_media_url; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_podcast_episodes_on_media_url ON public.podcast_episodes USING btree (media_url);


--
-- Name: index_podcast_episodes_on_podcast_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_podcast_episodes_on_podcast_id ON public.podcast_episodes USING btree (podcast_id);


--
-- Name: index_podcast_episodes_on_title; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_podcast_episodes_on_title ON public.podcast_episodes USING btree (title);


--
-- Name: index_podcast_episodes_on_website_url; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_podcast_episodes_on_website_url ON public.podcast_episodes USING btree (website_url);


--
-- Name: index_podcasts_on_creator_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_podcasts_on_creator_id ON public.podcasts USING btree (creator_id);


--
-- Name: index_podcasts_on_feed_url; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_podcasts_on_feed_url ON public.podcasts USING btree (feed_url);


--
-- Name: index_podcasts_on_slug; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_podcasts_on_slug ON public.podcasts USING btree (slug);


--
-- Name: index_poll_skips_on_poll_and_user; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_poll_skips_on_poll_and_user ON public.poll_skips USING btree (poll_id, user_id);


--
-- Name: index_poll_votes_on_poll_id_and_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_poll_votes_on_poll_id_and_user_id ON public.poll_votes USING btree (poll_id, user_id);


--
-- Name: index_poll_votes_on_poll_option_and_user; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_poll_votes_on_poll_option_and_user ON public.poll_votes USING btree (poll_option_id, user_id);


--
-- Name: index_profile_field_groups_on_name; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_profile_field_groups_on_name ON public.profile_field_groups USING btree (name);


--
-- Name: index_profile_fields_on_label; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_profile_fields_on_label ON public.profile_fields USING btree (label);


--
-- Name: index_profile_fields_on_profile_field_group_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_profile_fields_on_profile_field_group_id ON public.profile_fields USING btree (profile_field_group_id);


--
-- Name: index_profile_pins_on_profile_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_profile_pins_on_profile_id ON public.profile_pins USING btree (profile_id);


--
-- Name: index_profiles_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_profiles_on_user_id ON public.profiles USING btree (user_id);


--
-- Name: index_rating_votes_on_article_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_rating_votes_on_article_id ON public.rating_votes USING btree (article_id);


--
-- Name: index_rating_votes_on_user_id_and_article_id_and_context; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_rating_votes_on_user_id_and_article_id_and_context ON public.rating_votes USING btree (user_id, article_id, context);


--
-- Name: index_reactions_on_category; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_reactions_on_category ON public.reactions USING btree (category);


--
-- Name: index_reactions_on_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_reactions_on_created_at ON public.reactions USING btree (created_at);


--
-- Name: index_reactions_on_points; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_reactions_on_points ON public.reactions USING btree (points);


--
-- Name: index_reactions_on_reactable_id_and_reactable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_reactions_on_reactable_id_and_reactable_type ON public.reactions USING btree (reactable_id, reactable_type);


--
-- Name: index_reactions_on_reactable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_reactions_on_reactable_type ON public.reactions USING btree (reactable_type);


--
-- Name: index_reactions_on_user_id_reactable_id_reactable_type_category; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_reactions_on_user_id_reactable_id_reactable_type_category ON public.reactions USING btree (user_id, reactable_id, reactable_type, category);


--
-- Name: index_response_templates_on_type_of; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_response_templates_on_type_of ON public.response_templates USING btree (type_of);


--
-- Name: index_response_templates_on_user_id_and_type_of; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_response_templates_on_user_id_and_type_of ON public.response_templates USING btree (user_id, type_of);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON public.roles USING btree (name, resource_type, resource_id);


--
-- Name: index_services_on_artist_application_id; Type: INDEX; Schema: public; Owner: forem_latest
--

CREATE INDEX index_services_on_artist_application_id ON public.services USING btree (artist_application_id);


--
-- Name: index_site_configs_on_var; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_site_configs_on_var ON public.site_configs USING btree (var);


--
-- Name: index_sponsorships_on_level; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_sponsorships_on_level ON public.sponsorships USING btree (level);


--
-- Name: index_sponsorships_on_organization_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_sponsorships_on_organization_id ON public.sponsorships USING btree (organization_id);


--
-- Name: index_sponsorships_on_sponsorable_id_and_sponsorable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_sponsorships_on_sponsorable_id_and_sponsorable_type ON public.sponsorships USING btree (sponsorable_id, sponsorable_type);


--
-- Name: index_sponsorships_on_status; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_sponsorships_on_status ON public.sponsorships USING btree (status);


--
-- Name: index_sponsorships_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_sponsorships_on_user_id ON public.sponsorships USING btree (user_id);


--
-- Name: index_subscriber_id_and_email_with_user_subscription_source; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_subscriber_id_and_email_with_user_subscription_source ON public.user_subscriptions USING btree (subscriber_id, subscriber_email, user_subscription_sourceable_type, user_subscription_sourceable_id);


--
-- Name: index_tag_adjustments_on_tag_name_and_article_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_tag_adjustments_on_tag_name_and_article_id ON public.tag_adjustments USING btree (tag_name, article_id);


--
-- Name: index_taggings_on_context; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_taggings_on_context ON public.taggings USING btree (context);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_taggings_on_tag_id ON public.taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_taggings_on_taggable_id ON public.taggings USING btree (taggable_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON public.taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_taggings_on_taggable_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_taggings_on_taggable_type ON public.taggings USING btree (taggable_type);


--
-- Name: index_taggings_on_tagger_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_taggings_on_tagger_id ON public.taggings USING btree (tagger_id);


--
-- Name: index_taggings_on_tagger_id_and_tagger_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_taggings_on_tagger_id_and_tagger_type ON public.taggings USING btree (tagger_id, tagger_type);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_tags_on_name ON public.tags USING btree (name);


--
-- Name: index_tags_on_social_preview_template; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_tags_on_social_preview_template ON public.tags USING btree (social_preview_template);


--
-- Name: index_user_blocks_on_blocked_id_and_blocker_id; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_user_blocks_on_blocked_id_and_blocker_id ON public.user_blocks USING btree (blocked_id, blocker_id);


--
-- Name: index_user_documents_on_user_id; Type: INDEX; Schema: public; Owner: forem_latest
--

CREATE INDEX index_user_documents_on_user_id ON public.user_documents USING btree (user_id);


--
-- Name: index_user_subscriptions_on_author_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_user_subscriptions_on_author_id ON public.user_subscriptions USING btree (author_id);


--
-- Name: index_user_subscriptions_on_subscriber_email; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_user_subscriptions_on_subscriber_email ON public.user_subscriptions USING btree (subscriber_email);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_created_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_created_at ON public.users USING btree (created_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_facebook_username; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_facebook_username ON public.users USING btree (facebook_username);


--
-- Name: index_users_on_feed_url; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_feed_url ON public.users USING btree (feed_url) WHERE ((COALESCE(feed_url, ''::character varying))::text <> ''::text);


--
-- Name: index_users_on_github_username; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_github_username ON public.users USING btree (github_username);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_invitations_count ON public.users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_invited_by_type_and_invited_by_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_invited_by_type_and_invited_by_id ON public.users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_language_settings; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_language_settings ON public.users USING gin (language_settings);


--
-- Name: index_users_on_old_old_username; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_on_old_old_username ON public.users USING btree (old_old_username);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_twitter_username; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_twitter_username ON public.users USING btree (twitter_username);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_username ON public.users USING btree (username);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON public.users_roles USING btree (user_id, role_id);


--
-- Name: index_webhook_endpoints_on_events; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_webhook_endpoints_on_events ON public.webhook_endpoints USING btree (events);


--
-- Name: index_webhook_endpoints_on_oauth_application_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_webhook_endpoints_on_oauth_application_id ON public.webhook_endpoints USING btree (oauth_application_id);


--
-- Name: index_webhook_endpoints_on_target_url; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_webhook_endpoints_on_target_url ON public.webhook_endpoints USING btree (target_url);


--
-- Name: index_webhook_endpoints_on_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_webhook_endpoints_on_user_id ON public.webhook_endpoints USING btree (user_id);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX taggings_idx ON public.taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: taggings_idy; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX taggings_idy ON public.taggings USING btree (taggable_id, taggable_type, tagger_id, context);


--
-- Name: tweets fk_rails_003928b7f5; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tweets
    ADD CONSTRAINT fk_rails_003928b7f5 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: page_views fk_rails_00f38b1a99; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.page_views
    ADD CONSTRAINT fk_rails_00f38b1a99 FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: webhook_endpoints fk_rails_083276d374; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.webhook_endpoints
    ADD CONSTRAINT fk_rails_083276d374 FOREIGN KEY (oauth_application_id) REFERENCES public.oauth_applications(id);


--
-- Name: payment_providers fk_rails_0a6596cbb6; Type: FK CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.payment_providers
    ADD CONSTRAINT fk_rails_0a6596cbb6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: buffer_updates fk_rails_0b84f8076f; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.buffer_updates
    ADD CONSTRAINT fk_rails_0b84f8076f FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE SET NULL;


--
-- Name: audios fk_rails_124d1fac7e; Type: FK CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.audios
    ADD CONSTRAINT fk_rails_124d1fac7e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: messages fk_rails_1321992401; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_1321992401 FOREIGN KEY (chat_channel_id) REFERENCES public.chat_channels(id);


--
-- Name: page_views fk_rails_13a4e75c00; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.page_views
    ADD CONSTRAINT fk_rails_13a4e75c00 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: banished_users fk_rails_153ba6df7a; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.banished_users
    ADD CONSTRAINT fk_rails_153ba6df7a FOREIGN KEY (banished_by_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: display_ad_events fk_rails_1821fcc2c7; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.display_ad_events
    ADD CONSTRAINT fk_rails_1821fcc2c7 FOREIGN KEY (display_ad_id) REFERENCES public.display_ads(id) ON DELETE CASCADE;


--
-- Name: mentions fk_rails_1b711e94aa; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.mentions
    ADD CONSTRAINT fk_rails_1b711e94aa FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_subscriptions fk_rails_1ed776f5d9; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT fk_rails_1ed776f5d9 FOREIGN KEY (subscriber_id) REFERENCES public.users(id);


--
-- Name: audit_logs fk_rails_1f26bc34ae; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT fk_rails_1f26bc34ae FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: collections fk_rails_217eef6689; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT fk_rails_217eef6689 FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE SET NULL;


--
-- Name: podcasts fk_rails_23fc7f8ed6; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT fk_rails_23fc7f8ed6 FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: classified_listings fk_rails_2571500d9c; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listings
    ADD CONSTRAINT fk_rails_2571500d9c FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: messages fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: badge_achievements fk_rails_27820f58ce; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.badge_achievements
    ADD CONSTRAINT fk_rails_27820f58ce FOREIGN KEY (badge_id) REFERENCES public.badges(id);


--
-- Name: articles fk_rails_2b371e3029; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT fk_rails_2b371e3029 FOREIGN KEY (collection_id) REFERENCES public.collections(id) ON DELETE SET NULL;


--
-- Name: notification_subscriptions fk_rails_2bf71acda7; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notification_subscriptions
    ADD CONSTRAINT fk_rails_2bf71acda7 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: oauth_access_grants fk_rails_330c32d8d9; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT fk_rails_330c32d8d9 FOREIGN KEY (resource_owner_id) REFERENCES public.users(id);


--
-- Name: notes fk_rails_36c9deba43; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_36c9deba43 FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: notifications fk_rails_394d9847aa; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_394d9847aa FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: articles fk_rails_3d31dad1cc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT fk_rails_3d31dad1cc FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: poll_skips fk_rails_4046c49c05; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_skips
    ADD CONSTRAINT fk_rails_4046c49c05 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: polls fk_rails_48d9b585ee; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT fk_rails_48d9b585ee FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: badge_achievements fk_rails_4a2e48ca67; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.badge_achievements
    ADD CONSTRAINT fk_rails_4a2e48ca67 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users_roles fk_rails_4a41696df6; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk_rails_4a41696df6 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: chat_channel_memberships fk_rails_4ba367990a; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.chat_channel_memberships
    ADD CONSTRAINT fk_rails_4ba367990a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: html_variants fk_rails_4bb9f66719; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variants
    ADD CONSTRAINT fk_rails_4bb9f66719 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: identities fk_rails_5373344100; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.identities
    ADD CONSTRAINT fk_rails_5373344100 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_documents fk_rails_55c37c820d; Type: FK CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.user_documents
    ADD CONSTRAINT fk_rails_55c37c820d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: credits fk_rails_5628a713de; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT fk_rails_5628a713de FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE RESTRICT;


--
-- Name: organization_memberships fk_rails_57cf70d280; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.organization_memberships
    ADD CONSTRAINT fk_rails_57cf70d280 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ahoy_messages fk_rails_5894d6c55a; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_messages
    ADD CONSTRAINT fk_rails_5894d6c55a FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: html_variant_successes fk_rails_58c8775ab2; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_successes
    ADD CONSTRAINT fk_rails_58c8775ab2 FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: user_subscriptions fk_rails_59b0197af7; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT fk_rails_59b0197af7 FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: html_variant_successes fk_rails_5b92043d3f; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_successes
    ADD CONSTRAINT fk_rails_5b92043d3f FOREIGN KEY (html_variant_id) REFERENCES public.html_variants(id) ON DELETE CASCADE;


--
-- Name: classified_listing_endorsements fk_rails_699ddc4466; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listing_endorsements
    ADD CONSTRAINT fk_rails_699ddc4466 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: custom_profile_fields fk_rails_701e08633d; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.custom_profile_fields
    ADD CONSTRAINT fk_rails_701e08633d FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: organization_memberships fk_rails_715ab7f4fe; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.organization_memberships
    ADD CONSTRAINT fk_rails_715ab7f4fe FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: oauth_access_tokens fk_rails_732cb83ab7; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT fk_rails_732cb83ab7 FOREIGN KEY (application_id) REFERENCES public.oauth_applications(id);


--
-- Name: services fk_rails_76c4e193ac; Type: FK CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_76c4e193ac FOREIGN KEY (artist_application_id) REFERENCES public.artist_applications(id);


--
-- Name: sponsorships fk_rails_778bb453b1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.sponsorships
    ADD CONSTRAINT fk_rails_778bb453b1 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: articles fk_rails_7809a1a57d; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT fk_rails_7809a1a57d FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE SET NULL;


--
-- Name: webhook_endpoints fk_rails_819fdd0983; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.webhook_endpoints
    ADD CONSTRAINT fk_rails_819fdd0983 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: html_variant_trials fk_rails_823a31b2cf; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_trials
    ADD CONSTRAINT fk_rails_823a31b2cf FOREIGN KEY (html_variant_id) REFERENCES public.html_variants(id) ON DELETE CASCADE;


--
-- Name: poll_votes fk_rails_848ece0184; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT fk_rails_848ece0184 FOREIGN KEY (poll_option_id) REFERENCES public.poll_options(id) ON DELETE CASCADE;


--
-- Name: feedback_messages fk_rails_887c5f31ff; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.feedback_messages
    ADD CONSTRAINT fk_rails_887c5f31ff FOREIGN KEY (reporter_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: podcast_episodes fk_rails_893fc9044f; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.podcast_episodes
    ADD CONSTRAINT fk_rails_893fc9044f FOREIGN KEY (podcast_id) REFERENCES public.podcasts(id) ON DELETE CASCADE;


--
-- Name: classified_listing_endorsements fk_rails_8ba70ba87f; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listing_endorsements
    ADD CONSTRAINT fk_rails_8ba70ba87f FOREIGN KEY (classified_listing_id) REFERENCES public.classified_listings(id);


--
-- Name: classified_listings fk_rails_8ec4e83da0; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listings
    ADD CONSTRAINT fk_rails_8ec4e83da0 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: credits fk_rails_9001739776; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT fk_rails_9001739776 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_blocks fk_rails_9457ce6a10; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_blocks
    ADD CONSTRAINT fk_rails_9457ce6a10 FOREIGN KEY (blocked_id) REFERENCES public.users(id);


--
-- Name: poll_skips fk_rails_97ff88c452; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_skips
    ADD CONSTRAINT fk_rails_97ff88c452 FOREIGN KEY (poll_id) REFERENCES public.polls(id) ON DELETE CASCADE;


--
-- Name: api_secrets fk_rails_9aaa384ac8; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.api_secrets
    ADD CONSTRAINT fk_rails_9aaa384ac8 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: collections fk_rails_9b33697360; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT fk_rails_9b33697360 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reactions fk_rails_9f02fc96a0; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT fk_rails_9f02fc96a0 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: taggings fk_rails_9fcd2e236b; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT fk_rails_9fcd2e236b FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: ahoy_events fk_rails_a0df956a8d; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_events
    ADD CONSTRAINT fk_rails_a0df956a8d FOREIGN KEY (visit_id) REFERENCES public.ahoy_visits(id) ON DELETE CASCADE;


--
-- Name: rating_votes fk_rails_a3fec5b316; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.rating_votes
    ADD CONSTRAINT fk_rails_a3fec5b316 FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: rating_votes fk_rails_a47bf2c1e2; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.rating_votes
    ADD CONSTRAINT fk_rails_a47bf2c1e2 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: tag_adjustments fk_rails_a49150b7b2; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag_adjustments
    ADD CONSTRAINT fk_rails_a49150b7b2 FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: buffer_updates fk_rails_a4b9858400; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.buffer_updates
    ADD CONSTRAINT fk_rails_a4b9858400 FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: poll_votes fk_rails_a6e6974b7e; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT fk_rails_a6e6974b7e FOREIGN KEY (poll_id) REFERENCES public.polls(id) ON DELETE CASCADE;


--
-- Name: response_templates fk_rails_a8702c6917; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.response_templates
    ADD CONSTRAINT fk_rails_a8702c6917 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tags fk_rails_a9dc141dc9; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT fk_rails_a9dc141dc9 FOREIGN KEY (mod_chat_channel_id) REFERENCES public.chat_channels(id) ON DELETE SET NULL;


--
-- Name: poll_options fk_rails_aa85becb42; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_options
    ADD CONSTRAINT fk_rails_aa85becb42 FOREIGN KEY (poll_id) REFERENCES public.polls(id) ON DELETE CASCADE;


--
-- Name: notifications fk_rails_b080fb4855; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_b080fb4855 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: chat_channel_memberships fk_rails_b2bb73e339; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.chat_channel_memberships
    ADD CONSTRAINT fk_rails_b2bb73e339 FOREIGN KEY (chat_channel_id) REFERENCES public.chat_channels(id);


--
-- Name: sponsorships fk_rails_b3190c5fc6; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.sponsorships
    ADD CONSTRAINT fk_rails_b3190c5fc6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: oauth_access_grants fk_rails_b4b53e07b8; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT fk_rails_b4b53e07b8 FOREIGN KEY (application_id) REFERENCES public.oauth_applications(id);


--
-- Name: poll_votes fk_rails_b64de9b025; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT fk_rails_b64de9b025 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: html_variant_trials fk_rails_ba2bd12f4d; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.html_variant_trials
    ADD CONSTRAINT fk_rails_ba2bd12f4d FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: github_repos fk_rails_bbb82bb7f1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.github_repos
    ADD CONSTRAINT fk_rails_bbb82bb7f1 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: feedback_messages fk_rails_c15ceb2839; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.feedback_messages
    ADD CONSTRAINT fk_rails_c15ceb2839 FOREIGN KEY (offender_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: tag_adjustments fk_rails_c4e50e84fd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag_adjustments
    ADD CONSTRAINT fk_rails_c4e50e84fd FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: display_ad_events fk_rails_c692cbd6e1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.display_ad_events
    ADD CONSTRAINT fk_rails_c692cbd6e1 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: buffer_updates fk_rails_c8c6d97c30; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.buffer_updates
    ADD CONSTRAINT fk_rails_c8c6d97c30 FOREIGN KEY (composer_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: display_ads fk_rails_ca571cb23e; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.display_ads
    ADD CONSTRAINT fk_rails_ca571cb23e FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: tags fk_rails_d11c10a859; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT fk_rails_d11c10a859 FOREIGN KEY (badge_id) REFERENCES public.badges(id) ON DELETE SET NULL;


--
-- Name: user_blocks fk_rails_d1bf232861; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.user_blocks
    ADD CONSTRAINT fk_rails_d1bf232861 FOREIGN KEY (blocker_id) REFERENCES public.users(id);


--
-- Name: badge_achievements fk_rails_da1af2d63c; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.badge_achievements
    ADD CONSTRAINT fk_rails_da1af2d63c FOREIGN KEY (rewarder_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: ahoy_visits fk_rails_db648022ad; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_visits
    ADD CONSTRAINT fk_rails_db648022ad FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: music_tracks fk_rails_de41b6ad56; Type: FK CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.music_tracks
    ADD CONSTRAINT fk_rails_de41b6ad56 FOREIGN KEY (music_release_id) REFERENCES public.music_releases(id);


--
-- Name: profile_fields fk_rails_df1b1bea83; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profile_fields
    ADD CONSTRAINT fk_rails_df1b1bea83 FOREIGN KEY (profile_field_group_id) REFERENCES public.profile_field_groups(id);


--
-- Name: buffer_updates fk_rails_dfc43a0422; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.buffer_updates
    ADD CONSTRAINT fk_rails_dfc43a0422 FOREIGN KEY (approver_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: profiles fk_rails_e424190865; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT fk_rails_e424190865 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: feedback_messages fk_rails_e81fc50c33; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.feedback_messages
    ADD CONSTRAINT fk_rails_e81fc50c33 FOREIGN KEY (affected_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: tag_adjustments fk_rails_e8f5a32807; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag_adjustments
    ADD CONSTRAINT fk_rails_e8f5a32807 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ahoy_messages fk_rails_eb7709e291; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_messages
    ADD CONSTRAINT fk_rails_eb7709e291 FOREIGN KEY (feedback_message_id) REFERENCES public.feedback_messages(id) ON DELETE SET NULL;


--
-- Name: users_roles fk_rails_eb7b4658f8; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk_rails_eb7b4658f8 FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: oauth_access_tokens fk_rails_ee63f25419; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT fk_rails_ee63f25419 FOREIGN KEY (resource_owner_id) REFERENCES public.users(id);


--
-- Name: ahoy_events fk_rails_f1ed9fc4a0; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ahoy_events
    ADD CONSTRAINT fk_rails_f1ed9fc4a0 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: music_releases fk_rails_f7aacf9069; Type: FK CONSTRAINT; Schema: public; Owner: forem_latest
--

ALTER TABLE ONLY public.music_releases
    ADD CONSTRAINT fk_rails_f7aacf9069 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: email_authorizations fk_rails_faf7e663d1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.email_authorizations
    ADD CONSTRAINT fk_rails_faf7e663d1 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: classified_listings fk_rails_fd32b9b45f; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.classified_listings
    ADD CONSTRAINT fk_rails_fd32b9b45f FOREIGN KEY (classified_listing_category_id) REFERENCES public.classified_listing_categories(id);


--
-- PostgreSQL database dump complete
--

