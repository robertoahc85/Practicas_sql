-- Crear tabla ESTUDIANTE
CREATE TABLE estudiante (
    id_estudiante SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

-- Crear tabla CURSO
CREATE TABLE curso (
    id_curso SERIAL PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL,
    costo DECIMAL(10, 2) NOT NULL
);

-- Crear tabla PAGO
CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    id_curso INTEGER NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

-- Insertar algunos datos de ejemplo
INSERT INTO estudiante (nombre, apellido, fecha_nacimiento) VALUES
('Juan', 'Pérez', '2000-05-15'),
('María', 'González', '2001-08-22');

INSERT INTO curso (nombre_curso, costo) VALUES
('Matemáticas', 500.00),
('Historia', 450.00);

INSERT INTO pago (id_estudiante, id_curso, monto, fecha_pago, metodo_pago) VALUES
(1, 1, 500.00, '2024-09-01', 'Tarjeta de crédito'),
(2, 2, 450.00, '2024-09-02', 'Transferencia bancaria');