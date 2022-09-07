DROP TABLE chair;

CREATE TABLE chair
(
chair_id serial PRIMARY KEY,
chair_name varchar,
    dean varchar);
    
INSERT INTO chair
VALUES (1, 'name', 'dean');

SELECT *
FROM chair;

INSERT INTO chair
VALUES (1, 'name2', 'dean2');

INSERT INTO chair
VALUES (NULL, 'name2', 'dean2');

INSERT INTO chair
VALUES (2, 'name2', 'dean2');

CREATE TABLE chair
(
chair_id serial UNIQUE NOT NULL, --такое ограничение может быть наложено более чем на одну колонку в отличие от PK
chair_name varchar,
    dean varchar);

SELECT constraint_name
FROM information_schema.key_column_usage
WHERE table_name = 'chair'
AND table_schema = 'public'
AND column_name = 'chair_id';

ALTER TABLE chair
DROP CONSTRAINT chair_pkey;

ALTER TABLE chair
ADD PRIMARY KEY (chair_id);
