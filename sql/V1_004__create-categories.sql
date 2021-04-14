CREATE TABLE public.category (
    category_id SERIAL PRIMARY KEY,
    name text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
