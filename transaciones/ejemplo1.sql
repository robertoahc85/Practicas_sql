-- Active: 1725418236768@@127.0.0.1@5434@transacion_ejemplo
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    salario DECIMAL(10, 2)
);

-- Tabla de productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2)
);

-- Insertar empleados
INSERT INTO empleados (nombre, salario) VALUES
('Juan', 3000),
('Ana', 3500),
('Carlos', 4000);

-- Insertar productos
INSERT INTO productos (nombre, precio) VALUES
('Producto A', 100),
('Producto B', 150),
('Producto C', 200);


-- Ejemplo 1: Transacción con ROLLBACK
BEGIN;


INSERT INTO empleados (nombre, salario) VALUES ('Maria', 3800); --- Inserción de un nuevo empleado


UPDATE empleados SET salario = 4500 WHERE nombre = 'Carlos';-- Actualización del salario de Carlos


ROLLBACK;   -- Decides deshacer la transacción

------------- Ejemplo 2: Transacción con SAVEPOINT

BEGIN;

INSERT INTO productos (nombre, precio) VALUES ('Producto H', 250);

SAVEPOINT sp1; -- Crear un punto de guardado

UPDATE productos SET precio = 300 WHERE nombre = 'Producto B';-- Actualización del precio de un producto

ROLLBACK TO SAVEPOINT sp1;  -- Se deshace la actualización, pero no la inserción

COMMIT;-- Finalizas la transacción con los cambios restantes





--------Ejemplo 3: Transacción con error y ROLLBACK
BEGIN;


INSERT INTO empleados (nombre, salario) VALUES ('Luis', 3200);-- Inserción correcta


INSERT INTO empleados (nombre, salario) VALUES ('Pedro', -5000);-- Intento de inserción incorrecta (el salario es negativo, lo cual no tiene sentido)


ROLLBACK; -- Se produce un error aquí, así que se deshace todo


-- 4.....Uso avanzado de SAVEPOINT con múltiples puntos de guardado

BEGIN;

INSERT INTO empleados (nombre, salario) VALUES ('Roberto', 4300);-- Inserción de un empleado

SAVEPOINT sp1; -- Crear un punto de guardado


UPDATE productos SET precio = 180 WHERE nombre = 'Producto A'; -- Intento de actualizar un producto


SAVEPOINT sp2; -- Crear un segundo punto de guardado

UPDATE productos SET precio = 250 WHERE nombre = 'Producto X'; -- Intento de actualizar un producto inexistente, causando un error

-- Volvemos al punto de guardado anterior a la actualización incorrecta
ROLLBACK TO SAVEPOINT sp2;  -- Solo se deshace la actualización incorrecta

-- Eliminar un producto (una operación válida)
DELETE FROM productos WHERE nombre = 'Producto B';

-- Finalizamos la transacción con los cambios restantes
COMMIT;
