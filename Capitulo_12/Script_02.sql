DBCC TRACEON ( 1400,-1)
go
CREATE DATABASE Ginasio
go
Exec sp_addumpdevice
 @devtype     =  'Disk', 
 @logicalname =  'Backup_Ginasio',
 @physicalname = 'C:\Backup\Backup_Ginasio.Bak'
go
-- copiar o arquivo Backup_Ginasio para a maquina espelho
RESTORE DATABASE Ginasio
FROM Backup_Ginasio
WITH FILE = 1, REPLACE, NORECOVERY
go
RESTORE Log Ginasio
FROM Backup_Ginasio
WITH FILE = 2, NORECOVERY
go