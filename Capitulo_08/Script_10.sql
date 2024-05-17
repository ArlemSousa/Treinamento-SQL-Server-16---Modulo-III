SET NOCOUNT ON
Use Master
GO
IF EXISTS(SELECT * FROM master.dbo.sysdatabases
                   WHERE Name LIKE '%Vendas%')
          DROP DATABASE Vendas
GO
CREATE DATABASE Vendas
GO
Use Vendas
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
CREATE TABLE Premio
(
  Num_Premio     int Identity      Not Null,
  Cod_Func       int                    Not Null,
  Data_Premio    smalldatetime Not Null Default Getdate(),
  Val_Premio     decimal(10,2)  Not Null, 
  Status_Premio  bit                    Not Null
  Constraint PK_Premio Primary Key(Num_Premio),
  Constraint FK_Premio Foreign Key(Cod_Func) References Funcionario(Cod_Func),
  Constraint CH_Premio2 Check(Val_Premio Between 50.00 And 500.00)
)
GO

IF EXISTS(SELECT * FROM master.dbo.sysmessages
          WHERE error = 50001)
         Exec SP_DropMessage 50001
go
Exec SP_AddMessage 50001,16,'O funcionário %s acaba de ganhar 50.00 de premio'
go

CREATE PROCEDURE P_EnviaMensagem 
@Usuario varchar(255)
AS

Exec msdb.dbo.SP_send_dbmail
@Profile_name = NomedoProfile,
@Recipients = @Usuario,
@Body = 'Teste enviado pelo SQL Server 2005',
@Subject = 'Mensagem enviada com sucesso',
@Query = 'SELECT Convert(Char(20),F.Nome_Func) AS Nome_Func,
       Sum(P.Val_Premio) AS Val_Premio
FROM Vendas.dbo.Funcionario F inner join Vendas.dbo.Premio P
ON F.Cod_Func = P.Cod_Func
GROUP BY F.Cod_Func,
         F.Nome_Func'
go

CREATE TRIGGER T_GeraPremio
ON Pedido
FOR INSERT
AS
DECLARE @Valor  decimal(10,2),
        @Codigo int,
        @Nome   varchar(100)  

SELECT @Codigo = inserted.Cod_Func,
       @Valor  = inserted.Val_Ped,
       @Nome   = Funcionario.Nome_Func
FROM Funcionario inner join inserted
ON Funcionario.Cod_Func = inserted.Cod_Func

IF @Valor >= 500            
BEGIN
       INSERT Premio VALUES(@Codigo,getdate(),50.00,'0')
       Exec P_EnviaMensagem 'Administrator'  
       RAISERROR(50001,16,1,@Nome)   
       WITH LOG
END
go













