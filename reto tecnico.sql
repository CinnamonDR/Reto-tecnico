-- creacion de bd
CREATE DATABASE EmpresaSimple;
GO
USE EmpresaSimple;
GO

-- la tabla de producto
CREATE TABLE Producto(
    IdProducto INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50),
    Precio FLOAT,
    Stock INT
);

--  tabla de pedido
CREATE TABLE Pedido(
    IdPedido INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATE,
    Cliente VARCHAR(50),
    IdProducto INT,
    Cantidad INT
);

-- tabla de despacho
CREATE TABLE Despacho(
    IdDespacho INT PRIMARY KEY IDENTITY(1,1),
    IdPedido INT,
    FechaDespacho DATE,
    Estado VARCHAR(50)
);

-- ingfresar procutos
INSERT INTO Producto VALUES ('Laptop',50000,10);
INSERT INTO Producto VALUES ('Mouse',800,50);
INSERT INTO Producto VALUES ('Teclado',1500,30);
INSERT INTO Producto VALUES ('Monitor',12000,15);
INSERT INTO Producto VALUES ('Impresora',9000,8);

-- ingresar pedidos
INSERT INTO Pedido VALUES (GETDATE(),'Juan',1,1);
INSERT INTO Pedido VALUES (GETDATE(),'Maria',2,2);
INSERT INTO Pedido VALUES (GETDATE(),'Carlos',3,1);
INSERT INTO Pedido VALUES (GETDATE(),'Ana',4,1);
INSERT INTO Pedido VALUES (GETDATE(),'Luis',5,1);

-- ingresar despachos
INSERT INTO Despacho VALUES (1,GETDATE(),'Entregado');
INSERT INTO Despacho VALUES (2,GETDATE(),'Pendiente');
INSERT INTO Despacho VALUES (3,GETDATE(),'Entregado');
INSERT INTO Despacho VALUES (4,GETDATE(),'En proceso');
INSERT INTO Despacho VALUES (5,GETDATE(),'Pendiente');



SELECT * FROM Producto;

UPDATE Producto SET Precio = 48000 WHERE IdProducto = 1;

DELETE FROM Producto WHERE IdProducto = 5;

SELECT * FROM Producto;

-- pedidos por cliente
SELECT * FROM Pedido WHERE Cliente = 'Juan';

-- despachos pendientes
SELECT * FROM Despacho WHERE Estado = 'Pendiente';

-- consulta simple
SELECT Pedido.Cliente, Producto.Nombre, Pedido.Cantidad, Despacho.Estado
FROM Pedido
JOIN Producto ON Pedido.IdProducto = Producto.IdProducto
JOIN Despacho ON Pedido.IdPedido = Despacho.IdPedido;

--  vista general
CREATE VIEW VistaGeneral AS
SELECT Pedido.Cliente, Producto.Nombre, Pedido.Cantidad, Despacho.Estado
FROM Pedido
JOIN Producto ON Pedido.IdProducto = Producto.IdProducto
JOIN Despacho ON Pedido.IdPedido = Despacho.IdPedido;


CREATE PROCEDURE InsertarProductoSimple
@Nombre VARCHAR(50),
@Precio FLOAT,
@Stock INT
AS
BEGIN
INSERT INTO Producto VALUES (@Nombre,@Precio,@Stock);
END;

-- tabla de auditoria
CREATE TABLE Auditoria(
IdLog INT PRIMARY KEY IDENTITY(1,1),
Tabla VARCHAR(50),
Accion VARCHAR(50),
Fecha DATETIME
);

CREATE TRIGGER TriggerInsertProducto
ON Producto
AFTER INSERT
AS
INSERT INTO Auditoria VALUES ('Producto','INSERT',GETDATE());

-- reporte final
SELECT Pedido.Cliente, Producto.Nombre AS Producto,
Pedido.Cantidad, Despacho.Estado
FROM Pedido
JOIN Producto ON Pedido.IdProducto = Producto.IdProducto
JOIN Despacho ON Pedido.IdPedido = Despacho.IdPedido;