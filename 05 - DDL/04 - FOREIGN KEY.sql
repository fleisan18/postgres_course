DROP TABLE book;
DROP TABLE publisher;

CREATE TABLE publisher
(
    publisher_id int,
    publisher_name varchar (128) NOT NULL,
    address text,
    
    CONSTRAINT PR_publisher_id PRIMARY KEY (publisher_id));

CREATE TABLE book
(
    book_id int,
    title text NOT NULL,
    isbn varchar (32) NOT NULL,
    publisher_id int,
    
    CONSTRAINT PK_book_id PRIMARY KEY (book_id)
);

-- CREATE TABLE book
-- (
--     book_id int,
--     title text NOT NULL,
--     isbn varchar (32) NOT NULL,
--     publisher_id int,
    
--     CONSTRAINT PK_book_id PRIMARY KEY (book_id),
--     CONSTRAINT FK_book_publisher FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id)
-- );

INSERT INTO book
VALUES
(1, '11', '111', '1111');

SELECT *
FROM book;

TRUNCATE TABLE book;

ALTER TABLE book
ADD CONSTRAINT FK_book_publisher FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id);
