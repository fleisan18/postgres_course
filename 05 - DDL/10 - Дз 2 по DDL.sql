-- 1. Создать таблицу exam с полями:

-- - идентификатора экзамена - автоинкрементируемый, уникальный, запрещает NULL;
-- - наименования экзамена
-- - даты экзамена
DROP TABLE IF EXISTS exam;

CREATE TABLE exam
(
    exam_id serial NOT NULL,
    exam_name varchar,
    date_exam date,

    CONSTRAINT exam_exam_id UNIQUE (exam_id));

SELECT *
FROM exam;

-- 2. Удалить ограничение уникальности с поля идентификатора
ALTER TABLE exam
DROP CONSTRAINT exam_exam_id;

-- 3. Добавить ограничение первичного ключа на поле идентификатора
ALTER TABLE exam
ADD CONSTRAINT exam_pkey PRIMARY KEY (exam_id);

-- 4. Создать таблицу person с полями
-- - идентификатора личности (простой int, первичный ключ)
-- - имя
-- - фамилия
CREATE TABLE person
(
    person_id int PRIMARY KEY,
    first_name varchar,
    last_name varchar
);

-- 5. Создать таблицу паспорта с полями:
-- - идентификатора паспорта (простой int, первичный ключ)
-- - серийный номер (простой int, запрещает NULL)
-- - регистрация
-- - ссылка на идентификатор личности (внешний ключ)
CREATE TABLE passport
(
    passport_id int PRIMARY KEY,
    serial_number int NOT NULL,
    registration varchar,
    person_id int,
    FOREIGN KEY (person_id) REFERENCES person (person_id)
);
-- 6. Добавить колонку веса в таблицу book (создавали ранее) с ограничением, проверяющим вес (больше 0 но меньше 100)
SELECT * 
FROM book;

ALTER TABLE book
ADD COLUMN weight decimal CONSTRAINT CHK_book_weight CHECK (weight > 0 AND weight <=100);

-- 7. Убедиться в том, что ограничение на вес работает (попробуйте вставить невалидное значение)
INSERT INTO book (weight)
VALUES
(110);

-- 8. Создать таблицу student с полями:
-- - идентификатора (автоинкремент)
-- - полное имя
-- - курс (по умолчанию 1)
DROP TABLE IF EXISTS student;

CREATE TABLE student
(
student_id serial,
full_name text,
course int DEFAULT 1);

-- 9. Вставить запись в таблицу студентов и убедиться, что ограничение на вставку значения по умолчанию работает
INSERT INTO student (full_name)
VALUES
('Ivan Ivanovich');

SELECT *
FROM student;

-- 10. Удалить ограничение "по умолчанию" из таблицы студентов
ALTER TABLE student
ALTER COLUMN course DROP DEFAULT;

-- 11. Подключиться к БД northwind и добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
SELECT *
FROM products;

ALTER TABLE products
ADD CONSTRAINT CHK_products_unit_price CHECK (unit_price > 0);

-- 12. "Навесить" автоинкрементируемый счётчик на поле product_id таблицы products (БД northwind). 
-- Счётчик должен начинаться с числа следующего за максимальным значением по этому столбцу.
CREATE SEQUENCE IF NOT EXISTS products_product_id_seq
OWNED BY products.product_id;

SELECT setval ('products_product_id_seq', (SELECT MAX (product_id) FROM products));
                      
ALTER TABLE products
ALTER COLUMN product_id SET DEFAULT nextval('products_product_id_seq');

-- 13. Произвести вставку в products (не вставляя идентификатор явно) и убедиться, что автоинкремент работает. Вставку сделать так, чтобы в результате команды вернулось значение, сгенерированное в качестве идентификатора.
INSERT INTO products (product_name, discontinued)
VALUES
('product_78', 0);
