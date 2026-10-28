-- PostgreSQL Lesson 5: Superheroes and Damage
-- Run in pgAdmin's Query Tool, connected to your database (e.g. mydb).
-- Run setup once. The SELECT queries can then be rerun independently.

BEGIN;

CREATE TABLE heroes (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    power TEXT NOT NULL
);

CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    people INT NOT NULL -- population in thousands
);

CREATE TABLE rescues (
    id SERIAL PRIMARY KEY,
    hero_id INT NOT NULL REFERENCES heroes(id),
    city_id INT NOT NULL REFERENCES cities(id),
    saved INT,
    damage INT NOT NULL -- millions
);

INSERT INTO heroes (name, power) VALUES
    ('Zap', 'laser'), ('Rex', 'muscles'),
    ('Boom', 'explode'), ('Nap', 'sleep');

INSERT INTO cities (name, people) VALUES
    ('Big', 20), ('Low', 14), ('Meh', 5);

INSERT INTO rescues (hero_id, city_id, saved, damage) VALUES
    (1, 1, 2, 0),
    (2, 2, 5, 3),
    (1, 3, 1, 0),
    (3, 1, 4, 10),
    (2, 1, 3, 0),
    (3, 2, 6, 2),
    (1, 2, 2, 0),
    (2, 3, 1, 4);

COMMIT;

-- 1. Overall totals and mission statistics.
SELECT COUNT(*) AS missions,
       SUM(saved) AS total_saved,
       SUM(damage) AS total_damage_millions,
       ROUND(AVG(saved), 2) AS average_saved,
       MIN(saved) AS minimum_saved,
       MAX(saved) AS record_saved
FROM rescues;

-- Record means most people saved in one mission; return all ties.
SELECT r.id AS mission_id, h.name AS hero, c.name AS city,
       r.saved, r.damage AS damage_millions
FROM rescues r
JOIN heroes h ON h.id = r.hero_id
JOIN cities c ON c.id = r.city_id
WHERE r.saved = (SELECT MAX(saved) FROM rescues)
ORDER BY r.id;

-- 2a. Total saved, identified by hero number.
SELECT hero_id, SUM(saved) AS total_saved
FROM rescues
GROUP BY hero_id
ORDER BY total_saved DESC, hero_id;

-- 2b. The same ranking by name, including heroes with no missions.
SELECT h.name, COALESCE(SUM(r.saved), 0) AS total_saved
FROM heroes h
LEFT JOIN rescues r ON r.hero_id = h.id
GROUP BY h.id, h.name
ORDER BY total_saved DESC, h.name;

-- 3. Danger is measured by total damage. The highest total comes first.
SELECT c.name, COUNT(r.id) AS missions,
       COALESCE(SUM(r.saved), 0) AS total_saved,
       COALESCE(SUM(r.damage), 0) AS damage_millions,
       COUNT(DISTINCT r.hero_id) AS different_heroes
FROM cities c
LEFT JOIN rescues r ON r.city_id = c.id
GROUP BY c.id, c.name
ORDER BY damage_millions DESC, c.name;

-- 4. Saved by each hero in Big, including zero for absent heroes.
-- Filtering inside the JOIN preserves those heroes.
SELECT h.name, COALESCE(SUM(r.saved), 0) AS saved_in_big
FROM heroes h
LEFT JOIN rescues r
    ON r.hero_id = h.id
   AND r.city_id = (SELECT id FROM cities WHERE name = 'Big')
GROUP BY h.id, h.name
ORDER BY saved_in_big DESC, h.name;

-- 5a. Cities with at least 10 million in damage.
SELECT c.name, SUM(r.damage) AS damage_millions
FROM cities c
JOIN rescues r ON r.city_id = c.id
GROUP BY c.id, c.name
HAVING SUM(r.damage) >= 10
ORDER BY damage_millions DESC, c.name;

-- 5b. Compare the numeric totals, as requested by the worksheet:
-- damage is in millions, while saved is a count of people.
SELECT h.name, SUM(r.saved) AS total_saved,
       SUM(r.damage) AS damage_millions
FROM heroes h
JOIN rescues r ON r.hero_id = h.id
GROUP BY h.id, h.name
HAVING SUM(r.damage) > SUM(r.saved)
ORDER BY damage_millions DESC, h.name;

-- 6. Each hero's tour, in mission order, on one row.
SELECT h.name, COUNT(r.id) AS missions,
       COALESCE(STRING_AGG(c.name, ' -> ' ORDER BY r.id), 'No missions') AS tour
FROM heroes h
LEFT JOIN rescues r ON r.hero_id = h.id
LEFT JOIN cities c ON c.id = r.city_id
GROUP BY h.id, h.name
ORDER BY h.id;

-- Where is Nap? Find every hero absent from the mission log.
SELECT h.name, h.power
FROM heroes h
LEFT JOIN rescues r ON r.hero_id = h.id
WHERE r.id IS NULL
ORDER BY h.name;
