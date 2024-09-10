-- Crear tabla de categorías
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(50)
);

-- Crear tabla de proveedores
CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_proveedor VARCHAR(50),
    pais VARCHAR(50)
);

-- Crear tabla de productos
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10, 2),
    id_categoria INT REFERENCES categorias(id_categoria),
    id_proveedor INT REFERENCES proveedores(id_proveedor)
);

-- Crear tabla de ventas
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_producto INT REFERENCES productos(id_producto),
    cantidad INT,
    fecha_venta DATE
);

-- Insertar categorías
INSERT INTO categorias (nombre_categoria) VALUES 
('Pinturas'),
('Herramientas'),
('Accesorios');

-- Insertar proveedores
INSERT INTO proveedores (nombre_proveedor, pais) VALUES 
('Proveedor A', 'México'),
('Proveedor B', 'EE.UU.'),
('Proveedor C', 'Canadá');

-- Insertar productos
INSERT INTO productos (nombre, precio, id_categoria, id_proveedor) VALUES
('Pintura Blanca', 100.50, 1, 1),
('Pintura Roja', 120.00, 1, 2),
('Brocha', 15.00, 2, 3),
('Rodillo', 25.00, 2, 1),
('Cinta de enmascarar', 10.00, 3, 2);

-- Insertar ventas
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES
(1, 50, '2024-08-01'),
(1, 60, '2024-08-15'),
(2, 20, '2024-08-03'),
(3, 100, '2024-08-05'),
(4, 120, '2024-08-08'),
(5, 200, '2024-08-10');

-- Ejemplo 1: Productos con ventas totales superiores a 100 unidades

-- Ejemplo 2: Categorías con ingresos superiores a $10,000

-- Ejemplo 3: Proveedores con más de 5 productos registrados

-- Ejemplo 4: Productos con un precio promedio de ventas superior a $50

-- ###EXtract
-- Extraer el año de las ventas

-- Extraer el mes de las ventas

-- Ventas realizadas en un mes específico

-- Ventas realizadas en un año específico

-- Número de ventas por mes


-- Ingresos mensuales


-- #ejemplo de case when

Clasificar ventas en categorías de cantidad

Ejemplo 2: Asignar descuentos según el precio del producto

Ejemplo 3: Clasificar ventas por estación del año

Ejemplo 4: Calcular el estado del stock de productos