CREATE TABLE public.payment (
    payment_id SERIAL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
    FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id),
    FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id),
    PRIMARY KEY(payment_id, payment_date)
)
PARTITION BY RANGE (payment_date);

CREATE TABLE public.payment_p2020_01 (
    payment_id SERIAL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
    FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id),
    FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id)
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_01 FOR VALUES FROM ('2020-01-01 00:00:00+00') TO ('2020-02-01 00:00:00+00');

CREATE TABLE public.payment_p2020_02 (
    payment_id SERIAL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
    FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id),
    FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id)
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_02 FOR VALUES FROM ('2020-02-01 00:00:00+00') TO ('2020-03-01 00:00:00+00');

CREATE TABLE public.payment_p2020_03 (
    payment_id SERIAL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
    FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id),
    FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id)
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_03 FOR VALUES FROM ('2020-03-01 00:00:00+00') TO ('2020-04-01 00:00:00+00');

CREATE TABLE public.payment_p2020_04 (
    payment_id SERIAL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
    FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id),
    FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id)
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_04 FOR VALUES FROM ('2020-04-01 00:00:00+00') TO ('2020-05-01 00:00:00+00');

CREATE TABLE public.payment_p2020_05 (
    payment_id SERIAL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
    FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id),
    FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id)
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_05 FOR VALUES FROM ('2020-05-01 00:00:00+00') TO ('2020-06-01 00:00:00+00');

CREATE TABLE public.payment_p2020_06 (
    payment_id SERIAL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
    FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id),
    FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id)
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_06 FOR VALUES FROM ('2020-06-01 00:00:00+00') TO ('2020-07-01 00:00:00+00');
