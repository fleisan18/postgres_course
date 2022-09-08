CREATE SEQUENCE seq1;

SELECT nextval('seq1');
SELECT currval('seq1');
SELECT lastval();

SELECT setval('seq1', 16); --true);
SELECT currval('seq1'); --16
SELECT nextval('seq1'); --17

SELECT setval('seq1', 16, false); --true);
SELECT currval('seq1'); --17
SELECT nextval('seq1'); --16

CREATE SEQUENCE IF NOT EXISTS seq2 INCREMENT 15;
SELECT nextval('seq2');

CREATE SEQUENCE IF NOT EXISTS seq3
INCREMENT 15
MINVALUE 0
MAXVALUE 128
START WITH 0;

SELECT nextval('seq3');

ALTER SEQUENCE seq3 RENAME TO seq4;
ALTER SEQUENCE seq4 RESTART WITH 16;

SELECT nextval('seq4');

DROP SEQUENCE seq4;

_______

DROP TABLE IF EXISTS book;

CREATE TABLE book
(
    book_id int NOT NULL,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int NOT NULL,
    
    CONSTRAINT PK_book_id PRIMARY KEY (book_id)
)

CREATE SEQUENCE IF NOT EXISTS book_book_id_seq
START WITH 1 OWNED BY book.book_id;

INSERT INTO book (title, isbn, publisher_id)
VALUES ('title', 'isbn', 1);

ALTER TABLE book
ALTER COLUMN book_id SET DEFAULT nextval('book_book_id_seq');

SELECT *
FROM book;
