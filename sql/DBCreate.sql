--CREATE DATABASE GDA00545OT_AngelMarroquin;
USE GDA00545OT_AngelMarroquin;

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
GO;


CREATE PROCEDURE spProductos_Deshabilitar
	@ProductoId int
AS
BEGIN
	UPDATE Productos SET EstadoID = 1, PrecioUnidad = 0 WHERE ProductoId = @ProductoId
END;
GO