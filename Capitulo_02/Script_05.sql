
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Bancos'
IF (@result <> 0)
	Exec master.dbo.xp_cmdshell 'Md C:\Bancos'

EXEC @result = xp_cmdshell 'dir C:\Bancos\universidade'
IF (@result <> 0)
	Exec master.dbo.xp_cmdshell 'Md C:\Bancos\universidade'

go

CREATE DATABASE Universidade
ON PRIMARY
(
  name= 'Univers_primary',
  filename='C:\Bancos\universidade\Univers_primary.mdf',
  size= 10MB,
  maxsize=Unlimited,
  filegrowth= 10MB
),
FILEGROUP DADOS
(
  name= 'Univers_Dados1',
  filename='C:\Bancos\Universidade\Univers_Dados1.ndf',
  size= 10MB,
  maxsize=100MB,
  filegrowth= 10MB
)

LOG ON
(
  name= 'Univers_Log',
  filename='C:\Bancos\Universidade\Univers_Log.ldf',
  size= 10MB,
  maxsize=10MB,
  filegrowth= 10MB
)
go


USE Universidade
go
CREATE TABLE Aluno
(
Cod_Aluno	Int,	
Nome_Aluno	Varchar(100)
)ON Dados
go
INSERT Aluno VALUES(1,'Cristina')
INSERT Aluno VALUES(2,'Rosana')
INSERT Aluno VALUES(3,'Roberto')
INSERT Aluno VALUES(4,'Marcos')
INSERT Aluno VALUES(5,'Ana')
go
CREATE TABLE Funcionario
(
Cod_Func	Int,	
Nome_Func	Varchar(100)
)ON Dados
go
INSERT Funcionario VALUES(1,'Jorge')
INSERT Funcionario VALUES(2,'Ronaldo')
INSERT Funcionario VALUES(3,'Cláudia')
INSERT Funcionario VALUES(4,'Francisco')
INSERT Funcionario VALUES(5,'Agnaldo')
go

ALTER DATABASE Universidade SET READ_ONLY
go
Use Universidade
go
INSERT Aluno VALUES(6,'Laureana')
go
Use Master
go
ALTER DATABASE Universidade	SET OFFLINE
go
Use Universidade
go
ALTER DATABASE Universidade	SET ONLINE
go
ALTER DATABASE Universidade	SET READ_WRITE
go
Use Universidade
go
ALTER DATABASE Universidade	MODIFY FILEGROUP  DADOS READONLY
go
INSERT Funcionario VALUES(5,'Ronaldo')
go
ALTER DATABASE Universidade	MODIFY FILEGROUP DADOS READWRITE
go
INSERT Funcionario VALUES(5,'Ronaldo')
go
ALTER DATABASE Universidade	MODIFY FILEGROUP DADOS DEFAULT
go
CREATE TABLE Materia
(
Cod_Mat	Int,
Nome_Mat	Varchar(50)
)
go
Exec SP_Help Materia
go

ALTER DATABASE Universidade	MODIFY FILEGROUP [PRIMARY] DEFAULT
go

ALTER DATABASE Universidade	ADD FILEGROUP DADOS_BASICO

go
ALTER DATABASE Universidade
ADD FILE
(
  name= 'Univers_Dados3',
  filename='C:\Bancos\universidade\Univers_Dados3.ndf',
  size= 10MB,
  maxsize=UNLIMITED,
  filegrowth= 10MB
)TO FILEGROUP DADOS_BASICO
go
ALTER DATABASE Universidade	ADD FILEGROUP DADOS_COMPLEMENTO
go
ALTER DATABASE Universidade
ADD FILE
(
  name= 'Univers_Dados4',
  filename='C:\Bancos\universidade\univers_Dados_complemento1.ndf',
  size= 10MB,
  maxsize=UNLIMITED,
  filegrowth= 10MB
),
(
  name= 'Univers_Dados5',
  filename='C:\Bancos\universidade\Univers_Dados_complemento2.ndf',
  size= 10MB,
  maxsize=UNLIMITED,
  filegrowth= 10MB
)TO FILEGROUP DADOS_COMPLEMENTO
go

CREATE TABLE Professor
(
Cod_Prof	Int,
Nome_Prof	Varchar(50)
)ON DADOS_BASICO
go

Exec SP_HelpFile
go
ALTER DATABASE Universidade	MODIFY FILE
(
	Name = 'Univers_Dados5', 
	NewName = 'Univers_Dados6',
	Size = 20MB,
	MaxSize = UNLIMITED,
	Filegrowth = 20MB
)
go
Exec SP_Helpfile
go
DBCC SHRINKFILE ('Univers_Dados6',5)
go
ALTER DATABASE Universidade	REMOVE FILE Univers_Dados6
go
ALTER DATABASE Universidade	REMOVE FILE Univers_Dados4
go

ALTER DATABASE Universidade	REMOVE FILEGROUP DADOS_COMPLEMENTO
go
Exec SP_HelpFile 
go

