CREATE TABLE public.actor (
    actor_id SERIAL PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX idx_actor_last_name ON public.actor USING btree (last_name);