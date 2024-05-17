Use Master
go
IF EXISTS(SELECT * FROM sysdatabases WHERE Name LIKE '%Clientes%')
DROP DATABASE Clientes
go

Exec master.dbo.xp_cmdshell 'MD C:\BancoClientes'
Exec master.dbo.xp_cmdshell 'MD C:\BackupClientes'
go

CREATE DATABASE Clientes
ON
(
   Name = 'Clientes_Dados',
   Filename = 'C:\BancoClientes\Clientes_Dados.mdf',
   Size= 5MB,
   Maxsize = 10MB,
   Filegrowth = 1MB
)
LOG ON
(
   Name = 'Clientes_Log',
   Filename = 'C:\BancoClientes\Clientes_Log.ldf',
   Size= 1MB,
   Maxsize = 1MB,
   Filegrowth = 0%
)
go
USE Clientes
go
CREATE TABLE Cliente
(
  Cod_Cli      Bigint   identity  Not Null Primary Key,
  Nome_Cli   char(8000)         Not Null        
)
go
CREATE PROCEDURE P_InsereCliente
AS
DECLARE @Cont int,
                   @Nome varchar(1000)

SET @Cont = 1

WHILE @Cont <= 1000
BEGIN
           SET @Nome = 'Cliente' + Convert(varchar(100),@Cont)  
 
           INSERT Cliente VALUES(@nome)

           SET @Cont = @Cont + 1
END 
go

BACKUP DATABASE Clientes
TO DISK = 'C:\BackupClientes\BackupCliente.bak'
------------------------------------------------------------------------
--Exec P_InsereCliente