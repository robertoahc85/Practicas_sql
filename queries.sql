-- Active: 1725418236768@@127.0.0.1@5434@tienda2
/*Obtener  la informacion de todos lo movimiento de de stock  , con el nombre del pruducto asociado:*/
select  productos.nombre, movimiento_stock.tipo_moviento as Movimiento, movimiento_stock.cantidad
from movimiento_stock   join productos   on productos.id = movimiento_stock.product_id

/* Obtener los movimiento de stock contenga la palabra entrada */
Select *
from movimiento_stock
where tipo_moviento LIKE '%entrada%'

--  Actualizar  el stock de un producto aumentado 50

UPDATE  productos
set stock= stock + 50
WHERE id =1

-- Obtener la cantida total de movimientos de stock por tipo de movimiento

SELECT tipo_moviento, sum(cantidad) as Total
FROM movimiento_stock
GROUP BY tipo_moviento

-- calcular promedio de los precios de todos los productos
SELECT AVG(precio) as precio_promedio
FROM "prueba 1"

-- calcular  precio mas bajo y mas  alto de los productos

SELECT MIN(precios) as precio_minimo, MAX(precios) as precio_maximo
FROM productos

CREATE TABLE IF NOT EXISTS "prueba 1"
(
    id integer NOT NULL,
    precio float,
    PRIMARY KEY (id)
);