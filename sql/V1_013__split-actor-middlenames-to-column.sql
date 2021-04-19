ALTER TABLE public.actor ADD COLUMN middle_name text NULL;

UPDATE public.actor a1 
SET middle_name = (
  SELECT split_part(a1.first_name, ' ', 2) 
  FROM public.actor a2 
  WHERE a1.actor_id = a2.actor_id
),
first_name = (
  SELECT split_part(a1.first_name, ' ', 1) 
  FROM public.actor a2 
  WHERE a1.actor_id = a2.actor_id
);
