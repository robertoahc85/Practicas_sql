-- Ejercicios de consultas JOIN sencillas

-- Ejercicio 1: Listar todas las órdenes con información de la mesa
-- Esta consulta une las tablas Ordenes y Mesas
SELECT 
    o.id_orden,
    o.fecha_hora,
    m.numero_mesa,
    m.capacidad
FROM 
    Ordenes o
    JOIN Mesas m ON o.id_mesa = m.id_mesa
ORDER BY 
    o.fecha_hora DESC;

-- Ejercicio 2: Mostrar los detalles de los platos en cada orden
-- Esta consulta une las tablas Ordenes, Detalles_Orden y Platos
SELECT 
    o.id_orden,
    p.nombre AS nombre_plato,
    do.cantidad,
    do.precio_unitario
FROM 
    Ordenes o
    JOIN Detalles_Orden do ON o.id_orden = do.id_orden
    JOIN Platos p ON do.id_plato = p.id_plato
ORDER BY 
    o.id_orden, p.nombre;

-- Ejercicio 3: Calcular el total de cada orden
-- Esta consulta usa un JOIN y una función de agregación
SELECT 
    o.id_orden,
    o.fecha_hora,
    SUM(do.cantidad * do.precio_unitario) AS total_orden
FROM 
    Ordenes o
    JOIN Detalles_Orden do ON o.id_orden = do.id_orden
GROUP BY 
    o.id_orden, o.fecha_hora
ORDER BY 
    o.fecha_hora DESC;

-- Ejercicio 4: Encontrar los platos más populares
-- Esta consulta usa JOINs y cuenta la frecuencia de cada plato
SELECT 
    p.nombre AS nombre_plato,
    COUNT(do.id_detalle) AS veces_ordenado
FROM 
    Platos p
    JOIN Detalles_Orden do ON p.id_plato = do.id_plato
GROUP BY 
    p.id_plato, p.nombre
ORDER BY 
    veces_ordenado DESC
LIMIT 5;

-- Ejercicio 5: Listar las mesas que no tienen órdenes
-- Esta consulta usa un LEFT JOIN para encontrar mesas sin órdenes
SELECT 
    m.numero_mesa,
    m.capacidad
FROM 
    Mesas m
    LEFT JOIN Ordenes o ON m.id_mesa = o.id_mesa
WHERE 
    o.id_orden IS NULL;

-- Consulta que une tres tablas y utiliza GROUP BY

-- Esta consulta une las tablas Ordenes, Detalles_Orden y Platos
-- para mostrar un resumen de ventas por categoría de plato y día

SELECT 
    DATE(o.fecha_hora) AS fecha,
    p.categoria AS categoria_plato,
    COUNT(DISTINCT o.id_orden) AS numero_ordenes,
    SUM(do.cantidad) AS total_platos_vendidos,
    SUM(do.cantidad * do.precio_unitario) AS ingresos_totales,
    ROUND(AVG(do.precio_unitario), 2) AS precio_promedio
FROM 
    Ordenes o
    JOIN Detalles_Orden do ON o.id_orden = do.id_orden
    JOIN Platos p ON do.id_plato = p.id_plato
WHERE 
    o.fecha_hora >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY 
    DATE(o.fecha_hora),
    p.categoria
ORDER BY 
    fecha DESC,
    ingresos_totales DESC;    