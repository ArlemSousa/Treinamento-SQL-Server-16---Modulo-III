Use Master
go
IF EXISTS(SELECT * FROM sys.databases WHERE Name LIKE '%Producao%')
     DROP DATABASE Producao
go
CREATE DATABASE Producao
go
Use Producao
go
CREATE TABLE Produto
(
   Cod_Prod     int                   Not Null,
   Tipo_Prod    char(1)            Not Null,
   Nome_Prod varchar(100)  Not Null,
   Qtd_Prod     int                    Not Null,
   Val_Prod      decimal(10,2) Not Null
)
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE Name LIKE '%BackupProducao%')
Begin 
             Exec sp_dropdevice 'BackupProducao'
             Exec Master.dbo.xp_cmdshell 'RD C:\BackupProducao'
End
go
Exec Master.dbo.xp_cmdshell 'MD C:\BackupProducao'
go
Exec sp_addumpdevice
 @devtype     =  'Disk', 
 @logicalname =  'BackupProducao',
 @physicalname = 'C:\BackupProducao\BackupProducao.Bak'
go
SELECT * FROM Produto

