WITH ranked_stores AS (
    SELECT store_id, ROW_NUMBER() OVER (ORDER BY store_id) AS store_rank
    FROM store
),
ranked_staff AS (
    SELECT staff_id, ROW_NUMBER() OVER (ORDER BY staff_id) AS staff_rank
    FROM staff
)
UPDATE staff
SET store_id = ranked_stores.store_id
FROM ranked_stores, ranked_staff
WHERE staff.staff_id = ranked_staff.staff_id
  AND ranked_staff.staff_rank = ranked_stores.store_rank;
