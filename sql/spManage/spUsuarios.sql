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