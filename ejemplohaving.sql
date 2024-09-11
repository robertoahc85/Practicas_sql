-- Active: 1725418236768@@127.0.0.1@5434@ejemplos
-- Crear tabla de categorías
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(50)
);

-- Crear tabla de proveedores
CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_proveedor VARCHAR(50),
    pais VARCHAR(50)
);

-- Crear tabla de productos
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10, 2),
    id_categoria INT REFERENCES categorias(id_categoria),
    id_proveedor INT REFERENCES proveedores(id_proveedor)
);

-- Crear tabla de ventas
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_producto INT REFERENCES productos(id_producto),
    cantidad INT,
    fecha_venta DATE
);

-- Insertar categorías
INSERT INTO categorias (nombre_categoria) VALUES 
('Pinturas'),
('Herramientas'),
('Accesorios');

-- Insertar proveedores
INSERT INTO proveedores (nombre_proveedor, pais) VALUES 
('Proveedor A', 'México'),
('Proveedor B', 'EE.UU.'),
('Proveedor C', 'Canadá');

-- Insertar productos
INSERT INTO productos (nombre, precio, id_categoria, id_proveedor) VALUES
('Pintura Blanca', 100.50, 1, 1),
('Pintura Roja', 120.00, 1, 2),
('Brocha', 15.00, 2, 3),
('Rodillo', 25.00, 2, 1),
('Cinta de enmascarar', 10.00, 3, 2);

-- Insertar ventas
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES
(1, 50, '2024-08-01'),
(1, 60, '2024-08-15'),
(2, 20, '2024-08-03'),
(3, 100, '2024-08-05'),
(4, 120, '2024-08-08'),
(5, 200, '2024-08-10');

-- Ejemplo 1: Productos con ventas totales superiores a 100 unidades
select  p.nombre, sum(v.cantidad) as total_vendido
from productos p
JOIN ventas v ON p.id_producto = v.id_producto
group by p.nombre
having sum(v.cantidad) > 50

-- Ejemplo 2: Categorías con ingresos superiores a $10,000
SELECT  c.nombre_categoria, sum(v.cantidad * p.precio) as ingresos_totales
FROM productos p
JOIN ventas v ON p.id_producto = v.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY  c.nombre_categoria

-- Ejemplo 3: Proveedores con más de 5 productos registrados
select pr.nombre_proveedor, count(p.id_producto) as total
from public.proveedores pr 
join productos p on pr.id_proveedor = p.id_proveedor
GROUP BY pr.nombre_proveedor
having count(p.id_producto) > 1


-- Ejemplo 4: Productos con un precio promedio de ventas superior a $50

select p.nombre,  round(avg(p.precio),3) as  total
from productos p
JOIN ventas v on p.id_producto = v.id_producto
GROUP BY p.nombre
HAVING avg(p.precio) > 50


-- ###EXtract
-- Extraer el año de las ventas
select id_venta, fecha_venta, EXTRACT(YEAR FROM fecha_venta) 
from ventas

select id_venta, fecha_venta, DATE_PART('year', fecha_venta) as year
from ventas


-- Extraer el mes de las ventas
select id_venta, fecha_venta, EXTRACT(MONTH FROM fecha_venta) 
from ventas

select id_venta, fecha_venta, DATE_PART('month', fecha_venta) as mes
from ventas


-- Ventas realizadas en un mes específico
 SELECT id_venta, fecha_venta, cantidad
 from ventas
 where EXTRACT(MONTH FROM  fecha_venta) =8

--  agrupar ventas por anio
SELECT date_part('year', fecha_venta) as anio, COUNT(*) as total_ventas
from ventas
GROUP BY date_part('year', fecha_venta)
ORDER BY anio


-- Agrupor ventas por mes
SELECT date_part('month', fecha_venta) as mes, sum(v.cantidad * p.precio) as ingresos
from ventas v
JOIN productos p on  v.id_producto = p.id_producto
GROUP BY date_part('month', fecha_venta)
ORDER BY mes

-- Ventas realizadas en un año específico

-- Número de ventas por mes


-- Ingresos mensuales


-- #ejemplo de case when

-- Clasificar ventas en categorías de cantidad (Alta, media o Baja)
SELECT id_venta, cantidad, 
    CASE
        WHEN CANTIDAD > 100 THEN 'ALTA'
        WHEN CANTIDAD BETWEEN 50 AND 100 THEN 'Media'
        ELSE 'BAJA'
    END
from ventas

-- Ejemplo 2: Asignar descuentos según el precio del producto 10% productos  caro, 5% productos medios, 1% productos barato
SELECT nombre, precio, 
    CASE 
        WHEN  precio > 100 THEN  '10%'
        WHEN precio BETWEEN 50 AND 100 THEN '5% descuento'
        ELSE ' 1%'
    END as tipo_descuento
FROM productos

-- Ejemplo 3: Clasificar ventas por estación del año Invierno (6,7,8), Primavera(9,10,11), Verano(12,1,2), otono(3,4,5)

SELECT id_venta, fecha_venta,
    CASE 
        WHEN EXTRACT(MONTH FROM fecha_venta) IN (6,7,8)  THEN  'INVIERNO' 
        WHEN EXTRACT(MONTH FROM fecha_venta) IN (9,10,11)  THEN  'PRIMAVERA' 
        WHEN EXTRACT(MONTH FROM fecha_venta) IN (12,1,2)  THEN  'VERANO' 
        ELSE 'OTONO'
    END as Estacion
FROM ventas

-- Ejemplo 4: Calcular el estado del stock de productos Poco stock <10,  stock moderado 10 a 50,  stock alto > 50

SELECT nombre, cantidad,
    CASE 
        WHEN  CANTIDAD <10 THEN 'POCO STOCK' 
        WHEN CANTIDAD  BETWEEN 10  AND 50 THEN 'STOCK MODERADO'
        ELSE 'STOCK ALTO'
    END as estado_stock
from productos
