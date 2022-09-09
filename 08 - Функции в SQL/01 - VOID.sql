SELECT *
INTO tmp_customers
FROM customers;

SELECT *
FROM tmp_customers;

UPDATE tmp_customers
SET region = 'unknown'
WHERE region IS NULL;

CREATE OR REPLACE FUNCTION fix_customer_region() RETURNS void AS $$
	UPDATE tmp_customers
    SET region = 'unknown'
    WHERE region IS NULL
$$ language SQL;

SELECT fix_customer_region();

SELECT * 
INTO tmp_order
FROM orders;

CREATE OR REPLACE FUNCTION fix_orders_ship_region() RETURNS void AS $$
	UPDATE tmp_order
    SET ship_region = 'unknown'
    WHERE ship_region IS NULL
$$ language SQL;

SELECT fix_orders_ship_region();
