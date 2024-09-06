-- Creación de tablas
CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    fecha_registro DATE
);

CREATE TABLE Productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    categoria VARCHAR(50)
);

CREATE TABLE Pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Clientes(id_cliente),
    fecha_pedido DATE,
    estado VARCHAR(20)
);

CREATE TABLE Detalles_Pedido (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES Pedidos(id_pedido),
    id_producto INT REFERENCES Productos(id_producto),
    cantidad INT,
    precio_unitario DECIMAL(10, 2)
);

CREATE TABLE Envios (
    id_envio SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES Pedidos(id_pedido),
    direccion_envio VARCHAR(200),
    fecha_envio DATE
);

