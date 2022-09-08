SELECT *
FROM customers
WHERE country = 'Mexico' OR country = 'Germany' OR country = 'USA' OR country = 'Canada';

SELECT *
FROM customers
WHERE country IN ('Mexico', 'Germany', 'USA', 'Canada');

SELECT *
FROM customers
WHERE country NOT IN ('Mexico', 'Germany', 'USA', 'Canada');
