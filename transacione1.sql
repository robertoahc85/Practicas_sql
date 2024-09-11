BEGIN;
-- 2. Crear un savepoint antes de realizar tranferencia
SAVEPOINT tranfer_savepoint;

-- 3. Retirar 300 pesos a la cuenta de ana
UPDATE cuentas
SET SALDO = SALDO -300
WHERE cuenta_id =1 ;
-- 4. Abonar 300 pesos a  la cuenta de carlos carlos 
UPDATE cuentas
SET saldo = saldo + 300
WHERE cuenta_id =2;

-- 5. Regitrar  las transacciones en la tabla transaciones
INSERT INTO transacciones(desde_cuenta_id,hacia_cuenta_id, monto)
VALUES(1,2,300);

ROLLBACK TO tranfer_savepoint;

COMMIT;
END





