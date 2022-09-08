SELECT ship_country, COUNT (*)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY COUNT(*) DESC;

SELECT category_id, SUM (units_in_stock)
FROM products
GROUP BY category_id
ORDER BY SUM (units_in_stock)
LIMIT 5;

SELECT category_id, SUM (unit_price * units_in_stock)
FROM products
WHERE discontinued != 1
GROUP BY category_id
HAVING SUM (unit_price * units_in_stock) > 5000
ORDER BY SUM (unit_price * units_in_stock) DESC;
