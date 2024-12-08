CREATE DATABASE GDA00545OT_AngelMarroquin;
GO

USE GDA00545OT_AngelMarroquin;
GO

IF OBJECT_ID(N'dbo.Roles', N'U') IS NULL
CREATE TABLE Roles (
	RolID int PRIMARY KEY IDENTITY(1,1), 
	NombreRol varchar(30) NOT NULL,
);
GO

IF OBJECT_ID(N'dbo.Estados', N'U') IS NULL
CREATE TABLE Estados (
	EstadoId int PRIMARY KEY IDENTITY(1,1),
	NombreEstado varchar(30) NOT NULL,
);
GO

IF OBJECT_ID(N'dbo.Marcas', N'U') IS NULL
CREATE TABLE Marcas (
	MarcaId int PRIMARY KEY IDENTITY(1,1),
	NombreMarca varchar(30) NOT NULL,
);
GO

IF OBJECT_ID(N'dbo.Clientes', N'U') IS NULL
CREATE TABLE Clientes (
	ClienteId int PRIMARY KEY IDENTITY(1,1),
	RazonSocial varchar(50) NOT NULL,
	NombreSocial varchar(50) NOT NULL,
	DireccionEntrega varchar(100) NOT NULL,
	Telefono int NOT NULL,
	Email varchar(50) NOT NULL,
	CreatedDate datetime NOT NULL
);
GO

IF OBJECT_ID(N'dbo.Usuarios', N'U') IS NULL
CREATE TABLE Usuarios(
	UsuarioId int PRIMARY KEY IDENTITY(1,1),
	RolId int NOT NULL,
	EstadoId int,
	ClienteId int,
	Email varchar(50) NOT NULL,
	NombreUsuario varchar(100) NOT NULL,
	PasswordUsuario varchar(100) NOT NULL,
	Telefono int,
	BirthDate date,
	CreatedDate datetime NOT NULL,
	CONSTRAINT FKUsuarios_RolId FOREIGN KEY (RolID) REFERENCES Roles(RolId),
	CONSTRAINT FKUsuarios_EstadoId FOREIGN KEY (EstadoID) REFERENCES Estados(EstadoId)
);
GO


IF OBJECT_ID(N'dbo.CategoriaProductos', N'U') IS NULL
CREATE TABLE CategoriaProductos(
	CategoriaProductoId int PRIMARY KEY IDENTITY(1,1),
	NombreCategoria varchar(30) NOT NULL,
	EstadoId int NOT NULL,
	CreatedDate datetime NOT NULL,
	CreatedBy int NOT NULL,
	CONSTRAINT FKCateProductos_EstadoId FOREIGN KEY (EstadoId) REFERENCES Estados(EstadoId),
	CONSTRAINT FKCateProductos_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Usuarios(UsuarioId)
);
GO

IF OBJECT_ID(N'dbo.Productos', N'U') IS NULL
CREATE TABLE Productos(
	ProductoId int PRIMARY KEY IDENTITY(1,1),
	CategoriaProductoId int NOT NULL, 
	NombreProducto varchar(100) NOT NULL,
	MarcaId int NOT NULL,
	Codigo varchar(50),
	Stock float NOT NULL,
	EstadoID int NOT NULL,
	PrecioUnidad decimal NOT NULL,
	CreatedDate datetime NOT NULL,
	CreatedBy int NOT NULL,
	ImgPath VARCHAR(200),
	CONSTRAINT FKProductos_CategoriaProductoId FOREIGN KEY (CategoriaProductoId) REFERENCES CategoriaProductos(CategoriaProductoId),
	CONSTRAINT FKProductos_MarcaId FOREIGN KEY (MarcaId) REFERENCES Marcas(MarcaId),
	CONSTRAINT FKProductos_EstadoId FOREIGN KEY (EstadoId) REFERENCES Estados(EstadoId),
	CONSTRAINT FKProductos_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Usuarios(UsuarioId)
);
GO

IF OBJECT_ID(N'dbo.OrderHeader', N'U') IS NULL
CREATE TABLE OrderHeader(
	OrderId int PRIMARY KEY IDENTITY(1,1),
	UsuarioId int NOT NULL,
	EstadoId int NOT NULL,
	NombreCliente varchar(50) NOT NULL,
	Direccion varchar(100) NOT NULL,
	Telefono int NOT NULL,
	Email varchar(100) NOT NULL,
	FechaEntrega date NOT NULL,
	DetallesEntrega varchar(200) NOT NULL,
	TotalOrder float NOT NULL,
	CreateDate datetime NOT NULL,
	CONSTRAINT FKOrderHeader_UsuarioId FOREIGN KEY (UsuarioId) REFERENCES Usuarios(UsuarioId),
	CONSTRAINT FKOrderHeader_EstadoId FOREIGN KEY (EstadoId) REFERENCES Estados(EstadoId)
);
GO

IF OBJECT_ID(N'dbo.OrderDetails', N'U') IS NULL
CREATE TABLE OrderDetails(
	OrderDetailId int PRIMARY KEY IDENTITY(1,1),
	OrderId int NOT NULL,
	ProductoId int NOT NULL,
	Cantidad int NOT NULL,
	Precio decimal NOT NULL,
	Subtotal decimal NOT NULL,
	CONSTRAINT FKOrderDetail_OrderId FOREIGN KEY (OrderId) REFERENCES OrderHeader(OrderId),
	CONSTRAINT FKOrderDetail_ProductId FOREIGN KEY (ProductoId) REFERENCES Productos(ProductoId)
);
GO

CREATE PROCEDURE spUsuarios_Insert
	@RolId int,
	@EstadoId int,
	@Email varchar(50),
	@NombreUsuario varchar(100),
	@PasswordUsuario varchar(100),
	@Telefono int,
	@BirthDate date,
	@CreatedDate datetime
AS
BEGIN
	INSERT INTO Usuarios(
	RolId,
	EstadoId,
	Email,
	NombreUsuario,
	PasswordUsuario,
	Telefono,
	BirthDate,
	CreatedDate
	)
	VALUES(
	@RolId,
	@EstadoId,
	@Email,
	@NombreUsuario,
	@PasswordUsuario,
	@Telefono,
	@BirthDate,
	@CreatedDate
	)
END;
GO


CREATE PROCEDURE spProductos_Deshabilitar
	@ProductoId int
AS
BEGIN
	UPDATE Productos SET EstadoID = 1, PrecioUnidad = 0 WHERE ProductoId = @ProductoId
END;
GO



--INSERT STATEMENT TO TEST THE DB

--Roles
INSERT INTO Roles (NombreRol) Values 
	('Admin Sistema')		--1
	,('Developer')			--2
	,('Cajero')				--3
	,('Encargado tienda')	--4
	,('Gerente')			--5
	,('Cliente');			--6

--Estados
INSERT INTO Estados(NombreEstado) 
Values 
	('Dehabilitado')		--1
	,('Descontinuado')		--2
	,('En existencia')		--3
	,('Agotado')			--4

	,('En proceso')			--5
	,('Pendiente Entrega')	--6
	,('Completado')			--7
	,('Pendiente Pago')		--8

	,('Activo')				--9
	,('Despedido')			--10
	,('Renuncia');			--11

--Marca

INSERT INTO Marcas(NombreMarca) Values 
	('Intel')	--1
	,('AMD')	--2
	,('ASUS')	--3
	,('HP')		--4
	,('Razer');	--5

--Categoria Producto

INSERT INTO Clientes(NombreSocial,RazonSocial,Email,DireccionEntrega,Telefono,CreatedDate)
VALUES
	('Cliente1','Razon1','testCliente1@gmail.com','calle Prueba 1, test 1',11111111, GETDATE()),
	('Cliente2','Razon2','testCliente2@gmail.com','calle Prueba 2, test 2',22222222, GETDATE()),
	('Cliente3','Razon3','testCliente3@gmail.com','calle Prueba 3, test 3',33333333, GETDATE()),
	('Cliente4','Razon4','testCliente4@gmail.com','calle Prueba 4, test 4',44444444, GETDATE()),
	('Cliente5','Razon5','testCliente5@gmail.com','calle Prueba 5, test 5',55555555, GETDATE()),
	('Cliente6','Razon6','testCliente6@gmail.com','calle Prueba 6, test 6',66666666, GETDATE()),
	('Cliente7','Razon7','testCliente7@gmail.com','calle Prueba 7, test 7',77777777, GETDATE()),
	('Cliente8','Razon8','testCliente8@gmail.com','calle Prueba 8, test 8',88888888, GETDATE());


INSERT INTO Usuarios(RolId,EstadoId,ClienteId,Email,NombreUsuario,PasswordUsuario,Telefono,BirthDate,CreatedDate)
VALUES 
	(1,9,null,'temp1@gmail.com','AdminSistema','testPass',32871462,'2001-01-08',GETDATE()),		--1
	(2,9,null,'temp2@gmail.com','Dev1','testPass1',32871462,'2002-01-08',GETDATE()),			--2
	(2,10,null,'temp3@gmail.com','Dev2','testPass2',32871462,'2001-10-08',GETDATE()),			--3
	(3,9,null,'temp4@gmail.com','Cajero3','testPass3',32871462,'1988-07-11',GETDATE()),			--4
	(3,9,null,'temp5@gmail.com','Cajero4','testPass4',32871462,'2001-01-08',GETDATE()),			--5
	(3,11,null,'temp6@gmail.com','Cajero5','testPass5',32871462,'2001-01-08',GETDATE()),		--6
	(4,9,null,'temp7@gmail.com','Engargado1','testPass6',32871462,'2001-01-08',GETDATE()),		--7
	(4,9,null,'temp8@gmail.com','Engargado2','testPass7',32871462,'2001-01-08',GETDATE()),		--8
	(4,10,null,'temp9@gmail.com','Engargado3','testPass8',32871462,'2001-01-08',GETDATE()),		--9
	(5,9,null,'temp10@gmail.com','Gerente1','testPass9',32871462,'2001-01-08',GETDATE()),		--10
	(5,9,null,'temp11@gmail.com','Gerente2','testPass10',32871462,'2001-01-08',GETDATE()),		--11

	(6,9,1,'testCliente1@gmail.com','Cliente1','testPass11',11111111,'2001-01-08',GETDATE()),	--12
	(6,9,2,'testCliente2@gmail.com','Cliente2','testPass12',22222222,'2001-01-08',GETDATE()),	--13
	(6,9,3,'testCliente3@gmail.com','Cliente3','testPass13',33333333,'2001-01-08',GETDATE()),	--14
	(6,9,4,'testCliente4@gmail.com','Cliente4','testPass14',44444444,'2001-01-08',GETDATE()),	--15
	(6,9,5,'testCliente5@gmail.com','Cliente5','testPass15',55555555,'2001-01-08',GETDATE()),	--16
	(6,9,6,'testCliente6@gmail.com','Cliente6','testPass16',66666666,'2001-01-08',GETDATE()),	--17
	(6,9,7,'testCliente7@gmail.com','Cliente7','testPass17',77777777,'2001-01-08',GETDATE()),	--18
	(6,9,8,'testCliente8@gmail.com','Cliente8','testPass18',88888888,'2001-01-08',GETDATE());	--19


INSERT INTO CategoriaProductos(NombreCategoria, EstadoId, CreatedDate, CreatedBy)
VALUES
	('Pantalla', 9, GETDATE(), 1),		--1
	('Sonido', 9, GETDATE(), 1),		--2
	('Gaming', 9, GETDATE(), 1),		--3
	('Videos', 9, GETDATE(), 1),		--4
	('Iluminacion', 9, GETDATE(), 1),	--5
	('Muebles', 9, GETDATE(), 1),		--6
	('Securidad', 9, GETDATE(), 1),		--7
	('Scanners', 9, GETDATE(), 1),		--8
	('Software', 9, GETDATE(), 1);		--9



INSERT INTO Productos(CategoriaProductoId,NombreProducto, MarcaId, Codigo, Stock, EstadoID, PrecioUnidad, CreatedDate, CreatedBy)
VALUES
	(1, 'Monitor 27"',4, 'SDKJH-23987',123,3,984.95,GETDATE(),1),	--1
	(1, 'Monitor 24"',4, 'SDKJH-32943',42,3,984.95,GETDATE(),1),	--2
	(1, 'Monitor 19"',4, 'SDKJH-93824',500,3,984.95,GETDATE(),1),	--3
	(2, 'Producto1Cat2',4, 'SDKJH-23987',12,3,984.95,GETDATE(),1),	--4
	(2, 'Producto2Cat2',4, 'SDKJH-23987',45,3,984.95,GETDATE(),1),	--5
	(3, 'Producto3Cat3',4, 'SDKJH-23987',706,3,984.95,GETDATE(),1),	--6
	(4, 'Producto4Cat4',4, 'SDKJH-23987',975,3,984.95,GETDATE(),1),	--7
	(4, 'Producto5Cat4',4, 'SDKJH-23987',98,3,984.95,GETDATE(),1),	--8
	(5, 'Producto6Cat5',4, 'SDKJH-23987',19,3,984.95,GETDATE(),1),	--9
	(6, 'Producto7Cat6',4, 'SDKJH-23987',0,4,984.95,GETDATE(),1),	--10
	(6, 'Producto8Cat6',4, 'SDKJH-23987',0,4,984.95,GETDATE(),1),	--11
	(6, 'Producto9Cat6',4, 'SDKJH-23987',98,3,984.95,GETDATE(),1),	--12
	(7, 'Producto10Cat7',4, 'SDKJH-23987',4,3,984.95,GETDATE(),1);	--13


--LOS TOTALES DE ORDER HEADER NO SON LOS QUE DEBERIAN DE SER YA QUE NO ME TOME EL TIEMPO DE HACER LOS CALCULOS A MANO Y LA FORMA CORRECTA DE HACER ESTO
--DEBERIA DE SER QUE AL MOMENTO DE INSERTAR DATOS EN ORDERDETAIL SE HAGA AUTOMATICAMENTE EL UPDATE PARA MOSTRAR EL TOTAL REAL


INSERT INTO OrderHeader(UsuarioId, EstadoId, NombreCliente, Direccion, DetallesEntrega, Telefono, Email, FechaEntrega, TotalOrder, CreateDate)
VALUES 
	(12, 7, 'Cliente1', 'calle Prueba 1, test 1','Llamar antes de tocar', 11111111, 'testCliente1@gmail.com', '2024-09-12',2344321 ,GETDATE()),		--1
	(13, 7, 'Cliente2', 'calle Prueba 2, test 2','Llamar antes de tocar', 22222222, 'testCliente2@gmail.com', '2024-09-12',342243 ,'2024-08-12'),	--2
	(12, 6, 'Cliente1', 'calle Prueba 1, test 1','Llamar antes de tocar', 11111111, 'testCliente1@gmail.com', '2024-10-12',412 ,'2024-08-24'),	--3
	(12, 6, 'Cliente1', 'calle Prueba 1, test 1','Llamar antes de tocar', 11111111, 'testCliente1@gmail.com', '2024-11-14',12412 ,'2024-08-30'),	--4
	(16, 6, 'Cliente5', 'calle Prueba 5, test 5','Llamar antes de tocar', 55555555, 'testCliente5@gmail.com', '2024-10-23',21556 ,'2024-08-13');	--5
	
INSERT INTO OrderDetails(OrderId, ProductoId, Cantidad, Precio, Subtotal)
VALUES
	(1, 1,  23, 984.95, 23*984.95),
	(1, 2,  13, 984.95, 13*984.95),
	(1, 3,  24, 984.95, 24*984.95),
	(1, 4,  12, 984.95, 12*984.95),
	(2, 6,  53, 984.95, 53*984.95),
	(2, 7,  23, 984.95, 23*984.95),
	(2, 9,  25, 984.95, 25*984.95),
	(2, 11, 23, 984.95, 23*984.95),
	(2, 12, 12, 984.95, 12*984.95),
	(2, 13, 89, 984.95, 89*984.95),
	(3, 1,  30, 984.95, 30*984.95),
	(3, 3,  10, 984.95, 10*984.95),
	(3, 5,  50, 984.95, 50*984.95),
	(3, 8,  70, 984.95, 70*984.95),
	(3, 10, 45, 984.95, 45*984.95),
	(3, 11, 93, 984.95, 93*984.95),
	(4, 1,  23, 984.95, 23*984.95),
	(4, 2,  10, 984.95, 10*984.95),
	(4, 3,  10, 984.95, 10*984.95),
	(4, 4,  10, 984.95, 10*984.95),
	(4, 9,  10, 984.95, 10*984.95),
	(4, 10, 20, 984.95, 20*984.95),
	(4, 13, 30, 984.95, 30*984.95),
	(5, 1,  30, 984.95, 30*984.95),
	(5, 2,  43, 984.95, 43*984.95),
	(5, 4,  40, 984.95, 40*984.95),
	(5, 6,  23, 984.95, 23*984.95),
	(5, 8,  54, 984.95, 54*984.95),
	(5, 10, 65, 984.95, 65*984.95),
	(5, 12, 15, 984.95, 15*984.95),
	(5, 13, 32, 984.95, 32*984.95);
GO


CREATE VIEW vActiveProduct AS
SELECT * FROM Productos WHERE Stock > 0;
GO

CREATE VIEW vTotalAmountAugust AS
SELECT SUM(TotalOrder) AS Amount FROM OrderHeader WHERE MONTH(CreateDate) = 8;
GO

CREATE VIEW vTopClientes AS
	SELECT TOP 10 c.ClienteId, c.NombreSocial, SUM(h.TotalOrder) as Amount
	FROM OrderHeader h
	JOIN Usuarios u ON u.UsuarioId = h.UsuarioId
	JOIN Clientes c ON c.ClienteId = u.ClienteId
	GROUP BY c.ClienteId, c.NombreSocial
	ORDER BY SUM(h.TotalOrder) DESC;
GO

CREATE VIEW vTopVendios AS
	SELECT TOP 10 
		od.ProductoId,
		p.NombreProducto,
		SUM(SubTotal) AS TOTAL
	FROM OrderDetails od
	JOIN Productos p on od.ProductoId = p.ProductoId
	GROUP BY od.ProductoId, p.NombreProducto
	ORDER BY SUM(SubTotal) ASC;
GO