
-- No servidor Origem
CREATE DATABASE Ginasio
go
Use Ginasio
go
CREATE TABLE Esporte
(
  Cod_Esp	int Primary Key,
  Nome_Esp	varchar(100)
)
go
INSERT Esporte VALUES(1,'Ginastica')
INSERT Esporte VALUES(2,'Natação')
INSERT Esporte VALUES(3,'Basquete')
INSERT Esporte VALUES(4,'Futebol')
INSERT Esporte VALUES(5,'HandBol')
go
DBCC TRACEON ( 1400,-1)
go
Exec master.dbo.xp_cmdshell 'Md C:\Backup'
go
Exec sp_addumpdevice
 @devtype     =  'Disk', 
 @logicalname =  'Backup_Ginasio',
 @physicalname = 'C:\Backup\Backup_Ginasio.Bak'
go
BACKUP DATABASE Ginasio
TO Backup_Ginasio
go
BACKUP LOG Ginasio
TO Backup_Ginasio
go
