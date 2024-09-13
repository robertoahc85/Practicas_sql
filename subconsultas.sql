-- Active: 1725418236768@@127.0.0.1@5434@ejemplos_subconsultas
CREATE DATABASE empresa;


CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    departamento VARCHAR(100),
    salario DECIMAL(10, 2)
);

INSERT INTO empleados (nombre, departamento, salario) VALUES
('Ana', 'Ventas', 3000),
('Carlos', 'Ventas', 3500),
('Luis', 'Marketing', 4000),
('Marta', 'Ventas', 2800),
('Pedro', 'Recursos Humanos', 2500),
('Sofía', 'Marketing', 4500),
('Juan', 'Recursos Humanos', 3200);

CREATE TABLE proyectos (
    id SERIAL PRIMARY KEY,
    nombre_proyecto VARCHAR(100),
    departamento VARCHAR(100)
);

INSERT INTO proyectos (nombre_proyecto, departamento) VALUES
('Proyecto A', 'Ventas'),
('Proyecto B', 'Marketing'),
('Proyecto C', 'Recursos Humanos');

-- #Tabla departamento
CREATE TABLE departamentos (
    id_departamento SERIAL PRIMARY KEY,
    nombre_departamento VARCHAR(100) NOT NULL
);
INSERT INTO departamentos (nombre_departamento) VALUES
('Ventas'),
('Marketing'),
('Recursos Humanos'),
('IT');
ALTER TABLE empleados
ADD COLUMN id_departamento INT,
ADD CONSTRAINT fk_departamento
    FOREIGN KEY (id_departamento)
    REFERENCES departamentos(id_departamento);
UPDATE empleados SET id_departamento = 1 WHERE departamento = 'Ventas';
UPDATE empleados SET id_departamento = 2 WHERE departamento = 'Marketing';
UPDATE empleados SET id_departamento = 3 WHERE departamento = 'Recursos Humanos';

ALTER TABLE empleados DROP COLUMN departamento;





-- Reportes

-- 1. Encuentra los empleados que tiene el salario mas alto de la empresa
select nombre, salario
FROM empleados
where salario = (SELECT MAX(salario) from empleados)

-- SELECT nombre, salario
-- FROM empleados
-- ORDER BY salario DESC
-- LIMIT 1

-- 2. Encontrar los empleados que ganan mas que el salario promedio de la empresa
SELECT nombre, salario
from empleados
where salario > (select avg(salario) from empleados)

-- 3.  Encontrar los nombre de los departamentos donde el salario  promedio de los empleados sea superior a  3000
select nombre_departamento
from departamentos
where id_departamento IN(select id_departamento from empleados group by id_departamento
HAVING avg(salario) >3000)

-- 4. Contar cuantos empleados hay cada departamentos

SELECT nombre_departamento,(SELECT count(*) from empleados where empleados.id_departamento = departamentos.id_departamento) as total_empleados
from departamentos

SELECT nombre_departamento, COUNT(*) AS cantidad_empleados
FROM departamentos
JOIN empleados ON departamentos.id_departamento = empleados.id_departamento
GROUP BY nombre_departamento




