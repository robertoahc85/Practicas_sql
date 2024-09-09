-- Active: 1725418236768@@127.0.0.1@5434@tienda3b


  4  CREATE TABLE IF NOT EXISTS public.clientes
  5  (
  6      id_cliente serial NOT NULL,
  7      nombre_cliente text NOT NULL,
  8      direccion_cliente text NOT NULL,
  9      PRIMARY KEY (cliente_id)
  10  );
  11
  12  CREATE TABLE IF NOT EXISTS public.ventas
  13  (
  14      id_venta serial NOT NULL,
  15      id_cliente "char" NOT NULL,
  16      fecha_venta date NOT NULL,
  17      id_prod_vta "char" NOT NULL,
  18      PRIMARY KEY (id_venta)
  19  );
  20
  21  CREATE TABLE IF NOT EXISTS public.compras
  22  (
  23      id_compra serial NOT NULL,
  24      id_cliente "char" NOT NULL,
  25      fecha_compra date NOT NULL,
  26      id_prod_comp "char" NOT NULL,
  27      PRIMARY KEY (id_compra)
  28  );
  29
  30  CREATE TABLE IF NOT EXISTS public.productos_venta
  31  (
  32      id_prod_vtas serial NOT NULL,
  33      nombre_producto text NOT NULL,
  34      precio_venta money NOT NULL,
  35      PRIMARY KEY (id_prod_vtas)
  36  );
  37
  38  CREATE TABLE IF NOT EXISTS public.productos_compra
  39  (
  40      id_prod_comp serial NOT NULL,
  41      nombre_producto text NOT NULL,
  42      precio_compra money NOT NULL,
  43      PRIMARY KEY (id_prod_comp)
  44  );
  45
  46  CREATE TABLE IF NOT EXISTS public.reportes
  47  (
  48      id_transaccion serial NOT NULL,
  49      id_cliente "char" NOT NULL,
  50      id_venta "char",
  51      id_compra "char",
  52      PRIMARY KEY (id_transaccion)
  53  );
  54
  55  CREATE TABLE IF NOT EXISTS public.reportes_compras
  56  (
  57      reportes_id_compra "char",
  58      compras_id_compra serial NOT NULL
  59  );
  60
  61  ALTER TABLE IF EXISTS public.ventas
  62      ADD FOREIGN KEY (id_cliente)
  63      REFERENCES public.clientes (id_cliente) MATCH SIMPLE
  64      ON UPDATE NO ACTION
  65      ON DELETE NO ACTION
  66      NOT VALID;
  67
  68
  69  ALTER TABLE IF EXISTS public.ventas
  70      ADD FOREIGN KEY (id_prod_vta)
  71      REFERENCES public.productos_venta (id_prod_vtas) MATCH SIMPLE
  72      ON UPDATE NO ACTION
  73      ON DELETE NO ACTION
  74      NOT VALID;
  75
  76
  77  ALTER TABLE IF EXISTS public.compras
  78      ADD FOREIGN KEY (id_cliente)
  79      REFERENCES public.clientes (id_cliente) MATCH SIMPLE
  80      ON UPDATE NO ACTION
  81      ON DELETE NO ACTION
  82      NOT VALID;
  83
  84
  85  ALTER TABLE IF EXISTS public.compras
  86      ADD FOREIGN KEY (id_prod_comp)
  87      REFERENCES public.productos_compra (id_prod_comp) MATCH SIMPLE
  88      ON UPDATE NO ACTION
  89      ON DELETE NO ACTION
  90      NOT VALID;
  91
  92
  93  ALTER TABLE IF EXISTS public.reportes
  94      ADD FOREIGN KEY (id_cliente)
  95      REFERENCES public.clientes (id_cliente) MATCH SIMPLE
  96      ON UPDATE NO ACTION
  97      ON DELETE NO ACTION
  98      NOT VALID;
  99
  100
  101  ALTER TABLE IF EXISTS public.reportes
  102      ADD FOREIGN KEY (id_venta)
  103      REFERENCES public.ventas (id_venta) MATCH SIMPLE
  104      ON UPDATE NO ACTION
  105      ON DELETE NO ACTION
  106      NOT VALID;
  107
  108
  109  ALTER TABLE IF EXISTS public.reportes
  110      ADD FOREIGN KEY (id_compra)
  111      REFERENCES public.compras (id_compra) MATCH SIMPLE
  112      ON UPDATE NO ACTION
  113      ON DELETE NO ACTION
  114      NOT VALID;
end