-- Active: 1725418236768@@127.0.0.1@5434@constructora
-- nombre_proyecto	total_presupuesto
-- Proyecto B	800,000
-- Proyecto C	600,000
-- Proyecto D	1,200,000

SELECT p.nombre_proyecto, SUM(pd.presupuesto) AS total_presupuesto
FROM proyectos p
JOIN proyecto_detalle pd ON p.id = pd.id_proyecto
GROUP BY p.nombre_proyecto
HAVING SUM(pd.presupuesto) > 50000;



SELECT 
    EXTRACT(YEAR FROM fecha_inicio) AS anio,
    EXTRACT(MONTH FROM fecha_inicio) AS mes,
    COUNT(*) AS cantidad_proyectos
FROM 
   proyecto_detalle
GROUP BY 
    EXTRACT(YEAR FROM fecha_inicio), 
    EXTRACT(MONTH FROM fecha_inicio)
ORDER BY 
    anio, mes;


SELECT p.nombre_proyecto, 
       pd.presupuesto, 
       CASE
           WHEN pd.presupuesto > 100000 THEN 'Alto'
           WHEN pd.presupuesto BETWEEN 5000 AND 100000 THEN 'Medio'
           ELSE 'Bajo'
       END AS clasificacion_presupuesto
FROM proyectos p
JOIN proyecto_detalle pd ON p.id = pd.id_proyecto;

