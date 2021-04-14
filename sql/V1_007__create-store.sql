CREATE TABLE public.store (
    store_id SERIAL PRIMARY KEY,
    manager_staff_id integer NOT NULL UNIQUE,
    address_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE UNIQUE INDEX idx_unq_manager_staff_id ON public.store USING btree (manager_staff_id);
