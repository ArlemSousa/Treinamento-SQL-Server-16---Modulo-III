Use Master
IF EXISTS(SELECT * FROM sysdevices
          WHERE Name LIKE 'backup\academia') 
Begin
       Exec SP_DropDevice 'backup\academia'
       Exec xp_cmdshell 'RD C:\backup\academia'
End

go
Exec xp_cmdshell 'MD C:\backup\academia'
/* ******************************************************* */
Use Master
go
IF EXISTS(SELECT * FROM sysdatabases
                    WHERE Name LIKE '%Academia%')
Begin
            DROP DATABASE Academia
            Exec xp_cmdshell 'RD C:\banco\academia'
End
go
Exec xp_cmdshell 'MD C:\banco\academia'
go
CREATE DATABASE Academia
ON PRIMARY
(
name          =  'Academia_primary',
filename    =  'C:\banco\academia\Academia_primary.mdf',
size             = 10MB,
maxsize      = 100MB,
filegrowth  = 10MB
)
LOG ON
(
name            =  'Academia_Log',
filename      =  'C:\banco\academia\Academia_Log.ldf',
size               = 10MB,
maxsize        = 10MB,
filegrowth    = 10MB
)
GO 
Alter database academia set recovery FULL
go
Use Academia
go 
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

Use Academia
go

--Primeira Parte

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
Exec sp_addumpdevice
 @devtype     =  'Disk', 
 @logicalname =  'backupacademia',
 @physicalname = 'C:\Backup\Academia\BackupAcademia.bak'
go

/* ******************************************************* */
/* ******************************************************* */
/* ******************************************************* */
Use Academia
go

--Segunda Parte

INSERT Materia VALUES(3,'Química')
INSERT Materia VALUES(4,'Astronimia')
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
/* ******************************************************* */
/* ******************************************************* */

-- Terceira Parte

Use Academia
go
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
/* ******************************************************* */
/* ******************************************************* */

-- Quarta Parte

Use Academia
go
INSERT Materia VALUES(7,'Taro')
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
/* ******************************************************* */
/* ******************************************************* */
-- Quinta Parte
Use Academia
go
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
/* ******************************************************* */
Use Academia
go
SELECT * FROM Materia
SELECT * FROM Professor 
SELECT * FROM Aluno 
SELECT * FROM Funcionario
/* ******************************************************* */
/* ******************************************************* */
/* ******************************************************* */
Use Master
go
DROP DATABASE Academia
go
SELECT * FROM sys.databases
/* ******************************************************* */
/* ******************************************************* */
/* ******************************************************* */
Use Academia
go
SELECT * FROM Materia
SELECT * FROM Aluno
SELECT * FROM Professor
SELECT * FROM Funcionario
/* ******************************************************* */
