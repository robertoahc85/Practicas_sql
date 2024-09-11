BEGIN;

SAVEPOINT antes_transferencia;

-- Disminuir saldo en la cuenta 1
UPDATE cuentas
SET saldo = saldo - 300
WHERE cuenta_id = 1;

-- Verificar si el saldo de la cuenta 1 es negativo
-- Si es negativo, revertir al punto de guardado
SELECT CASE
    WHEN saldo < 0 THEN
        ROLLBACK TO antes_transferencia
    ELSE
        NULL
    END
FROM cuentas
WHERE cuenta_id = 1;

-- Continuar con la transferencia si no se realizó el ROLLBACK
UPDATE cuentas
SET saldo = saldo + 300
WHERE cuenta_id = 2;

-- Registrar la transacción
INSERT INTO transacciones (desde_cuenta_id, hacia_cuenta_id, monto)
VALUES (1, 2, 300);

COMMIT;