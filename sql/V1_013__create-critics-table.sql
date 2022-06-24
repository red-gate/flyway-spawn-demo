CREATE TABLE public.critic (
    critic_id SERIAL PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
CREATE INDEX idx_critic_last_name ON public.critic USING btree (last_name);