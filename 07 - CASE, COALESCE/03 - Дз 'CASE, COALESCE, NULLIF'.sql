-- 1. Выполните следующий код (записи необходимы для тестирования корректности выполнения ДЗ):
INSERT INTO customers(customer_id, contact_name, city, country, company_name)
VALUES 
('AAAAA', 'Alfred Mann', NULL, 'USA', 'fake_company'),
('BBBBB', 'Alfred Mann', NULL, 'Austria','fake_company');

-- После этого выполните задание:
-- Вывести имя контакта заказчика, его город и страну, отсортировав по возрастанию по имени контакта и городу,
-- а если город равен NULL, то по имени контакта и стране. Проверить результат, используя заранее вставленные строки. 
SELECT contact_name, city, country
FROM customers
ORDER BY contact_name,
CASE WHEN city IS NULL THEN country
     ELSE city END;

-- 2. Вывести наименование продукта, цену продукта и столбец со значениями
-- too expensive если цена >= 100
-- average если цена >=50 но < 100
-- low price если цена < 50
SELECT product_name, unit_price,
CASE WHEN unit_price >=100 THEN 'too expensive'
     WHEN unit_price >= 50 AND unit_price < 100 THEN 'average'
     ELSE 'low price'
END AS price_description
FROM products
ORDER BY unit_price;

-- 3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и значение 'no orders' если order_id = NULL.
SELECT order_id, company_name, COALESCE(TO_CHAR(order_id, 'FM99999999'),'no orders')  AS is_there_order
FROM orders
RIGHT JOIN customers USING (customer_id);

-- 4. Вывести ФИО сотрудников и их должности. 
-- В случае если должность = Sales Representative вывести вместо неё Sales Stuff.
SELECT CONCAT(first_name,' ', last_name), title,
CASE WHEN title = 'Sales Representative' THEN 'Sales Stuff' 
ELSE title
END AS title
FROM employees;

SELECT CONCAT(first_name,' ', last_name), COALESCE(NULLIF(title, 'Sales Representative'), 'Sales Stuff') AS title
FROM employees;
