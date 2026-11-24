-- Question 1: Everything in room 101, grouped together by kind.
-- Returns inventory number, kind, model, and purchase date for each device.
-- Change '101' to the desired room code; ORDER BY keeps individual devices visible.
SELECT
    d.inventory_number,
    k.name AS kind,
    d.model,
    d.purchase_date
FROM public.devices AS d
JOIN public.device_kinds AS k ON k.kind_id = d.kind_id
WHERE d.room_code = '101'
ORDER BY k.name, d.inventory_number;

-- Question 2: Equipment older than five years, including devices in storage.
-- Returns inventory number, kind, model, room (NULL = storage), purchase date,
-- and exact calendar age in years, months, and days, with the oldest items first.
SELECT
    d.inventory_number,
    k.name AS kind,
    d.model,
    d.room_code,
    d.purchase_date,
    AGE(CURRENT_DATE, d.purchase_date) AS exact_age
FROM public.devices AS d
JOIN public.device_kinds AS k ON k.kind_id = d.kind_id
WHERE d.purchase_date < (CURRENT_DATE - INTERVAL '5 years')::date
ORDER BY d.purchase_date, d.inventory_number;
