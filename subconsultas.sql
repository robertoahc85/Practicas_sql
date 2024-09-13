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

