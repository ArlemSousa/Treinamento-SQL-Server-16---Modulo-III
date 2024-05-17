Use Master
go
-- Este código verifica se há no disco C:\ uma pasta chamada Bancos e se não 
-- houver ela será criada
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Bancos'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos'


EXEC @result = xp_cmdshell 'dir C:\Bancos\colegio'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos\colegio'
go

DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Backup'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Backup'

go
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Backup\colegio'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Backup\colegio'

go


CREATE DATABASE Colegio
ON PRIMARY
(
Name		= 'Colegio_primary',
filename    = 'C:\Bancos\colegio\Colegio_primary.mdf',
size        = 10MB,
maxsize     = 100MB,
filegrowth  = 10MB
)
LOG ON
(
Name		= 'Colegio_Log',
filename    = 'C:\Bancos\colegio\Colegio_Log.ldf',
size        = 10MB,
maxsize     = 10MB,
filegrowth  = 10MB
)
GO

Alter database colegio set recovery full
GO

Exec sp_addumpdevice
 @devtype     =  'Disk', 
 @logicalname =  'Backupcolegio',
 @physicalname = 'C:\Backup\colegio\colegio.bak'

go 
 -----------------------------------------------------------------------------------
Use Colegio
go 
-----------------------------------------------------------------------------------
CREATE TABLE Materia
(
Cod_Mat int,
Nome_Mat char(30)
)
go 
CREATE TABLE   Professor
(
Cod_Prof int,
Nome_Prof char(30)
)
go 
CREATE TABLE Aluno
(
Cod_Aluno int,
Nome_Aluno char(30)
)
go 
CREATE TABLE Funcionario
(
Cod_Func int,
Nome_Func char(30)
)
go 
-----------------------------------------------------------------------------------
INSERT Materia VALUES(1,'Matemática')
INSERT Materia VALUES(2,'Física')
go
INSERT Professor VALUES(1,'Leandro')
INSERT Professor VALUES(2,'Marcos')
go 
INSERT Aluno VALUES(1,'André')
INSERT Aluno VALUES(2,'José')
go
INSERT Funcionario VALUES(1,'Paulo')
INSERT Funcionario VALUES(2,'Paula')
go
Checkpoint
go
/* ******************************************************* */
BACKUP DATABASE  Colegio
TO backupcolegio
WITH
DESCRIPTION = 'Primeiro Backup Full do Database Colegio',
INIT,
MEDIANAME = 'Backup Colegio',
NAME = 'Backup Full Colegio'
go
/******************************************************** */
INSERT Materia VALUES(3,'Química')
INSERT Materia VALUES(4,'Astronomia')
go
INSERT Professor VALUES(3,'Paulo')
INSERT Professor VALUES(4,'Roberta')
go
INSERT Aluno VALUES(3,'Renato')
INSERT Aluno VALUES(4,'Ricardo')
go
INSERT Funcionario VALUES(3,'Mauro')
INSERT Funcionario VALUES(4,'Maura')
go
Checkpoint
go

/* ******************************************************* */
BACKUP LOG Colegio
TO backupcolegio
WITH
DESCRIPTION = 'Primeiro Backup Log do Database Colegio',
NOINIT,
MEDIANAME = 'Backup Colegio',
NAME = 'Backup Log 1 Colegio'
go
/* ******************************************************* */
INSERT Materia VALUES(5,'Astrologia')
INSERT Materia VALUES(6,'Quiromancia')
go
INSERT Professor VALUES(5,'Morgana')
INSERT Professor VALUES(6,'Odavlas')
go
INSERT Aluno VALUES(5,'Agnes')
INSERT Aluno VALUES(6,'Agnus')
go
INSERT Funcionario VALUES(5,'Marcelo')
INSERT Funcionario VALUES(6,'Mauricio')
go
Checkpoint
go
/* ******************************************************* */
BACKUP LOG Colegio
TO backupcolegio
WITH
DESCRIPTION = 'Segundo Backup Log do Database Colegio',
NOINIT,
MEDIANAME = 'Backup Colegio',
NAME = 'Backup Log 2 Colegio'
go
/* ******************************************************* */
INSERT Materia VALUES(7,'Tarô')
INSERT Materia VALUES(8,'Cartomancia')
go
INSERT Professor VALUES(7,'Zoroastra')
INSERT Professor VALUES(8,'Zoroastro')
go
INSERT Aluno VALUES(7,'Eleotério')
INSERT Aluno VALUES(8,'Midas')
go
INSERT Funcionario VALUES(7,'Cristina')
INSERT Funcionario VALUES(8,'Cristiano')
go
Checkpoint
go
/* ******************************************************* */
BACKUP DATABASE Colegio
TO backupcolegio
WITH
DIFFERENTIAL,
DESCRIPTION = 'Backup Diferencial do database Colegio',
NOINIT,
MEDIANAME = 'Backup Colegio',
NAME = 'Backup Diferencial Colegio'
go
/* ******************************************************* */
INSERT Materia VALUES(9,'Telepatia')
INSERT Materia VALUES(10,'Runas')
go
INSERT Professor VALUES(9,'Rubeo')
INSERT Professor VALUES(10,'Nana Sara')
go
INSERT Aluno VALUES(9,'Silvia')
INSERT Aluno VALUES(10,'Sonia')
go
INSERT Funcionario VALUES(9,'Bianca')
INSERT Funcionario VALUES(10,'Beatriz')
go
Checkpoint
go
/* ******************************************************* */
BACKUP LOG Colegio
TO backupcolegio
WITH
DESCRIPTION = 'Terceiro Backup Log do Database Colegio',
NOINIT,
MEDIANAME = 'Backup Colegio',
NAME = 'Backup Log 3 Colegio'
go
/* ******************************************************* */
RESTORE HEADERONLY	FROM DISK = 'C:\backup\colegio\colegio.bak'
/* ******************************************************* */
Use Master
go
DROP DATABASE Colegio
go
SELECT * FROM sys.databases
go
/* ******************************************************* */
RESTORE DATABASE Colegio
FROM backupcolegio
WITH  FILE = 1, NORECOVERY
go
RESTORE DATABASE Colegio
FROM backupcolegio
WITH  FILE = 4, NORECOVERY
go
RESTORE LOG Colegio
FROM backupcolegio
WITH  FILE = 5, RECOVERY
go
/* ******************************************************* */
Use Colegio
go
SELECT * FROM Materia
SELECT * FROM Aluno
SELECT * FROM Professor
SELECT * FROM Funcionario
/* ******************************************************* */