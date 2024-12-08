--CREATE DATABASE GDA00545OT_AngelMarroquin;
USE GDA00545OT_AngelMarroquin;

CREATE TABLE Roles (
	RolID int PRIMARY KEY IDENTITY(1,1), 
	NameRol varchar(30) NOT NULL,
);

CREATE TABLE Estados (
	EstadoId int PRIMARY KEY IDENTITY(1,1),
	NameEstado varchar(30) NOT NULL,
);

CREATE TABLE Marcas (
	MarcaId int PRIMARY KEY IDENTITY(1,1),
	NameMarca varchar(30) NOT NULL,
);

CREATE TABLE Clientes (
	ClienteId int PRIMARY KEY IDENTITY(1,1),
	RazonSocial varchar(50) NOT NULL,
	NombreSocial varchar(50) NOT NULL,
	DireccionEntrega varchar(100) NOT NULL,
	Telefono int NOT NULL,
	Email varchar(50) NOT NULL,
	CreatedDate datetime NOT NULL
);

CREATE TABLE Usuarios(
	UsuarioId int PRIMARY KEY IDENTITY(1,1),
	RolId int NOT NULL,
	EstadoId int,
	Email varchar(50) NOT NULL,
	NameUsuario varchar(100) NOT NULL,
	PasswordUsuario varchar(100) NOT NULL,
	Telefono int,
	BirthDate date,
	CreatedDate datetime NOT NULL
);

CREATE TABLE CategoriaProductos(
	CategoriaProductoId int PRIMARY KEY IDENTITY(1,1),
	NameCategoria varchar(30) NOT NULL,
	EstadoId int NOT NULL,
	CreatedDate datetime NOT NULL,
	CreatedBy int NOT NULL
);

CREATE TABLE Productos(
	ProductoId int PRIMARY KEY IDENTITY(1,1),
	CategoriaProductoId int NOT NULL, 
	NameProduct varchar(100) NOT NULL,
	MarcaId int NOT NULL,
	Codigo varchar(50),
	Stock float NOT NULL,
	EstadoID int NOT NULL,
	PrecioUnidad decimal NOT NULL,
	CreatedDate datetime NOT NULL,
	CreatedBy int NOT NULL
);


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
	CreateDate datetime NOT NULL
);

CREATE TABLE OrderDetails(
	OrderDetailId int PRIMARY KEY IDENTITY(1,1),
	OrderId int NOT NULL,
	ProductId int NOT NULL,
	Cantidad int NOT NULL,
	Precio decimal NOT NULL,
	Subtotal decimal NOT NULL
);