-- 1. Найти заказчиков и обслуживающих их заказы сотрудников таких, 
-- что и заказчики и сотрудники из города London, 
-- а доставка идёт компанией Speedy Express. 
-- Вывести компанию заказчика и ФИО сотрудника.
SELECT customers.company_name, first_name, last_name, customers.city, shippers.company_name
FROM customers
JOIN orders USING (customer_id)
JOIN employees USING (employee_id)
JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE customers.city = 'London' AND employees.city = 'London' AND shippers.company_name = 'Speedy Express';

-- 2. Найти активные (см. поле discontinued) продукты 
-- из категории Beverages и Seafood, 
-- которых в продаже менее 20 единиц. 
-- Вывести наименование продуктов, кол-во единиц в продаже, имя контакта поставщика и его телефонный номер.
SELECT product_name, units_in_stock, suppliers.company_name, phone
FROM categories 
JOIN products USING (category_id)
JOIN suppliers USING (supplier_id)
WHERE category_name IN ('Beverages' ,'Seafood') AND discontinued = 0 AND units_in_stock < 20;

-- 3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
SELECT customers.company_name, order_id
FROM customers
LEFT JOIN orders USING (customer_id)
WHERE order_id IS NULL;

-- 4. Переписать предыдущий запрос, использовав симметричный вид джойна (подсказка: речь о LEFT и RIGHT).
SELECT customers.company_name, order_id
FROM orders
RIGHT JOIN customers USING (customer_id)
WHERE order_id IS NULL;
