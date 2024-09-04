-- Active: 1725418236768@@127.0.0.1@5434@Tienda

CREATE TABLE categoria
(
  id      NOT NULL,
  nombre ,
  PRIMARY KEY (id)
);

CREATE TABLE Productos
(
  id              NOT NULL,
  name           ,
  fk_producto     NOT NULL,
  fk_proveedores  NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE proveedores
(
  id   ,
  name ,
        NOT NULL,
  PRIMARY KEY ()
);

CREATE TABLE Ventas
(
  id     NOT NULL,
  fecha ,
  id     NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE Productos
  ADD CONSTRAINT FK_categoria_TO_Productos
    FOREIGN KEY (fk_producto)
    REFERENCES categoria (id);

ALTER TABLE Productos
  ADD CONSTRAINT FK_proveedores_TO_Productos
    FOREIGN KEY (fk_proveedores)
    REFERENCES proveedores ();

ALTER TABLE Ventas
  ADD CONSTRAINT FK_Productos_TO_Ventas
    FOREIGN KEY (id)
    REFERENCES Productos (id);

CREATE INDEX pk_producto
  ON Productos (id ASC);