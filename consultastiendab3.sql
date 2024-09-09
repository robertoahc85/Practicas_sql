-- Reporte de Ventas por Cliente
SELECT
    c.nombre AS cliente,
    c.ap_paterno AS apellido,
    COUNT(t.id) AS numero_ventas,
    CONCAT('$', SUM(t.precio * t.cantidad))  AS total_ventas, tt.nombre
FROM
  transaciones t
JOIN
    clientes c ON t.id_cliente = c.id
JOIN
   tipo_transaciones tt ON t.id_tipo_transacion = tt.id
WHERE
    tt.id = 2 
GROUP BY
    c.nombre,
    c.ap_paterno
    tt.nombre
ORDER BY
    c.nombre DESC;

-- Reporte de Ventas por Producto
SELECT 
    p.nombre AS producto,
    COUNT(t.id) AS Unidades_Vendidas,
     CONCAT('$', SUM(t.precio * t.cantidad)) AS ingreso_total
FROM 
    transaciones t
JOIN 
    productos p ON t.id_producto = p.id
WHERE 
     t.id_tipo_transacion IN(4,2,27)  
GROUP BY    
    p.nombre
ORDER BY 
    ingreso_total DESC;

-- Reporte de Ventas por Producto
SELECT 
    p.nombre AS producto,
    COUNT(t.id) AS Unidades_Vendidas,
     CONCAT('$', SUM(t.precio * t.cantidad)) AS ingreso_total,
     tt.nombre
FROM 
    transaciones t
JOIN 
    productos p ON t.id_producto = p.id
JOIN
   tipo_transaciones tt ON t.id_tipo_transacion = tt.id    
WHERE 
    --  t.id_tipo_transacion IN(4,2,27)  
    tt.nombre LIKE '%Venta%'
GROUP BY    
    p.nombre,
    tt.nombre
ORDER BY 
    ingreso_total DESC;