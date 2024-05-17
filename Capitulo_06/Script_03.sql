Use Farmacia
go
SELECT * FROM Funcionario
go
SELECT * FROM Premio
go

---------------------------------------------------------------------------
BULK INSERT Funcionario
FROM 'c:\Funcionarios.txt'
WITH(FIELDTERMINATOR = '|')
---------------------------------------------------------------------------
SELECT * FROM Funcionario
SELECT * FROM Premio
---------------------------------------------------------------------------
TRUNCATE TABLE Funcionario
---------------------------------------------------------------------------
BULK INSERT Funcionario
FROM 'c:\Funcionarios.txt'
WITH(FIELDTERMINATOR = '|',
     FIRSTROW = 5,
     FIRE_TRIGGERS,
	 LASTROW = 7,
	 KEEPIDENTITY)
---------------------------------------------------------------------------
SELECT * FROM Funcionario
SELECT * FROM Premio
---------------------------------------------------------------------------
TRUNCATE TABLE Funcionario
TRUNCATE TABLE Premio
---------------------------------------------------------------------------