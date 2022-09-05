SELECT company_name, order_id
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE order_id IS NULL;

SELECT COUNT(*)
FROM employees
LEFT JOIN orders ON employees.employee_id = orders.employee_id
WHERE order_id IS NULL;
