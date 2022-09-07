SELECT *
FROM book;

ALTER TABLE book
ADD COLUMN price decimal CONSTRAINT CHK_book_price CHECK (price >= 0);

INSERT INTO book (book_id, title, isbn, price)
VALUES
(1, 'title', 'isbn', 1, -1);

INSERT INTO book (book_id, title, isbn, price)
VALUES
(1, 'title', 'isbn', 1.5);

SELECT *
FROM book;

ALTER TABLE book
ADD COLUMN price decimal CONSTRAINT CHK_book_price CHECK (price >= 0);

INSERT INTO book (book_id, title, isbn, price)
VALUES
(1, 'title', 'isbn', 1, -1);

INSERT INTO book (book_id, title, isbn, price)
VALUES
(1, 'title', 'isbn', 1.5);
