CREATE TABLE author
(
author_id serial,
full_name text,
rating decimal);

INSERT INTO author
VALUES
(10, 'Joh Silver', 4.5);

INSERT INTO author (author_id, full_name)
VALUES
(11, 'Bob Gray');


INSERT INTO author (author_id, full_name)
VALUES
(12, 'name12'),
(13, 'name13');

SELECT * 
FROM author;

SELECT *
INTO best_authors
FROM author
WHERE rating >=4.5;

SELECT *
FROM best_authors;

INSERT INTO best_authors
SELECT *
FROM author
WHERE rating <4.5;
