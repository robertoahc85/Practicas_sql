-- Active: 1725418236768@@127.0.0.1@5434@ejemplos_relaciones@public
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE
);

INSERT INTO customers (customer_name)
VALUES ('Alice'), ('Bob'), ('Charlie'), ('David');

INSERT INTO orders (customer_id, order_date)
VALUES 
(1, '2024-09-01'), 
(2, '2024-09-02'), 
(2, '2024-09-03'),
(3, '2024-09-04');


INSERT INTO customers (customer_name)
VALUES ('Eva'), ('Frank'), ('Grace');

INSERT INTO orders (customer_id, order_date)
VALUES 
(5, '2024-09-05'), 
(6, '2024-09-06'), 
(7, '2024-09-07'), 
(3, '2024-09-08');

-- 1. INNER JOIN: Devuelve las fila que tiene coincidencia en ambas tablas

SELECT c.customer_name , o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id

-- 2. FULL outer join  , este operador devuelve todas la filas cuando hay una coincidencia en una de de la tabla ,

SELECT c.customer_name , o.order_date
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id

-- 3. LEFT JOIN Devuelve toda las filas de tabla izquierda y la coincidencia de tabla derecha
SELECT c.customer_name , o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id

-- 4. Devuelve toda las filas de tabla derecha y la coincidencia de tabla izquierda

SELECT c.customer_name , o.order_date
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id

-- 5. FULL JOIN DEVUELVE TODA LAS FILAS CUANDO HAY UNA COINCIDENCIA EN UNA DE TABLAS, INCLUYENDO LA FILAS QUE  NO COINCIDEN EN NINGUNA DE LA DOS TABLAS

SELECT c.customer_name , o.order_date
FROM customers c
FULL JOIN orders o ON c.customer_id = o.customer_id


-- 6 . INTERSECT.  devuelve las fila comunes ente dos consultas
SELECT customer_id  from customers
INTERSECT
SELECT customer_id FROM orders

-- 7. producto cartesiano todas la combinaciones posible de fila
SELECT c.customer_name, o.order_date
FROM customers c, orders o

-- 8. UNION COMBINA LOS RESULTADO DE DOS O MAS CONSULTA. ELIMINADO LOS DUPLICADO
SELECT customer_name AS name, 'Customer' AS source, NULL AS order_date
FROM customers
UNION
SELECT 'Order' AS name, 'Order' AS source, order_date
FROM orders;
-- 9. Minus  Devuelve las filas que estan en la primera consulta pero no la segunda
Select customer_name from customers 
EXCEPT
SELECT customer_name from orders o JOIN customers c ON o.customer_id = c.customer_id


