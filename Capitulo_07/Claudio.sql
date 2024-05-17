
--Conexão do Cláudio (SQL)

Use Impacta
go
SELECT user
go
CREATE TABLE Instrutor
(
  Cod_Instr		int	,
  Nome_Instr	varchar(100)
)
go
CREATE TABLE Treinamento
(
  Cod_Trein		int,
  Nome_Trein	varchar(100)
)
go
CREATE TABLE InstTrein
(
  Cod_Trein		int,
  Nome_Trein	varchar(100)
)
go

SELECT * FROM Instrutores.Instrutor
SELECT * FROM Instrutores.Treinamento
SELECT * FROM Instrutores.TreinInstr

SELECT * FROM Sys.schemas
SELECT * FROM Sys.Tables

SELECT Sys.schemas.Name AS Nome_Schema,
       Sys.Tables.Name AS Nome_Tabela  
FROM Sys.Schemas inner join sys.Tables
ON Sys.Schemas.schema_Id = Tables.Schema_Id