Use Master
go
-- Este c�digo verifica se h� no disco C:\ uma pasta chamada Bancos e se n�o 
-- houver ela ser� criada
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Bancos'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos'


EXEC @result = xp_cmdshell 'dir C:\Bancos\TESTE_PARTICAO'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos\TESTE_PARTICAO'
go

--1
CREATE DATABASE TESTE_PARTICAO
ON ( NAME = 'TESTE_PARTICAO_PRIM',
     FILENAME = 'C:\Bancos\TESTE_PARTICAO\TESTE_PARTICAO_PRIM.MDF',
     SIZE = 10, MAXSIZE = 10, FILEGROWTH = 5 ),
FILEGROUP FG1
 ( NAME = 'TESTE_PARTICAO_FG1',
     FILENAME = 'C:\Bancos\TESTE_PARTICAO\TESTE_PARTICAO_FG1.NDF',
     SIZE = 10, MAXSIZE = 10, FILEGROWTH = 5 ),
FILEGROUP FG2
 ( NAME = 'TESTE_PARTICAO_FG2',
     FILENAME = 'C:\Bancos\TESTE_PARTICAO\TESTE_PARTICAO_FG2.NDF',
     SIZE = 10, MAXSIZE = 10, FILEGROWTH = 5 ),
FILEGROUP FG3
 ( NAME = 'TESTE_PARTICAO_FG3',
     FILENAME = 'C:\Bancos\TESTE_PARTICAO\TESTE_PARTICAO_FG3.NDF',
     SIZE = 10, MAXSIZE = 10, FILEGROWTH = 5 )
LOG ON
 ( NAME = 'TESTE_PARTICAO_LOG',
     FILENAME = 'C:\Bancos\TESTE_PARTICAO\TESTE_PARTICAO_LOG.LDF',
     SIZE = 10, MAXSIZE = 10, FILEGROWTH = 5 )
GO

--2
USE TESTE_PARTICAO
go

--3
CREATE PARTITION FUNCTION DeptosPFN( INT )
AS
RANGE RIGHT FOR VALUES (
                         3,  -- COD_DEPTO < 3              -> FG1
                         8   -- de 3 at� 7                 -> FG2
                             -- de 8 em diante             -> FG3
)
GO
--4
CREATE PARTITION SCHEME DeptosScheme
AS
PARTITION DeptosPFN TO (FG1, FG2, FG3 )
GO

--5
CREATE TABLE [dbo].[Empregados](
	[CODFUN] [int] IDENTITY(1,1) NOT NULL,
	[NOME] [varchar](35) NOT NULL,
	[COD_DEPTO] [int] NOT NULL,
	[COD_CARGO] [int] NULL,
	[DATA_ADMISSAO] [datetime] NULL,
	[SALARIO] [numeric](18, 2) NULL,
CONSTRAINT [PK_Empregados] PRIMARY KEY (CODFUN, COD_DEPTO) 
) ON DeptosScheme(COD_DEPTO)
GO
--6
SELECT * FROM SYS.PARTITIONS
WHERE OBJECT_ID = OBJECT_ID('EMPREGADOS')

--7
INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('MAGNO',1,1000)

INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('CARLOS',2,1000)

SELECT * FROM SYS.PARTITIONS
WHERE OBJECT_ID = OBJECT_ID('EMPREGADOS')

--8
INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('CARLOS',3,1000)

INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('PEDRO',4,1000)

INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('JULIO',5,1000)

INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('LUIZA',6,1000)

INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('SONIA',7,1000)

SELECT * FROM SYS.PARTITIONS
WHERE OBJECT_ID = OBJECT_ID('EMPREGADOS')

--9
INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('MARCIA',8,1000)

INSERT INTO EMPREGADOS (NOME, COD_DEPTO, SALARIO)
VALUES ('ANTONIO',9,1850)

SELECT * FROM SYS.PARTITIONS
WHERE OBJECT_ID = OBJECT_ID('EMPREGADOS')

--10
SELECT $PARTITION.DeptosPFN( COD_DEPTO ) AS NUM_PARTICAO, 
       NOME, COD_DEPTO
FROM EMPREGADOS
ORDER BY NUM_PARTICAO, COD_DEPTO

select * from EMPREGADOS

--Laborat�rio 2

--1
CREATE TABLE Departamento
(COD_DEPTO		INT 	PRIMARY KEY,
NOME			VARCHAR(20) )
GO

--2
CREATE SEQUENCE SEQ_DEPTO  
	START WITH 1
    INCREMENT BY 1 ;

GO
--3
INSERT INTO DEPARTAMENTO (COD_DEPTO, NOME) VALUES 
(NEXT VALUE FOR DBO.SEQ_DEPTO, 'CONTABILIDADE'),
(NEXT VALUE FOR DBO.SEQ_DEPTO, 'TI');

--4
SELECT * FROM SYS.SEQUENCES;

--Laborat�rio 3

-- 1. Verifique o tamanho da tabela Empregados
EXEC SP_SPACEUSED EMPREGADOS

-- 2. Realize o Rebuild da tabela empregados aplicando compress�o por linhas.
ALTER TABLE EMPREGADOS 
REBUILD WITH (DATA_COMPRESSION = ROW);

--3. Verifique o espa�o databela Emptregados
EXEC SP_SPACEUSED EMPREGADOS


--Laborat�rio 4

--1
CREATE SYNONYM TB_EMPREGADO FOR DBO.EMPREGADOS

--2
SELECT * FROM TB_EMPREGADO











