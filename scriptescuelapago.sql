-- 1. Listar todos los estudiantes
SELECT * FROM estudiante;;

-- 2. Mostrar todos los pagos con información del estudiante
SELECT p.id_pago, e.nombre, e.apellido, p.monto, p.fecha_pago, p.metodo_pago
FROM pago p
JOIN estudiante e ON p.id_estudiante = e.id_estudiante;

-- 3. Calcular el total de pagos recibidos
SELECT SUM(monto) as total_pagos FROM pago;

-- 4. Listar los cursos con su costo
SELECT * FROM curso;

-- 5. Mostrar los pagos de un estudiante específico
SELECT p.id_pago, c.nombre_curso, p.monto, p.fecha_pago
FROM pago p
JOIN curso c ON p.id_curso = c.id_curso
WHERE p.id_estudiante = 1;  -- Cambie el número para buscar otro estudiante

-- 6. Contar cuántos estudiantes hay en la base de datos
SELECT COUNT(*) as total_estudiantes FROM estudiante;

-- 7. Encontrar el pago más alto
SELECT MAX(monto) as pago_maximo FROM pago;

-- 8. Listar los estudiantes que han realizado pagos
SELECT  e.id_estudiante, e.nombre, e.apellido
FROM estudiante e
JOIN pago p ON e.id_estudiante = p.id_estudiante;

-- 9. Mostrar los pagos ordenados por fecha (del más reciente al más antiguo)
SELECT * FROM pago
ORDER BY fecha_pago DESC;

-- 10. Calcular el promedio de pagos por curso
SELECT c.nombre_curso, AVG(p.monto) as promedio_pago
FROM pago p
JOIN curso c ON p.id_curso = c.id_curso
GROUP BY c.nombre_curso;