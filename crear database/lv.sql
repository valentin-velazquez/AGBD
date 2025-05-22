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