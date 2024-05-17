SET NOCOUNT ON
Use Master
GO

IF EXISTS(SELECT * FROM master.dbo.sysdatabases
                   WHERE Name LIKE '%SuperMercado%')
          DROP DATABASE SuperMercado
GO


CREATE DATABASE SuperMercado
GO
Alter database  SuperMercado set recovery FULL
GO
Use SuperMercado
GO
CREATE TABLE Funcionario
(
  Cod_Func    int Identity     Not Null,
  Nome_Func varchar(100) Not Null,
  End_Func    varchar(200) Not Null,
  Sal_Func     decimal(10,2) Not Null,
  Sexo_Func   char(1),
  Constraint PK_Func Primary Key(Cod_Func),
  Constraint CH_Func1 Check(Sal_Func >= 0),
  Constraint CH_Func2 Check(Sexo_Func IN ('F','M'))
)
GO
INSERT Funcionario VALUES('Antônio da Silva','Rua A',2500.00,'M')
INSERT Funcionario VALUES('Mariano Barbosa','Rua B',300.00,'M')
INSERT Funcionario VALUES('Carlos Gonçalves','Rua C',580.00,'M')
INSERT Funcionario VALUES('Solange Linhares','Rua D',3000.00,'F')
INSERT Funcionario VALUES('Silvia Alencas','Rua E',2000.00,'M')
GO
CREATE TABLE Pedido
(
  Num_Ped  int Identity           Not Null,
  Cod_Func  int                         Not Null, 
  Data_Ped  smalldatetime      Not Null,
  Val_Ped    decimal(10,2)        Not Null,
  Constraint PK_Ped Primary Key(Num_Ped),
  Constraint FK_Ped2 Foreign Key(Cod_Func) references Funcionario(Cod_Func)
)
GO
INSERT Pedido VALUES(2,getdate(),1500.00)
INSERT Pedido VALUES(4,getdate(),50.00)
INSERT Pedido VALUES(2,getdate(),100.00)
INSERT Pedido VALUES(4,getdate(),200.00)
INSERT Pedido VALUES(5,getdate(),300.00)
INSERT Pedido VALUES(4,getdate(),100.00)
INSERT Pedido VALUES(5,getdate(),50.00)
INSERT Pedido VALUES(2,getdate(),50.00)
INSERT Pedido VALUES(2,getdate(),2000.00)
INSERT Pedido VALUES(1,getdate(),3000.00)
GO
CREATE TABLE Premio
(
  Num_Premio    int Identity      Not Null,
  Cod_Func          int                    Not Null,
  Data_Premio    smalldatetime Not Null Default Getdate(),
  Val_Premio       decimal(10,2)  Not Null, 
  Status_Premio  bit                    Not Null
  Constraint PK_Premio Primary Key(Num_Premio),
  Constraint FK_Premio Foreign Key(Cod_Func) References Funcionario(Cod_Func),
  Constraint CH_Premio2 Check(Val_Premio Between 50.00 And 500.00)
)
GO
CREATE PROCEDURE P_GeraPremio
AS

IF NOT EXISTS(SELECT * FROM Premio
	      WHERE Day(Data_Premio) = Day(Getdate())
   	      AND      Month(Data_Premio) = Month(Getdate())
	      AND      Year(Data_Premio)    = Year(Getdate()))

INSERT Premio
SELECT  Cod_Func,
                 Getdate(),
                 Case 
                    WHEN Sum(Val_Ped) Between 500.00 And 1000 Then 50.00
                    WHEN Sum(Val_Ped) Between 1000.00 And 3000 Then 200.00
                    WHEN Sum(Val_Ped) > 3000.00 Then 500.00
                 End,
                 0 -- Ainda não pago
FROM Pedido
WHERE Day(Data_Ped) = Day(Getdate())
AND      Month(Data_Ped) = Month(Getdate())
AND      Year(Data_Ped)    = Year(Getdate())
GROUP BY Cod_Func
HAVING Sum(Val_Ped) >= 500.00
GO
SET NOCOUNT OFF
/* ************************************************************************ */
--Exec P_GeraPremio
--DELETE Premio
--SELECT * FROM Premio
/* ************************************************************************ */