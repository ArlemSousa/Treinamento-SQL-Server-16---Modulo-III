Use Master
go
-- Este código verifica se há no disco C:\ uma pasta chamada Bancos e se não 
-- houver ela será criada
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Bancos'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos'


EXEC @result = xp_cmdshell 'dir C:\Bancos\farmacia'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos\farmacia'
go


Use Master
go
IF EXISTS(SELECT * FROM Master.dbo.Sysdatabases
                    WHERE Name LIKE '%Farmacia%')
         DROP DATABASE Farmacia
go

CREATE DATABASE Farmacia
ON PRIMARY
(
  name  =  'Farmacia_Dados',
  filename   =  'C:\Bancos\farmacia\Farmacia_Dados.mdf',
  size = 5MB,
  maxsize= 5MB,
  filegrowth = 1MB
)
LOG ON
(
  name  =  'Farmacia_Log',
  filename   =  'C:\Bancos\farmacia\Farmacia_Log.ldf',
  size = 1MB,
  maxsize= 10MB,
  filegrowth = 1MB
)
go
Use Farmacia
go
CREATE TABLE Cliente
(
  Cod_Cli           int Identity,
  Nome_Cli          varchar(100),
  Renda_Cli         decimal(10,2),
  Data_NascCli		smalldatetime,
  Sexo_Cli          char(1),
  Constraint PK_Cli Primary Key(Cod_Cli)
)
go
CREATE TABLE ControleCli
(
  Cod_Cli	int	,
  Data_Cli	smalldatetime
)
go
CREATE TRIGGER T_controlaCli
ON Cliente
FOR INSERT
AS
INSERT ControleCli
  SELECT Cod_Cli,getdate() FROM Inserted
  ORDER BY Cod_Cli

