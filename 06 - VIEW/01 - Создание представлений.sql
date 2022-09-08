CREATE VIEW products_soppliers_categories AS
SELECT product_name, quantity_per_unit, unit_price, units_in_stock,
company_name, contact_name, phone,
category_name, description
FROM products
JOIN suppliers USING (supplier_id)
JOIN categories USING (category_id);

SELECT *
FROM products_soppliers_categories
WHERE unit_price > 20;

DROP VIEW IF EXISTS products_soppliers_categories;
