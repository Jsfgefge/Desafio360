DECLARE @json NVARCHAR(MAX) = '{"orderHeader": {"usuarioid": 1, "NombreCliente": "testowo"}, 
                                "OrderDetails": [{"id": 1, "name": "dsfsaf"}, {"id": 2, "name": "dsfsaf"}]}';

-- Extract the order header
SELECT 
    JSON_VALUE(@json, '$.orderHeader.usuarioid') AS usuarioid,
    JSON_VALUE(@json, '$.orderHeader.NombreCliente') AS NombreCliente;

-- Extract the order details as separate rows
SELECT 
    detail.id,
    detail.name
FROM OPENJSON(@json, '$.OrderDetails') 
WITH (
    id INT '$.id',
    name NVARCHAR(255) '$.name'
) AS detail;