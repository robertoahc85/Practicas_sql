-- Creación de tablas para un restaurante

CREATE TABLE Platos (
    id_plato SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50)
);

CREATE TABLE Mesas (
    id_mesa SERIAL PRIMARY KEY,
    numero_mesa INT NOT NULL,
    capacidad INT NOT NULL
);

CREATE TABLE Ordenes (
    id_orden SERIAL PRIMARY KEY,
    id_mesa INT REFERENCES Mesas(id_mesa),
    fecha_hora TIMESTAMP NOT NULL,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE Detalles_Orden (
    id_detalle SERIAL PRIMARY KEY,
    id_orden INT REFERENCES Ordenes(id_orden),
    id_plato INT REFERENCES Platos(id_plato),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
);

-- Inserción de datos de ejemplo

INSERT INTO Platos (nombre, descripcion, precio, categoria) VALUES
('Pasta Carbonara', 'Pasta con salsa cremosa y panceta', 12.99, 'Pasta'),
('Pizza Margherita', 'Pizza clásica con tomate y mozzarella', 10.99, 'Pizza'),
('Ensalada César', 'Lechuga romana con aderezo César y crutones', 8.99, 'Ensaladas'),
('Tiramisú', 'Postre italiano de café', 6.99, 'Postres');

INSERT INTO Mesas (numero_mesa, capacidad) VALUES
(1, 2), (2, 4), (3, 6), (4, 4);

INSERT INTO Ordenes (id_mesa, fecha_hora, estado) VALUES
(1, '2024-03-01 18:30:00', 'Completada'),
(2, '2024-03-01 19:00:00', 'En proceso'),
(3, '2024-03-01 19:15:00', 'Pendiente');

INSERT INTO Detalles_Orden (id_orden, id_plato, cantidad, precio_unitario) VALUES
(1, 1, 2, 12.99),
(1, 3, 1, 8.99),
(2, 2, 1, 10.99),
(2, 4, 2, 6.99),
(3, 1, 1, 12.99),
(3, 2, 1, 10.99);

-- Consulta con INNER JOIN de tres tablas

SELECT 
    o.id_orden,
    m.numero_mesa,
    p.nombre AS nombre_plato,
    do.cantidad,
    do.precio_unitario,
    (do.cantidad * do.precio_unitario) AS subtotal
FROM 
    Ordenes o
    INNER JOIN Mesas m ON o.id_mesa = m.id_mesa
    INNER JOIN Detalles_Orden do ON o.id_orden = do.id_orden
    INNER JOIN Platos p ON do.id_plato = p.id_plato
ORDER BY 
    o.id_orden, p.nombre;
