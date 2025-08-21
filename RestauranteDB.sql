CREATE DATABASE RestauranteDB;
GO

USE RestauranteDB;
GO

CREATE TABLE Meseros (
    IdMesero INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20)
);

CREATE TABLE Mesas (
    IdMesa INT PRIMARY KEY IDENTITY(1,1),
    NumeroMesa INT NOT NULL,
    Capacidad INT NOT NULL
);

CREATE TABLE Clientes (
    IdCliente INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20)
);

CREATE TABLE Menu (
    IdPlato INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE Pedidos (
    IdPedido INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATETIME DEFAULT GETDATE(),
    IdCliente INT,
    IdMesa INT,
    IdMesero INT,
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
    FOREIGN KEY (IdMesa) REFERENCES Mesas(IdMesa),
    FOREIGN KEY (IdMesero) REFERENCES Meseros(IdMesero)
);

CREATE TABLE DetallePedidos (
    IdDetalle INT PRIMARY KEY IDENTITY(1,1),
    IdPedido INT,
    IdPlato INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido),
    FOREIGN KEY (IdPlato) REFERENCES Menu(IdPlato)
);

INSERT INTO Meseros (Nombre, Telefono) VALUES ('Carlos Gómez', '999111222');
INSERT INTO Meseros (Nombre, Telefono) VALUES ('Lucía Fernández', '988776655');

INSERT INTO Mesas (NumeroMesa, Capacidad) VALUES (1, 4);
INSERT INTO Mesas (NumeroMesa, Capacidad) VALUES (2, 6);

INSERT INTO Clientes (Nombre, Telefono) VALUES ('Juan Pérez', '999555444');
INSERT INTO Clientes (Nombre, Telefono) VALUES ('María López', '977888666');

INSERT INTO Menu (Nombre, Precio) VALUES ('Lomo Saltado', 25.50);
INSERT INTO Menu (Nombre, Precio) VALUES ('Arroz con Pollo', 18.00);
INSERT INTO Menu (Nombre, Precio) VALUES ('Ceviche', 30.00);

INSERT INTO Pedidos (IdCliente, IdMesa, IdMesero) VALUES (1, 1, 1);
INSERT INTO DetallePedidos (IdPedido, IdPlato, Cantidad, PrecioUnitario) VALUES (1, 1, 2, 25.50);
INSERT INTO DetallePedidos (IdPedido, IdPlato, Cantidad, PrecioUnitario) VALUES (1, 3, 1, 30.00);

INSERT INTO Pedidos (IdCliente, IdMesa, IdMesero) VALUES (2, 2, 2);
INSERT INTO DetallePedidos (IdPedido, IdPlato, Cantidad, PrecioUnitario) VALUES (2, 2, 3, 18.00);

SELECT C.Nombre AS Cliente, M.NumeroMesa, Me.Nombre AS Mesero, P.Fecha, SUM(D.Cantidad * D.PrecioUnitario) AS TotalCuenta
FROM Pedidos P
JOIN Clientes C ON P.IdCliente = C.IdCliente
JOIN Mesas M ON P.IdMesa = M.IdMesa
JOIN Meseros Me ON P.IdMesero = Me.IdMesero
JOIN DetallePedidos D ON P.IdPedido = D.IdPedido
GROUP BY C.Nombre, M.NumeroMesa, Me.Nombre, P.Fecha;

SELECT Pl.Nombre AS Plato, SUM(D.Cantidad) AS TotalVendido
FROM DetallePedidos D
JOIN Menu Pl ON D.IdPlato = Pl.IdPlato
GROUP BY Pl.Nombre
ORDER BY TotalVendido DESC;

SELECT Me.Nombre AS Mesero, COUNT(P.IdPedido) AS PedidosAtendidos
FROM Pedidos P
JOIN Meseros Me ON P.IdMesero = Me.IdMesero
GROUP BY Me.Nombre
ORDER BY PedidosAtendidos DESC;
