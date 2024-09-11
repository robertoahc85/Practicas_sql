-- 1. Iniciar una transacción
BEGIN;

-- 2. Crear un savepoint antes de intentar realizar el pedido
SAVEPOINT before_order;

-- 3. Verificar la disponibilidad del Producto X
-- Verificar si hay suficiente stock para Producto X
UPDATE productos
SET cantidad = cantidad - 20
WHERE producto_id = 1 AND cantidad >= 20;

-- Verificar si la actualización fue exitosa
IF NOT FOUND THEN
    -- 6. Revertir a la savepoint si no hay suficiente stock
    ROLLBACK TO before_order;
    RAISE NOTICE 'No hay suficiente stock para Producto X. Transacción revertida.';
END IF;

-- 4. Verificar la disponibilidad del Producto Y
-- Verificar si hay suficiente stock para Producto Y
UPDATE productos
SET cantidad = cantidad - 10
WHERE producto_id = 2 AND cantidad >= 10;

-- Verificar si la actualización fue exitosa
IF NOT FOUND THEN
    -- 6. Revertir a la savepoint si no hay suficiente stock
    ROLLBACK TO before_order;
    RAISE NOTICE 'No hay suficiente stock para Producto Y. Transacción revertida.';
END IF;

-- 5. Registrar los pedidos si hay suficiente stock
INSERT INTO pedidos (producto_id, cantidad) VALUES (1, 20);
INSERT INTO pedidos (producto_id, cantidad) VALUES (2, 10);

-- 7. Confirmar la transacción
COMMIT;
