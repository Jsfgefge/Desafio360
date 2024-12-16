use GDA00545OT_AngelMarroquin;
GO
--INSERT 
ALTER PROCEDURE spEstados_Insert
	@EstadoName varchar(30)
AS
BEGIN
	INSERT INTO Estados VALUES (@EstadoName)
END;
GO

ALTER PROCEDURE spMarcas_Insert
	@MarcaName varchar(30)
AS
BEGIN
	INSERT INTO Marcas VALUES (@MarcaName)
END;
GO

ALTER PROCEDURE spRoles_Insert
	@RolName varchar(30)
AS
BEGIN
	INSERT INTO Roles VALUES (@RolName)
END;
GO

--UPDATE

CREATE PROCEDURE spEstados_Update
	@EstadoID int,
	@EstadoName varchar(30)
AS
BEGIN
	UPDATE Estados SET NombreEstado= @EstadoName WHERE EstadoId = @EstadoID
END;
GO

CREATE PROCEDURE spMarcas_Update
	@MarcaID int,
	@MarcaName varchar(30)
AS
BEGIN
	UPDATE Marcas SET NombreMarca = @MarcaName WHERE MarcaId = @MarcaID 
END;
GO

CREATE PROCEDURE spRoles_Update
	@RolID int,
	@RolName varchar(30)
AS
BEGIN
	UPDATE Roles SET NombreRol = @RolName WHERE RolID = @RolID 
END;
GO

--DELETE

CREATE PROCEDURE spEstados_Delete
	@EstadoID int
AS
BEGIN
	UPDATE Estados SET IsArchived = 1 WHERE EstadoId = @EstadoID
END;
GO

CREATE PROCEDURE spMarcas_Delete
	@MarcaID int
AS
BEGIN
	UPDATE Marcas SET IsArchived = 1 WHERE MarcaId = @MarcaID 
END;
GO

CREATE PROCEDURE spRoles_Delete
	@RolID int
AS
BEGIN
	UPDATE Roles SET IsArchived = 1 WHERE RolID = @RolID 
END;
GO