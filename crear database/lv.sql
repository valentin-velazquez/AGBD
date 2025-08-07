RESUMEN DE RELACIONES

Stock se relaciona con Empleados (quién lo registró).
Stock se relaciona con Precio (cuánto cuesta ese producto).
Empleados se relacionan con Sucursales (dónde trabajan).

-- Tabla de Sucursales
CREATE TABLE Sucursales (
    id_Sucursales SERIAL PRIMARY KEY AUTOINCREMENT,
    Pais VARCHAR(100),
    Ciudad VARCHAR(100),
    Horario_abierto TIME,
    Horario_cerrado TIME
);


INSERT INTO Sucursales (Pais, Ciudad, Horario_abierto, Horario_cerrado)
VALUES('Argentina', 'Buenos Aires', '10:00', '22:00'),
      ('Argentina', 'Córdoba', '11:00', '23:00');



-- Tabla de Empleados
CREATE TABLE Empleados (
    id_Empleados SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Email VARCHAR(100),
    Numero INT,
    id_Sucursales INT,
    CONSTRAINT fk_empleado_sucursal
    FOREIGN KEY (id_Sucursales) REFERENCES Sucursales(id_Sucursales)
);

INSERT INTO Empleados (Nombre, Apellido, Email, Numero, id_Sucursales)
VALUES('Valentin', 'Velazquez', 'valesergiovelazquez@gmail.com', 1161138645, 1),
      ('Lian', 'Leyenda', 'leyendita78@gmail.com', 1157368754, 2);



-- Tabla de Stock
CREATE TABLE Stock (
    id_Stock INTEGER PRIMARY KEY AUTOINCREMENT,
    Distribuidora VARCHAR(100),
    Ingreso DATE,
    Producto VARCHAR(100),
    Cantidad INT CHECK (Cantidad >= 0),
    id_Empleados INT,
    CONSTRAINT fk_stock_empleado
    FOREIGN KEY (id_Empleados) REFERENCES Empleados(id_Empleados)
);

INSERT INTO Stock (Distribuidora, Ingreso, Producto, Cantidad, id_Empleados)
VALUES('Distribuidora Sergio', '2025-05-20', 'Pan de papa', 30, 1),
      ('Distribuidora Thierri', '2025-05-21', 'Pan de queso', 25, 2);



-- Tabla de Precio
CREATE TABLE Precio (
    id_Precio SERIAL PRIMARY KEY,
    id_Stock INTEGER,
    Producto VARCHAR(100),
    Costo DECIMAL(10,2),
    CONSTRAINT fk_precio_stock
    FOREIGN KEY (id_Stock) REFERENCES Stock(id_Stock)
);

INSERT INTO Precio (id_Stock, Producto, Costo)
VALUES(1, 'Pan de papa', 600.50),
      (2, 'Pan de queso', 700.20);





-- Tabla Clientes
CREATE TABLE Clientes (
    id_Cliente SERIAL PRIMARY KEY AUTOINCREMENT,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Email VARCHAR(100)
);

-- insertar a los clientes
INSERT INTO Clientes (Nombre, Apellido, Email)
VALUES ('juan', 'parrado', 'juan@gmail.com'),
       ('diego', 'ajata', 'diego@gmail.com');      


-- Tabla Ventas
CREATE TABLE Ventas (
    id_Venta SERIAL PRIMARY KEY,
    Fecha DATE,
    id_Cliente INT,
    id_Stock INT,
    Cantidad INT CHECK (Cantidad > 0),
    Total DECIMAL(10,2),
    FOREIGN KEY (id_Cliente) REFERENCES Clientes(id_Cliente),
    FOREIGN KEY (id_Stock) REFERENCES Stock(id_Stock)
);

INSERT INTO Ventas (Fecha, id_Cliente, id_Stock, Cantidad, Total)
VALUES('2025-05-22', 1, 1, 2, 2401.00),
      ('2025-05-22', 2, 2, 1, 1150.75);






-- Tabla de Sucursales
CREATE TABLE IF NOT EXISTS Sucursales (
    id_Sucursales INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Pais VARCHAR(100),
    Ciudad VARCHAR(100),
    Horario_abierto TIME,
    Horario_cerrado TIME
);

-- Datos de Sucursales
INSERT INTO Sucursales (Pais, Ciudad, Horario_abierto, Horario_cerrado) VALUES
('Argentina', 'Buenos Aires', '10:00', '22:00'),
('Argentina', 'Córdoba', '11:00', '23:00'),
('Argentina', 'Rosario', '08:00', '17:00'),
('Chile', 'Valparaíso', '09:00', '18:00'),
('Uruguay', 'Punta del Este', '08:30', '17:30'),
('Paraguay', 'Ciudad del Este', '09:00', '18:00'),
('Perú', 'Arequipa', '08:00', '16:00'),
('Bolivia', 'Cochabamba', '10:00', '19:00'),
('Brasil', 'Rio de Janeiro', '08:00', '17:00'),
('Colombia', 'Medellín', '09:00', '18:00');

-- Tabla de Empleados
CREATE TABLE IF NOT EXISTS Empleados (
    id_Empleados INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Email VARCHAR(100),
    Numero INT,
    id_Sucursales INT,
    CONSTRAINT fk_empleado_sucursal
        FOREIGN KEY (id_Sucursales) REFERENCES Sucursales(id_Sucursales)
        ON DELETE CASCADE
);

-- Datos de Empleados
INSERT INTO Empleados (Nombre, Apellido, Email, Numero, id_Sucursales) VALUES
('Valentin', 'Velazquez', 'valesergiovelazquez@gmail.com', 1161138645, 1),
('Lian', 'Leyenda', 'leyendita78@gmail.com', 1157368754, 2),
('Bruno', 'Morales', 'bruno.morales@mail.com', 1160012233, 10),
('Renata', 'Vega', 'renata.vega@mail.com', 1160012234, 9),
('Elías', 'Castro', 'elias.castro@mail.com', 1160012235, 3),
('Mía', 'Silva', 'mia.silva@mail.com', 1160012236, 7),
('Gael', 'Rojas', 'gael.rojas@mail.com', 1160012237, 8),
('Catalina', 'Navarro', 'catalina.navarro@mail.com', 1160012238, 3),
('Facundo', 'Mendoza', 'facundo.mendoza@mail.com', 1160012239, 6),
('Isabela', 'Cabrera', 'isabela.cabrera@mail.com', 1160012240, 5);

-- Tabla de Stock
CREATE TABLE IF NOT EXISTS Stock (
    id_Stock INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Distribuidora VARCHAR(100),
    Ingreso DATE,
    Producto VARCHAR(100),
    Cantidad INT CHECK (Cantidad >= 0),
    id_Empleados INT,
    CONSTRAINT fk_stock_empleado
        FOREIGN KEY (id_Empleados) REFERENCES Empleados(id_Empleados)
        ON DELETE CASCADE
);

-- Datos de Stock
INSERT INTO Stock (Distribuidora, Ingreso, Producto, Cantidad, id_Empleados) VALUES
('Distribuidora La Hamburguesa', '2025-05-20', 'Pan de hamburguesa', 300, 1),
('Distribuidora La Hamburguesa', '2025-05-20', 'Carne vacuna', 200, 2),
('Distribuidora Sabores', '2025-05-21', 'Queso cheddar', 150, 3),
('Distribuidora Papas Plus', '2025-05-21', 'Papas congeladas', 500, 4),
('Distribuidora Bebidas SRL', '2025-05-21', 'Coca-Cola 500ml', 240, 5),
('Distribuidora Bebidas SRL', '2025-05-21', 'Agua mineral 500ml', 120, 6),
('Distribuidora Salsas', '2025-05-22', 'Mayonesa', 50, 7),
('Distribuidora Salsas', '2025-05-22', 'Ketchup', 50, 8),
('Distribuidora Extras', '2025-05-23', 'Panceta', 100, 9),
('Distribuidora Extras', '2025-05-23', 'Huevos', 200, 10);

-- Tabla de Precio
CREATE TABLE IF NOT EXISTS Precio (
    id_Precio INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    id_Stock INTEGER,
    Producto VARCHAR(100),
    Costo DECIMAL(10,2),
    CONSTRAINT fk_precio_stock
        FOREIGN KEY (id_Stock) REFERENCES Stock(id_Stock)
        ON DELETE CASCADE
);

-- Datos de Precio
INSERT INTO Precio (id_Stock, Producto, Costo) VALUES
(1, 'Pan de hamburguesa', 50.00),
(2, 'Carne vacuna', 120.00),
(3, 'Queso cheddar', 80.00),
(4, 'Papas congeladas', 60.00),
(5, 'Coca-Cola 500ml', 100.00),
(6, 'Agua mineral 500ml', 80.00),
(7, 'Mayonesa', 30.00),
(8, 'Ketchup', 30.00),
(9, 'Panceta', 90.00),
(10, 'Huevos', 25.00);

-- Tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    id_Cliente INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Email VARCHAR(100)
);

-- Datos de Clientes
INSERT INTO Clientes (Nombre, Apellido, Email) VALUES
('juan', 'parrado', 'juan@gmail.com'),
('diego', 'ajata', 'diego@gmail.com'),
('Lucía', 'Ramírez', 'lucia.ramirez@mail.com'),
('Mateo', 'González', 'mateo.gonzalez@mail.com'),
('Camila', 'Fernández', 'camila.fernandez@mail.com'),
('Santiago', 'López', 'santiago.lopez@mail.com'),
('Valentina', 'Torres', 'valentina.torres@mail.com'),
('Joaquín', 'Pérez', 'joaquin.perez@mail.com'),
('Martina', 'Sánchez', 'martina.sanchez@mail.com'),
('Tomás', 'Herrera', 'tomas.herrera@mail.com');

-- Tabla Ventas
CREATE TABLE IF NOT EXISTS Ventas (
    id_Venta INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Fecha DATE,
    id_Cliente INT,
    id_Stock INT,
    Cantidad INT CHECK (Cantidad > 0),
    Total DECIMAL(10,2),
    FOREIGN KEY (id_Cliente) REFERENCES Clientes(id_Cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_Stock) REFERENCES Stock(id_Stock) ON DELETE CASCADE
);

-- Datos de Ventas
INSERT INTO Ventas (Fecha, id_Cliente, id_Stock, Cantidad, Total) VALUES
('2025-05-22', 1, 2, 2, 240.00),  -- Carne vacuna
('2025-05-22', 2, 4, 1, 60.00),   -- Papas congeladas
('2025-05-22', 3, 5, 2, 200.00),  -- Coca-Cola
('2025-05-23', 4, 1, 2, 100.00),  -- Pan de hamburguesa
('2025-05-23', 5, 3, 1, 80.00),   -- Queso cheddar
('2025-05-23', 6, 9, 1, 90.00),   -- Panceta
('2025-05-24', 7, 6, 1, 80.00);   -- Agua mineral