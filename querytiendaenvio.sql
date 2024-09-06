-- Inserción de datos de ejemplo (omitido por brevedad)

-- Consultas de ejemplo

-- 1. Uso de GROUP BY y HAVING: 
-- Encontrar clientes que han realizado más de 3 pedidos
SELECT c.nombre, COUNT(p.id_pedido) as total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(p.id_pedido) > 3;

-- 2. Uso de condicionales (CASE) y GROUP BY:
-- Clasificar productos por rango de precios
SELECT 
    categoria,
    COUNT(*) as total_productos,
    CASE 
        WHEN precio < 50 THEN 'Económico'
        WHEN precio BETWEEN 50 AND 100 THEN 'Medio'
        ELSE 'Premium'
    END AS rango_precio
FROM Productos
GROUP BY categoria, rango_precio
ORDER BY categoria, rango_precio;

-- 3. Uso de subconsultas, GROUP BY y HAVING:
-- Encontrar productos que se han vendido más de 100 unidades en total
SELECT p.nombre, SUM(dp.cantidad) as total_vendido
FROM Productos p
JOIN Detalles_Pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
HAVING SUM(dp.cantidad) > 100;

-- 4. Uso de JOIN múltiple, GROUP BY y condicionales:
-- Resumen de ventas por categoría de producto y estado del pedido
SELECT 
    p.categoria,
    pe.estado,
    COUNT(dp.id_detalle) as total_ventas,
    SUM(dp.cantidad * dp.precio_unitario) as total_ingresos
FROM Productos p
JOIN Detalles_Pedido dp ON p.id_producto = dp.id_producto
JOIN Pedidos pe ON dp.id_pedido = pe.id_pedido
WHERE pe.fecha_pedido >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY p.categoria, pe.estado
ORDER BY p.categoria, total_ingresos DESC;

-- 5. Uso de LEFT JOIN, GROUP BY y HAVING:
-- Encontrar clientes que han realizado pedidos pero no han recibido envíos
SELECT c.nombre, COUNT(p.id_pedido) as pedidos_sin_envio
FROM Clientes c
LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente
LEFT JOIN Envios e ON p.id_pedido = e.id_pedido
WHERE e.id_envio IS NULL
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(p.id_pedido) > 0
ORDER BY pedidos_sin_envio DESC;

-- Ejemplos de JOINs con tres o cuatro tablas

-- 1. JOIN de tres tablas: Clientes, Pedidos y Detalles_Pedido
-- Obtener un resumen de los pedidos de cada cliente con el total gastado
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    p.id_pedido,
    p.fecha_pedido,
    SUM(dp.cantidad * dp.precio_unitario) AS total_pedido
FROM 
    Clientes c
    JOIN Pedidos p ON c.id_cliente = p.id_cliente
    JOIN Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY 
    c.id_cliente, c.nombre, p.id_pedido, p.fecha_pedido
ORDER BY 
    c.id_cliente, p.fecha_pedido;

-- 2. JOIN de cuatro tablas: Clientes, Pedidos, Detalles_Pedido y Productos
-- Listar los productos comprados por cada cliente
SELECT 
    c.nombre AS nombre_cliente,
    p.nombre AS nombre_producto,
    SUM(dp.cantidad) AS cantidad_total,
    SUM(dp.cantidad * dp.precio_unitario) AS total_gastado
FROM 
    Clientes c
    JOIN Pedidos pe ON c.id_cliente = pe.id_cliente
    JOIN Detalles_Pedido dp ON pe.id_pedido = dp.id_pedido
    JOIN Productos p ON dp.id_producto = p.id_producto
GROUP BY 
    c.id_cliente, c.nombre, p.id_producto, p.nombre
ORDER BY 
    c.nombre, total_gastado DESC;

-- 3. JOIN de cuatro tablas con subconsulta: Clientes, Pedidos, Detalles_Pedido y Envios
-- Encontrar los clientes con pedidos pendientes de envío
SELECT DISTINCT
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    p.id_pedido,
    p.fecha_pedido
FROM 
    Clientes c
    JOIN Pedidos p ON c.id_cliente = p.id_cliente
    JOIN Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
    LEFT JOIN Envios e ON p.id_pedido = e.id_pedido
WHERE 
    e.id_envio IS NULL
    AND p.id_pedido IN (
        SELECT id_pedido 
        FROM Detalles_Pedido 
        GROUP BY id_pedido 
        HAVING SUM(cantidad * precio_unitario) > 100
    )
ORDER BY 
    p.fecha_pedido;

-- 4. JOIN de tres tablas con ventana deslizante: Clientes, Pedidos y Detalles_Pedido
-- Calcular el total acumulado de compras por cliente a lo largo del tiempo
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    p.fecha_pedido,
    SUM(dp.cantidad * dp.precio_unitario) AS total_pedido,
    SUM(SUM(dp.cantidad * dp.precio_unitario)) OVER (
        PARTITION BY c.id_cliente 
        ORDER BY p.fecha_pedido
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_acumulado
FROM 
    Clientes c
    JOIN Pedidos p ON c.id_cliente = p.id_cliente
    JOIN Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY 
    c.id_cliente, c.nombre, p.id_pedido, p.fecha_pedido
ORDER BY 
    c.id_cliente, p.fecha_pedido;