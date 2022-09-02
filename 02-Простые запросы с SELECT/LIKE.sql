-- % - сколько угодно символов
-- - ровно 1 символ

SELECT last_name, first_name
FROM employees
WHERE first_name LIKE '%n';

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'B%';

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE '_uch%';
