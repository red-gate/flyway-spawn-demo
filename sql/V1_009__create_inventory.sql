CREATE TABLE public.inventory (
    inventory_id SERIAL PRIMARY KEY,
    film_id integer NOT NULL,
    store_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (store_id) REFERENCES public.store(store_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE INDEX idx_store_id_film_id ON public.inventory USING btree (store_id, film_id);