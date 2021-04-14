DROP TRIGGER IF EXISTS film_fulltext_trigger on public.film;
CREATE TRIGGER film_fulltext_trigger BEFORE INSERT OR UPDATE ON public.film FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');

DROP TRIGGER IF EXISTS last_updated on public.actor;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.actor FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.address;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.address FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.category;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.category FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.city;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.city FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.country;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.country FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.customer;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.customer FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.film;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.film FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.film_actor;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.film_actor FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.film_category;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.film_category FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.inventory;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.inventory FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.language;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.language FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.rental;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.rental FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.staff;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.staff FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

DROP TRIGGER IF EXISTS last_updated on public.store;
CREATE TRIGGER last_updated BEFORE UPDATE ON public.store FOR EACH ROW EXECUTE PROCEDURE public.last_updated();
