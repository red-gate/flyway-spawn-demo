CREATE TABLE public.country (
    country_id SERIAL PRIMARY KEY,
    country text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.city (
    city_id SERIAL PRIMARY KEY,
    city text NOT NULL,
    country_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    FOREIGN KEY(country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE public.address (
    address_id SERIAL PRIMARY KEY,
    address text NOT NULL,
    address2 text,
    district text NOT NULL,
    city_id integer NOT NULL,
    postal_code text,
    phone text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    FOREIGN KEY(city_id) REFERENCES public.city(city_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

