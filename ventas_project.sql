CREATE DATABASE ventas_project;

-- DDL: creación de tablas

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    edad SMALLINT NOT NULL CHECK (edad BETWEEN 18 AND 120),
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    categoria VARCHAR(80) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INTEGER NOT NULL CHECK (stock >= 0)
);

-- Esta tabla se crea después de clientes y productos
CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    fecha_venta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),

    CONSTRAINT fk_ventas_clientes
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id),

    CONSTRAINT fk_ventas_productos
        FOREIGN KEY (producto_id)
        REFERENCES productos(producto_id)
);

-- DML: carga inicial dentro de una transacción explícita
BEGIN;

INSERT INTO clientes (nombre, email, edad, fecha_registro) VALUES
('Ana García', 'ana.garcia@email.com', 28, '2026-08-01'),
('Bruno López', 'bruno.lopez@email.com', 35, '2026-08-05'),
('Carla Fernández', 'carla.fernandez@email.com', 22, '2026-08-10'),
('Diego Martínez', 'diego.martinez@email.com', 41, '2026-08-15'),
('Elena Ruiz', 'elena.ruiz@email.com', 30, '2026-08-20');

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Notebook Pro', 'Tecnologia', 1200.00, 15),
('Mouse inalámbrico', 'Tecnologia', 25.50, 80),
('Silla ergonómica', 'Oficina', 350.00, 12),
('Cuaderno A4', 'Libreria', 4.75, 200),
('Botella térmica', 'Hogar', 32.00, 50);

INSERT INTO ventas (cliente_id, producto_id, fecha_venta, cantidad, precio_unitario) VALUES
(1, 1, '2026-08-21 10:30:00', 1, 1200.00),
(2, 2, '2026-08-22 11:00:00', 2, 25.50),
(3, 3, '2026-08-23 14:15:00', 1, 350.00),
(4, 4, '2026-08-24 09:45:00', 5, 4.75),
(5, 5, '2026-08-25 16:20:00', 1, 32.00);

COMMIT;

-- Verificación previa y actualización masiva de precios
SELECT producto_id, nombre, categoria, precio
FROM productos
WHERE categoria = 'Tecnologia';

UPDATE productos
SET precio = ROUND(precio * 1.10, 2)
WHERE categoria = 'Tecnologia';

-- Verificación previa y eliminación de una venta de prueba
SELECT *
FROM ventas
WHERE venta_id = 5;

DELETE FROM ventas
WHERE venta_id = 5;
