-- Active: 1725418236768@@127.0.0.1@5434@northwind
-- Insertar un nuevo cliente
INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax)
VALUES ('C001', 'Acme Corp', 'John Doe', 'CEO', '123 Elm St', 'Metropolis', 'NY', '10001', 'USA', '123-456-7890', '123-456-7891');

-- Insertar un nuevo empleado
INSERT INTO employees (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address, city, region, postal_code, country, home_phone, extension, photo, notes, reports_to, photo_path)
VALUES (1, 'Smith', 'Jane', 'Manager', 'Ms.', '1980-06-15', '2020-01-01', '456 Oak St', 'Gotham', 'NY', '10002', 'USA', '123-456-7892', '101', NULL, 'No notes', NULL, 'path/to/photo.jpg');

-- Insertar un nuevo producto
INSERT INTO products (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level, discontinued)
VALUES (1, 'Widget', 10, 5, '10 per box', 19.99, 100, 50, 10, 0);

-- Consultar todos los clientes
SELECT * FROM customers;

-- Consultar clientes por país
SELECT * FROM customers WHERE country = 'USA';

-- Consultar empleados y sus títulos
SELECT employee_id, first_name, last_name, title FROM employees;

-- Consultar productos con stock bajo
SELECT product_name, units_in_stock FROM products WHERE units_in_stock < 5;

-- Actualizar la dirección de un cliente
UPDATE customers SET address = '789 Pine St' WHERE customer_id = 'C001';

-- Actualizar el precio de un producto
UPDATE products SET unit_price = 17.99 WHERE product_id = 1;

-- Eliminar un cliente
DELETE FROM customers WHERE customer_id = 'C001';

-- Eliminar un producto
DELETE FROM products WHERE product_id = 1;

-- Consultar pedidos con detalles del cliente
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Consultar detalles de los pedidos junto con información del producto
SELECT od.order_id, p.product_name, od.unit_price, od.quantity
FROM order_details od
join public.products p on p.product_id = od.product_id

-- Consultar clientes de una región específica
SELECT * FROM customers
WHERE region = 'NY';

-- Consultar pedidos realizados en el año 2024
SELECT * FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Total de ventas (suma de precios unitarios) por pedido
SELECT c.contact_name, o.order_id, SUM(od.unit_price * od.quantity) AS total_sales
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.contact_name, o.order_id; 


SELECT o.order_id, c.company_name AS customer_name, c.contact_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- hacer join con costumer para obtener el nombre

-- Promedio de precios unitarios de los productos
SELECT AVG(unit_price) AS average_price
FROM products;

-- Precio máximo y mínimo de productos
SELECT MAX(unit_price) AS max_price, MIN(unit_price) AS min_price
FROM products;

-- Contar el número de productos en cada categoría
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id;


SELECT c.category_name,  COUNT(*) AS total_products
FROM categories c
JOIN products p ON p.category_id = c.category_id
GROUP BY c.category_name

SELECT p.product_id, p.product_name, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- hacer un join para obtener el nombre de la categoria

select category_id
from products

-- Total de ventas por cliente
SELECT c.company_name, SUM(od.unit_price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.company_name;

-- Consultar productos cuyo nombre contiene 'Widget'
SELECT * FROM products
WHERE product_name LIKE '%Widget%';
-- Consultar pedidos realizados por ciertos clientes
SELECT * FROM orders
WHERE customer_id IN ('C001', 'C002', 'C003');

select * from orders
where customer_id= 'C001'
and   customer_id = 'C002'
and   customer_id ='C003'

-- Consultar productos ordenados por precio descendente
SELECT * FROM products
ORDER BY unit_price DESC;

-- Consultar clientes ordenados por nombre de la empresa
SELECT * FROM customers
ORDER BY company_name ASC;


