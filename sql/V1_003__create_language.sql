CREATE TABLE public.language (
    language_id SERIAL PRIMARY KEY,
    name character(20) NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
