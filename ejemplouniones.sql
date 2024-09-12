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
