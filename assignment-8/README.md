# Decisions I made and why

I use three tables: `rooms` for the classrooms, `device_kinds` for the kinds of equipment, and `devices` for the individual items.
The inventory number is the primary key of `devices` because each sticker identifies exactly one device; it is text so that letters and leading zeros are preserved.
Each other table also has a primary key, and foreign keys connect each device to its kind and, when assigned, its room; a NULL room means the device is in storage.
I store the purchase date as a `DATE`, but I do not store age because it changes over time and can be calculated with `AGE(CURRENT_DATE, purchase_date)`.
The room query sorts by kind to keep similar devices together while showing every individual item, and the old-equipment query includes devices in storage and excludes items that are exactly five years old.
