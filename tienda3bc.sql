CREATE TABLE IF NOT EXISTS public.clientes
(
    id_cliente serial NOT NULL,
    nombre_cliente text NOT NULL,
    direccion_cliente text NOT NULL,
    PRIMARY KEY (cliente_id)
);

CREATE TABLE IF NOT EXISTS public.ventas
(
    id_venta serial NOT NULL,
    id_cliente "char" NOT NULL,
    fecha_venta date NOT NULL,
    id_prod_vta "char" NOT NULL,
    PRIMARY KEY (id_venta)
);

CREATE TABLE IF NOT EXISTS public.compras
(
    id_compra serial NOT NULL,
    id_cliente "char" NOT NULL,
    fecha_compra date NOT NULL,
    id_prod_comp "char" NOT NULL,
    PRIMARY KEY (id_compra)
);

CREATE TABLE IF NOT EXISTS public.productos_venta
(
    id_prod_vtas serial NOT NULL,
    nombre_producto text NOT NULL,
    precio_venta money NOT NULL,
    PRIMARY KEY (id_prod_vtas)
);

CREATE TABLE IF NOT EXISTS public.productos_compra
(
    id_prod_comp serial NOT NULL,
    nombre_producto text NOT NULL,
    precio_compra money NOT NULL,
    PRIMARY KEY (id_prod_comp)
);

CREATE TABLE IF NOT EXISTS public.reportes
(
    id_transaccion INTEGER NOT NULL auto_increment,
    id_cliente "char" NOT NULL,
    id_venta "char",
    id_compra "char",
    PRIMARY KEY (id_transaccion)
);

CREATE TABLE IF NOT EXISTS public.reportes_compras
(
    reportes_id_compra "char",
    compras_id_compra serial NOT NULL
);

ALTER TABLE IF EXISTS public.ventas
    ADD FOREIGN KEY (id_cliente)
    REFERENCES public.clientes (id_cliente) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.ventas
    ADD FOREIGN KEY (id_prod_vta)
    REFERENCES public.productos_venta (id_prod_vtas) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.compras
    ADD FOREIGN KEY (id_cliente)
    REFERENCES public.clientes (id_cliente) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.compras
    ADD FOREIGN KEY (id_prod_comp)
    REFERENCES public.productos_compra (id_prod_comp) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reportes
    ADD FOREIGN KEY (id_cliente)
    REFERENCES public.clientes (id_cliente) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reportes
    ADD FOREIGN KEY (id_venta)
    REFERENCES public.ventas (id_venta) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reportes
    ADD FOREIGN KEY (id_compra)
    REFERENCES public.compras (id_compra) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
