CREATE OR REPLACE FUNCTION get_product_price_by_name (prod_name varchar) RETURNS real AS $$
    SELECT unit_price
    FROM products
    WHERE product_name = prod_name
$$ LANGUAGE SQL;

SELECT get_product_price_by_name ('Chocolade') AS price;

SELECT *
FROM products
WHERE product_name = 'Chocolade';

CREATE OR REPLACE FUNCTION get_price_boundaries (OUT max_price real, OUT min_price real) AS $$
    SELECT MAX(unit_price), MIN (unit_price)
    FROM products
$$ LANGUAGE SQL;

SELECT get_price_boundaries();

SELECT *
FROM get_price_boundaries();

CREATE OR REPLACE FUNCTION get_price_boundaries_by_discontinuty (is_discontinued int, OUT max_price real, OUT min_price real) AS $$
    SELECT MAX(unit_price), MIN (unit_price)
    FROM products
    WHERE is_discontinued = discontinued
$$ LANGUAGE SQL;

SELECT *
FROM get_price_boundaries_by_discontinuty(1);

CREATE OR REPLACE FUNCTION get_price_boundaries_by_discontinuty (is_discontinued int DEFAULT 1, OUT max_price real, OUT min_price real) AS $$
    SELECT MAX(unit_price), MIN (unit_price)
    FROM products
    WHERE is_discontinued = discontinued
$$ LANGUAGE SQL;

SELECT *
FROM get_price_boundaries_by_discontinuty();

SELECT *
FROM get_price_boundaries_by_discontinuty(0);
