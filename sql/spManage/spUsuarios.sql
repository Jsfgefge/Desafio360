use GDA00545OT_AngelMarroquin;
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

CREATE PROCEDURE spUsuarios_Update
	@RolId int,
	@EstadoId int = NULL,
	@Email varchar(50) = NULL,
	@NombreUsuario varchar(100) = NULL,
	@PasswordUsuario varchar(100) = NULL,
	@Telefono int = NULL,
	@BirthDate date = NULL
AS
BEGIN

UPDATE Usuarios 
SET 	
	RolId			= ISNULL(@RolId, RolId),
	EstadoId		= ISNULL(@EstadoId, EstadoId),
	Email			= ISNULL(@Email, Email),
	NombreUsuario	= ISNULL(@NombreUsuario, NombreUsuario),
	PasswordUsuario	= ISNULL(@PasswordUsuario, PasswordUsuario),
	Telefono		= ISNULL(@Telefono, Telefono),
	BirthDate		= ISNULL(@BirthDate, BirthDate)
END;
GO

