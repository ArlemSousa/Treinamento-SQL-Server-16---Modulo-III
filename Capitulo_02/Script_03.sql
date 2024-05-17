-- Este código verifica se há no disco C:\ uma pasta chamada Bancos e se não 
-- houver ela será criada
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Bancos'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos'

EXEC @result = xp_cmdshell 'dir C:\Bancos\Impacta'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos\Impacta'

go
------------------------------------------------------------------
CREATE DATABASE Impacta
ON PRIMARY
(
  name= 'Impacta_Dados1',
  filename='C:\Bancos\Impacta\Impacta_primary1.mdf',
  size= 10MB,
  maxsize=Unlimited,
  filegrowth= 10MB
),
FILEGROUP Tabelas
(
  name= 'Impacta_Dados2',
  filename='C:\Bancos\Impacta\Impacta_Dados1.ndf',
  size= 10MB,
  maxsize=Unlimited,
  filegrowth= 10MB
),
FILEGROUP INDICES
(
  name= 'Impacta_Indices1',
  filename='C:\Bancos\Impacta\Impacta_Indices1.ndf',
  size= 10MB,
  maxsize=Unlimited,
  filegrowth= 10MB
)
LOG ON
(
  name= 'Impacta_Log1',
  filename='C:\Bancos\Impacta\Impacta_Log1.ldf',
  size= 10MB,
  maxsize=10MB,
  filegrowth= 10MB
),
(
  name= 'Impacta_Log2',
  filename='C:\Bancos\Impacta\Impacta_Log2.ldf',
  size= 10MB,
  maxsize=10MB,
  filegrowth= 10MB
)
go
USE Impacta
go
CREATE TABLE Aluno
(
Cod_Aluno	Int,	
Nome_Aluno	Varchar(100)
)ON TABELAS
go
INSERT Aluno VALUES(1,'Cristina')
INSERT Aluno VALUES(2,'Rosana')
INSERT Aluno VALUES(3,'Roberto')
INSERT Aluno VALUES(4,'Marcos')
INSERT Aluno VALUES(5,'Ana')
go
CREATE TABLE Treinamento
(
Cod_Trein	Int	,
Nome_Trein	Varchar(100)	
)ON TABELAS
go
INSERT Treinamento VALUES(1,'SQL Server')
INSERT Treinamento VALUES(2,'Oracle')
INSERT Treinamento VALUES(3,'DB2')
INSERT Treinamento VALUES(4,'Sybase')
INSERT Treinamento VALUES(5,'Postgresql')
go
Exec SP_HelpFile
go
Exec SP_HelpFileGroup
go
Exec SP_HelpSort
go
SELECT * FROM ::Fn_HelpCollations()
WHERE name = 'Latin1_General_CI_AI_KS'
go
Exec SP_Help 'Aluno'
go
Exec SP_Help 'Treinamento'
go
SELECT syscolumns.Name,
                 syscolumns.Collation 
FROM sysobjects,syscolumns
WHERE sysobjects.id = syscolumns.id
and sysobjects.Name = 'Aluno'
go
SELECT syscolumns.Name,
                 syscolumns.Collation 
FROM sysobjects,syscolumns
WHERE sysobjects.id = syscolumns.id
and sysobjects.Name = 'Treinamento'
go

CREATE NONCLUSTERED INDEX I_Func_1
ON Aluno(Nome_Aluno)
ON INDICES
go
CREATE NONCLUSTERED INDEX I_Trein_1
ON Treinamento(Nome_Trein)
ON INDICES
go
