use GDA00545OT_AngelMarroquin;
GO

CREATE PROCEDURE spProductos_Deshabilitar
	@ProductoId int
AS
BEGIN
	UPDATE Productos SET EstadoID = 1, PrecioUnidad = 0 WHERE ProductoId = @ProductoId
END;
GO
