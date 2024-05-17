Use Comercio
go
DECLARE @ContPed int,
                   @ContProd int,
                   @LinPed int,
                   @LinProd int

SET @ContPed = 1
SET @ContProd = 1

WHILE 1 =1 
SELECT @LinPed = Count(*) FROM Pedido
SELECT @LinProd = Count(*) FROM Produto

BEGIN TRANSACTION
WHILE @ContPed <= @LinPed
BEGIN
	WHILE @ContProd <= @LinProd
	BEGIN
		UPDATE Itens
		SET Val_Vend = Val_Vend * 1
                           WHERE Num_Ped = @ContPed
                           AND       Cod_Prod = @ContProd

                           SET @ContProd = @ContProd + 1
               END

               SET @ContPed = @ContPed + 1
END




