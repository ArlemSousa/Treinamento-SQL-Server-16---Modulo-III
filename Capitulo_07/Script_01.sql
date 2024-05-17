Use Master
go
-- Este código verifica se há no disco C:\ uma pasta chamada Bancos e se não 
-- houver ela será criada
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Bancos\'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos'


EXEC @result = xp_cmdshell 'dir C:\Bancos\Impacta'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos\Impacta'
go

Use Master
go

IF EXISTS(SELECT * FROM Master.dbo.Sysdatabases
                    WHERE Name LIKE '%IMPACTA%')
         DROP DATABASE IMPACTA
go

-- Obtendo o nome do Usuário conectado
SELECT USER
-- Criando o Database Impacta
CREATE DATABASE Impacta
go
-- Mapeando Logins de Usuários do Windows

CREATE LOGIN [UNIVERSO\Jorge] FROM WINDOWS;
CREATE LOGIN [UNIVERSO\Jairo] FROM WINDOWS;
CREATE LOGIN [UNIVERSO\Roberta] FROM WINDOWS;
CREATE LOGIN [UNIVERSO\Helena] FROM WINDOWS;
CREATE LOGIN [UNIVERSO\Daniel] FROM WINDOWS;
CREATE LOGIN [UNIVERSO\Fernando] FROM WINDOWS;
CREATE LOGIN [UNIVERSO\VendedoresW] FROM WINDOWS;
go
-- Criando usuários no SQL Server
CREATE LOGIN Paula WITH PASSWORD = 'xptoPaula' , check_policy = off
CREATE LOGIN Sonia WITH PASSWORD = 'xptoSonia', check_policy = off
CREATE LOGIN Raquel WITH PASSWORD = 'xptoRaquel', check_policy = off
CREATE LOGIN Marcos WITH PASSWORD = 'xptoMarcos' , check_policy = off
CREATE LOGIN Pedro WITH PASSWORD = 'xptoPedro', check_policy = off
CREATE LOGIN Carla WITH PASSWORD = 'xptoCarla', check_policy = off
CREATE LOGIN Margarida WITH PASSWORD = 'xptoMargarida', check_policy = off
CREATE LOGIN Claudio WITH PASSWORD = 'xptoClaudio', check_policy = off

go

--Acrescentando usuário no Server Role
Exec SP_AddSrvRoleMember [UNIVERSO\Jorge],sysadmin
Exec SP_AddSrvRoleMember Marcos,sysadmin

-- Acessando o Database Impacta
Use Impacta
go

-- Criando os schemas do sistema 
go
CREATE SCHEMA RH
go
CREATE SCHEMA VENDAS
go
CREATE SCHEMA FATURAMENTO
go
CREATE SCHEMA INSTRUTORES
go

--Criando um User Define Role
CREATE ROLE VendedoresSQL
go

-- Criando usuários no database Impacta
CREATE USER [UNIVERSO\Jairo]		WITH DEFAULT_SCHEMA = DBO
CREATE USER [UNIVERSO\Roberta]		WITH DEFAULT_SCHEMA = DBO
CREATE USER [UNIVERSO\Helena]		WITH DEFAULT_SCHEMA = RH
CREATE USER [UNIVERSO\Daniel]		WITH DEFAULT_SCHEMA = VENDAS
CREATE USER [UNIVERSO\Fernando]		WITH DEFAULT_SCHEMA = FATURAMENTO
CREATE USER [UNIVERSO\VendedoresW]	--Não pode ser associado a nenhum schema como default

CREATE USER Pedro					WITH DEFAULT_SCHEMA = DBO
CREATE USER Carla					WITH DEFAULT_SCHEMA = DBO
CREATE USER Margarida				WITH DEFAULT_SCHEMA = DBO
CREATE USER Claudio					WITH DEFAULT_SCHEMA = INSTRUTORES


go


--Acrescentando usuários nos Database Roles
Exec SP_AddRoleMember db_Owner,[UNIVERSO\JAIRO]
Exec SP_AddRoleMember db_datareader,[UNIVERSO\Roberta]
Exec SP_AddRoleMember db_datawriter,[UNIVERSO\Roberta]
Exec SP_AddRoleMember db_ddladmin,[UNIVERSO\Helena]
Exec SP_AddRoleMember db_ddladmin,[UNIVERSO\Daniel]
Exec SP_AddRoleMember db_ddladmin,[UNIVERSO\Fernando]
Exec SP_AddRoleMember VendedoresSQL,[UNIVERSO\VendedoresW]
Exec SP_AddRoleMember VendedoresSQL,Pedro
Exec SP_AddRoleMember VendedoresSQL,Carla
Exec SP_AddRoleMember VendedoresSQL,Margarida
Exec SP_AddRoleMember db_ddladmin,Claudio

--Conectando com os logins e criando as tabelas
-- Helena: Funcionario, Atributo,FuncAtrib
-- Daniel: Cliente,Treinamento,CliTrein
-- Fernando: Fatura, NF 
-- Claudio:Instrutor,Treinamento,InstTrein

SELECT Sys.schemas.Name AS Nome_Schema,
       Sys.Tables.Name AS Nome_Tabela  
FROM Sys.Schemas inner join sys.Tables
ON Sys.Schemas.schema_Id = Tables.Schema_Id

-- Após a Criação das tabelas, atribuir as Permissões:

-- Obtendo metadados
SELECT * FROM sys.sysusers
Exec SP_HelpUser
Exec SP_HelProtect
Exec SP_HelpLogins

-- Eliminando os usuários que criaram tabelas
DROP USER [universo\Helena]
DROP USER [universo\Daniel]
DROP USER [universo\Fernando]
DROP USER [universo\Jairo]
DROP USER [universo\Roberta]
DROP USER [universo\Helena]
DROP USER [universo\Daniel]
DROP USER [universo\Fernando]
DROP USER [universo\VendedoresW]
DROP USER Pedro
DROP USER Carla
DROP USER Margarida
DROP USER Claudio
DROP USER Paula
DROP USER Sonia
DROP USER Raquel


-- As tabelas continuam no sistema
SELECT Sys.schemas.Name AS Nome_Schema,
       Sys.Tables.Name AS Nome_Tabela  
FROM Sys.Schemas inner join sys.Tables
ON Sys.Schemas.schema_Id = Tables.Schema_Id

------------------------ fim ------------------------------------
DROP LOGIN [universo\Jorge]
DROP LOGIN [universo\Jairo]
DROP LOGIN [universo\Roberta]
DROP LOGIN [universo\Helena]
DROP LOGIN [universo\Daniel]
DROP LOGIN [universo\Fernando]
DROP LOGIN [universo\VendedoresW]
DROP LOGIN Pedro
DROP LOGIN Carla
DROP LOGIN Margarida
DROP LOGIN Claudio
DROP LOGIN Paula
DROP LOGIN Sonia
DROP LOGIN Raquel
DROP LOGIN Marcos
--------------------------------------------------------------------

Exec SP_AddAppRole Aplicação,'xptoTeste'

Exec SP_SetAppRole 'Aplicação','xptoTeste'


-- Laboratório 2

--1. Cria tabela TB_COMISSAO
CREATE TABLE TB_COMISSAO (  
ID				INT IDENTITY PRIMARY KEY,  
USUARIO			SYSNAME,	
QTD				INT,  
VALOR			DECIMAL(10,2),
COMISSAO		DECIMAL(10,2)
)
GO

-- 2. Inserir os valores abaixo 
INSERT INTO TB_COMISSAO VALUES
( 'MARCOS',		10,		1500.00,	142),
( 'ANTONIO',	12,		758.00,		71.22),
( 'LEIA',		3,		10158.00,	1451),
( 'MARCELO',	57,		1650.00,	78)
GO

--3. CRIAÇÃO DOS USUÁRIOS
CREATE USER MARCOS	WITHOUT LOGIN;   
CREATE USER ANTONIO WITHOUT LOGIN;   
CREATE USER LEIA	WITHOUT LOGIN;   
CREATE USER MARCELO WITHOUT LOGIN;   
CREATE USER GESTOR	WITHOUT LOGIN;   

-- 4. Dar permissão de SELECT na tabela TB_COMISSAO para os usuários criados acima
GRANT SELECT ON TB_COMISSAO TO MARCOS
GRANT SELECT ON TB_COMISSAO TO ANTONIO
GRANT SELECT ON TB_COMISSAO TO LEIA
GRANT SELECT ON TB_COMISSAO TO MARCELO
GRANT SELECT ON TB_COMISSAO TO GESTOR

--5. Crie uma SCHEMA de nome SCHEMA_COMISSAO

GO
CREATE SCHEMA SCHEMA_COMISSAO;  

GO
--6. Crie uma função FN_SECURITYPREDICATE
  
CREATE FUNCTION SCHEMA_COMISSAO.FN_SECURITYPREDICATE(@USUARIO AS SYSNAME)
RETURNS TABLE
WITH SCHEMABINDING	AS

	RETURN SELECT 1 AS FN_SECURITYPREDICATE_RESULT
	WHERE @USUARIO = USER_NAME() OR USER_NAME() = 'GESTOR';


-- 7. Crie uma política de segurança para que os usuários consigam visualizar somente seus dados e o Gestor todos os registros.
GO
CREATE SECURITY POLICY SCHEMA_COMISSAO.FILTRO_TB_VENDA
    ADD FILTER PREDICATE SCHEMA_COMISSAO.FN_SECURITYPREDICATE(USUARIO)   
        ON DBO.TB_COMISSAO
		WITH (STATE = ON);
GO

-- 8 - Realize a consulta para todos os usuários criados conforme exemplo abaixo:

EXECUTE AS USER = 'MARCOS';  
SELECT * FROM TB_COMISSAO
REVERT
GO  

EXECUTE AS USER = 'ANTONIO';  
SELECT * FROM TB_COMISSAO
REVERT
GO  

EXECUTE AS USER = 'LEIA';  
SELECT * FROM TB_COMISSAO
REVERT
GO  

EXECUTE AS USER = 'MARCELO';  
SELECT * FROM TB_COMISSAO
REVERT
GO  

EXECUTE AS USER = 'GESTOR';  
SELECT * FROM TB_COMISSAO
REVERT
GO  


-- Laboratório 3

7.11.	Dynamic Data Masking

Este recurso permite o mascaramento de um campo evitando que usuários consigam visualizar informações de campos restritos.

Verifique o exemplo abaixo:


-- 1. Criação da tabela TB_Empregado_Sal
CREATE TABLE TB_Empregado_Sal (  
ID				INT IDENTITY PRIMARY KEY,  
NUM_Empregado	INT,  
Empregado		VARCHAR(10),  
Salario			DECIMAL(10,2) MASKED WITH (FUNCTION = 'DEFAULT()')
)

GO

-- Insere os registros na tabela
INSERT INTO TB_Empregado_Sal VALUES
(  1, 'Marcelo', 1500.00),
(  2, 'Marcos', 4758.00),
(  3, 'Leia', 1800.00),
(  4, 'Cadu', 1650.00),
(  5, 'Joel', 6050.00)

GO

-- 3. Faça a consulta na tabela TB_Empregado_Sal
SELECT * FROM TB_Empregado_Sal


-- 4. Atribua permissão de SELECT para o Gestor visualizar as informações
GRANT SELECT ON TB_Empregado_Sal TO GESTOR

-- 5. Realize uma consulta como Gestor.
EXECUTE AS USER = 'GESTOR';  
SELECT * FROM TB_Empregado_Sal
REVERT
GO 

-- 7. Atribua permissão de SELECT para o usuário Marcelo
GRANT SELECT ON TB_Empregado_Sal TO Marcelo

-- 6. Realize uma consulta como Marcelo.
EXECUTE AS USER = 'MARCELO';  
SELECT * FROM TB_Empregado_Sal
REVERT
GO 
  
