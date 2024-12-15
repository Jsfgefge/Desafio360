use GDA00545OT_AngelMarroquin;
GO

CREATE PROCEDURE spEstados_Insert
	@NombreEstado varchar(30)
AS
BEGIN
	INSERT INTO Estados VALUES (@NombreEstado)
END;
GO