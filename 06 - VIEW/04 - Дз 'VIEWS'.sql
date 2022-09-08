-- 1. Создать представление, которое выводит следующие колонки:
-- order_date, required_date, shipped_date, ship_postal_code, company_name, contact_name, phone, last_name, first_name, title из таблиц orders, customers и employees.
CREATE VIEW orders_customers_employees AS
SELECT order_date, required_date, shipped_date, ship_postal_code,
company_name, contact_name, phone,
last_name, first_name, title
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);

-- Сделать select к созданному представлению, выведя все записи, где order_date больше 1го января 1997 года.
SELECT *
FROM orders_customers_employees
WHERE order_date > '1997-01-01';

-- 2. Создать представление, которое выводит следующие колонки:
-- order_date, required_date, shipped_date, ship_postal_code, ship_country, company_name, contact_name, phone, last_name, first_name, title из таблиц orders, customers, employees.
-- Попробовать добавить к представлению (после его создания) колонки postal_code и reports_to. Убедиться, что проихсодит ошибка. Переименовать представление и создать новое уже с дополнительными колонками.
CREATE OR REPLACE VIEW orders_customers_employees AS
SELECT order_date, required_date, shipped_date, ship_postal_code, ship_country, --add ship_country
company_name, contact_name, phone, customers.postal_code, --add postal_code
last_name, first_name, title, reports_to --add reports_to
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);

-- Сделать к нему запрос, выбрав все записи, отсортировав их по ship_county.
SELECT *
FROM orders_customers_employees
ORDER BY ship_country;

-- Удалить переименованное представление.
DROP VIEW IF EXISTS orders_customers_employees;

-- 3.  Создать представление "активных" (discontinued = 0) продуктов, содержащее все колонки. 
-- Представление должно быть защищено от вставки записей, в которых discontinued = 1.
CREATE VIEW active_products AS
SELECT *
FROM products
WHERE discontinued = 0
WITH LOCAL CHECK OPTION;

SELECT *
FROM active_products;

-- Попробовать сделать вставку записи с полем discontinued = 1 - убедиться, что не проходит.
INSERT INTO active_products
VALUES 
(79, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10, 13, 70, 25, 1);
