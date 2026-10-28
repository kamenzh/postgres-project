# Superheroes and Damage — PostgreSQL Lesson 5

Open `superheroes.sql` in pgAdmin's **Query Tool**, connected to your database
(the worksheet uses `mydb`), and execute it. Setup creates and populates the
three tables, followed by queries answering every worksheet question.
Run setup once in a database where these table names do not already exist.
Afterward, select and execute individual queries as needed.

## Expected answers

1. **8 missions**, **24 people saved**, **19 million damage**. Average saved:
   **3.00**; minimum: **1**; maximum: **6**. The record is mission **6**:
   **Boom** saved **6** in **Low**, causing **2 million** damage.
2. By hero ID: **3 → 10**, **2 → 9**, **1 → 5**. By name:
   **Boom 10**, **Rex 9**, **Zap 5**, **Nap 0**.
3. Using total damage to measure danger:

   | City | Missions | Saved | Damage (millions) | Different heroes |
   | --- | ---: | ---: | ---: | ---: |
   | Big | 3 | 9 | 10 | 3 |
   | Low | 3 | 13 | 5 | 3 |
   | Meh | 2 | 2 | 4 | 2 |

   **Big** is most dangerous by total damage. If danger means mission count,
   **Big and Low tie**, with three missions each.
4. In Big: **Boom 4**, **Rex 3**, **Zap 2**, **Nap 0**.
5. **Big** has at least 10 million damage, with **10 million**.
   **Boom** has damage greater than saved: **12 > 10**. This follows the
   worksheet's numerical comparison; the quantities have different units.
6. Tours retain repeat visits and follow mission ID order:

   | Hero | Missions | Tour |
   | --- | ---: | --- |
   | Zap | 3 | Big → Meh → Low |
   | Rex | 3 | Low → Big → Meh |
   | Boom | 2 | Big → Low |
   | Nap | 0 | No missions |

   Nap exists in `heroes` but has no matching rescue rows. `LEFT JOIN` keeps
   Nap in the report; `COUNT(r.id)` correctly counts zero missions.
