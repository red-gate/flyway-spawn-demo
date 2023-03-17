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
