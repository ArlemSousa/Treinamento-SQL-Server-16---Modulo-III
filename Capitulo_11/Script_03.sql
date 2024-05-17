Use Comercio
go
DECLARE @Cont int,
                   @Lin int
SELECT @Lin = Count(*) FROM Pedido
SET @Cont = 1

WHILE @Cont <= @Lin
BEGIN
BEGIN TRANSACTION

        IF @Cont = 980
           SET @Cont = 1

        UPDATE Pedido
        SET Val_Ped = Val_Ped + 1
        WHERE Num_Ped = @Cont
        
        SET @Cont = @Cont + 1
      
END


 
