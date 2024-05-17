---------------------------------------------------------------------------
Use Farmacia
go
---------------------------------------------------------------------------
CREATE TABLE Funcionario
(
   Cod_Func        int Identity,
   Nome_Func       varchar(100),
   Data_CadFunc    smalldatetime,
   SexoFunc        char(1),
   Sal_Func        decimal(10,2),
   End_Func        varchar(100),
   Constraint PK_Func Primary Key(Cod_Func)
)
go
---------------------------------------------------------------------------
CREATE TABLE Premio
(
  Cod_Func 	  int	,
  Val_Premio  dec(10,2),
  Data_premio smalldatetime
)
go
---------------------------------------------------------------------------
CREATE TRIGGER T_GeraPremio
ON Funcionario
FOR INSERT
AS
INSERT Premio
  SELECT Cod_Func, Sal_Func * 0.9,Getdate()
  FROM Inserted
go
