-- Iniciar la transacción
BEGIN;

-- Crear un savepoint inicial
SAVEPOINT inicio_transferencia;

-- Intentar realizar la transferencia

-- Debitar 300 unidades de la cuenta de Ana
UPDATE cuentas
SET saldo = saldo - 300
WHERE cuenta_id = 1;

-- Crear un savepoint antes de la segunda operación
SAVEPOINT antes_registro_transaccion;

-- Acreditar 300 unidades a la cuenta de Carlos
UPDATE cuentas
SET saldo = saldo + 300
WHERE cuenta_id = 2;

-- Registrar la transacción en la tabla de transacciones
INSERT INTO transacciones (desde_cuenta_id, hacia_cuenta_id, monto)
VALUES (1, 2, 300);

-- Comprobar si todas las operaciones se realizaron correctamente
-- Si todo está bien, confirmar la transacción
COMMIT;

-- En caso de error, revertir a la savepoint
-- ROLLBACK TO SAVEPOINT antes_registro_transaccion;

-- En caso de que ocurra un error durante el proceso de debitar o acreditar
-- (esto es opcional y depende del manejo de errores en el cliente o la aplicación)
-- ROLLBACK TO SAVEPOINT inicio_transferencia;

-- Finalmente, confirmar todos los cambios si todo ha ido bien
-- COMMIT;








-- Iniciar la transacción
BEGIN;

-- Crear un savepoint inicial
SAVEPOINT inicio_pedido;

-- Verificar la disponibilidad del Producto X
-- Si no hay suficiente stock, revertir a la savepoint
UPDATE productos
SET cantidad = cantidad - 20
WHERE producto_id = 1 AND cantidad >= 20;

-- Si la actualización del Producto X fue exitosa
-- Crear un savepoint antes de actualizar el segundo producto
SAVEPOINT antes_actualizacion_producto_y;

-- Verificar la disponibilidad del Producto Y
-- Si no hay suficiente stock, revertir a la savepoint antes de la actualización
UPDATE productos
SET cantidad = cantidad - 10
WHERE producto_id = 2 AND cantidad >= 10;

-- Si la actualización del Producto Y fue exitosa
-- Registrar el pedido en la tabla de pedidos
INSERT INTO pedidos (producto_id, cantidad)
VALUES (1, 20), (2, 10);

-- Confirmar la transacción si todo salió bien
COMMIT;

-- Si ocurre un error en la actualización del Producto X
-- Revertir a la savepoint
-- ROLLBACK TO SAVEPOINT inicio_pedido;

-- Si ocurre un error en la actualización del Producto Y
-- Revertir a la savepoint antes de la actualización del Producto Y
-- ROLLBACK TO SAVEPOINT antes_actualizacion_producto_y;

-- Finalmente, si la transacción es abortada en cualquier punto, liberar todos los cambios
-- ROLLBACK;
