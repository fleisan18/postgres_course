-- 1. Создать функцию, которая делает бекап таблицы customers (копирует все данные в другую таблицу), 
-- предварительно стирая таблицу для бекапа, если такая уже существует, чтобы в случае многократного запуска 
-- таблица для бекапа перезатиралась. 

CREATE OR REPLACE FUNCTION backup_customers () RETURNS void AS $$
    DROP TABLE IF EXISTS backed_up_customers;
    CREATE TABLE backed_up_customers AS
    SELECT * 
    FROM customers;
--     SELECT * 
--     INTO backed_up_customers
--     FROM customers;
$$ LANGUAGE SQL;

SELECT * FROM backup_customers();
SELECT * FROM backed_up_customers;

-- 2. Создать функцию, которая возвращает средний фрахт.
CREATE OR REPLACE FUNCTION get_avg_freight() RETURNS real AS $$
    SELECT AVG (freight) AS avg_freight
    FROM orders;
$$ LANGUAGE SQL;

SELECT get_avg_freight();

-- 3. Написать функцию, которая принимает 2 целочисленных параметра, 
-- используемых как нижняя и верхняя границы для генерации случайного числа, включая сами граничные значения.
-- Необходимо вычислить разницу между границами и прибавить 1. 
-- На полученное число умножить результат функции RANDOM. 
-- Прибавить к результату значение нижней границы. 
-- Применить фукнцию FLOOR, чтобы не уехать за границу и получить целое число.
CREATE OR REPLACE FUNCTION get_diff_by_boundaries (low_boundary real, high_boundary real) RETURNS int AS $$
BEGIN
    RETURN FLOOR((high_boundary-low_boundary+1) * RANDOM() + low_boundary);
END
$$ LANGUAGE plpgsql;

SELECT * FROM get_diff_by_boundaries(1, 5);

-- 4. Создать функцию, которая возвращает самую низкую и высокую зарплату среди сотрудников заданного города (аргумент).
CREATE OR REPLACE FUNCTION salary_boundaries (emp_city varchar, OUT low_salary real, OUT high_salary real) AS $$
BEGIN
    SELECT MIN(salary), MAX(salary) 
    INTO low_salary, high_salary
    FROM employees
    WHERE salary = emp_city;
END;
$$ LANGUAGE plpgsql;
    
-- 5. Создать функцию, которая корректирует зарплату на некий k (аргумент), но не корректирует ее, если ее уровень не превышает некую заданную границу. 
-- При этом верхний уровень з/п по умолчанию = 70, % коррекции = 15%.
CREATE OR REPLACE FUNCTION corrected_salary(upper_boundary numeric DEFAULT 70, correction_rate numeric DEFAULT 0.15) RETURNS void AS $$
    UPDATE employees
    SET salary = (1+correction_rate)*salary
    WHERE salary <= upper_boundary;
$$ LANGUAGE SQL;

-- 6. Модифицировать функцию, корректирующую з/п таким образом, чтобы она также выводила изменененные записи.
DROP FUNCTION IF EXISTS corrected_salary;
CREATE OR REPLACE FUNCTION corrected_salary(upper_boundary numeric DEFAULT 70, correction_rate numeric DEFAULT 0.15) RETURNS SETOF employees AS $$
    UPDATE employees
    SET salary = (1+correction_rate)*salary
    WHERE salary <= upper_boundary;
    RETURNING employees   
$$ LANGUAGE SQL;

-- 7. Модифицировать предыдущую функцию так, чтобы она возвращала только колонки last_name, first_name, title. salary.
DROP FUNCTION IF EXISTS corrected_salary;
CREATE OR REPLACE FUNCTION corrected_salary(upper_boundary numeric DEFAULT 70, correction_rate numeric DEFAULT 0.15) 
RETURNS SETOF TABLE (last_name text, first_name text, title text, salary numeric) AS $$
    UPDATE employees
    SET salary = (1+correction_rate)*salary
    WHERE salary <= upper_boundary;
    RETURNING last_name, first_name, title, salary
$$ LANGUAGE SQL;

-- 8. Написать функцию, которая принимает метод поставки (ship_via) и возвращает запись из таблицы orders, 
-- в которых фрахт меньше значения, определяемого след. алгоритмом: 
-- макс(фрахта) среди заказов по заданному методу доставки (аргумент) понижаем его на 30%, 
-- вычисляем среднее фрахта среди заказов по заданному методу доставки, 
-- вычисляем среднее между полученными числами 
-- и возвращаем все заказы, в которых значение фрахта меньше найденного среднего. 

CREATE OR REPLACE FUNCTION less_freight (given_ship_via int) RETURNS SETOF orders AS $$
DECLARE
    avg_freight real;
    max_freight real;
    avg_result real;
BEGIN
    SELECT AVG(freight) INTO avg_freight
    FROM orders
    WHERE ship_via = given_ship_via;
    SELECT MAX(freight) INTO max_freight
    FROM orders
    WHERE ship_via = given_ship_via;
    max_freight = 0.7 * max_freight;
    avg_result = (avg_freight + max_freight) / 2;
    RETURN QUERY
    SELECT *
    FROM orders
    WHERE freight < avg_result;
END
$$ LANGUAGE plpqsql;

SELECT * FROM less_freight(3);

-- 9. Написать функцию, которая принимать максимальный и минимальный уровень з/п (по умолчанию макс. = 80, мин. = 30), коэф. роста з/п по умолчанию 20%. 
-- Если з/п, которую передали, выше минимальной - фалсе. 
-- Если з/п ниже минимальной, то увеличивается з/п на коэф. роста и проверяется, не станет ли з/п после повышения выше максимальной. 
-- Если привысит, возвращаем фолсе, иначе тру. 
CREATE OR REPLACE FUNCTION correct_salary (
    current_salary real, 
    max_salary real DEFAULT 80, 
    min_salary real DEFAULT 30, 
    correction_rate real DEFAULT 0.2) 
RETURNS bool AS $$
DECLARE 
    result bool;
BEGIN
    IF current_salary >= min_salary OR current_salary >= max_salary THEN result = false;
    ELSEIF current_salary * (1 + correction_rate) > max_salary THEN result = false;
    ELSE result = true
    END IF;
END;
$$ LANGUAGE plpqsql;
