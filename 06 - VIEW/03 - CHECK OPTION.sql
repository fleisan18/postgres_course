CREATE OR REPLACE VIEW heavy_orders AS
SELECT *
FROM orders
WHERE freight > 100
WITH LOCAL CHECK OPTION; --CASCADE

SELECT *
FROM heavy_orders
ORDER BY freight;

INSERT INTO heavy_orders
VALUES
(12900,	'FOLIG', 1,	'1997-12-22', '1998-01-19',	'1997-12-31', 2, 80,	
 'Folies gourmandes', '184, chaussée de Tournai', 'Lille', null, 59000, 'France');
 
SELECT *
FROM heavy_orders
WHERE order_id = 11900;

SELECT *
FROM orders
WHERE order_id = 11900;
