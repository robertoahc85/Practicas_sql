-- Crear la tabla de autores
CREATE TABLE autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    nacionalidad VARCHAR(50)
);

-- Crear la tabla de libros
CREATE TABLE libros (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(150),
    precio NUMERIC(10, 2),
    id_autor INT REFERENCES autores(id_autor),
    fecha_publicacion DATE
);

-- Crear la tabla de ventas
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_libro INT REFERENCES libros(id_libro),
    cantidad INT,
    fecha_venta DATE
);

-- Insertar datos en la tabla de autores
INSERT INTO autores (nombre, nacionalidad) VALUES
('Gabriel García Márquez', 'Colombiana'),
('Isabel Allende', 'Chilena'),
('J.K. Rowling', 'Británica'),
('Jorge Luis Borges', 'Argentina');

-- Insertar datos en la tabla de libros
INSERT INTO libros (titulo, precio, id_autor, fecha_publicacion) VALUES
('Cien años de soledad', 25.99, 1, '1967-05-30'),
('El amor en los tiempos del cólera', 20.99, 1, '1985-09-10'),
('La casa de los espíritus', 18.50, 2, '1982-09-20'),
('Harry Potter y la piedra filosofal', 15.99, 3, '1997-06-26'),
('Ficciones', 22.00, 4, '1944-06-15');

-- Insertar datos en la tabla de ventas
INSERT INTO ventas (id_libro, cantidad, fecha_venta) VALUES
(1, 3, '2023-01-15'),
(2, 5, '2023-02-20'),
(3, 2, '2023-01-18'),
(4, 10, '2023-03-25'),
(5, 1, '2023-01-10'),
(1, 4, '2023-03-05');

-- 1. Subconsulta en la cláusula WHERE Devuelve todos los libros cuyos precios estén por encima del precio promedio de los libros de la misma nacionalidad del autor.
SELECT l.titulo, l.precio, a.nacionalidad
FROM libros l
JOIN autores a ON l.id_autor = a.id_autor
WHERE l.precio > (
    SELECT AVG(l2.precio)
    FROM libros l2
    JOIN autores a2 ON l2.id_autor = a2.id_autor
    WHERE a2.nacionalidad = a.nacionalidad
);


-- 2. Subconsulta en la cláusula SELECT Muestra el título del libro, su precio, y el número total de ventas para ese libro.

SELECT l.titulo, l.precio, 
    (SELECT SUM(v.cantidad)
     FROM ventas v
     WHERE v.id_libro = l.id_libro) AS total_ventas
FROM libros l;

-- 3. Subconsulta correlacionada
-- Muestra el nombre de los autores que han publicado al menos un libro cuyo precio sea mayor que el precio promedio de todos los libros de ese mismo autor.

SELECT DISTINCT a.nombre
FROM autores a
JOIN libros l ON a.id_autor = l.id_autor
WHERE l.precio > (
    SELECT AVG(l2.precio)
    FROM libros l2
    WHERE l2.id_autor = a.id_autor
);

-- 4. Subconsulta en la cláusula FROM Muestra el nombre de los autores y el total de ventas de libros de cada autor.
SELECT a.nombre, ventas_por_autor.total_ventas
FROM autores a
JOIN (
    SELECT l.id_autor, SUM(v.cantidad) AS total_ventas
    FROM libros l
    JOIN ventas v ON l.id_libro = v.id_libro
    GROUP BY l.id_autor
) ventas_por_autor ON a.id_autor = ventas_por_autor.id_autor;

-- 5. Devuelve el título de los libros que se han vendido al menos una vez en el mes de enero.

SELECT titulo
FROM libros
WHERE id_libro IN (
    SELECT id_libro
    FROM ventas
    WHERE EXTRACT(MONTH FROM fecha_venta) = 1
);
